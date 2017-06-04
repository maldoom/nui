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

local UnitClass          = UnitClass;
local UnitClassification = UnitClassification;
local UnitCreatureFamily = UnitCreatureFamily;
local UnitCreatureType   = UnitCreatureType;
local UnitExists         = UnitExists;
local UnitFactionGroup   = UnitFactionGroup;
local UnitGUID           = UnitGUID;
local UnitIsPlayer       = UnitIsPlayer;
local UnitIsUnit         = UnitIsUnit;
local UnitName           = UnitName;
local UnitRace           = UnitRace;
local UnitSex            = UnitSex;

-------------------------------------------------------------------------------

if not nUI_Unit.Drivers then 
	nUI_Unit.Drivers = CreateFrame( "Frame", "nUI_UnitDrivers", WorldFrame ); 
end

nUI_Profile.nUI_UnitChange       = {};

local ProfileCounter = nUI_Profile.nUI_UnitChange;

local frame                 = CreateFrame( "Frame", "$parent_UnitChange", nUI_Unit.Drivers );
local NewUnitInfo           = {};
local UpdateQueue           = {};
local UnitChangeCallbacks   = {};
local UnitChangeUnits       = {};
local queue_timer           = 1 / nUI_DEFAULT_FRAME_RATE;

nUI_Unit.Drivers.UnitChange = frame;

-------------------------------------------------------------------------------
-- variables used in methods within this module are declared here to eliminate
-- the use of dynamic memory and the garbage collector

local unit_id;
local unit_info;
local list;

-------------------------------------------------------------------------------
-- unit event handler

local function onUnitChangeEvent( who, event, arg1 )

--	nUI_ProfileStart( ProfileCounter, "onUnitChangeEvent", event );
	
	if event == "PLAYER_TARGET_CHANGED" then
		
		if UnitChangeCallbacks["target"] and #UnitChangeCallbacks["target"] > 0 then
			UpdateQueue["target"] = true;
			NewUnitInfo["target"] = nUI_Unit:getUnitInfo( "target" );
		end
		
	elseif event == "PLAYER_FOCUS_CHANGED" then
		
		if UnitChangeCallbacks["focus"] and #UnitChangeCallbacks["focus"] > 0 then
			UpdateQueue["focus"] = true;
			NewUnitInfo["focus"] = nUI_Unit:getUnitInfo( "focus" );
		end
		
	elseif event == "PARTY_MEMBERS_CHANGED" then
	
		for i=1,4 do		
			unit_id = "party"..i;
			
			if UnitChangeCallbacks[unit_id] and #UnitChangeCallbacks[unit_id] > 0 then
				UpdateQueue[unit_id] = true;
				NewUnitInfo[unit_id] = nUI_Unit:getUnitInfo( unit_id );
			end
		end
		
	elseif event == "RAID_ROSTER_UPDATE" then
	
		for i=1,40 do		
			unit_id = "raid"..i;
			
			if UnitChangeCallbacks[unit_id] and #UnitChangeCallbacks[unit_id] > 0 then
				UpdateQueue[unit_id] = true;
				NewUnitInfo[unit_id] = nUI_Unit:getUnitInfo( unit_id );
			end
		end
		
	elseif event == "UNIT_TARGET" then
	
		unit_id = arg1.."target";
		
		if UnitChangeCallbacks[unit_id] and #UnitChangeCallbacks[unit_id] > 0 then
			UpdateQueue[unit_id] = true;
			NewUnitInfo[unit_id] = nUI_Unit:getUnitInfo( unit_id );
		end
			
	elseif event == "UNIT_NAME_UPDATE" then
	
		if UnitChangeCallbacks[arg1] and #UnitChangeCallbacks[arg1] > 0 then
			UpdateQueue[arg1] = true;
			NewUnitInfo[arg1] = nUI_Unit:getUnitInfo( arg1 );
		end
		
	-- for the rest of the events, we don't know which units are affected, so
	-- we span the list of all known interested units to see who is watching
		
	else

		for unit_id in pairs( UnitChangeCallbacks ) do		
			if UnitChangeCallbacks[unit_id] and #UnitChangeCallbacks[unit_id] > 0 then
				UpdateQueue[unit_id] = true;
				NewUnitInfo[unit_id] = nUI_Unit:getUnitInfo( unit_id );
			end
		end		
	end	

--	nUI_ProfileStop();
	
end

frame:SetScript( "OnEvent", onUnitChangeEvent );
frame:RegisterEvent( "UNIT_TARGET" );
frame:RegisterEvent( "UNIT_NAME_UPDATE" );
frame:RegisterEvent( "PARTY_MEMBERS_CHANGED" );	
frame:RegisterEvent( "PLAYER_ENTERING_WORLD" );
frame:RegisterEvent( "PLAYER_TARGET_CHANGED" );	
frame:RegisterEvent( "PLAYER_FOCUS_CHANGED" );	
frame:RegisterEvent( "RAID_ROSTER_UPDATE" );	

-------------------------------------------------------------------------------

local function onQueueUpdate( who, elapsed )
	
	queue_timer = queue_timer - elapsed;
	
	if queue_timer <= 0 then -- process the update queue at the user selected frame rate
	
		queue_timer = nUI_Unit.frame_rate;

		-- update any units that have flagged a change since the last iteration
		
		for unit_id in pairs( UpdateQueue ) do
			if UpdateQueue[unit_id] then
				UpdateQueue[unit_id] = false;
				
				if UnitChangeCallbacks[unit_id] and #UnitChangeCallbacks[unit_id] > 0 then
					nUI_Unit:notifyCallbacks( 
						nUI_L["unit change"], UnitChangeCallbacks, UnitChangeUnits, 
						NewUnitInfo[unit_id], unit_id, false 
					);
				end
			end
		end
	end
end

frame:SetScript( "OnUpdate", onQueueUpdate );

-------------------------------------------------------------------------------
-- this method is triggered anytime a request for a unit id's unit_info structure
-- via nUI_Unit:getUnitInfo() finds a new GUID on the unit

frame.newUnitInfo = function( unit_id, unit_info )
	
--	nUI_ProfileStart( ProfileCounter, "newUnitInfo" );
	
	UpdateQueue[unit_id] = true;
	NewUnitInfo[unit_id] = unit_info;
	
--	nUI_ProfileStop();
	
end

-------------------------------------------------------------------------------
-- add and remove callbacks from the list of listeners who want to know
-- when the underlying GUID / unit information of a unit changes
--
-- calling this method will return the current unit_info structure
-- for this unit id if it exists or nil if the unit does not exist
--
-- Note: this is NOT recommended for unit existence! Use RegisterUnitWatch()
--       or RegisterUnitWatchState() for that purpose (allows for a taint safe
--		 way to know when a unit does and does not exist including the ability
--		 to show and hide frames, move frames, etc.)

function nUI_Unit:registerUnitChangeCallback( unit_id, callback )
	
--	nUI_ProfileStart( ProfileCounter, "registerUnitChangeCallback" );
	
	unit_info = nil;
	
	if unit_id and callback then
		
		list = UnitChangeCallbacks[unit_id] or {};
		
		nUI:TableInsertByValue( list, callback );
		
		if not UnitChangeCallbacks[unit_id] then
			UnitChangeCallbacks[unit_id] = list;
		end	
		
		unit_info = nUI_Unit:getUnitInfo( unit_id );
		
	end
	
--	nUI_ProfileStop();
	
	return unit_info;
	
end

function nUI_Unit:unregisterUnitChangeCallback( unit_id, callback )
	
--	nUI_ProfileStart( ProfileCounter, "unregisterUnitChangeCallback" );
	
	if unit_id and callback then
		
		list = UnitChangeCallbacks[unit_id] or {};
		
		nUI:TableRemoveByValue( list, callback );
		
	end
	
--	nUI_ProfileStop();
	
end
