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

local CreateFrame         = CreateFrame;
local GetTime             = GetTime;
local IsResting           = IsResting;
local UnitAffectingCombat = UnitAffectingCombat;
local UnitInRange         = UnitInRange;
local UnitIsAFK           = UnitIsAFK;
local UnitIsConnected     = UnitIsConnected;
local UnitIsDND           = UnitIsDND;
local UnitIsDead          = UnitIsDead;
local UnitIsFeignDeath    = UnitIsFeignDeath;
local UnitIsGhost         = UnitIsGhost;

-- 5.0.1 Change Start
-- local UnitIsPartyLeader   = UnitIsPartyLeader;
local UnitIsPartyLeader   = UnitIsGroupLeader;		
-- 5.0.1 Change End

local UnitOnTaxi          = UnitOnTaxi;

-------------------------------------------------------------------------------
-- unit status event management

if not nUI_Unit.Drivers then 
	nUI_Unit.Drivers = CreateFrame( "Frame", "nUI_UnitDrivers", WorldFrame ); 
end

nUI_Profile.nUI_UnitStatus       = {};
nUI_Profile.nUI_UnitStatus.Frame = {};

local ProfileCounter      = nUI_Profile.nUI_UnitStatus;
local FrameProfileCounter = nUI_Profile.nUI_UnitStatus.Frame;

local frame = CreateFrame( "Frame", "$parent_Status", nUI_Unit.Drivers )

local StatusCallbacks    = {};
local StatusUnits        = {};
local NewUnitInfo        = {};
local UpdateQueue        = {};
local queue_timer        = 1 / nUI_DEFAULT_FRAME_RATE;
local timer              = 0;

nUI_Unit.Drivers.Status  = frame;

-------------------------------------------------------------------------------
-- variables used in methods within this module are declared here to eliminate
-- the use of dynamic memory and the garbage collector

local unit_id;
local unit_info;
local list;
local modified;
local prior_state;
local raid_info;
local range_info;
local raid_leader;
local is_player;
local status_info;
local is_dead;
local is_ghost;
local is_resting;
local is_afk;
local is_dnd;
local is_oor;
local is_fd;
local is_tank;
local is_healer;
local is_damage;
local on_taxi;
local is_leader;
local is_online;
local in_range;
local in_combat;
local pet_owner;
local msg;

-------------------------------------------------------------------------------

local function onStatusUpdate( who, elapsed )
	
--	nUI_ProfileStart( ProfileCounter, "onStatusUpdate" );

	queue_timer = queue_timer - elapsed;
	
	if queue_timer <= 0 then -- process the update queue at the user selected frame rate
	
		queue_timer = nUI_Unit.frame_rate;

		for unit_id in pairs( UpdateQueue ) do
		
			if UpdateQueue[unit_id] then
			
				UpdateQueue[unit_id] = false;
				unit_info = NewUnitInfo[unit_id];
								
				if StatusCallbacks[unit_id] and #StatusCallbacks[unit_id] > 0 then
					nUI_Unit:notifyCallbacks( 
						nUI_L["unit status"], StatusCallbacks, StatusUnits, 
						unit_info, unit_id, nUI_Unit:updateStatusInfo( unit_id, unit_info ) 
					);
				end
			end
		end
	end	

	-- periodically recheck status on all units that exist and have watchers
		
	timer = timer + elapsed;
	
	if timer > 0.2 then -- check at 5fps -- plenty fast enough to know this info
	
		timer = 0;
			
		-- we're only going to bother looking at the lists that have at least one listener
			
		for unit_id in pairs( StatusCallbacks ) do
			if #StatusCallbacks[unit_id] > 0 then		
				NewUnitInfo[unit_id] = nUI_Unit:getUnitInfo( unit_id );		
				UpdateQueue[unit_id] = NewUnitInfo[unit_id] ~= nil;
			end
		end				
	end

--	nUI_ProfileStop();
	
end

frame:SetScript( "OnUpdate", onStatusUpdate );

-------------------------------------------------------------------------------
-- this callback method is called when one of the unit IDs we are monitoring
-- for unit status changes GUID

frame.newUnitInfo = function( unit_id, unit_info )

--	nUI_ProfileStart( ProfileCounter, "newUnitInfo" );
	
	UpdateQueue[unit_id] = true;
	NewUnitInfo[unit_id] = unit_info;
	
--	nUI_ProfileStop();
	
end

-------------------------------------------------------------------------------
-- add and remove callbacks from the list of unit status listeners we manage
--
-- calling this method will return the current unit_info structure for this 
-- unit if it exists or nil if the unit does not exist at this time
--
-- Note: these callbacks will be notified both when the underlying GUID for the
--		 unit changes or when the status info of the underlying GUID to the
--		 player changes. If the underlying unit does not exist, the callback
--		 will be passed a nil unit_info structure

function nUI_Unit:registerStatusCallback( unit_id, callback )
	
--	nUI_ProfileStart( ProfileCounter, "registerStatusCallback" );
	
	unit_info = nil;
	
	if unit_id and callback then
		
		-- get the list of callbacks for this unit id and add this callback
		
		list = StatusCallbacks[unit_id] or {};
		
		nUI:TableInsertByValue( list, callback );
		
		-- if this is a new unit id, add it to the callback list
		
		if not StatusCallbacks[unit_id] then
			StatusCallbacks[unit_id] = list;
		end
		
		-- if this is the first callback for the unit id, then register our
		-- event driver to receive notice when the GUID changes on this id
		
		if #list == 1 then
			nUI_Unit:registerRangeCallback( unit_id, nUI_Unit.Drivers.Label );
		end
		
		-- collect status information for this unit as we know it at this time
	
		unit_info = nUI_Unit:getUnitInfo( unit_id );
		
		if unit_info then
			nUI_Unit:updateStatusInfo( unit_id, unit_info );
		end
	end
	
--	nUI_ProfileStop();
	
	return unit_info;
	
end

function nUI_Unit:unregisterStatusCallback( unit_id, callback )
	
--	nUI_ProfileStart( ProfileCounter, "unregisterStatusCallback" );
	
	if unit_id and callback then
		
		-- get the list of current callbacks for this unit ud and remove this callback
		
		list = StatusCallbacks[unit_id] or {};
		
		nUI:TableRemoveByValue( list, callback );
		
		-- if that's the last callback in the list, then remove our event handler of
		-- the list of unit change callbacks for that unit it
		
		if #list == 0 then
			nUI_Unit:unregisterRangeCallback( unit_id, nUI_Unit.Drivers.Label );
		end
	end

--	nUI_ProfileStop();
	
end

-------------------------------------------------------------------------------
-- update the status information for this unit
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

function nUI_Unit:updateStatusInfo( unit_id, unit_info )

--	nUI_ProfileStart( ProfileCounter, "updateStatusInfo" );
	
	modified  = false;
	
	if unit_info then
		
		raid_info   = unit_info.in_raid and unit_info.raid_info or nil;
		range_info  = unit_info.range_info;
		raid_leader = raid_info and raid_info.rank == 2 or false;
		is_player   = unit_info.is_player;
		status_info = unit_info.status_info or {};
		is_dead     = UnitIsDead( unit_id ) and true or false;
		is_ghost    = UnitIsGhost( unit_id ) and true or false;
		is_resting  = unit_info.is_self and IsResting() and true or false;
		is_afk      = is_player and UnitIsAFK( unit_id ) and true or false;
		is_dnd      = is_player and UnitIsDND( unit_id ) and true or false;
		is_oor      = range_info and range_info.min and range_info.min >= 40 or false;
		is_fd       = is_player and UnitIsFeignDeath( unit_id )and true or false;
		on_taxi     = is_player and UnitOnTaxi( unit_id ) and true or false;
		is_leader   = is_player and (raid_leader or UnitIsPartyLeader( unit_id )) and true or false;
		is_online   = not is_player or (UnitIsConnected( unit_id ) and true or false);
		in_range    = not is_player or (UnitInRange( unit_id ) and true or false);
		in_combat   = UnitAffectingCombat( unit_id ) and true or false;
		
		-- we get a few status values for pets from the status values of their owner
		
		if unit_info.pet_owner then
			
			pet_owner = nUI_Unit:getGUIDInfo( unit_info.pet_owner );
			
			if pet_owner and pet_owner.status_info then
				is_afk     = pet_owner.status_info.is_afk;
				is_dnd     = pet_owner.status_info.is_dnd;
				is_onlne   = pet_owner.status_info.is_online;
				is_resting = pet_owner.status_info.is_resting;
			end
		end
		
		if status_info.is_dead    ~= is_dead
		or status_info.is_ghost   ~= is_ghost
		or status_info.is_resting ~= is_resting
		or status_info.is_afk     ~= is_afk
		or status_info.is_dnd     ~= is_dnd
		or status_info.is_oor     ~= is_oor
		or status_info.is_online  ~= is_online
		or status_info.is_fd      ~= is_fd
		or status_info.is_leader  ~= is_leader
		or status_info.on_taxi    ~= on_taxi
		or status_info.in_range   ~= in_range
		or status_info.in_combat  ~= in_combat
		then
			
			status_info.is_dead    = is_dead;
			status_info.is_ghost   = is_ghost;
			status_info.is_resting = is_resting
			status_info.is_afk     = is_afk;
			status_info.is_dnd     = is_dnd;
			status_info.is_oor     = is_oor;
			status_info.is_online  = is_online;
			status_info.is_fd      = is_fd;
			status_info.is_leader  = is_leader;
			status_info.on_taxi    = on_taxi;
			status_info.in_range   = in_range;
			status_info.in_combat  = in_combat;
			
			modified              = true;
			unit_info.modified    = true;
			unit_info.last_change = GetTime();
			unit_info.status_info = status_info;

		end
	end
	
--	nUI_ProfileStop();
	
	return modified and unit_info or nil;
	
end

-------------------------------------------------------------------------------
-- update all of the registered unit status listeners, even if there's no 
-- change in data... typically used when the status color options change
-- or entering the world

function nUI_Unit:refreshStatusCallbacks()

--	nUI_ProfileStart( ProfileCounter, "refreshStatusCallbacks" );
	
	for unit_id in pairs( StatusCallbacks ) do
		if StatusCallbacks[unit_id] and #StatusCallbacks[unit_id] > 0 then
			UpdateQueue[unit_id] = true;
			NewUnitInfo[unit_id] = nUI_Unit:getUnitInfo( unit_id );
		end
	end

--	nUI_ProfileStop();
	
end

-------------------------------------------------------------------------------
-- create a new unit status frame

function nUI_Unit:createStatusFrame( parent, unit_id, id, options )

--	nUI_ProfileStart( ProfileCounter, "createStatusFrame" );
	
	local frame      = nUI_Unit:createFrame( "$parent_Status"..(id or ""), parent, unit_id, options and options.clickable );
	frame.text       = frame:CreateFontString( "$parentText", nil );
	frame.text.value = "";
	frame.Super      = {};
	
	-- called when the underlying GUID for the unit changes or when the
	-- content of the GUID is updated
	
	frame.Super.newUnitInfo = frame.newUnitInfo;
	frame.newUnitInfo       = function( list_unit, unit_info )
		
--		nUI_ProfileStart( FrameProfileCounter, "newUnitInfo" );
		
		frame.Super.newUnitInfo( list_unit, unit_info );
		
		if frame.enabled then
			nUI_Unit:updateStatusFrame( frame );
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
				frame.unit_info = nUI_Unit:registerStatusCallback( frame.unit, frame );
				nUI_Unit:updateStatusFrame( frame );
			else
				nUI_Unit:unregisterStatusCallback( frame.unit, frame );
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

		frame.configText( frame.text, frame.options.label );
		
--		nUI_ProfileStop();
		
	end
	
	-- applies the set of frame options to this frame. Typically called when the frame 
	-- is first created or when the user changes options via config.

	frame.Super.applyOptions = frame.applyOptions;
	frame.applyOptions       = function( options )

--		nUI_ProfileStart( FrameProfileCounter, "applyOptions" );
		
		frame.Super.applyOptions( options );
		
		frame.parent:SetAlpha( frame.active and frame.options.fade_unit or 1 );
		
		nUI_Unit:updateStatusFrame( frame );
		
--		nUI_ProfileStop();
		
	end

	-- initiate the frame
	
	frame.unit_info = nUI_Unit:registerStatusCallback( frame.unit, frame );	
	frame.applyOptions( options );
	
--	nUI_ProfileStop();
	
	return frame;
	
end

-------------------------------------------------------------------------------
-- remove a unit status frame

function nUI_Unit:deleteStatusFrame( frame )

--	nUI_ProfileStart( ProfileCounter, "deleteStatusFrame" );
	
	nUI_Unit:unregisterStatusCallback( frame.unit, frame );
	nUI_Unit:deleteFrame( frame );
	
	frame.parent.applyFrameFader( frame, false );	
	
--	nUI_ProfileStop();
	
end

-------------------------------------------------------------------------------
-- display the appropriate icon for the unit's status
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

function nUI_Unit:updateStatusFrame( frame )
	
--	nUI_ProfileStart( ProfileCounter, "updateStatusFrame" );
	
	unit_info = frame.unit_info;
	
	-- if there is no unit or we don't know it's status, then hide the icon
	
	if not unit_info or not unit_info.status_info then
		
		if frame.active then
			frame.active = false;
			frame:SetAlpha( 0 );

			if frame.options.fade_unit then
				frame.parent:SetAlpha( 1 );
			end
		end
	
	-- otherwise, show the icon and clip the appropriate region
	
	else

		-- if the status has changed from what we last knew, then update 

		status_info = unit_info.status_info;
		
		if status_info.is_ghost then msg = nUI_L["GHOST"];
		elseif status_info.is_dead then msg = nUI_L["DEAD"];
		elseif status_info.is_fd then msg = nUI_L["FD"];
		elseif status_info.on_taxi then msg = nUI_L["TAXI"];
		elseif status_info.is_afk then msg = nUI_L["AFK"];
		elseif not status_info.is_online then msg = nUI_L["OFFLINE"];
		elseif status_info.is_oor then msg = nUI_L["OOR"];
		else msg = nil;
		end
		
		if frame.text.value ~= msg then
			
			frame.text.value = msg;

			if msg then
				
				-- if the status is hidden, show it
				
				if not frame.active then
					frame.active = true;
					frame:SetAlpha( 1 );
				end
		
				frame.text:SetText( msg );
			
			elseif frame.active then
				
				frame.active = false;
				frame:SetAlpha( 0 );

			end
		end
		
		frame.parent.applyFrameFader( frame, msg ~= nil and frame.options.fade_unit );
		
	end
	
--	nUI_ProfileStop();
	
end
