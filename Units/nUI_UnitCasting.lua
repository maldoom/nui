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

local CreateFrame     = CreateFrame;
local GetNetStats     = GetNetStats;
local GetTime         = GetTime;
local UnitCastingInfo = UnitCastingInfo;
local UnitChannelInfo = UnitChannelInfo;

-------------------------------------------------------------------------------
-- default options for the casting bar colors

nUI_DefaultConfig.CastBarColors =
{
	["Casting"]     = { r = 0.9, g = 0.75, b = 0, a = 1, },
	["Channeling"]  = { r = 0, g = 0.75, b = 0.25, a = 1, },
	["Latency"]     = { r = 0.1, g = 0.25, b = 1, a = 1, },
	["NoInterrupt"] = { r = 1, g = 0.25, b = 0.25, a = 1, },
};

-------------------------------------------------------------------------------
-- unit casting bar event management

if not nUI_Unit.Drivers then 
	nUI_Unit.Drivers = CreateFrame( "Frame", "nUI_UnitDrivers", WorldFrame ); 
end

nUI_Profile.nUI_UnitCasting       = {};
nUI_Profile.nUI_UnitCasting.Frame = {};

local ProfileCounter      = nUI_Profile.nUI_UnitCasting;
local FrameProfileCounter = nUI_Profile.nUI_UnitCasting.Frame;

local frame = CreateFrame( "Frame", "$parent_Casting", nUI_Unit.Drivers )

local CastingCallbacks    = {};
local CastingUnits        = {};
local CastingStatusList   = {};
local ActiveCastingUnits  = {};
local CastMessages        = {};
local CastingFlags        = {};
local UpdateQueue         = {};
local NewUnitInfo         = {};
local update_timer        = 1 / nUI_DEFAULT_FRAME_RATE;

nUI_Unit.Drivers.Casting  = frame;

-------------------------------------------------------------------------------
-- variables used in methods within this module are declared here to eliminate
-- the use of dynamic memory and the garbage collector

local unit_id;
local unit_info;
local list;
local new_data;
local this_cast = {};
local cast_info;
local modified;
local cached;
local proc_time;
local prior_state;
local message;
local persist;

-------------------------------------------------------------------------------
-- helper unitility to copy what we know about a cast from one table to another

local function CopyCast( target, source )
	
--	nUI_ProfileStart( ProfileCounter, "CopyCast" );
	
	target.spell        = source.spell;
	target.rank         = source.rank;
	target.spell_name   = source.spell_name;
	target.icon         = source.icon;
	target.start_time   = source.start_time;
	target.end_time     = source.end_time;
	target.pct_time     = source.pct_time;
	target.cur_time     = source.cur_time;
	target.max_time     = source.max_time;
	target.pct_latency  = source.pct_latency;
	target.cur_latency  = source.cur_latency;
	target.max_latency  = source.max_latency;
	target.active       = source.active;
	target.channeling   = source.channeling;
	target.complete     = source.complete;
	target.stopped      = source.stopped;
	target.interrupted  = source.interrupted;
	target.failed       = source.failed;
	target.delayed      = source.delayed;
	target.succeeded    = source.succeeded;
	target.missed       = source.missed;
	target.tradeskill   = source.tradeskill;				
	target.bar_color    = source.bar_color;
	target.castID       = source.castID;
	target.noInterrupt  = source.noInterrupt;

--	nUI_ProfileStop();

end

-------------------------------------------------------------------------------

local function UpdateCastInfo( cast_info, proc_time )
	
	cast_info.cur_time    = proc_time - cast_info.start_time;
	cast_info.pct_time    = max( 0, min( 1, cast_info.cur_time / cast_info.max_time ));
	cast_info.cur_latency = cast_info.cur_time + nUI.latency / 1000;
	cast_info.pct_latency = max( 0, min( 1, cast_info.cur_latency / cast_info.max_time ));

	if cast_info.channeling then
		
		cast_info.pct_time    = 1 - cast_info.pct_time;
		cast_info.pct_latency = 1 - cast_info.pct_latency;

	end

	-- is the spell actively being cast at this time?
	
	cast_info.active =	cast_info.is_casting
						and cast_info.start_time <= proc_time
						and cast_info.end_time >= proc_time;

end

-------------------------------------------------------------------------------

local function onCastingEvent( who, event, arg1 )
	
--	nUI_ProfileStart( ProfileCounter, "onCastingEvent", event );

--	nUI:debug( "processing "..(event or "<nil>").." unit casting event" );
	
	if event == "ADDON_LOADED" then
		
		if arg1 == "nUI" then
			nUI:patchConfig();
			nUI_Unit:configCasting();
		end

	-- we don't care about the event unless there are observers for the unit id
	
	elseif arg1 and CastingCallbacks[arg1] and #CastingCallbacks[arg1] > 0 then

		unit_info = nUI_Unit:getUnitInfo( arg1 );

		if unit_info then
			if not unit_info.cast_info then unit_info.cast_info = {}; end
			if not CastingFlags[arg1] then CastingFlags[arg1] = {}; end						
			
			UpdateQueue[arg1] = true;
			NewUnitInfo[arg1] = unit_info;
			
			if unit_info then
					
				-- starting a new cast spell
				
				if event == "UNIT_SPELLCAST_START" then
					
					CastingFlags[arg1].channeling = false;

				-- starting a new channeled spell
				
				elseif event == "UNIT_SPELLCAST_CHANNEL_START" then			
					
					CastingFlags[arg1].channeling = true;

				-- otherwise, we're updating a spellcast that is already underway
				
				elseif event == "UNIT_SPELLCAST_DELAYED" then
					
					CastingFlags[arg1].delayed = true;
					
				-- the spellcast has been stopped
				
				elseif event == "UNIT_SPELLCAST_STOP"
				or     event == "UNIT_SPELLCAST_CHANNEL_STOP" then
									
					CastingFlags[arg1].stopped = true;
					
				-- spell succeeded
				
				elseif event == "UNIT_SPELLCAST_SUCCEEDED" then
					
					CastingFlags[arg1].succeeded = true;
					
				-- spell failed
				
				elseif event == "UNIT_SPELLCAST_FAILED" then
					
					CastingFlags[arg1].failed = true;
					
				-- spell missed
				
				elseif event == "UNIT_SPELLCAST_SPELLMISS" then
					
					CastingFlags[arg1].missed = true;
					
				-- spell interrupted
				
				elseif event == "UNIT_SPELLCAST_INTERRUPTED" then
					
					CastingFlags[arg1].interrupted = true;
					
				end
			end
		end
	end

--	nUI_ProfileStop();

end

frame:SetScript( "OnEvent", onCastingEvent );
frame:RegisterEvent( "ADDON_LOADED" );
frame:RegisterEvent( "UNIT_SPELLCAST_CHANNEL_START" );
frame:RegisterEvent( "UNIT_SPELLCAST_CHANNEL_STOP" );
frame:RegisterEvent( "UNIT_SPELLCAST_CHANNEL_UPDATE" );
frame:RegisterEvent( "UNIT_SPELLCAST_START" );
frame:RegisterEvent( "UNIT_SPELLCAST_STOP" );
frame:RegisterEvent( "UNIT_SPELLCAST_SUCCEEDED" );
frame:RegisterEvent( "UNIT_SPELLCAST_SPELLMISS" );
frame:RegisterEvent( "UNIT_SPELLCAST_DELAYED" );
frame:RegisterEvent( "UNIT_SPELLCAST_FAILED" );
frame:RegisterEvent( "UNIT_SPELLCAST_INTERRUPTED" );

-------------------------------------------------------------------------------
-- casting bar update event handler

local function onCastingUpdate( who, elapsed )

--	nUI_ProfileStart( ProfileCounter, "onCastingUpdate" );
	
	update_timer = update_timer - elapsed;
	
	if update_timer <= 0 then -- update casting bars at the user selected frame rate

		update_timer = nUI_Unit.frame_rate;
				
		-- always update the actively displayed casting bars
		
		for i=#ActiveCastingUnits, 1, -1 do

			unit_id              = ActiveCastingUnits[i];
			UpdateQueue[unit_id] = true;
			NewUnitInfo[unit_id] = nUI_Unit:getUnitInfo( unit_id );
			
		end

		-- update the casting info for those units that require it
		
		for unit_id in pairs( UpdateQueue ) do
			if UpdateQueue[unit_id] then
			
				UpdateQueue[unit_id] = false;
				
				if CastingCallbacks[unit_id] and #CastingCallbacks[unit_id] > 0 then

					unit_info = NewUnitInfo[unit_id];
					new_data  = nUI_Unit:updateCastingInfo( unit_id, unit_info );

					nUI_Unit:notifyCallbacks( nUI_L["casting bar"], CastingCallbacks, CastingUnits, unit_info, unit_id, new_data );
				end
			end
		end
	end

--	nUI_ProfileStop();

end

frame:SetScript( "OnUpdate", onCastingUpdate );

-------------------------------------------------------------------------------
-- this callback method is called when one of the unit IDs we are monitoring
-- for casting bar changes GUID

frame.newUnitInfo = function( unit_id, unit_info )

--	nUI_ProfileStart( ProfileCounter, "newUnitInfo" );

	if unit_info and not unit_info.cast_info then unit_info.cast_info = {}; end
	if not CastingFlags[unit_id] then CastingFlags[unit_id] = {}; end						
	
	UpdateQueue[unit_id] = true;
	NewUnitInfo[unit_id] = unit_info;

--	nUI_ProfileStop();

end

-------------------------------------------------------------------------------
-- initialize configuration for the casting bar colors
-- 
-- this method is called when the mod's saved variables have been loaded by Bliz and
-- may be called again whenever the casting bar color configuration has been changed
-- by the player or programmatically. Passing true or a non-nil value for "use_default"
-- will cause the player's current cast bar color configuration to be replaced with
-- the default settings defined at the top of this file (which cannot be undone!)

function nUI_Unit:configCasting( use_default )
	
--	nUI_ProfileStart( ProfileCounter, "configCasting" );
	
	if not nUI_UnitOptions then nUI_UnitOptions = {}; end
	if not nUI_UnitOptions.CastBarColors then nUI_UnitOptions.CastBarColors = {}; end

	nUI_Unit:configCastBar( "Casting", use_default );
	nUI_Unit:configCastBar( "Channeling", use_default );
	nUI_Unit:configCastBar( "Latency", use_default );
	nUI_Unit:configCastBar( "NoInterrupt", use_default );

--	nUI_ProfileStop();

end

-------------------------------------------------------------------------------
-- configure casting bar colors for the named bar

function nUI_Unit:configCastBar( name, use_default )
	
--	nUI_ProfileStart( ProfileCounter, "configCastBar" );
	
	local config  = nUI_UnitOptions.CastBarColors[name] or {};
	local default = nUI_DefaultConfig.CastBarColors[name];
	
	if use_default then
			
		config.r = default.r;
		config.g = default.g;
		config.b = default.b;
		config.a = default.a;

	else
			
		config.r = tonumber( config.r or default.r );
		config.g = tonumber( config.g or default.g );
		config.b = tonumber( config.b or default.b );
		config.a = tonumber( config.a or default.a );

	end
		
	nUI_UnitOptions.CastBarColors[name] = config;
	
	nUI_Unit:refreshCastingCallbacks();
	
--	nUI_ProfileStop();

end

-------------------------------------------------------------------------------
-- add and remove callbacks from the list of casting bar listeners we manage
--
-- calling this method will return the current unit_info structure for this 
-- unit if it exists or nil if the unit does not exist at this time
--
-- Note: these callbacks will be notified both when the underlying GUID for the
--		 unit changes or when the casting info of the underlying GUID to the
--		 player changes. If the underlying unit does not exist, the callback
--		 will be passed a nil unit_info structure

function nUI_Unit:registerCastingCallback( unit_id, callback )
	
--	nUI_ProfileStart( ProfileCounter, "registerCastingCallback" );
	
	unit_info = nil;
	
	if unit_id and callback then
		
		-- get the list of callbacks for this unit id and add this callback
		
		list = CastingCallbacks[unit_id] or {};
		
		nUI:TableInsertByValue( list, callback );
		
		-- if this is a new unit id, add it to the callback list
		
		if not CastingCallbacks[unit_id] then
			CastingCallbacks[unit_id] = list;
		end
		
		-- if this is the first callback for the unit id, then register our
		-- event driver to receive notice when the GUID changes on this id
		
		if #list == 1 then
			nUI_Unit:registerUnitChangeCallback( unit_id, nUI_Unit.Drivers.Casting );
		end
		
		-- collect casting information for this unit as we know it at this time
	
		unit_info = nUI_Unit:getUnitInfo( unit_id );
		
		if unit_info then
			nUI_Unit:updateCastingInfo( unit_id, unit_info );
		end
	end
	
--	nUI_ProfileStop();

	return unit_info;
	
end

function nUI_Unit:unregisterCastingCallback( unit_id, callback )
	
--	nUI_ProfileStart( ProfileCounter, "unregisterCastingCallback" );
	
	if unit_id and callback then
		
		-- get the list of current callbacks for this unit ud and remove this callback
		
		list = CastingCallbacks[unit_id] or {};
		
		nUI:TableRemoveByValue( list, callback );
		
		-- if that's the last callback in the list, then remove our event handler of
		-- the list of unit change callbacks for that unit it
		
		if #list == 0 then
			nUI_Unit:unregisterUnitChangeCallback( unit_id, nUI_Unit.Drivers.Casting );
		end
	end

--	nUI_ProfileStop();

end

-------------------------------------------------------------------------------
-- update the casting information for this unit
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

function nUI_Unit:updateCastingInfo( unit_id, unit_info )

--	nUI_ProfileStart( ProfileCounter, "updateCastingInfo" );
	
	modified  = false;
	
	if unit_info then

		if not CastingFlags[unit_id] then CastingFlags[unit_id] = {}; end
		
		proc_time = GetTime();
		
		this_cast.channeling  = CastingFlags[unit_id].channeling;
		this_cast.delayed     = CastingFlags[unit_id].delayed;
		this_cast.stopped     = CastingFlags[unit_id].stopped;
		this_cast.succeeded   = CastingFlags[unit_id].succeeded;
		this_cast.failed      = CastingFlags[unit_id].failed;
		this_cast.missed      = CastingFlags[unit_id].missed;
		this_cast.interrupted = CastingFlags[unit_id].interrupted;

		if CastingFlags[unit_id].channeling then
		
			this_cast.spell_name = nil;
			
			this_cast.spell, this_cast.rank, this_cast.channel_name, 
			this_cast.icon, this_cast.start_time, this_cast.end_time, 				
			this_cast.tradeskill, this_cast.noInterrupt = UnitChannelInfo( unit_id );				
			
			if this_cast.spell then
				this_cast.bar_color  = nUI_UnitOptions.CastBarColors["Channeling"];		
				this_cast.start_time = this_cast.start_time / 1000;
				this_cast.end_time   = this_cast.end_time / 1000;
			end
			
		else
		
			this_cast.channel_name = nil;
			
			this_cast.spell, this_cast.rank, this_cast.spell_name, 
			this_cast.icon, this_cast.start_time, this_cast.end_time, 				
			this_cast.tradeskill, this_cast.castID, this_cast.noInterrupt = UnitCastingInfo( unit_id );
			
			if this_cast.spell then
				this_cast.bar_color  = nUI_UnitOptions.CastBarColors["Casting"];		
				this_cast.start_time = this_cast.start_time / 1000;
				this_cast.end_time   = this_cast.end_time / 1000;
			end
			
		end
		
		if this_cast.noInterrupt 
		and not UnitIsUnit( unit_id, "player" )
		and not UnitIsUnit( unit_id, "pet" )
		then
			this_cast.bar_color = nUI_UnitOptions.CastBarColors["NoInterrupt"];
		end
			
		-- is there an active spell?

		this_cast.is_casting =	this_cast.spell ~= nil;			
		
		-- no longer have a valid spell?
		
		if not this_cast.is_casting
		or not this_cast.start_time
		or not this_cast.end_time
		or this_cast.end_time <= proc_time
		then
				
			if unit_info.cast_info then
				unit_info.cast_info.active = false;
			end

			if unit_info.is_casting then
		
				modified              = true;
				unit_info.modified    = true;
				unit_info.last_change = proc_time;
				unit_info.is_casting  = false;
				
				nUI:TableRemoveByValue( ActiveCastingUnits, unit_id );				
				CastingStatusList[unit_id] = nil;
				
			end
			
		-- we have a valid spell, do something with it
		
		else
	
			this_cast.max_time    = this_cast.end_time - this_cast.start_time;
			this_cast.max_latency = this_cast.max_time;

			-- if this is a channeled spell, the time is time remaining so we invert the percentage value
			
			if this_cast.channeling then
				
				-- by default, when channeling a spell, the localized spell name you get
				-- from UnitChannelInfo() is "channeling" instead of the spell name... so
				-- here we do some extra work to get the actual name of the spell 

				this_cast.spell_name = nUI_L[this_cast.spell_name] 
				                    or GetSpellInfo( this_cast.spell ) 
				                    or this_cast.channel_name;
									
			end
			
			-- if the spell has stopped, then mark it complete so we can dequeue it
			-- on the next update... this makes sure that all the listeners get a
			-- notice on the completion before we dequeue it.
			
			this_cast.complete = this_cast.stopped;
						
			-- update percentages
			
			UpdateCastInfo( this_cast, proc_time );
			
			-- update the cache if the status of this spell changed
			
			cached = unit_info.cast_info or {};
			
			if not this_cast.active then
					
				modified              = true;
				unit_info.modified    = true;
				unit_info.last_change = proc_time;
				unit_info.is_casting  = false;
				
				if unit_info.cast_info then
					unit_info.cast_info.active = false;
				end

				nUI:TableRemoveByValue( ActiveCastingUnits, unit_id );				
				CastingStatusList[unit_id] = nil;				
			
			elseif not unit_info.is_casting
			or cached.pct_time     ~= this_cast.pct_time
			or cached.cur_time     ~= this_cast.cur_time
			or cached.max_time     ~= this_cast.max_time
			or cached.pct_latency  ~= this_cast.pct_latency
			or cached.cur_latency  ~= this_cast.cur_latency
			or cached.max_latency  ~= this_cast.max_latency
			or cached.spell        ~= this_cast.spell
			or cached.rank         ~= this_cast.rank
			or cached.failed       ~= this_cast.failed
			or cached.interrupted  ~= this_cast.interrupted
			or cached.succeeded    ~= this_cast.succeeded  
			or cached.missed       ~= this_cast.missed     
			or cached.stopped      ~= this_cast.stopped    
			or cached.active       ~= this_cast.active
			or cached.complete     ~= this_cast.complete
			or cached.delayed      ~= this_cast.delayed
			or cached.channeling   ~= this_cast.channeling
			or cached.spell_name   ~= this_cast.spell_name
			or cached.channel_name ~= this_cast.channel_name
			or cached.icon         ~= this_cast.icon
			or cached.start_time   ~= this_cast.start_time
			or cached.end_time     ~= this_cast.end_time
			or cached.tradeskill   ~= this_cast.tradeskill
			or cached.bar_color    ~= this_cast.bar_color
			or cached.castID       ~= this_cast.castID
			or cached.noInterrupt  ~= this_cast.noInterrupt

			then
				
				cached.pct_time     = this_cast.pct_time;
				cached.cur_time     = this_cast.cur_time;
				cached.max_time     = this_cast.max_time;
				cached.pct_latency  = this_cast.pct_latency;
				cached.cur_latency  = this_cast.cur_latency;
				cached.max_latency  = this_cast.max_latency;
				cached.spell        = this_cast.spell;
				cached.rank         = this_cast.rank;
				cached.failed       = this_cast.failed;
				cached.interrupted  = this_cast.interrupted;
				cached.succeeded    = this_cast.succeeded;
				cached.missed       = this_cast.missed;     
				cached.stopped      = this_cast.stopped;    
				cached.active       = this_cast.active;
				cached.complete     = this_cast.complete;
				cached.delayed      = this_cast.delayed;
				cached.channeling   = this_cast.channeling;
				cached.spell_name   = this_cast.spell_name;
				cached.channel_name = this_cast.channel_name;
				cached.icon         = this_cast.icon;
				cached.start_time   = this_cast.start_time;
				cached.end_time     = this_cast.end_time;
				cached.tradeskill   = this_cast.tradeskill;
				cached.bar_color    = this_cast.bar_color;
				cached.castID       = this_cast.castID;
				cached.noInterrupt  = this_cast.noInterrupt;
				
				modified              = true;
				unit_info.modified    = true;
				unit_info.is_casting  = true;
				unit_info.last_change = proc_time;
				unit_info.cast_info   = cached;
				
				-- if this is a new cast, add it to the list of active units
				-- for our casting bar updates
				
				if CastingStatusList[unit_id] ~= unit_info.guid
				then
	
					nUI:TableInsertByValue( ActiveCastingUnits, unit_id );				
					CastingStatusList[unit_id] = unit_info.guid;
					
				end			
			end
		end
	end
		
	CastingFlags[unit_id].delayed     = false;
	CastingFlags[unit_id].stopped     = false;
	CastingFlags[unit_id].succeeded   = false;
	CastingFlags[unit_id].failed      = false;
	CastingFlags[unit_id].missed      = false;
	CastingFlags[unit_id].interrupted = false;
	
--	nUI_ProfileStop();

	return modified and unit_info or nil;
	
end

-------------------------------------------------------------------------------
-- update all of the registered casting bar listeners, even if there's no 
-- change in data... typically used when the cast bar color options change
-- or entering the world

function nUI_Unit:refreshCastingCallbacks()

--	nUI_ProfileStart( ProfileCounter, "refreshCastingCallbacks" );
	
	nUI_Unit:refreshCallbacks( 
	
		nUI_L["casting bar"], CastingCallbacks, CastingUnits, 
	
		function( list_unit, unit_info ) 
			nUI_Unit:updateCastingInfo( list_unit, unit_info ); 
		end 
	);
	
--	nUI_ProfileStop();

end

-------------------------------------------------------------------------------
-- create a new unit casting bar frame

function nUI_Unit:createCastingFrame( parent, unit_id, id, options )

--	nUI_ProfileStart( ProfileCounter, "createCastingFrame" );
	
	local frame      = nUI_Unit:createFrame( "$parent_Casting"..(id or ""), parent, unit_id, options and options.clickable );	
	frame.bar        = nUI_Bars:createStatusBar( "$parentBar", frame, true );
	frame.latency    = nUI_Bars:createStatusBar( "$parentLatency", frame, true );
	frame.bar_anchor = frame:CreateTexture( "$parentAnchor", "ARTWORK" );
	frame.cur        = frame:CreateFontString( "$parentCurrent", "OVERLAY" );			-- shows current casting time as text
	frame.max        = frame:CreateFontString( "$parentMaximum", "OVERLAY" );			-- shows maximum casting time as text
	frame.pct        = frame:CreateFontString( "$parentPercent", "OVERLAY" );			-- shows percent percent of casting time as text
	frame.lbl        = frame:CreateFontString( "$parentSpellName", "OVERLAY" );			-- shows the name of the spell
	frame.msg        = frame.parent:CreateFontString( "$parentMessage", "OVERLAY" );	-- shows alert messages (failed, interrupted, etc)
	frame.Super      = {};

	frame.bar_anchor:SetPoint( "CENTER", frame, "CENTER", 0, 0 );
	
	-- called when the underlying GUID for the unit changes or when the
	-- content of the GUID is updated

	frame.Super.newUnitInfo = frame.newUnitInfo;	
	frame.newUnitInfo       = function( list_unit, unit_info )
		
--		nUI_ProfileStart( FrameProfileCounter, "newUnitInfo" );
	
		frame.Super.newUnitInfo( list_unit, unit_info );
		
		if frame.enabled then
			nUI_Unit:updateCastingFrame( frame );
		end
		
--		nUI_ProfileStop();
	
	end;
	
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
				frame.unit_info = nUI_Unit:registerCastingCallback( frame.unit, frame );
				frame.bar.setEnabled( frame.options.show_bar );
				frame.latency.setEnabled( frame.options.show_latency );
				nUI_Unit:updateCastingFrame( frame );
			else
				nUI_Unit:unregisterCastingCallback( frame.unit, frame );
				frame.bar.setEnabled( false );
				frame.latency.setEnabled( false );
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
				
			frame.font_size = (frame.vSize or (frame.bar.horizontal and frame.height or frame.width)) * 0.7;		
			
			frame.configText( frame.cur, frame.options.cur_time );
			frame.configText( frame.max, frame.options.max_time );
			frame.configText( frame.pct, frame.options.pct_time );
			frame.configText( frame.lbl, frame.options.spell_name );
			frame.configText( frame.msg, frame.options.msg_label );
	
			if frame.bar_anchor.hSize  ~= frame.hSize 
			or frame.bar_anchor.vSize  ~= frame.vSize 
			or frame.bar_anchor.width  ~= frame.width
			or frame.bar_anchor.height ~= frame.height 
			or frame.bar_anchor.hInset ~= frame.hInset
			or frame.bar_anchor.vInset ~= frame.vInset
			then
	
				local width  = (frame.hSize or frame.width) - frame.hInset;
				local height = (frame.vSize or frame.height) - frame.vInset;
				
				frame.bar_anchor.hSize  = frame.hSize;
				frame.bar_anchor.vSize  = frame.vSize;
				frame.bar_anchor.width  = frame.width;
				frame.bar_anchor.height = frame.height;
				frame.bar_anchor.hInset = frame.hInset;
				frame.bar_anchor.vInset = frame.vInset;
							
				frame.bar_anchor:SetWidth( width );
				frame.bar_anchor:SetHeight( height );
				
				if frame.bar.horizontal then
					
					frame.bar:SetWidth( width );
					frame.bar:SetHeight( height * (frame.latency.enabled and 0.7 or 1) );
					
					frame.latency:SetWidth( width );
					frame.latency:SetHeight( height * 0.3 );
					
				else
					
					frame.bar:SetWidth( width * (frame.latency.enabled and 0.7 or 1) );
					frame.bar:SetHeight( height );
					
					frame.latency:SetWidth( width * 0.3 );
					frame.latency:SetHeight( height );
									
				end
			end
		end		

--		nUI_ProfileStop();
	
	end
	
	-- overload the frame anchor method to also anchor the bars correctly
	
	frame.Super.applyAnchor = frame.applyAnchor;
	frame.applyAnchor       = function( anchor )
		
--		nUI_ProfileStart( FrameProfileCounter, "applyAnchor" );
	
		frame.Super.applyAnchor( anchor );
		
		if frame.bar.horizontal then
			
			frame.bar:ClearAllPoints();
			frame.bar:SetPoint( "TOP", frame.bar_anchor, "TOP", 0, 0 );
			
			frame.latency:ClearAllPoints();
			frame.latency:SetPoint( "TOP", frame.bar, "BOTTOM", 0, 0 );
			
		else
			
			frame.bar:ClearAllPoints();
			frame.bar:SetPoint( "LEFT", frame.bar_anchor, "LEFT", 0, 0 );
			
			frame.latency:ClearAllPoints();
			frame.latency:SetPoint( "LEFT", frame.bar, "RIGHT", 0, 0 );
			
		end				

--		nUI_ProfileStop();
	
	end

	-- applies the set of frame options to this frame. Typically called when the frame 
	-- is first created or when the user changes options via config.
	
	frame.Super.applyOptions = frame.applyOptions;
	frame.applyOptions       = function( options )

--		nUI_ProfileStart( FrameProfileCounter, "applyOptions" );
	
		if options then
			frame.bar.setEnabled( options.show_bar );
			frame.latency.setEnabled( options.show_latency );
		end

		frame.Super.applyOptions( options );

		-- extra frame level work
		
		frame.bar:SetFrameStrata( frame:GetFrameStrata() );
		frame.bar:SetFrameLevel( frame:GetFrameLevel() );
		
		frame.latency:SetFrameStrata( frame.bar:GetFrameStrata() );
		frame.latency:SetFrameLevel( frame.bar:GetFrameLevel() );

		-- set the bar texture
		
		if options.overlay then
			frame.bar_anchor:SetAlpha( 1 );
			frame.bar_anchor:SetTexture( options.overlay );
			frame.bar_anchor:SetTexCoord( 0, 0, 0, 1, 1, 0, 1, 1 );
		else
			frame.bar_anchor:SetAlpha( 0 );
		end
		
		-- enable or disable the display of a graphic casting bar
		
		if not frame.bar.enabled then
			
			frame.bar:SetAlpha( 0 );
			
		else
			
			frame.bar:SetAlpha( 1 );
			frame.bar.setOrientation( options.orient or "LEFT" );
			frame.bar.setBar();
			
		end
		
		-- enable or disable the display of a graphic latency bar
		
		if not frame.latency.enabled then
			
			frame.latency:SetAlpha( 0 );
			
		else
			
			frame.latency:SetAlpha( 1 );
			frame.latency.setOrientation( options.orient or "LEFT" );
			frame.latency.setBar();
			
		end
		
		-- and refresh the frame
		
		nUI_Unit:updateCastingFrame( frame );
		
--		nUI_ProfileStop();
	
	end
	
	-- initiate the frame
			
	frame.unit_info = nUI_Unit:registerCastingCallback( frame.unit, frame );
	frame.applyOptions( options );
	
--	nUI_ProfileStop();
	
	return frame;
	
end

-------------------------------------------------------------------------------
-- remove a unit healt frame

function nUI_Unit:deleteCastingFrame( frame )

--	nUI_ProfileStart( ProfileCounter, "deleteCastingFrame" );
	
	frame.bar.deleteBar();
	
	nUI_Unit:unregisterCastingCallback( frame.unit, frame );
	nUI_Unit:deleteFrame( frame );
	
--	nUI_ProfileStop();
	
end

-------------------------------------------------------------------------------
-- update the casting bar text and casting bar as required
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

local pct;
local max;
local cur;
local lbl;

function nUI_Unit:updateCastingFrame( frame )
	
--	nUI_ProfileStart( ProfileCounter, "updateCastingFrame" );
	
	unit_info = frame.unit_info;
	cast_info = unit_info and unit_info.cast_info or nil;
	proc_time = GetTime();
	message   = nil;
	
	-- if we don't have a spell anymore, then shut down the casting bar
	
	if not unit_info
	or not unit_info.is_casting
	or not cast_info 
	or not cast_info.active
	or cast_info.end_time < proc_time then
		
		if frame.active then
			
			persist       = frame.options.persist;
			frame.active  = false;
			
			frame:SetAlpha( persist and 1 or 0 );
			frame.bar.updateBar();
			frame.latency.updateBar();
			
		end
	
		if frame.pct.active then
			frame.pct.active = false;
			frame.pct.value  = nil;
			frame.pct:SetText( "" );
		end
		
		if frame.max.active then
			frame.max.active = false;
			frame.max.value  = nil;
			frame.max:SetText( "" );
		end
		
		if frame.cur.active then
			frame.cur.active = false;
			frame.cur.value  = nil;
			frame.cur:SetText( "" );
		end
		
		if frame.lbl.active then
			frame.lbl.active = false;
			frame.lbl.value  = nil;
			frame.lbl:SetText( "" );
		end			
	
	-- do we have a new message to show the user?
	
	elseif cast_info.failed      then message = nUI_L["~FAILED~"];
	elseif cast_info.missed      then message = nUI_L["~MISSED~"];
	elseif cast_info.interrupted then message = nUI_L["~INTERRUPTED~"];
	end

	if message 
	and frame.msg.enabled 
	and frame.msg.value ~= message 
	then
			
		frame.msg.active     = true;
		frame.msg.value      = value;
		frame.msg.start_time = GetTime()+1;
		
--		frame.msg:SetText( message );		
--		nUI:TableInsertByValue( CastMessages, frame.msg );
		
	end
		
	-- if we have an active casting bar, then update it
	
	if cast_info and cast_info.active then

		pct = ("%0.0f%%"):format( cast_info.pct_time * 100 );
		max = ("%0.0f"):format( cast_info.max_time );
		cur = ("%0.01f"):format( cast_info.channeling and (cast_info.max_time - cast_info.cur_time) or cast_info.cur_time );
		lbl = cast_info.spell_name;

		-- make sure our bar is visible
		
		if not frame.active then
			
			frame.active = true;			
			frame:SetAlpha( 1 );
			
		end
	
		-- update the labels as required

		if frame.pct.enabled and frame.pct.value ~= pct then
			
			frame.pct.active = true;
			frame.pct.value  = pct;
			frame.pct:SetText( pct );
			
		end
		
		if frame.max.enabled and frame.max.value ~= max then
			
			frame.max.active = true;
			frame.max.value  = max;
			frame.max:SetText( max );
			
		end
		
		if frame.cur.enabled and frame.cur.value ~= cur then
			
			frame.cur.active = true;
			frame.cur.value  = cur;			
			frame.cur:SetText( cur );
			
		end
		
		if frame.lbl.enabled and frame.lbl.value ~= lbl then

			frame.lbl.active = true;
			frame.lbl.value  = lbl;
			frame.lbl:SetText( lbl );
			
		end

		-- update the casting bars

		frame.bar.updateBar( 
		
			frame.bar.enabled 
			and cast_info.pct_time ~= 0
			and cast_info.pct_time ~= 1
			and cast_info.pct_time or nil, 
			
			frame.bar.enabled 
			and cast_info.bar_color or nil );
		
		frame.latency.updateBar( 
		
			frame.latency.enabled 
			and cast_info.pct_latency ~= 0 
			and cast_info.pct_latency ~= 1 
			and cast_info.pct_latency or nil, 
			
			frame.latency.enabled 
			and nUI_UnitOptions.CastBarColors["Latency"] or nil 
		);
		
	end
	
--	nUI_ProfileStop();
	
end
