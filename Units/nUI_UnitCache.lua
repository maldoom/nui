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

if not nUI_Unit then nUI_Unit = {}; end
if not nUI_Unit.CurrentUnit then nUI_Unit.CurrentUnit = {}; end
if not nUI_UnitOptions then nUI_UnitOptions = {}; end
if not nUI_DefaultConfig then nUI_DefaultConfig = {}; end
if not nUI_Profile then nUI_Profile = {}; end;

nUI_Profile.nUI_UnitCache  = {};

local ProfileCounter = nUI_Profile.nUI_UnitCache;

--[[---------------------------------------------------------------------------

-- What a unit information structure looks like. Note that all elements may
-- not be present at any given time depending on the current update status
-- of the various elements of the unit's referring to this particular instance
-- and always represents the last known values which may or may not be current
-- depending on whether or not anyone is observing a unit to which this GUID
-- belongs and if any change in status has occured since last observed
--
-- The information contained in this structure is never guaranteed to be 100%
-- accurate, complete or current. It is always "best-known" as of the time it
-- is examined and based on the information available when last observed
--
-- The first time nUI_Unit sees a new GUID (a unique player character or mob)
-- it will attempt to populate as much of this structure as possible. Whether
-- or not the content updates after that will depend on whether or not the GUID
-- is being observed on any units and whether or not any interested parties
-- are registered for callbacks on the observing units at which point only 
-- the information for which they have registered for updates will be updated.
--
-- Unit information structures are observationally transient. There is only
-- one unit_info structure per GUID the player has observed in this session
-- and unit_info structures are not saved between sessions. However, these
-- structures are persistent within a given session even when the GUID is not
-- being observed and their values will only update if and when they
-- are being observed. A unit_info structure is never tied to any particular
-- unit id though it may be observed by any number of unit ids at any time.
--
-- There is no mechanism for knowing whether or not a given unit_info structure
-- is being observed at any given time outside of the nUI_Unit callback system.
-- Interested observers can register to be notified when a given unit changes
-- GUID via nUI_Unit:registerUnitChangeCallback() or when specific elements of 
-- the data associated with a unit change [i.e. nUI_Unit:registerReactionCallback()]
-- or if interested in being updated when changes to a specific GUID are made
-- via nUI_Unit:registerGUIDModifiedCallback()
--
-- it may help to think of this system as a big state machine where the focus is
-- on fetching data as infrequently as possible, performing calculations and making
-- decisions as little as possible and adding a data layer between the Bliz game
-- engine and the data consumer. At any given time, the unit_info structure provides
-- a snapshot of the current known state of that particular object as last observed.

class unit_info =
{
	time last_change		-- the last time the data was changed a per GetTime() with millisecond accuracy
	unsigned long guid      -- a number unique in the WoW universe identifying this unit
	
	boolean modified		-- true when the content was recently modified
	boolean is_visible      -- true if the unit is in visible range (not to be confused with line-of-sight)
	boolean is_self         -- true if this unit refers to the player's toon
	boolean is_pet          -- true if this unit refers to one of the player's pets	
	boolean is_hunter_pet   -- true if this unit is one of the player's hunter pets
	boolean is_pvp			-- true when the unit is flagged for PvP
	boolean is_ffa			-- true when the unit is flagged for PvP Free-for-all
	boolean is_sanctuary	-- true when the unit is in PvP santuary
	boolean is_player		-- true if the unit is a player character (any player)
	boolean is_controlled	-- true if the unit is controlled by a player
	boolean is_friend		-- true if the unit is friendly to the player
	boolean is_tapped		-- true if the unit has been tapped
	boolean is_casting      -- true if the unit has a spellcast underway (may or may not be active)
	boolean is_trivial		-- true if the unit is trivial (grey) to the player
	boolean in_party		-- true if the unit is in the player's party
	boolean in_raid			-- true if the unit is in the player's raid
	boolean has_pet_ui		-- true if this is a player pet that has a pet UI when observed
	boolean can_attack		-- true if the unit can attack the player
	boolean attackable		-- true if the player can attack the unit

	string last_unit        -- the last unit id this GUID was seen on/fetched for
	string name				-- the unit's name
	string realm			-- the realm to which the unit belongs -- nil if unknown or same as player's realm
	stirng class			-- the English name of the unit's class (WARRIOR, DRIUD, etc.)
	string class_name       -- the localized name of the unit's class 
	string faction          -- the English name for the unit's faction group
	string faction_name		-- the localized name of the unit's faction group
	string spec				-- the unit's talent spec or classification (rare, elite, etc.)
	string classification   -- the unit's classification: elite, rare, rareelite, worldboss, normal or trivial
	string family			-- the creature family (Bear, Wolf, etc.)
	string type				-- the creature type (Humanoid, Beast, etc.)
	string race				-- the unit's race (Human, Troll, etc.)
	string ready_check      -- ready check status: 1 ready, 2 not ready, nil if not still pending or no check underway
	string ready_check_icon -- path to ready check status texture or nil if no ready check underway
	
	string pvp_icon			-- if the unit is flagged for PvP or PvP free-for-all, this is the icon texture path
	string pvp_tt_title		-- title string to use for the PvP game tooltip title
	string pvp_tt_text      -- text to use for the PvP game tooltip text

	int cur_health			-- the unit's current health level (relative to the max) or nil if unknown
	int max_health          -- the unit's maximum health or nil if unknown
	float pct_health        -- the unit's current health level as a percentage of the maximum (0 to 1) or nil if unknown
	
	int cur_power           -- the unit's current power level (mana, rage, whatever) or nil if unknown
	int max_power			-- the unit's maximum power level or nil if unknown
	float pct_power			-- the unit's current power level as a percentage of the maximum (0 to 1) or nil if unknown	
	int power_type			-- the type of power applied to this GUID
							   0 = mana
							   1 = rage
							   2 = focus (hunter pets)
							   3 = energy
							   4 = happiness (no longer used? -- used to be for hunters)
							   
	int sex					-- 1 = unknown, 2 = male, 3 = female
	int gcdRemains          -- how much of the current global cooldown remains (as a percent of the total) -- zero if there is no active cooldown -- applicable to the player's info structure only
	int combo_points        -- the number of combo points the player has on this unit, or nil
	int party_id            -- if this GUID is in the player's party then what party ID (1-4) is this, 0 if the player's GUID or nil if not in a party
	int raid_id             -- if this GUID is in the player's raid, on which raid ID (1-40) or nil if not in the raid
	int pet_happiness       -- 1 = angry, 2 = unhappy, 3 = happy (hunter pets only)
	int pet_loyalty         -- N < 0 is losing loyalty, N > 0 gaining loyalty (hunter pets only)
	int pet_damage          -- pet damage modifier angry = 75%, unhappy = 100%, happy = 125% (hunter pets only)
	unsigned long pet_owner -- If this unit is a pet belonging to any player, this will be the owner's GUID
	
	int reaction			-- unit's reaction to the player
							   1 = Exceptionally hostile, 
							   2 = Very Hostile, 
							   3 = Hostile, 
							   4 = Neutral, 
							   5 = Friendly, 
							   6 = Very Friendly, 
							   7 = Exceptionally friendly, 
							   8 = Exalted 

	string pet_foods[]		-- an array of food types this pet eats if this is a hunter pet, nil otherwise
	class valid_foods[x]    -- an array of foods that are appropriate to feed this pet if it is a hunter pet, otherwise nil - x is the Bliz assigned item ID for that food item
	{
		int itemId			-- the unique Bliz assigned item ID
		int itemRarity		-- 0 to 8 where 0 is poor and 8 is artifact
		int itemLevel		-- the food item level
		int itemMinLevel	-- the minimum level required to eat this item, 0 if no minimum
		int itemCount		-- the stack count... how many of this item is allowed per stack
		int itemEquipLoc	-- where this item can be equipped if it can be (i.e. trinkets)
		int itemBag         -- if the player had this item in their bags when they tried to feed their pet, this is the bag number it was in
		int itemSlot        -- again, if the player has this item when they last fed, this is the slot number it was in within the indicated bag
		string itemLink		-- the unique Bliz assigned item link for this entry
		string foodType		-- the type of food: "Meat", "Fish", etc.
		string itemName		-- the localized name of the item
		string itemType     -- the type of item: "Weapon", "Armor", etc.
		string itemSubType	-- the sub-type of the item: "Enchanting", "Cloth", "Sword", etc.
		string itemTexture	-- path to the icon texture file for this item
		button feedButton	-- a clickable action button that can be used to feed this item
	};
	
	class class_info  		-- information used for class coloring and icon selection
	{
		int		row			-- the icon row within "Interface\\AddOns\\nUI\\Layouts\\Default\\Art\\nUI_Icon_Classes.blp"
		int		col			-- the icon column within the same BLP
		float	x1			-- left edge clipping value for SetTexCoord()
		float	x2			-- right edge clipping value
		float	y1			-- top edge clipping value
		float	y2			-- bottom edge clipping value
		
		class color  		-- the player's selected color for the current class' labels
		{
			float r			-- red value from 0 to 1
			float g			-- green value from 0 to 1
			float b			-- blue value from 0 to 1
		};
	};

	class status_info  		-- information gathered by UnitStatus driver
	{
		boolean is_dnd		-- true if the player is flagged DND
		boolean is_afk		-- true if the player is afk
		boolean is_online	-- true if the unit is connected (online)
		boolean is_dead		-- true if the unit is dead
		boolean is_ghost	-- true if the unit is a ghost
		boolean is_fd		-- true if the unit is feigning death (party only)
		boolean is_resting  -- true if the unit is resting and is the player
		boolean is_leader	-- true if the unit is either the party leader or the raid leader
		boolean in_range    -- true if the unit is in range for a typical spellcast
		boolean in_combat   -- true if the unit is currently affecting combat or has agro
		boolean on_taxi     -- true if the unit is on a taxi
	};

	class range_info        -- range to target information
	{
		int min             -- the minimum range from the player to the unit or nil if unit is self
		int max             -- the maximum range from the player to the unit or nil if unit is self or out of visible range
		string text         -- a text label for the range
		
		class color			-- the user selected color to use for this range
		{
			float	r		-- red value from 0 to 1 or nil if no background required
			float	g		-- green value from 0 to 1 or nil if no background required
			float	b		-- blue value from 0 to 1 or nil if no background required
		};
	};
	
	class feedback			-- combat feedback system information
	{
		string action		-- the action type: HEAL, DODGE, BLOCK, WOUND, MISS, PARRY, RESIST, etc.
		string effect		-- the action's effect: GLANCING, CRITICAL, CRUSHING, etc.
		float hitValue		-- the amount of healing/damage incurred as a number
		int hitType			-- damage type as a number: 1 - physical; 2 - holy; 4 - fire; 8 - nature; 16 - frost; 32 - shadow; 64 - arcane
		float start_time	-- the time at which this combat item was recorded
		float end_time		-- the time at which it will expire
		boolean has_agro	-- true if this unit is the agro target of the last hostile target the player had
		boolean has_magic	-- true if the unit has at least one magic class debuff cast on it
		boolean has_curse	-- true if the unit has at least one curse debuff cast on it
		boolean has_poison	-- true if the unit has at least one poison debuff applied to it
		boolean has_disease -- true is the unit has at least one disease debuff on it
		
		class bgColor		-- the background color to use to highlight the feedback
		{
			float	r		-- red value from 0 to 1 or nil if no background required
			float	g		-- green value from 0 to 1 or nil if no background required
			float	b		-- blue value from 0 to 1 or nil if no background required
		};
		
		class txtColor		-- the text color to use to display the hitValue
		{
			float	r		-- red value from 0 to 1 or nil if no text required
			float	g		-- green value from 0 to 1 or nil if no text required
			float	b		-- blue value from 0 to 1 or nil if no text required
		};
		
		class hitColor		-- the border color to use to highlight the type of damage received
		{
			float	r		-- red value from 0 to 1 or nil if no highlight required
			float	g		-- green value from 0 to 1 or nil if no highlight required
			float	b		-- blue value from 0 to 1 or nil if no highlight required
		};
	};
		
	class role_info         -- information about a unit's role within the party or raid, nil if not in a party or raid
	{
		boolean is_leader	-- true if this unit is the party or raid leader
		boolean is_assist   -- true if this unit is a raid assistant
		boolean is_tank     -- true if this unit is the raid's main tank
		boolean is_offtank  -- true if this unit is the raid's off-tank		
		boolean is_ml       -- true if this unit is hte raid's master looter
	};
	
	class raid_info      	-- information about the GUID's role in the current raid or nil
	{
		int		rank		-- 2 = raid leader, 1 = raid assistant, 0 = all others
		int		subGroup	-- which raid group the GUID is in 1-8 
		int     raid_id     -- which raid ID this GUID is assigned to (1-40)
		string	role		-- the unit's role in the raid: maintank, mainassist
		boolean is_ml		-- true if this GUID is the master looter for the raid
	};
	
	class raid_target		-- set if the GUID has a raid target icon (X, diamond, star, etc.) or nil if not
	{
		int		idx			-- which raid target index to use in "Interface\\TargetingFrame\\UI-RaidTargetingIcons"
		float	x1			-- left edge of clipping region for SetTexCoord()
		float	x2			-- right edge of clipping region
		float	y1			-- top edge of clipping region
		float	y2			-- bottom edge of clipping region
	};
	
	class level_color 		-- the player's chosen color for the level difficulty of this GUID
	{
		float	r			-- red value from 0 to 1
		float	g			-- green value from 0 to 1
		float	b			-- blue value from 0 to 1
	};
	
	class reaction_color  	-- the player's chosen color representing this unit's reaction
	{
		float	r			-- red value from 0 to 1
		float	g			-- green value from 0 to 1
		float	b			-- blue value from 0 to 1
		float	a			-- alpha value from 0 to 1 (1 = fully opaque)
	};
	
	class health_color  	-- the player's chosen color representing this unit's current health level
	{
		float	r			-- red value from 0 to 1
		float	g			-- green value from 0 to 1
		float	b			-- blue value from 0 to 1
		float	a			-- alpha value from 0 to 1 (1 = fully opaque)
	};
	
	class power_color  		-- the player's chosen color representing the unit's current power level and type
	{
		float	r			-- red value from 0 to 1
		float	g			-- green value from 0 to 1
		float	b			-- blue value from 0 to 1
		float	a			-- alpha value from 0 to 1 (1 = fully opaque)
	};

	class cast_info         -- information about the current cast if the GUID is casting a spell
	{
		string  spell		-- the spell being cast
		string  rank		-- the spell rank (i.e. Rank 1)
		string	spell_name	-- the localized name of the spell being cast
		string  icon		-- the path to the texture file for the spell's icon
		float	start_time  -- when the spell cast is scheduled to start
		float	end_time	-- when the spell cast is scheduled to end
		float	pct_time	-- what percentage of the spell cast time has elapsed (or 0)
		float	cur_time	-- the amount of time elapsed since the cast began or time remaining when channeling (or 0)
		float	max_time	-- how long it will take to complete the full cast (or 0)
		float	pct_latency	-- percent completion taking current network latency into account (or 0)
		float	cur_latency -- network latency at the time of the most recent casting update (or 0)
		float   max_latency -- total casting time less the current network latency (or 0)
		boolean	active		-- true if the spell is actively being cast at this time
		boolean channeling	-- true if the spell is a channeled spell
		boolean complete	-- true if the spell has been completed (successful or otherwise)
		boolean stopped     -- true when we receive a spellcast "STOP" message for the spell
		boolean interrupted -- true if the spell cast was interrupted
		boolean	failed		-- true if the spell cast failed
		boolean delayed     -- true if the last update was due to the spell being delayed
		boolean succeeded   -- true if we receive a "succeeded" message for the spell
		boolean missed      -- true if we recieve a "missed" message for the spell
		boolean tradeskill  -- true if the spell being cast is for a trade skill
		
		class bar_color		-- the player selected color for the current casting bar
		{
			float	r		-- red value from 0 to 1
			float	g		-- green value from 0 to 1
			float	b		-- blue value from 0 to 1
			float	a		-- alpha value from 0 to 1 (1 = fully opaque)
		};
	};

	class aura_info			-- detail on all of the auras currently on this GUID
	{
		class weapon_buffs[1..2] -- info on temporary weapon enchants -- nil if not player's guid -- [1] is main hand or nil, [2] is offhand or nil
		{
			int id				-- the slot id of the weapon
			int count			-- the number of charges remaining
			float max_time		-- always the same as cur_time
			float cur_time      -- time remaining on spell
			float pct_time		-- always 1
			float start_time	-- always the time at which the observation occured
			float end_time		-- the time as which the buff ends (a la GetTime())
			string icon			-- path to the icon texture for the buffed weapon		
			boolean expired     -- set true when the current time has passed the end time (Bliz may or may not have sent an event yet)
			SetTooltip(frame)	-- function for setting the mouseover tooltip for the passed frame
			SetClick(frame)		-- function for setting the OnClick method for the passed frame needed to cancel the buff (or disable onclick if cannot be cancelled)				
		};
		
		class buff_list[1..n]	-- listing of all buffs on the GUID... indexes run 1 to 40, nil if no buffs
		{
			int id				-- the index used to fetch this buff from UnitBuff()
			int count			-- the number of times the buff has been applied
			int player_idx		-- player spell index if unit is player, nil otherwise
			float max_time		-- the full duration of the buff in seconds if cast by the player, nil otherwise
			float cur_time      -- time remaining on spell if cast by the player, nil otherwise
			float pct_time		-- the percent of time elapsed is cast by the player, nil otherwise
			float start_time	-- the time at which the buff was started (a la GetTime()) if player cast, nil otherwise
			float end_time		-- the time as which the buff ends (a la GetTime()) if player cast, or nil
			string name			-- the name of the buff
			string rank			-- the rank of the buff
			string icon			-- path to the icon texture file for this buff
			string type			-- the dispell type for the buff: "Magic", "Disease", "Curse" or "Poison"
			boolean expired     -- set true when the current time has passed the end time (Bliz may or may not have sent an event yet)
			boolean is_player	-- true if the buff was cast by the player
			boolean until_cancel-- true if the spell is on the player and valid until cancelled
			SetTooltip(frame)	-- function for setting the mouseover tooltip for the passed frame
			SetClick(frame)		-- function for setting the OnClick method for the passed frame needed to cancel the buff (or disables mouse and onclick if cannot be cancelled)
				
			class buff_color	-- the player selected border color to use for this buff
			{
				float	r		-- red value from 0 to 1
				float	g		-- green value from 0 to 1
				float	b		-- blue value from 0 to 1
			};
		};
		
		class debuff_list[1..n] -- listing of all debuffs on the GUID.. indexes run 1 to 40, nil if no debuffs
		{
			int id				-- the index used to fetch this buff from UnitDebuff()
			int count			-- the number of times the buff has been applied
			int player_idx		-- player spell index if unit is player, nil otherwise
			float max_time		-- the full duration of the buff in seconds if cast by the player, nil otherwise
			float cur_time      -- time remaining on spell if cast by the player, nil otherwise
			float pct_time		-- the percent of time elapsed is cast by the player, nil otherwise
			float start_time	-- the time at which the debuff was started (a la GetTime()) if player cast, nil otherwise
			float end_time		-- the time as which the debuff ends (a la GetTime()) if player cast, or nil
			string name			-- the name of the debuff
			string rank			-- the rank of the debuff
			string icon			-- path to the icon texture file for this debuff
			string type			-- the dispell type for the debuff: "Magic", "Disease", "Curse" or "Poison"
			boolean expired     -- set true when the current time has passed the end time (Bliz may or may not have sent an event yet)
			boolean is_player	-- true if the debuff was cast by the player
			boolean until_cancel-- true if the spell is on the player and valid until cancelled
			boolean can_dispell -- true if the player can dispell this debuff
			SetTooltip(frame)	-- function for setting the mouseover tooltip for the passed frame
			SetClick(frame)		-- function for setting the OnClick method for the passed frame needed to cancel the debuff (or disables mouse and onclick if cannot be cancelled)
				
			class debuff_color	-- the player selected border color to use for this debuff
			{
				float	r		-- red value from 0 to 1
				float	g		-- green value from 0 to 1
				float	b		-- blue value from 0 to 1
			};
		};
	};
	
	class build				-- talent build information for player characters (when available)
	{	
		time last_update    -- result from GetTime() the last time this unit spec was updated
		
		string	name1		-- the localized name of the first talent tab
		string	name2		-- the localized name of the second talent tab
		string	name3		-- the localized name of the third talent tab
		
		int num1			-- the number of talent points spent on the first tab
		int num2			-- the number of talent points spent on the second tab
		int num3			-- the number of points spent on the third tab
		
		string icon1		-- path to the texture for the tab1 icon
		string icon2		-- path to the texture for the tab2 icon
		string icon3		-- path to the texture for the tab3 icon
		
		string bg1			-- path to the background texture for tab1
		string bg2			-- path to the background texture for tab2
		string bg3			-- path to the background texture for tab3
		
		string name         -- localized text name for this unit's primary talent build (i.e. "affliction")
		string points       -- text string showing the talent points spent on this build (i.e. "41/15/3")
	};
}

--]]---------------------------------------------------------------------------

local frame = CreateFrame( "Frame", "nUI_UnitCallbackDispatch", WorldFrame );

local GUIDCache        = {};	-- this is an array of unit_info structures
local CallbackQueue    = {};
local GUIDCallbacks    = {};
local ModifiedElements = {};
local dispatch_timer   = 1 / nUI_DEFAULT_FRAME_RATE;

-------------------------------------------------------------------------------
-- variables used locally in methods, declared here so they are never part of
-- any update loop of dynamic memory creation or garbage collection

local option;
local command;
local rate;
local count = 0;
local unit_info;
local queue;
local callbacks;
local guid;
local player_pet;
local new_data;
local callback_list;
local list;

-------------------------------------------------------------------------------

local function onUnitCacheEvent( who, event, arg1 )

--	nUI_ProfileStart( ProfileCounter, "onUnitCacheEvent", event );
	
	if event == "ADDON_LOADED" and arg1 == "nUI" then
		
		-- set the refresh rate for the callback engine
		
		if nUI_Options.frame_rate then
			nUI_Unit.frame_rate = 1 / nUI_Options.frame_rate;
		end
	
		-- set up a slash command handler for dealing with setting the frame rate
		
		option = nUI_SlashCommands[nUI_SLASHCMD_FRAMERATE];
		
		nUI_SlashCommands:setHandler( option.command, 
			
			function( msg )
				
				command, rate = strsplit( " ", msg );
				
				rate = tonumber( ("%0.0f"):format( rate or "30" ) );
				
				if rate ~= nUI_Options.frame_rate then
					
					DEFAULT_CHAT_FRAME:AddMessage( (option.message):format( rate ), 1, 0.83, 0 );
					nUI_Options.frame_rate = rate;
					nUI_Unit.frame_rate = 1 / rate;
					
				end					
			end
		);
	end

--	nUI_ProfileStop();
	
end

frame:SetScript( "OnEvent", onUnitCacheEvent );
frame:RegisterEvent( "ADDON_LOADED" );

-------------------------------------------------------------------------------
-- this is the main driver loop that dispatches queued update callback notices

local function onUnitCacheUpdate( who, elapsed )
	
--	nUI_ProfileStart( ProfileCounter, "onUnitCacheUpdate" );
	
	dispatch_timer = dispatch_timer - elapsed;
	
	if dispatch_timer <= 0 then -- process updates at 30fps, should be fast enough for most anything
	
		dispatch_timer = nUI_Unit.frame_rate;

		-- spin the list of known GUIDs and queue up any that are changed and have any
		-- active listeners.
		
		for guid in pairs( GUIDCallbacks ) do
			
			unit_info = GUIDCache[guid];
			
			if unit_info and unit_info.modified then
				
				unit_info.modified = false;
				
				if GUIDCallbacks[guid] then
					for callback in pairs( GUIDCallbacks[guid] ) do
						callback.newUnitInfo( unit_info.last_unit, unit_info );
					end
				end
			end
		end
		
		-- and execute the callbacks
		
		for unit_id in pairs( CallbackQueue ) do
			
			queue = CallbackQueue[unit_id];
			
			if ModifiedElements[queue] then
			
				ModifiedElements[queue] = false;
				
				unit_info = nUI_Unit:getUnitInfo( unit_id );			

				for callback in pairs( queue ) do
						
					callbacks = queue[callback];
			
					if ModifiedElements[callbacks] then
					
						ModifiedElements[callbacks] = false;
									
						for unitlist in pairs( callbacks ) do						
							if callbacks[unitlist] then
								callbacks[unitlist] = false;
								unitlist[unit_id] = unit_info;
							end
						end

						callback.newUnitInfo( unit_id, unit_info );
					end
				end
			end
		end
	end

--	nUI_ProfileStop();
	
end

frame:SetScript( "OnUpdate", onUnitCacheUpdate );

-------------------------------------------------------------------------------
-- fetch information about a specific GUID (may or may not be current data!)

function nUI_Unit:getGUIDInfo( guid )
	
	return GUIDCache[guid];
	
end

-------------------------------------------------------------------------------
-- fetch information about a unit from the list of known units 
-- create a new cache entry if we haven't seen this GUID before

function nUI_Unit:getUnitInfo( unit_id )
	
	guid = nil;
	unit_info = nil;

--	nUI_ProfileStart( ProfileCounter, "getUnitInfo" );
	
	if UnitExists( unit_id ) then
			
		guid      = UnitGUID( unit_id );
		unit_info = GUIDCache[guid] or {};
		
		-- if we haven't seen this unit before, collect info about it

		unit_info.is_pet       = unit_id == "pet" or UnitIsUnit( unit_id, "pet" );
		
		if not unit_info.guid then
	
			unit_info.guid         = guid;
			unit_info.is_self      = UnitIsUnit( unit_id, "player" );
			unit_info.is_player    = UnitIsPlayer( unit_id );

			nUI_Unit:updateSpecInfo( unit_id, unit_info );
			nUI_Unit:updateLabelInfo( unit_id, unit_info );
			nUI_Unit:updateLevelInfo( unit_id, unit_info );
			nUI_Unit:updateClassInfo( unit_id, unit_info );
			nUI_Unit:updateHealthInfo( unit_id, unit_info );
			nUI_Unit:updatePowerInfo( unit_id, unit_info );
			nUI_Unit:updateCastingInfo( unit_id, unit_info );
			nUI_Unit:updateReactionInfo( unit_id, unit_info );			
			nUI_Unit:updateAuraInfo( unit_id, unit_info );
			nUI_Unit:updateCombatInfo( unit_id, unit_info );
			nUI_Unit:updateFeedbackInfo( unit_id, unit_info );
			nUI_Unit:updatePortraitInfo( unit_id, unit_info );
			nUI_Unit:updatePvPInfo( unit_id, unit_info );
			nUI_Unit:updateRaidGroupInfo( unit_id, unit_info );
			nUI_Unit:updateRaidTargetInfo( unit_id, unit_info );
			nUI_Unit:updateReadyCheckInfo( unit_id, unit_info );
			nUI_Unit:updateRestingInfo( unit_id, unit_info );
			nUI_Unit:updateRoleInfo( unit_id, unit_info );
			nUI_Unit:updateStatusInfo( unit_id, unit_info );

			-- two things that are truly annoying... there's no "easy" way to determine if
			-- a unit is a player pet... no... not THE player's pet... ANY player's pet.
			-- The other thing that is annoying? Bliz likes to report UnitIsConnected()
			-- to be false if the unit is a player pet. 
			--
			-- This hack examines known unit ID pets to see if any of them match the unit
			-- ID we're looking at. This is done the first time we see a new unit and
			-- never again, so it's a tad expensive on the first peek, but never costs
			-- us again after that.
			--
			-- And, just for giggles, since we're already spending the CPU cycles to
			-- do this, we'll record what GUID the pet belongs to so the pet can refer
			-- back to the owner if needed
			
			player_pet = unit_info.is_pet;
			
			if unit_info.is_pet                             then player_pet = "player";
			elseif UnitIsUnit( unit_id, "targetpet" )       then player_pet = "target";
			elseif UnitIsUnit( unit_id, "targettargetpet" ) then player_pet = "targettarget";
			elseif UnitIsUnit( unit_id, "focuspet" )        then player_pet = "focus";
			elseif UnitIsUnit( unit_id, "mouseoverpet" )    then player_pet = "mouseover";
			end

			-- 5.0.1 Change Start
			--if not player_pet then
			--	for i=1,GetNumPartyMembers() do
			--		if UnitIsUnit( unit_id, "partypet"..i ) then 
			--			player_pet = "party"..i;
			--			break;
			--		end
			--	end
			--end
			--if not player_pet then
			--	for i=1,GetNumRaidMembers() do
			--		if UnitIsUnit( unit_id, "raidpet"..i ) then 
			--			player_pet = "raid"..i;
			--			break;
			--		end
			--	end
			--end
			if not player_pet then
				for i=1,GetNumSubgroupMembers() do
					if UnitIsUnit( unit_id, "partypet"..i ) then 
						player_pet = "party"..i;
						break;
					end
				end
			end
			if not player_pet then
				for i=1,GetNumGroupMembers() do
					if UnitIsUnit( unit_id, "raidpet"..i ) then 
						player_pet = "raid"..i;
						break;
					end
				end
			end
			-- 5.0.1 Change End

			if player_pet then 
				unit_info.pet_owner = UnitGUID( player_pet );
			end
			
			-- cache the new GUID
			
			GUIDCache[guid] = unit_info;
			
		else -- things we may need to recheck because we couldn't get them earier
		
			if not unit_info.level or unit_info.level == 0 then				
				new_data = nUI_Unit:updateLevelInfo( unit_id, unit_info );				
				if new_data then nUI_Unit.Drivers.Level.newUnitInfo( unit_id, unit_info ); end				
			end
		
			if not unit_info.name or unit_info.name == "" then				
				new_data = nUI_Unit:updateLabelInfo( unit_id, unit_info );				
				if new_data then nUI_Unit.Drivers.Label.newUnitInfo( unit_id, unit_info ); end				
			end
		
			if not unit_info.class or unit_info.class == "" then				
				new_data = nUI_Unit:updateClassInfo( unit_id, unit_info );				
				if new_data then nUI_Unit.Drivers.Class.newUnitInfo( unit_id, unit_info ); end				
			end
		end		
		
		-- information we collect every time somone asks for the unit

		unit_info.last_unit  = unit_id;
		unit_info.is_visible = UnitIsVisible( unit_id );
		
	end

	-- table index free references to the primary units
	
	if     unit_id == "player"       then nUI_Unit.PlayerInfo = unit_info; 
	elseif unit_id == "target"       then nUI_Unit.TargetInfo = unit_info;
	elseif unit_id == "targettarget" then nUI_Unit.ToTInfo = unit_info;
	elseif unit_id == "pet"          then nUI_Unit.PetInfo = unit_info; 
	elseif unit_id == "pettarget"    then nUI_Unit.PetTargetInfo = unit_info;
	end
	
	-- if the unit information we just got for this unit id does not
	-- match what we last knew this unit to be, then we need to update
	-- anyone who cares about changes in this unit
	
	-- this table also provides access to units as they were last requested...
	-- giving the consumer a look at the last known state of the unit when last
	-- observed. However, consumers of this data should be very aware that this
	-- may not be the current accurate state of either the unit or the underlying
	-- GUID... that is entirely dependent on whether or not the unit has any active
	-- observers and what unit data they are observing. If you need to be sure 
	-- you have the current data for a unit, register a callback for it using 
	-- the appropriate callback registration methods based on which data you need.
	-- Otherwise, if whatever we knew last was good enough, using this table will
	-- eliminate any and all function calls for data.	
	
	if nUI_Unit.CurrentUnit[unit_id] ~= unit_info then

		-- note: in theory, this could become recursive to some extent if, fot
		--       example, a large raid was rapidly changing targets in a close 
		--       area, so we absolutely MUST record which unit_info we observed 
		--       on the unit id BEFORE we notify callbacks so if we recurse this
		--       method, the final result will be the last state witnessed
		
		nUI_Unit.CurrentUnit[unit_id] = unit_info;

		nUI_Unit.Drivers.UnitChange.newUnitInfo( unit_id, unit_info );

	end
	
	-- and return what we got
	
--	nUI_ProfileStop();
	
	return unit_info;
	
end

-------------------------------------------------------------------------------
-- conditional callback notification only notified the callbacks that either
-- match the unit ID that changed if this is a unit change without new data,
-- otherwise if this is new data, it notifies all callbacks that have the
-- same underlying GUID. The queue process helps to improver performance by
-- combining multiple notices for the same callback frame on the same unit
-- id for the same guid. Even if a change in unit results in 20 different
-- requests to notify the frame of the new data, it will on get called once
-- (presuming they all occur in the same update cycle)

function nUI_Unit:notifyCallbacks( calltype, callbacks, unitlist, unit_info, list_unit, new_data )

--	nUI_ProfileStart( ProfileCounter, "notifyCallbacks" );
	
	-- we're only going to bother looking at the lists that at least one listener
	
	if not list_unit then 
		DEFAULT_CHAT_FRAME:AddMessage( nUI_L["passed unit id is <nil> in callback table for %s"]:format( calltype ) );
	else
			
		for unit_id in pairs( callbacks ) do		
			
			callback_list = callbacks[unit_id];
			
			if #callback_list > 0 -- ignore unit IDs with no listeners
			and (new_data or unitlist[unit_id] ~= unit_info) -- only notify on new data or changed GUID
			and UnitIsUnit( unit_id, list_unit ) -- and only notify if the listener and target units match
			then
				
				-- remember what GUID, if any, this unit refers to now
				
				unitlist[unit_id] = unit_info;

				-- queue the callback
				
				guid = unit_info and unit_info.guid or 0;
				queue = CallbackQueue[unit_id] or {};				

				ModifiedElements[queue] = true;
								
				for i,callback in ipairs( callback_list ) do

					list                   = queue[callback] or {};					
					ModifiedElements[list] = true;
					list[unitlist]         = true;
					queue[callback]        = list;
					
				end	
				
				CallbackQueue[unit_id] = queue;
				
			end
		end
	end	

--	nUI_ProfileStop();
	
end

-------------------------------------------------------------------------------
-- update all of the registered listeners for this callback, even if there's no 
-- change in data... typically used when the aura color options change
-- or entering the world

function nUI_Unit:refreshCallbacks( calltype, callbacks, unitlist, dataUpdate )
		
--	nUI_ProfileStart( ProfileCounter, "refreshCallbacks" );
	
	for list_unit in pairs( callbacks ) do
		
		if #callbacks[list_unit] > 0 then
			
			unit_info = nUI_Unit:getUnitInfo( list_unit );
			
			dataUpdate( list_unit, unit_info );
			
			nUI_Unit:notifyCallbacks( calltype, callbacks, unitlist, unit_info, list_unit, true );
			
		end
	end	
	
--	nUI_ProfileStop();
	
end
