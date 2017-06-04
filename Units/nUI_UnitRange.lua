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
if not nUI.SpellStatus then nUI.SpellStatus = {}; end
if not nUI_Profile then nUI_Profile = {}; end;

local CheckInteractDistance = CheckInteractDistance;
local CreateFrame           = CreateFrame;
local GetSpellBookItemName          = GetSpellBookItemName;
local GetTime               = GetTime;
local IsSpellInRange        = IsSpellInRange;
local SpellHasRange         = SpellHasRange;

local SpellStatus = nUI.SpellStatus;

nUI_Profile.nUI_UnitRange       = {};
nUI_Profile.nUI_UnitRange.Frame = {};

local ProfileCounter      = nUI_Profile.nUI_UnitRange;
local FrameProfileCounter = nUI_Profile.nUI_UnitRange.Frame;

-------------------------------------------------------------------------------

nUI_DefaultConfig.RangeColors = 
{
	melee = { r = 1, g = 0.25, b = 0.25 },
	short = { r = 1, g = 1, b = 0.25 },
	med   = { r = 0.25, g = 1, b = 0.25 },
	long  = { r = 0.25, g = 1, b = 1 },
	oor   = { r = 1, g = 1, b = 1 },
};

nUI_UnitOptions.RangeColors = nUI_DefaultConfig.RangeColors;

-------------------------------------------------------------------------------
-- spells we manualy exclude from the range check logic

local ExcludedRangedSpells =
{
	["Raptor Strike"] = 1,
	["Dismiss Pet"] = 1,
	["Eagle Eye"] = 1,
	["Fishing"] = 1,
	["Eyes of the Beast"] = 1,
	["Hunter's Mark"] = 1,
	["Misdirection"] = 1,
	["Flare"] = 1,
};

-------------------------------------------------------------------------------
-- spells we know to be zero max range but valid for range checking

local ZeroRangeSpells =
{
	["Mongoose Bite"] = 1,
	["Wing Clip"] = 1,
};

-------------------------------------------------------------------------------
-- this method may need a little explanation on intent. It is used to build a
-- list of spells the player has which have a range component to them. That is
-- later used to range check distances to targets. The list is cached for the
-- sake of efficiency and only updated if the player's spellbook changes.

local function GetSpellBookItemName()
	return nil, nil;
end

local function createRangeList()

--	nUI_ProfileStart( ProfileCounter, "createRangeList" );
	
	local player_info     = nUI_Unit:getUnitInfo( "player" );		
	
	-- 5.0.1 Change Start - check if player_info has been filled
	if not player_info then return end
	-- 5.0.1 change End

	player_info.RangeList = {};
	

	-- 5.0.4 Update - Use this instead

	-- Get Specialization Spell Tab Info
	local tabName, tabTexture, tabOffset, tabSlots, tabIsGuild, tabOffSpecID = GetSpellTabInfo(2);

	-- Cycle through specialization spell tab and extra spells for cooldown usage
	for i = tabOffset+1, tabSlots+tabOffset do
		local spellType, spellID = GetSpellBookItemInfo( i, BOOKTYPE_SPELL );
		local spellName, spellRank = GetSpellInfo( i, BOOKTYPE_SPELL );

		if ( spellName ~= nil ) then
			if SpellHasRange( spellName ) then
				if not ExcludedRangedSpells[spellName] then
					local spell_name, spell_rank, spell_icon, cast_time, min_range, max_range = GetSpellInfo( spellName );

					if max_range and max_range > 0 then
						
						if not player_info.RangeList[spellName] 
						or (spellRank and spellRank > player_info.RangeList[spellName].rank)
						then
							
							-- insert the new spell into the table at the current index
							
							local new_spell =
							{
								id   = i,
								name = spellName,
								rank = spellRank,
								min  = min_range,
								max  = max_range,
							};
							
							player_info.RangeList[spellName] = new_spell;

						end
					end
				end
			end
		end
	end

--	nUI_ProfileStop();
	
end

-------------------------------------------------------------------------------
-- unit range event management

if not nUI_Unit.Drivers then 
	nUI_Unit.Drivers = CreateFrame( "Frame", "nUI_UnitDrivers", WorldFrame ); 
end

local frame = CreateFrame( "Frame", "$parent_Range", nUI_Unit.Drivers )

local RangeCallbacks    = {};
local RangeUnits        = {};
local NewUnitInfo       = {};
local UpdateQueue       = {};
local queue_timer       = 1 / nUI_DEFAULT_FRAME_RATE;

nUI_Unit.Drivers.Range  = frame;

-------------------------------------------------------------------------------
-- variables used in methods within this module are declared here to eliminate
-- the use of dynamic memory and the garbage collector

local unit_id;
local unit_info;
local list;
local modified;
local prior_state;
local RangeList;
local text;
local min_range;
local max_range;		
local color;
local spell;
local id;
local result;
local range28;
local range11;
local range10;
local range_info;
local show_icon;
local r, g, b;

-------------------------------------------------------------------------------

local function onRangeEvent( who, event, arg1 )
	
--	nUI_ProfileStart( ProfileCounter, "onRangeEvent", event );
	
	if event == "ADDON_LOADED" and arg1 == "nUI" then
		
		nUI:registerSkinnedFrame( frame );
		
	-- create a list of ranged spells for the player when they login and 
	-- update the list any time they learn a new spell
	
	elseif event == "LEARNED_SPELL_IN_TAB" 
	or     event == "PLAYER_LOGIN"
	or     event == "PLAYER_SPECIALIZATION_CHANGED"			-- 5.0.4 Change
	then
		
		createRangeList();
		
	-- for these events, we don't know which units are affected, so
	-- we span the list of all known interested units to see who is watching
		
	elseif event == "PLAYER_ENTERING_WORLD" then
		
		nUI_Unit:refreshRangeCallbacks();
		
	end

--	nUI_ProfileStop();
	
end

frame:SetScript( "OnEvent", onRangeEvent );
frame:RegisterEvent( "ADDON_LOADED" );
frame:RegisterEvent( "PLAYER_LOGIN" );
frame:RegisterEvent( "LEARNED_SPELL_IN_TAB" );
frame:RegisterEvent( "PLAYER_ENTERING_WORLD" );
frame:RegisterEvent("PLAYER_SPECIALIZATION_CHANGED");		-- 5.0.4 Change

-------------------------------------------------------------------------------
-- periodically recheck range to each tracked unit id and look for changes
-- in range for those units that exist

-------------------------------------------------------------------------------

local function onQueueUpdate( who, elapsed )

	queue_timer = queue_timer - elapsed;
	
	if queue_timer <= 0 then -- process the update queue at the user selected frame rate
	
		queue_timer = nUI_Unit.frame_rate;

		for unit_id in pairs( RangeCallbacks ) do
		
			if RangeCallbacks[unit_id] and #RangeCallbacks[unit_id] > 0 then

				unit_info = nUI_Unit:getUnitInfo( unit_id );
			
				if unit_info or UpdateQueue[unit_id] then
			
					UpdateQueue[unit_id] = false;
								
					nUI_Unit:notifyCallbacks( 
						nUI_L["unit range"], RangeCallbacks, RangeUnits, 
						unit_info, unit_id, nUI_Unit:updateRangeInfo( unit_id, unit_info ) 
					);
				end
			end
		end
	end	
end

frame:SetScript( "OnUpdate", onQueueUpdate );

-------------------------------------------------------------------------------
-- this callback method is called when one of the unit IDs we are monitoring
-- for unit range changes

frame.newUnitInfo = function( unit_id, unit_info )

--	nUI_ProfileStart( ProfileCounter, "newUnitInfo" );
	
	UpdateQueue[unit_id] = true;
	NewUnitInfo[unit_id] = unit_info;
	
--	nUI_ProfileStop();
	
end

-------------------------------------------------------------------------------

frame.applySkin = function( skin )
	
--	nUI_ProfileStart( ProfileCounter, "applySkin" );
	
	nUI_UnitOptions.RangeColors = skin.RangeColors or nUI_DefaultConfig.RangeColors;

	nUI_Unit:refreshRangeCallbacks();
	
--	nUI_ProfileStop();
	
end

-------------------------------------------------------------------------------
-- add and remove callbacks from the list of unit range listeners we manage
--
-- calling this method will return the current unit_info structure for this 
-- unit if it exists or nil if the unit does not exist at this time
--
-- Note: these callbacks will be notified both when the underlying GUID for the
--		 unit changes or when the range info of the underlying GUID to the
--		 player changes. If the underlying unit does not exist, the callback
--		 will be passed a nil unit_info structure

function nUI_Unit:registerRangeCallback( unit_id, callback )
	
--	nUI_ProfileStart( ProfileCounter, "registerRangeCallback" );
	
	unit_info = nil;
	
	if unit_id and callback then
		
		-- get the list of callbacks for this unit id and add this callback
		
		list = RangeCallbacks[unit_id] or {};
		
		nUI:TableInsertByValue( list, callback );
		
		-- if this is a new unit id, add it to the callback list
		
		if not RangeCallbacks[unit_id] then
			RangeCallbacks[unit_id] = list;
		end
		
		-- if this is the first callback for the unit id, then register our
		-- event driver to receive notice when the GUID changes on this id
		
		if #list == 1 then
			nUI_Unit:registerUnitChangeCallback( unit_id, nUI_Unit.Drivers.Range );
		end
		
		-- collect range information for this unit as we know it at this time
	
		unit_info = nUI_Unit:getUnitInfo( unit_id );
		
		if unit_info then
			nUI_Unit:updateRangeInfo( unit_id, unit_info );
		end
	end
	
--	nUI_ProfileStop();
	
	return unit_info;
	
end

function nUI_Unit:unregisterRangeCallback( unit_id, callback )
	
--	nUI_ProfileStart( ProfileCounter, "unregisterRangeCallback" );
	
	if unit_id and callback then
		
		-- get the list of current callbacks for this unit ud and remove this callback
		
		list = RangeCallbacks[unit_id] or {};
		
		nUI:TableRemoveByValue( list, callback );
		
		-- if that's the last callback in the list, then remove our event handler of
		-- the list of unit change callbacks for that unit it
		
		if #list == 0 then
			nUI_Unit:unregisterUnitChangeCallback( unit_id, nUI_Unit.Drivers.Range );
		end
	end

--	nUI_ProfileStop();
	
end

-------------------------------------------------------------------------------
-- update the range information for this unit
--
-- note: it is the caller's responsibility to ensure that the unit_info being
--       passed belongs to the unit_id that is passed. Generally third party
--       consumers of unit_info should not call this method, rather they 
--       should use the callback registration system to get change notices
--       and let the nUI unit driver engine do the updating. If you MUST call
--       this method, you should first test that the following condition 
--       evaluates as true: UnitGUID( unit_id ) == unit_info.guid
--
-- returns the updated unit information structure for the current GUID
-- if the data has changed, otherwise returns nil if nothing changed

function nUI_Unit:updateRangeInfo( unit_id, unit_info )

--	nUI_ProfileStart( ProfileCounter, "updateRangeInfo" );
	
	modified  = false;
	RangeList = nUI_Unit.PlayerInfo and nUI_Unit.PlayerInfo.RangeList;
	
	if unit_info and RangeList then
		
		-- if we're looking at ourself, don't bother
		
		if unit_info.is_self
		then

			color     = nUI_UnitOptions.RangeColors.melee;
			min_range = nil;
			max_range = nil;
			text      = nil;
		
		-- otherwise, if the unit is not visible, we can only say it's more than 100yds away
		
		elseif not unit_info.is_visible then

			color     = nUI_UnitOptions.RangeColors.oor;
			min_range = 100;
			max_range = nil;
			text      = ("|cFFFFFFFF%s:|r 100+"):format( nUI_L["Range"] );
	
		-- if the unit is visble, then use our range list and interaction info to determine range
		
		else

			min_range = 0;
			max_range = 100;
			
			-- parse the spell list and see what we learn from it
			
			for i in pairs( RangeList ) do
				
				spell  = RangeList[i];
				id     = spell.id;
				result = IsSpellInRange( id, BOOKTYPE_SPELL, unit_id );
				
				if result == 1 then
					
					if spell.max < max_range then 
						max_range = spell.max; 
					end
					if spell.min > min_range then 
						min_range = spell.min; 
					end
					if min_range > max_range then 
						min_range = 0; 
					end
					
				elseif result == 0 then 
					
					if spell.max > min_range and spell.max < max_range then
						min_range = spell.max;
					end				
				end
			end	
			
			-- see if we can learn anything narrower from interaction distance
			
			range28 = CheckInteractDistance( unit_id, 4 );
			range11 = CheckInteractDistance( unit_id, 2 );
			range10 = CheckInteractDistance( unit_id, 3 );
			
			if range28 and max_range > 28 then max_range = 28;
			elseif not range28 and min_range < 28 then min_range = 28;
			end
			
			if range11 and max_range > 11 then max_range = 11;
			elseif not range11 and min_range < 11 then min_range = 11;
			end
			
			if range10 and max_range > 10 then max_range = 10;
			elseif not range10 and min_range < 10 then min_range = 10;
			end
			
			if min_range > max_range then
				min_range = max_range;
			end
			
			-- build the range text and color from the result
			
			if max_range <= 5 then text = ("|cFFFFFFFF%s:|r %s"):format( nUI_L["Range"], nUI_L["MELEE"] );
			elseif min_range == max_range then text = ("|cFFFFFFFF%s:|r %d"):format( nUI_L["Range"], min_range );
			else text = ("|cFFFFFFFF%s:|r %d-%d"):format( nUI_L["Range"], min_range, max_range );
			end
			
			if     min_range <= 5  then color = nUI_UnitOptions.RangeColors.melee;				
			elseif min_range <= 20 then color = nUI_UnitOptions.RangeColors.short;
			elseif min_range <= 30 then color = nUI_UnitOptions.RangeColors.med;
			elseif min_range <= 40 then color = nUI_UnitOptions.RangeColors.long;
			else                        color = nUI_UnitOptions.RangeColors.oor;
			end
			
		end
	
		-- do the actual update;
		
		if not unit_info.range_info
		or unit_info.range_info.min     ~= min_range
		or unit_info.range_info.max     ~= max_range
		or unit_info.range_info.text    ~= text
		or unit_info.range_info.color.r ~= color.r
		or unit_info.range_info.color.g ~= color.g
		or unit_info.range_info.color.b ~= color.b
		then
			modified              = true;
			unit_info.modified    = true;
			unit_info.last_change = GetTime();
			
			if not unit_info.range_info then
				unit_info.range_info = {};
			end
			
			unit_info.range_info.min   = min_range;
			unit_info.range_info.max   = max_range;
			unit_info.range_info.text  = text;
			unit_info.range_info.color = color;
		end
	end
	
--	nUI_ProfileStop();
	
	return modified and unit_info or nil;
	
end

-------------------------------------------------------------------------------
-- update all of the registered unit range listeners, even if there's no 
-- change in data... typically used when the range options change
-- or entering the world

function nUI_Unit:refreshRangeCallbacks()

--	nUI_ProfileStart( ProfileCounter, "refreshRangeCallbacks" );
	
	for unit_id in pairs( RangeCallbacks ) do
		if RangeCallbacks[unit_id] and #RangeCallbacks[unit_id] > 0 then
			UpdateQueue[unit_id] = true;
			NewUnitInfo[unit_id] = nUI_Unit:getUnitInfo( unit_id );
		end
	end

--	nUI_ProfileStop();
	
end

-------------------------------------------------------------------------------
-- create a new unit range frame

function nUI_Unit:createRangeFrame( parent, unit_id, id, options )

--	nUI_ProfileStart( ProfileCounter, "createRangeFrame" );
	
	local frame          = nUI_Unit:createFrame( "$parent_Range"..(id or ""), parent, unit_id, options and options.clickable );	
	frame.text           = frame:CreateFontString( "$parentLable", "OVERLAY" );
	frame.texture        = frame:CreateTexture( "$parentTexture", "ARTWORK" );
	frame.texture.active = true;
	frame.Super          = {};
	
	frame.texture:SetPoint( "CENTER", frame, "CENTER", 0, 0 );
	frame.texture:SetTexture( "Interface\\AddOns\\nUI\\Layouts\\Default\\Art\\nUI_UnitRange" );

	-- called when the underlying GUID for the unit changes or when the
	-- content of the GUID is updated
	
	frame.Super.newUnitInfo = frame.newUnitInfo;
	frame.newUnitInfo       = function( list_unit, unit_info )
		
--		nUI_ProfileStart( FrameProfileCounter, "newUnitInfo" );
		
		frame.Super.newUnitInfo( list_unit, unit_info );
		
		if frame.enabled then
			nUI_Unit:updateRangeFrame( frame );
		end
		
--		nUI_ProfileStop();
		
	end
	
	-- setting enabled to false will prevent the frame from updating when new
	-- unit information is received (saves framerate). Setting enabled true will
	-- call the frame to immediately update if its content has changed since it
	-- was disabled

	frame.Super.setEnabled = frame.setEnabled;	
	frame.setEnabled       = function( enabled )
		
--		nUI_ProfileStart( FrameProfileCounter, "setEnabled" );
		
		prior_state = frame.enabled;
		
		frame.Super.setEnabled( enabled );
		
		if frame.enabled ~= prior_state then
		
			if frame.enabled then
				frame.unit_info = nUI_Unit:registerRangeCallback( frame.unit, frame );
				nUI_Unit:updateRangeFrame( frame );
			else
				nUI_Unit:unregisterRangeCallback( frame.unit, frame );
			end
		end

--		nUI_ProfileStop();
		
	end
	
	-- used to change the scale of the frame... rather than the Bliz widget frame:SetScale()
	-- this method actually recalculates the size of the frame and uses frame:SetHeight()
	-- and frame:SetWidth() to reflect the actual size of the frame.

	frame.Super.applyScale = frame.applyScale;
	frame.applyScale       = function( scale )
		
--		nUI_ProfileStart( FrameProfileCounter, "applyScale" );
		
		frame.Super.applyScale( scale );

		if frame.options then
			frame.configText( frame.text, frame.options.label );
		end
		
		if frame.texture.hSize  ~= frame.hSize 
		or frame.texture.vSize  ~= frame.vSize 
		or frame.texture.width  ~= frame.width
		or frame.texture.hInset ~= frame.hInset 
		or frame.texture.vInset ~= frame.vInset 
		then
			
			frame.texture.hSize  = frame.hSize;
			frame.texture.vSize  = frame.vSize;
			frame.texture.width  = frame.width;
			frame.texture.hInset = frame.hInset;
			frame.texture.vInset = frame.vInset;
			
			frame.texture:SetWidth( (frame.hSize or frame.width) - frame.hInset );
			frame.texture:SetHeight( (frame.vSize or frame.width) / 4 - frame.vInset );

		end

--		nUI_ProfileStop();
		
	end
	
	-- applies the set of frame options to this frame. Typically called when the frame 
	-- is first created or when the user changes options via config.
	
	frame.Super.applyOptions = frame.applyOptions;
	frame.applyOptions       = function( options )

--		nUI_ProfileStart( FrameProfileCounter, "applyOptions" );
		
		frame.Super.applyOptions( options );		
		nUI_Unit:updateRangeFrame( frame );
		
--		nUI_ProfileStop();
		
	end

	-- initiate the frame
	
	frame.unit_info = nUI_Unit:registerRangeCallback( frame.unit, frame );
	
	frame.applyOptions( options );
	
--	nUI_ProfileStop();
	
	return frame;
	
end

-------------------------------------------------------------------------------
-- remove a unit range frame

function nUI_Unit:deleteRangeFrame( frame )

--	nUI_ProfileStart( ProfileCounter, "deleteRangeFrame" );
		
	nUI_Unit:unregisterRangeCallback( frame.unit, frame );
	nUI_Unit:deleteFrame( frame );
	
	frame.parent.applyFrameFader( frame, false );	
	
--	nUI_ProfileStop();
	
end

-------------------------------------------------------------------------------
-- display the appropriate info for the unit's range
--
-- note: this method expends extra energy in state management... as in knowing
--       exactly what state it is currently in and only updating the frame text,
--       content, colors, alphas, etc. when a change in state occurs. The extra
--       effort is spent on state management in order to reduce impact to the
--       graphis engine so as to preserve frame rate. It costs far less to check
--		 a memory value that and burn through the graphics geometry. It does not
--       matter how many times the unit changes GUID or how many times this 
--       method will call, it will only alter the graphics elements when its
--       relative state changes.

function nUI_Unit:updateRangeFrame( frame )
	
--	nUI_ProfileStart( ProfileCounter, "updateRangeFrame" );
		
	unit_info = frame.unit_info;
	range_info = unit_info and unit_info.range_info or nil;
	
	-- if there is no unit or we don't know it's range, then hide the frame
	
	if not range_info then
		
		if frame.active then
			frame.active = false;
			frame.texture:SetAlpha( 0 );
		end
	
	-- otherwise, show the icon and clip the appropriate region
	
	else

		-- if the range frame is hidden, show it
		
		if not frame.active then
			frame.active = true;
			frame.texture:SetAlpha( 1 );
		end

		-- if we're using a text label, update it
		
		if frame.text.enabled then
			
			if frame.text.value ~= range_info.text then
			
				frame.text.value = range_info.text;
				frame.text:SetText( range_info.text and range_info.text or "" );
				
			end
		
			color = range_info.color;
			
			if frame.text.r ~= color.r
			or frame.text.g ~= color.g
			or frame.text.b ~= color.b
			then
				
				frame.text.r = color.r;
				frame.text.g = color.g;
				frame.text.b = color.b;
				
				frame.text:SetTextColor( color.r, color.g, color.b );
				
			end
		end

		-- if we're using a range icon, update it
		
		show_icon = false;
		
		if frame.options.inrange_icon
		and range_info.max
		and range_info.max <= 40
		then
			
			show_icon = true;
			
			if range_info.max < 10 then
				r = 0;
				g = 0;
				b = 1;
			elseif range_info.max <= 30 then
				r = 0;
				g = 1;
				b = 0;
			else
				r = 1;
				g = 1;
				b = 0;
			end
		
		elseif frame.options.outofrange_icon 
		and range_info.min
		and range_info.min >= 30
		then
			
			show_icon = true;
			
			if range_info.min >= 40 then
				r = 1;
				g = 0;
				b = 0;
			else
				r = 1;
				g = 1;
				b = 0;
			end
		end
		
		if show_icon then
			
			if not frame.texture.active then
				frame.texture.active = true;
				frame.texture:SetAlpha( 1 );
			end
			
			if frame.texture.r ~= r
			or frame.texture.g ~= g
			or frame.texture.b ~= b
			then
				
				frame.texture.r = r;
				frame.texture.g = g;
				frame.texture.b = b;
				
				frame.texture:SetVertexColor( r, g, b, 1 );
				
			end
			
		elseif frame.texture.active then
			
			frame.texture.active = false;
			frame.texture:SetAlpha( 0 );
			
		end			
		
		-- if we're doing parent fading, check it
		
		local fade_frame = false;
		
		if range_info.min
		and range_info.min >= 40
		then fade_frame = true;
		end
		
		frame.parent.applyFrameFader( frame, fade_frame and frame.options.fade_unit );
			
	end
	
--	nUI_ProfileStop();
	
end
