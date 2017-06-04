--[[---------------------------------------------------------------------------

Copyright (c) 2008-2017 by K. Scott Piel 
All Rights Reserved

E-mail: < kscottpiel@gmail.com >

This file is part of nUI.

The author no longer develops or directly supports this addon and has released it
into the public domain under the Creative Commons Attribution-NonCommercial 3.0 
Unported license - a copy of which is included in this distribution. This source
may not be distributed without said license.
	   
nUI is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; 
without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR 
PURPOSE.  See the enclosed license for more details.
	
THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS  "AS IS" AND 
ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT  LIMITED TO, THE IMPLIED 
WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. 
IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, 
INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, 
BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, 
DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF 
LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE 
OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED 
OF THE POSSIBILITY OF SUCH DAMAGE.

--]]---------------------------------------------------------------------------

if not nUI then nUI = {}; end
if not nUI_Unit then nUI_Unit = {}; end
if not nUI_UnitOptions then nUI_UnitOptions = {}; end
if not nUI_DefaultConfig then nUI_DefaultConfig = {}; end
if not nUI_Profile then nUI_Profile = {}; end;

-- 5.0.1 Change Start - Function name changes
-- local GetNumPartyMembers	 = GetNumPartyMembers;
-- local GetNumRaidMembers   = GetNumRaidMembers;
-- local GetRaidRosterInfo   = GetRaidRosterInfo;
local GetNumRaidMembers		 = GetNumGroupMembers;
local GetNumPartyMembers	 = GetNumSubgroupMembers;
-- 5.0.1 Change End

local GetTime                = GetTime;
local PlaySound              = PlaySound;
local UnitCanAttack          = UnitCanAttack;
local UnitFactionGroup       = UnitFactionGroup;
local UnitIsFriend           = UnitIsFriend;
local UnitIsPVP              = UnitIsPVP;
local UnitIsPVPFreeForAll    = UnitIsPVPFreeForAll;
local UnitIsPVPSanctuary     = UnitIsPVPSanctuary;
-- Legion Change Start TJK
local UnitIsTapDenied		 = UnitIsTapDenied;
-- Legion Change End TJK
local UnitIsTrivial          = UnitIsTrivial;
local UnitPlayerControlled   = UnitPlayerControlled;
local UnitPlayerOrPetInParty = UnitPlayerOrPetInParty;
local UnitPlayerOrPetInRaid  = UnitPlayerOrPetInRaid;
local UnitReaction           = UnitReaction;

-------------------------------------------------------------------------------
-- default options for the unit reaction frames

nUI_DefaultConfig.ReactionColors =
{
	-- color used to highlight the player, player's pet and party/raid members (when not PvP)
	
--	Party = { r = 0, g = 0, b = 0, a = 0.25 },
	
	-- color used to highlight units that are attackable but trivial to player (give no XP)
	
	Trivial = { r = 0.5, g = 0.5, b = 0.5, a = 0.25, },
	
	-- color used to highlight units tapped by another player
	
	Tapped = { r = 0.5, g = 0.5, b = 0.5, a = 0.25, },
	
	-- color used to highlight hostile units
	
	Hostile = { r = 1, g = 0, b = 0, a = 0.25, },
	
	-- color used to highlight neutral units
	
	Neutral = { r = 1, g = 0.85, b = 0, a = 0.3, },
	
	-- color used to highlight friendly units
	
	Friendly = { r = 0, g = 0.5, b = 0, a = 0.25, },
	
	-- color used to color player characters who are not PvP
	
	Player = { r = 0, g = 0, b = 0.5, a = 0.25 },
	
	-- color used to highlight friendly players who are PvP
	
	PvP_Enabled = { r = 0, g = 0.5, b = 0, a = 0.25 },
	
	-- color used to highlight PvP units that can attack us
	
	PvP_Active = { r = 1, g = 0, b = 0, a = 0.25 },
	
	-- color used to highlight PvP units we can attack (but cannot yet attack back)
	
	PvP_Available = { r = 1, g = 1, b = 0, a = 0.25 },
	
};

-------------------------------------------------------------------------------
-- unit reaction event management

if not nUI_Unit.Drivers then 
	nUI_Unit.Drivers = CreateFrame( "Frame", "nUI_UnitDrivers", WorldFrame ); 
end

nUI_Profile.nUI_UnitReaction = {};

local ProfileCounter = nUI_Profile.nUI_UnitReaction;

local frame                = CreateFrame( "Frame", "$parent_UnitReaction", nUI_Unit.Drivers )
local ReactionCallbacks    = {};
local ReactionUnits        = {};
local NewUnitInfo          = {};
local UpdateQueue          = {};
local queue_timer          = 1 / nUI_DEFAULT_FRAME_RATE;

nUI_Unit.Drivers.Reaction  = frame;

-------------------------------------------------------------------------------
-- variables used in methods within this module are declared here to eliminate
-- the use of dynamic memory and the garbage collector

local unit_id;
local unit_info;
local list;
local modified;
local prior_state;
local is_pvp;
local is_ffa;
local is_sanctuary;
local is_controlled;
local is_friend;
local is_tapped;
local is_trivial;
local in_party;
local in_raid;
local reaction;
local can_attack;
local attackable;
local raid_size;
local party_id;
local raid_id;
local faction, faction_name;
local colors;

-------------------------------------------------------------------------------
-- unit reaction event handler

local function onReactionEvent( who, event, arg1 )
	
--	nUI_ProfileStart( ProfileCounter, "onReactionEvent", event );
	
	if event == "ADDON_LOADED" then

		if arg1 == "nUI" then
			nUI:patchConfig();
			nUI_Unit:configReactionColors();
		end
		
	-- for these events, we don't know which units are affected, so
	-- we span the list of all known interested units to see who is watching
		
	elseif event == "PLAYER_ENTERING_WORLD" 

	-- 5.0.1 Change Start - Event name change
	--or event == "RAID_ROSTER_UPDATE"
	--or event == "PARTY_MEMBERS_CHANGED"
	or event == "GROUP_ROSTER_UPDATE"		
	-- 5.0.1 Change End

	then
		
		nUI_Unit:refreshReactionCallbacks();

	-- we're only going to look at the event if there's someone who cares about it
		
	elseif ReactionCallbacks[arg1] and #ReactionCallbacks[arg1] > 0 then
			
		UpdateQueue[arg1] = true;
		NewUnitInfo[arg1] = nUI_Unit:getUnitInfo( arg1 );
		
	end

--	nUI_ProfileStop();
	
end

frame:SetScript( "OnEvent", onReactionEvent );
frame:RegisterEvent( "ADDON_LOADED" );
frame:RegisterEvent( "PLAYER_ENTERING_WORLD" );

-- 5.0.1 Change Start - event name change
--frame:RegisterEvent( "RAID_ROSTER_UPDATE" );
--frame:RegisterEvent( "PARTY_MEMBERS_CHANGED" );
frame:RegisterEvent("GROUP_ROSTER_UPDATE");		
-- 5.0.1 Change end

frame:RegisterEvent( "UNIT_PVP_UPDATE" );
frame:RegisterEvent( "UNIT_FACTION" );

-------------------------------------------------------------------------------

local function onQueueUpdate( who, elapsed )

	queue_timer = queue_timer - elapsed;
	
	if queue_timer <= 0 then -- process the update queue at the user selected frame rate
	
		queue_timer = nUI_Unit.frame_rate;

		for unit_id in pairs( UpdateQueue ) do
		
			if UpdateQueue[unit_id] then
			
				UpdateQueue[unit_id] = false;
				unit_info = NewUnitInfo[unit_id];
								
				if ReactionCallbacks[unit_id] and #ReactionCallbacks[unit_id] > 0 then
					nUI_Unit:notifyCallbacks( 
						nUI_L["unit reaction"], ReactionCallbacks, ReactionUnits, 
						unit_info, unit_id, nUI_Unit:updateReactionInfo( unit_id, unit_info ) 
					);
				end
			end
		end
	end	
end

frame:SetScript( "OnUpdate", onQueueUpdate );

-------------------------------------------------------------------------------
-- this callback method is called when one of the unit IDs we are monitoring
-- for unit reaction changes GUID

frame.newUnitInfo = function( unit_id, unit_info )

--	nUI_ProfileStart( ProfileCounter, "newUnitInfo" );
	
	UpdateQueue[unit_id] = true;
	NewUnitInfo[unit_id] = unit_info;
	
--	nUI_ProfileStop();
	
end

-------------------------------------------------------------------------------
-- initialize configuration for the unit reaction color selection system
-- 
-- this method is called when the mod's saved variables have been loaded by Bliz and
-- may be called again whenever the reaction color configuration has been changed
-- by the player or programmatically. Passing true or a non-nil value for "use_default"
-- will cause the player's current reaction color configuration to be replaced with
-- the default settings defined at the top of this file (which cannot be undone!)

function nUI_Unit:configReactionColors( use_default )
	
--	nUI_ProfileStart( ProfileCounter, "configReactionColors" );
	
	if not nUI_UnitOptions then
		nUI_UnitOptions = {};
	end
	
	if not nUI_UnitOptions.ReactionColors then
		nUI_UnitOptions.ReactionColors = {};
	end
	
	local config  = nUI_UnitOptions.ReactionColors;
	local default = nUI_DefaultConfig.ReactionColors;

	-- color used to highlight the player, player's pet and party/raid members (when not PvP)
	
	if not config.Trivial       then config.Trivial = {}; end
	if not config.Tapped        then config.Tapped = {}; end
	if not config.Hostile       then config.Hostile = {}; end
	if not config.Neutral       then config.Neutral = {}; end
	if not config.Friendly      then config.Friendly = {}; end
	if not config.Player        then config.Player = {}; end
	if not config.PvP_Enabled   then config.PvP_Enabled = {}; end
	if not config.PvP_Active    then config.PvP_Active = {}; end
	if not config.PvP_Available then config.PvP_Available = {}; end
	
	if use_default then

		config.Trivial.r = default.Trivial.r;
		config.Trivial.g = default.Trivial.g;
		config.Trivial.b = default.Trivial.b;
		config.Trivial.a = default.Trivial.a;
		
		config.Tapped.r = default.Tapped.r;
		config.Tapped.g = default.Tapped.g;
		config.Tapped.b = default.Tapped.b;
		config.Tapped.a = default.Tapped.a;
		
		config.Hostile.r = default.Hostile.r;
		config.Hostile.g = default.Hostile.g;
		config.Hostile.b = default.Hostile.b;
		config.Hostile.a = default.Hostile.a;
		
		config.Neutral.r = default.Neutral.r;
		config.Neutral.g = default.Neutral.g;
		config.Neutral.b = default.Neutral.b;
		config.Neutral.a = default.Neutral.a;
		
		config.Friendly.r = default.Friendly.r;
		config.Friendly.g = default.Friendly.g;
		config.Friendly.b = default.Friendly.b;
		config.Friendly.a = default.Friendly.a;
		
		config.Player.r = default.Player.r;
		config.Player.g = default.Player.g;
		config.Player.b = default.Player.b;
		config.Player.a = default.Player.a;
		
		config.PvP_Enabled.r = default.PvP_Enabled.r;
		config.PvP_Enabled.g = default.PvP_Enabled.g;
		config.PvP_Enabled.b = default.PvP_Enabled.b;
		config.PvP_Enabled.a = default.PvP_Enabled.a;
		
		config.PvP_Available.r = default.PvP_Available.r;
		config.PvP_Available.g = default.PvP_Available.g;
		config.PvP_Available.b = default.PvP_Available.b;
		config.PvP_Available.a = default.PvP_Available.a;
		
		config.PvP_Active.r = default.PvP_Active.r;
		config.PvP_Active.g = default.PvP_Active.g;
		config.PvP_Active.b = default.PvP_Active.b;
		config.PvP_Active.a = default.PvP_Active.a;
		
	else

		config.Trivial.r = tonumber( config.Trivial.r or default.Trivial.r );
		config.Trivial.g = tonumber( config.Trivial.g or default.Trivial.g );
		config.Trivial.b = tonumber( config.Trivial.b or default.Trivial.b );
		config.Trivial.a = tonumber( config.Trivial.a or default.Trivial.a );
		
		config.Tapped.r = tonumber( config.Tapped.r or default.Tapped.r );
		config.Tapped.g = tonumber( config.Tapped.g or default.Tapped.g );
		config.Tapped.b = tonumber( config.Tapped.b or default.Tapped.b );
		config.Tapped.a = tonumber( config.Tapped.a or default.Tapped.a );
		
		config.Hostile.r = tonumber( config.Hostile.r or default.Hostile.r );
		config.Hostile.g = tonumber( config.Hostile.g or default.Hostile.g );
		config.Hostile.b = tonumber( config.Hostile.b or default.Hostile.b );
		config.Hostile.a = tonumber( config.Hostile.a or default.Hostile.a );
		
		config.Neutral.r = tonumber( config.Neutral.r or default.Neutral.r );
		config.Neutral.g = tonumber( config.Neutral.g or default.Neutral.g );
		config.Neutral.b = tonumber( config.Neutral.b or default.Neutral.b );
		config.Neutral.a = tonumber( config.Neutral.a or default.Neutral.a );
		
		config.Friendly.r = tonumber( config.Friendly.r or default.Friendly.r );
		config.Friendly.g = tonumber( config.Friendly.g or default.Friendly.g );
		config.Friendly.b = tonumber( config.Friendly.b or default.Friendly.b );
		config.Friendly.a = tonumber( config.Friendly.a or default.Friendly.a );
		
		config.Player.r = tonumber( config.Player.r or default.Player.r );
		config.Player.g = tonumber( config.Player.g or default.Player.g );
		config.Player.b = tonumber( config.Player.b or default.Player.b );
		config.Player.a = tonumber( config.Player.a or default.Player.a );
		
		config.PvP_Enabled.r = tonumber( config.PvP_Enabled.r or default.PvP_Enabled.r );
		config.PvP_Enabled.g = tonumber( config.PvP_Enabled.g or default.PvP_Enabled.g );
		config.PvP_Enabled.b = tonumber( config.PvP_Enabled.b or default.PvP_Enabled.b );
		config.PvP_Enabled.a = tonumber( config.PvP_Enabled.a or default.PvP_Enabled.a );
		
		config.PvP_Available.r = tonumber( config.PvP_Available.r or default.PvP_Available.r );
		config.PvP_Available.g = tonumber( config.PvP_Available.g or default.PvP_Available.g );
		config.PvP_Available.b = tonumber( config.PvP_Available.b or default.PvP_Available.b );
		config.PvP_Available.a = tonumber( config.PvP_Available.a or default.PvP_Available.a );
		
		config.PvP_Active.r = tonumber( config.PvP_Active.r or default.PvP_Active.r );
		config.PvP_Active.g = tonumber( config.PvP_Active.g or default.PvP_Active.g );
		config.PvP_Active.b = tonumber( config.PvP_Active.b or default.PvP_Active.b );
		config.PvP_Active.a = tonumber( config.PvP_Active.a or default.PvP_Active.a );
		
	end	
	
	-- in the event we have frames already registered, update them according
	-- to the potentially new set of reaction colors
	
	nUI_Unit:refreshReactionCallbacks();
	
--	nUI_ProfileStop();
	
end

-------------------------------------------------------------------------------
-- add and remove callbacks from the list of unit reaction listeners we manage
--
-- calling this method will return the current unit_info structure for this 
-- unit if it exists or nil if the unit does not exist at this time
--
-- Note: these callbacks will be notified both when the underlying GUID for the
--		 unit changes or when the reaction of the underlying GUID to the
--		 player changes. If the underlying unit does not exist, the callback
--		 will be passed a nil unit_info structure

function nUI_Unit:registerReactionCallback( unit_id, callback )
	
--	nUI_ProfileStart( ProfileCounter, "registerReactionCallback" );
	
	unit_info = nil;
	
	if unit_id and callback then
		
		-- get the list of callbacks for this unit id and add this callback
		
		list = ReactionCallbacks[unit_id] or {};
		
		nUI:TableInsertByValue( list, callback );
		
		-- if this is a new unit id, add it to the callback list
		
		if not ReactionCallbacks[unit_id] then
			ReactionCallbacks[unit_id] = list;
		end
		
		-- if this is the first callback for the unit id, then register our
		-- event driver to receive notice when the GUID changes on this id
		
		if #list == 1 then
			nUI_Unit:registerUnitChangeCallback( unit_id, nUI_Unit.Drivers.Reaction );
		end
		
		-- collect reaction information for this unit as we know it at this time
	
		unit_info = nUI_Unit:getUnitInfo( unit_id );
		
		if unit_info then
			nUI_Unit:updateReactionInfo( unit_id, unit_info );
		end
	end
	
--	nUI_ProfileStop();
	
	return unit_info;
	
end

function nUI_Unit:unregisterReactionCallback( unit_id, callback )
	
--	nUI_ProfileStart( ProfileCounter, "unregisterReactionCallback" );
	
	if unit_id and callback then
		
		-- get the list of current callbacks for this unit ud and remove this callback
		
		list = ReactionCallbacks[unit_id] or {};
		
		nUI:TableRemoveByValue( list, callback );
		
		-- if that's the last callback in the list, then remove our event handler of
		-- the list of unit change callbacks for that unit it
		
		if #list == 0 then
			nUI_Unit:unregisterUnitChangeCallback( unit_id, nUI_Unit.Drivers.Reaction );
		end
	end
	
--	nUI_ProfileStop();
	
end

-------------------------------------------------------------------------------
-- retrieve information about the reaction, or potential reaction of a unit to
-- the player, or the player's own status if the unit is the player
--
-- note: it is the caller's responsibility to ensure that the unit_info being
--       passed belongs to the unit_id that is passed. Generally third party
--       consumers of unit_info should not call this method, rather they 
--       should use the callback registration system to get change notices
--       and let the nUI unit driver engine do the updating. If you MUST call
--       this method, you should first test that the following condition 
--       evaluates as true: UnitGUID( unit_id ) == unit_info.guid
--
-- returns the modified unit information structure if anything has changed
-- or nil if there has been no change in reaction

function nUI_Unit:updateReactionInfo( unit_id, unit_info )
	
--	nUI_ProfileStart( ProfileCounter, "updateReactionInfo" );
	
	modified  = false;

	-- collect infomation about the unit's reaction, or potential reaction
	
	if unit_info then
		
		is_pvp        = UnitIsPVP( unit_id );
		is_ffa        = UnitIsPVPFreeForAll( unit_id );
		is_sanctuary  = UnitIsPVPSanctuary( unit_id );
		is_controlled = UnitPlayerControlled( unit_id );
		is_friend     = UnitIsFriend( "player", unit_id );
		is_tapped 	  = UnitIsTapDenied(unit_id);
		is_trivial    = UnitIsTrivial( unit_id );
		in_party	  = UnitPlayerOrPetInParty( unit_id ) or UnitIsUnit( unit_id, "player" ) and GetNumPartyMembers() > 0;
		in_raid       = UnitPlayerOrPetInRaid( unit_id ) or UnitIsUnit( unit_id, "player" ) and GetNumRaidMembers() > 0;
		reaction      = UnitReaction( "player", unit_id );
		can_attack    = UnitCanAttack( unit_id, "player" );
		attackable    = UnitCanAttack( "player", unit_id );
		raid_size     = 0;

		faction, faction_name = UnitFactionGroup( unit_id );
		
		-- if the unit is in the player's party, on which party id?
		
		if in_party then
			
			if unit_info.is_self then party_id = 0;
			else
				for i=1,4 do
					
					if UnitIsUnit( unit_id, "party"..i ) then
						party_id = i;
						break;
					end
				end
			end
		end

		-- if the unit is in the player's raid, on which raid id?
		
		if in_raid then
				
			raid_size = GetNumRaidMembers();
			
			for i=1,raid_size do
				
				local name = GetRaidRosterInfo( i );
				
				if name and UnitIsUnit( unit_id, name ) then 
					raid_id = i;
					break; 
				end
			end			
		end
		
		-- if anything changed, update the GUID cache accordingly
		
		if unit_info.is_pvp        ~= is_pvp
		or unit_info.is_ffa        ~= is_ffa
		or unit_info.is_santuary   ~= is_sanctuary
		or unit_info.is_controlled ~= is_controlled
		or unit_info.is_friend     ~= is_friend
		or unit_info.is_tapped     ~= is_tapped
		or unit_info.is_trivial    ~= is_trivial
		or unit_info.in_party      ~= in_party
		or unit_info.in_raid       ~= in_raid
		or unit_info.raid_size     ~= raid_size
		or unit_info.party_id      ~= party_id
		or unit_info.raid_id       ~= raid_id
		or unit_info.can_attack    ~= can_attack
		or unit_info.attackable    ~= attackable
		or unit_info.reaction      ~= reaction
		or unit_info.faction       ~= faction
		or unit_info.faction_name  ~= faction_name
		then

			-- if this unit is the player and the player has just
			-- flagged for PvP, create a sound for it
			
			if unit_info.is_self then

				-- is the player PvP now?
				
				if is_ffa 
				or (faction and is_pvp)
				then
					
					-- was the player not in PvP last time we updated?
					
					if not unit_info.is_ffa 
					and not (faction and unit_info.is_pvp)
					then
					
						PlaySound( "igPVPUpdate" );
						
					end					
				end			
			end		

			-- update the GUID cache
			
			modified                = true;
			unit_info.last_change   = GetTime();
			unit_info.modified      = true;
			unit_info.is_pvp        = is_pvp;
			unit_info.is_ffa        = is_ffa;
			unit_info.is_sanctuary  = is_sanctuary;
			unit_info.is_controlled = is_controlled;
			unit_info.is_friend     = is_friend;
			unit_info.is_tapped     = is_tapped;
			unit_info.is_trivial    = is_trivial;
			unit_info.in_party      = in_party;
			unit_info.in_raid       = in_raid;
			unit_info.party_id      = party_id;
			unit_info.raid_id       = raid_id;
			unit_info.can_attack    = can_attack;
			unit_info.attackable    = attackable;
			unit_info.reaction      = reaction;
			unit_info.faction       = faction;
			unit_info.faction_name  = faction_name;
			
		end
	end	
	
	-- if we found new information about the unit, then we need to set a reaction color
	
	if modified then
		
		colors = nUI_UnitOptions.ReactionColors or nUI_DefaultConfig.ReactionColors;
	
		-- color selection for units that are controlled by a player
		
		if unit_info.is_controlled then
			
			-- color selection for this player, the player's pet and party/raid members
			
			if unit_info.is_self
			or unit_info.is_pet
			or unit_info.in_party
			or unit_info.in_raid
			then
				
				if unit_info.is_pvp or unit_info.is_ffa then
					unit_info.reaction_color = colors.PvP_Enabled;
				else
					unit_info.reaction_color = nil;
				end
	
			-- if the unit can attack the player...
			
			elseif unit_info.can_attack then
				
				if unit_info.attackable then
					unit_info.reaction_color = colors.PvP_Active;
				else
					unit_info.reaction_color = colors.Player;
				end
				
			-- if we can attack the other player, but they can't attack us
			
			elseif unit_info.attackable then
			
				unit_info.reaction_color = colors.PvP_Available;
	
			-- if the unit is PvP and not in sanctuary
			
			elseif unit_info.is_pvp
			and not unit_info.is_sanctuary
			and not nUI_Unit.PlayerInfo.is_sanctuary
			then
				
				unit_info.reaction_color = colors.PvP_Enabled;
				
			-- otherwise this is simply a player character
			
			else
				
				unit_info.reaction_color = colors.Player;
				
			end
		
		-- color selection for non-player units we can attack
		
		elseif unit_info.attackable then
			
			if unit_info.is_tapped
			then
				
				unit_info.reaction_color = colors.Tapped;
				
			elseif unit_info.is_trivial then
				
				unit_info.reaction_color = colors.Trivial;
				
			elseif unit_info.reaction >= 0 
			and unit_info.reaction <= 3
			then
				
				unit_info.reaction_color = colors.Hostile;
				
			else
				
				unit_info.reaction_color = colors.Neutral;
				
			end
		
		-- friendly NPC's
		
		elseif unit_info.is_friend then
			
			unit_info.reaction_color = colors.Friendly;
			
		else
			
			unit_info.reaction_color = colors.Neutral;
			
		end
	end
	
	-- return the unit info if it changed, nil otherwise
	
--	nUI_ProfileStop();
	
	return modified and unit_info or nil;
	
end

-------------------------------------------------------------------------------
-- update all of the registered reaction listeners, even if there's no 
-- change in data... typically used when the reaction color options change
-- or entering the world

function nUI_Unit:refreshReactionCallbacks()
	
--	nUI_ProfileStart( ProfileCounter, "refreshReactionCallbacks" );
	
	for unit_id in pairs( ReactionCallbacks ) do
		if ReactionCallbacks[unit_id] and #ReactionCallbacks[unit_id] > 0 then
			UpdateQueue[unit_id] = true;
			NewUnitInfo[unit_id] = nUI_Unit:getUnitInfo( unit_id );
		end
	end

--	nUI_ProfileStop();
	
end
