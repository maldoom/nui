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
if not nUI_UnitOptions then nUI_UnitOptions = {}; end
if not nUI_DefaultConfig then nUI_DefaultConfig = {}; end
if not nUI_Profile then nUI_Profile = {}; end;

local GetRaidRosterInfo   = GetRaidRosterInfo;		

local GetTime                = GetTime;
local UnitIsUnit             = UnitIsUnit;
local UnitPlayerOrPetInRaid  = UnitPlayerOrPetInRaid;

-------------------------------------------------------------------------------
-- unit raid group event management

if not nUI_Unit.Drivers then 
	nUI_Unit.Drivers = CreateFrame( "Frame", "nUI_UnitDrivers", WorldFrame ); 
end

nUI_Profile.nUI_UnitRaidGroup       = {};
nUI_Profile.nUI_UnitRaidGroup.Frame = {};

local ProfileCounter      = nUI_Profile.nUI_UnitRaidGroup;
local FrameProfileCounter = nUI_Profile.nUI_UnitRaidGroup.Frame;

local frame = CreateFrame( "Frame", "$parent_RaidGroup", nUI_Unit.Drivers )

local RaidGroupCallbacks    = {};
local RaidGroupUnits        = {};
local NewUnitInfo           = {};
local UpdateQueue           = {};
local queue_timer           = 1 / nUI_DEFAULT_FRAME_RATE;

nUI_Unit.Drivers.RaidGroup  = frame;

-------------------------------------------------------------------------------
-- variables used in methods within this module are declared here to eliminate
-- the use of dynamic memory and the garbage collector

local unit_id;
local unit_info;
local list;
local modified;
local prior_state;
local raid_info;
local raid_group;
local name, rank, subGroup, level, class, fileName, zone, online, isDead, role, is_ml;

-------------------------------------------------------------------------------

local function onRaidGroupEvent()

--	nUI_ProfileStart( ProfileCounter, "onRaidGroupEvent", event );	
	nUI_Unit:refreshRaidGroupCallbacks();
--	nUI_ProfileStop();
	
end

frame:SetScript( "OnEvent", onRaidGroupEvent );
frame:RegisterEvent( "PLAYER_ENTERING_WORLD" );

-------------------------------------------------------------------------------

local function onQueueUpdate( who, elapsed )

	queue_timer = queue_timer - elapsed;
	
	if queue_timer <= 0 then -- process the update queue at the user selected frame rate
	
		queue_timer = nUI_Unit.frame_rate;

		for unit_id in pairs( UpdateQueue ) do
		
			if UpdateQueue[unit_id] then
			
				UpdateQueue[unit_id] = false;
				unit_info = NewUnitInfo[unit_id];
								
				if RaidGroupCallbacks[unit_id] and #RaidGroupCallbacks[unit_id] > 0 then
					nUI_Unit:notifyCallbacks( 
						nUI_L["raid group"], RaidGroupCallbacks, RaidGroupUnits, 
						unit_info, unit_id, nUI_Unit:updateRaidGroupInfo( unit_id, unit_info ) 
					);
				end
			end
		end
	end	
end

frame:SetScript( "OnUpdate", onQueueUpdate );

-------------------------------------------------------------------------------
-- this callback method is called when one of the unit IDs we are monitoring
-- for raid group changes GUID or when the unit reaction information changes

frame.newUnitInfo = function( unit_id, unit_info )

--	nUI_ProfileStart( ProfileCounter, "newUnitInfo" );
	
	UpdateQueue[unit_id] = true;
	NewUnitInfo[unit_id] = unit_info;
	
--	nUI_ProfileStop();
	
end

-------------------------------------------------------------------------------
-- add and remove callbacks from the list of raid group listeners we manage
--
-- calling this method will return the current unit_info structure for this 
-- unit if it exists or nil if the unit does not exist at this time
--
-- Note: these callbacks will be notified both when the underlying GUID for the
--		 unit changes or when the raid group of the underlying GUID to the
--		 player changes. If the underlying unit does not exist, the callback
--		 will be passed a nil unit_info structure

function nUI_Unit:registerRaidGroupCallback( unit_id, callback )
	
--	nUI_ProfileStart( ProfileCounter, "registerRaidGroupCallbacks" );
	
	unit_info = nil;
	
	if unit_id and callback then
		
		-- get the list of callbacks for this unit id and add this callback
		
		list = RaidGroupCallbacks[unit_id] or {};
		
		nUI:TableInsertByValue( list, callback );
		
		-- if this is a new unit id, add it to the callback list
		
		if not RaidGroupCallbacks[unit_id] then
			RaidGroupCallbacks[unit_id] = list;
		end
		
		-- if this is the first callback for the unit id, then register our
		-- event driver to receive notice when the GUID changes on this id
		-- or the unit reaction status changes (enters/leaves a party/raid, etc.)
		
		if #list == 1 then
			nUI_Unit:registerReactionCallback( unit_id, nUI_Unit.Drivers.RaidGroup );
		end
		
		-- collect raid group information for this unit as we know it at this time
	
		unit_info = nUI_Unit:getUnitInfo( unit_id );
		
		if unit_info then
			nUI_Unit:updateRaidGroupInfo( unit_id, unit_info );
		end
	end
	
--	nUI_ProfileStop();
	
	return unit_info;
	
end

function nUI_Unit:unregisterRaidGroupCallback( unit_id, callback )
	
--	nUI_ProfileStart( ProfileCounter, "unregisterRaidGroupCallbacks" );
	
	if unit_id and callback then
		
		-- get the list of current callbacks for this unit ud and remove this callback
		
		list = RaidGroupCallbacks[unit_id] or {};
		
		nUI:TableRemoveByValue( list, callback );
		
		-- if that's the last callback in the list, then remove our event handler of
		-- the list of unit change callbacks for that unit it
		
		if #list == 0 then
			nUI_Unit:unregisterReactionCallback( unit_id, nUI_Unit.Drivers.RaidGroup );
		end
	end

--	nUI_ProfileStop();
	
end

-------------------------------------------------------------------------------
-- update the raid group information for this unit
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

function nUI_Unit:updateRaidGroupInfo( unit_id, unit_info )

--	nUI_ProfileStart( ProfileCounter, "updateRaidGroupInfo" );
	
	modified  = false;
	
	if unit_info then
		
		-- we only care about the unit if it is in our raid
		
		if not unit_info.in_raid then

			-- record the fact that this GUID is not in the raid
			
			if unit_info.raid_info then

				modified               = true;
				unit_info.modified     = true;
				unit_info.last_change  = GetTime();
				
				if unit_info.raid_info then
					unit_info.raid_info.in_raid = false;
				end				
			end

		-- otherwise the unit is in our raid, so see if the data has changed
		
		elseif unit_info.raid_id then

			-- fetch the raid information
			
			raid_info = unit_info.raid_info or {};
			name, rank, subGroup, level, class, fileName, zone, online, isDead, role, is_ml = GetRaidRosterInfo( unit_info.raid_id );
			
			-- if we found a matching entry, validate the data against what we know
			
			if not raid_info.in_raid
			or raid_info.rank     ~= rank
			or raid_info.subGroup ~= subGroup
			or raid_info.role     ~= role
			or raid_info.is_ml    ~= is_ml
			then

				raid_info.in_raid  = true;
				raid_info.rank     = rank;
				raid_info.subGroup = subGroup;
				raid_info.role     = role;
				raid_info.is_ml    = is_ml;
				
				modified              = true;
				unit_info.modified    = true;
				unit_info.last_change = GetTime();
				unit_info.raid_info   = raid_info;
				
			end
			
		-- otherwise, we don't have a raid ID for this unit, so we have no raid data
		
		elseif unit_info.raid_info then

			modified              = true;
			unit_info.modified    = true;
			unit_info.last_change = GetTime();
				
			if unit_info.raid_info then
				unit_info.raid_info.in_raid = false;
			end			
		end
	end
	
--	nUI_ProfileStop();
	
	return modified and unit_info or nil;
	
end

-------------------------------------------------------------------------------
-- update all of the registered raid group listeners, even if there's no 
-- change in data.

function nUI_Unit:refreshRaidGroupCallbacks()
	
--	nUI_ProfileStart( ProfileCounter, "refreshRaidGroupCallbacks" );
	
	for unit_id in pairs( RaidGroupCallbacks ) do
		if RaidGroupCallbacks[unit_id] and #RaidGroupCallbacks[unit_id] > 0 then
			UpdateQueue[unit_id] = true;
			NewUnitInfo[unit_id] = nUI_Unit:getUnitInfo( unit_id );
		end
	end

--	nUI_ProfileStop();
	
end

-------------------------------------------------------------------------------
-- create a new raid group frame

function nUI_Unit:createRaidGroupFrame( parent, unit_id, id, options )

--	nUI_ProfileStart( ProfileCounter, "createRaidGroupFrame" );
	
	local frame = nUI_Unit:createFrame( "$parent_RaidGroup"..(id or ""), parent, unit_id, options and options.clickable );
	frame.text  = frame:CreateFontString( nil, nil );
	frame.Super = {};
	
	-- called when the underlying GUID for the unit changes or when the
	-- content of the GUID is updated

	frame.Super.newUnitInfo = frame.newUnitInfo;
	frame.newUnitInfo       = function( list_unit, unit_info )

--		nUI_ProfileStart( FrameProfileCounter, "newUnitInfo" );
	
		frame.Super.newUnitInfo( list_unit, unit_info );
		
		if frame.enabled then
			nUI_Unit:updateRaidGroupFrame( frame );
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
				frame.unit_info = nUI_Unit:registerRaidGroupCallback( frame.unit, frame );
				nUI_Unit:updateRaidGroupFrame( frame );
			else
				nUI_Unit:unregisterRaidGroupCallback( frame.unit, frame );
			end
		end

--		nUI_ProfileStop();
		
	end
	
	-- used to change the scale of the frame... rather than the Bliz widget frame:SetScale()
	-- this method actually recalculates the size of the frame and uses frame:SetHeight()
	-- and frame:SetWidth() to reflect the actual size of the frame. Is also recreates
	-- the font to present clear, sharp, readable text versus the blurred text you get
	-- as a result of frame:SetScale() or text:SetTextHeight()
	
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
		nUI_Unit:updateRaidGroupFrame( frame );
		
--		nUI_ProfileStop();
		
	end
	
	-- initiate the frame
	
	frame.unit_info = nUI_Unit:registerRaidGroupCallback( frame.unit, frame );
	frame.applyOptions( options );
	
--	nUI_ProfileStop();
	
	return frame;
		
end

-------------------------------------------------------------------------------
-- remove a raid group frame

function nUI_Unit:deleteRaidGroupFrame( frame )

--	nUI_ProfileStart( ProfileCounter, "deleteRaidGroupFrame" );
	
	nUI_Unit:unregisterRaidGroupCallback( frame.unit, frame );
	nUI_Unit:deleteFrame( frame );
	
--	nUI_ProfileStop();
	
end

-------------------------------------------------------------------------------
-- display the appropriate text for the unit's raid group
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

function nUI_Unit:updateRaidGroupFrame( frame )
	
--	nUI_ProfileStart( ProfileCounter, "updateRaidGroupFrame" );
	
	local unit_info = frame.unit_info;

	-- if there is no unit or we don't know it's raid group, then hide the panel
	
	if not unit_info 
	or not unit_info.in_raid 
	or not unit_info.raid_info 
	or not unit_info.raid_info.in_raid
	then
		
		if frame.active then

			frame.active = false;
			frame:SetAlpha( 0 );
		end
	
	-- otherwise, show the raid group
	
	else

		-- if the raid group is hidden, show it
		
		if not frame.active then

			frame.active = true;
			frame:SetAlpha( 1 );
		end

		-- if the raid group has changed from what we last knew, then update 
		
		raid_group = (frame.options.prefix and nUI_L["Group %d"] or "%d"):format( unit_info.raid_info.subGroup );
		
		if frame.raid_group ~= raid_group then

			frame.raid_group = raid_group;			
			frame.text:SetText( raid_group );
			
		end		
	end
	
--	nUI_ProfileStop();
	
end
