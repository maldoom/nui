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

if not ClickCastFrames then	ClickCastFrames = {};end
if not nUI then nUI = {}; end
if not nUI_Unit then nUI_Unit = {}; end
if not nUI_UnitOptions then nUI_UnitOptions = {}; end
if not nUI_DefaultConfig then nUI_DefaultConfig = {}; end
if not nUI_DefaultConfig.BarColors then nUI_DefaultConfig.BarColors = {}; end
if not nUI_Profile then nUI_Profile = {}; end;

local CreateFrame    = CreateFrame;
local IsAddOnLoaded  = IsAddOnLoaded;
local UnitThreat      = UnitThreat;
local UnitThreatMax   = UnitThreatMax;
local UnitThreatType  = UnitThreatType;

nUI_UnitOptions.BarColors = nUI_DefaultConfig.BarColors;

-------------------------------------------------------------------------------
-- default colors for unit threat bars

nUI_DefaultConfig.BarColors.Threat =
{
	["min"] = { r = 0, g = 1, b = 0, a = 1 },	 -- zero threat bar color
	["mid"] = { r = 1, g = 0.83, b = 0, a = 1 }, -- bar color at 50% of tank's threat
	["max"] = { r = 1, g = 0, b = 0, a = 1 },	 -- bar color at 100% of tank's threat
};

-------------------------------------------------------------------------------
-- unit threat event management

if not nUI_Unit.Drivers then 
	nUI_Unit.Drivers = CreateFrame( "Frame", "nUI_UnitDrivers", WorldFrame ); 
end

nUI_Profile.nUI_UnitThreat       = {};
nUI_Profile.nUI_UnitThreat.Frame = {};

local ProfileCounter      = nUI_Profile.nUI_UnitThreat;
local FrameProfileCounter = nUI_Profile.nUI_UnitThreat.Frame;

local frame = CreateFrame( "Frame", "$parent_Threat", nUI_Unit.Drivers )

local ThreatCallbacks   = {};
local ThreatUnits       = {};
local NewUnitInfo       = {};
local UpdateQueue       = {};
local queue_timer       = 1 / nUI_DEFAULT_FRAME_RATE;
local threat_timer       = 0;

nUI_Unit.Drivers.Threat  = frame;

-------------------------------------------------------------------------------
-- variables used in methods within this module are declared here to eliminate
-- the use of dynamic memory and the garbage collector

local unit_id;
local unit_info;
local list;
local modified;
local prior_state;

-------------------------------------------------------------------------------

local function onThreatEvent( who, event, arg1 )
	
--	nUI_ProfileStart( ProfileCounter, "onThreatEvent", event );
	
	if event == "ADDON_LOADED" and arg1 == "nUI" then
		
		nUI:patchConfig();
		
	elseif event == "PLAYER_ENTERING_WORLD" then

		nUI_Unit:refreshThreatCallbacks();
		
	-- change in threat status for a mob
	
	elseif event == "UNIT_THREAT_LIST_UPDATE" then
	
		for unit_id in pairs( ThreatCallbacks ) do
		
			if ThreatCallbacks[unit_id] and #ThreatCallbacks[unit_id] > 0 then
			
				NewUnitInfo[unit_id] = nUI_Unit:getUnitInfo( unit_id );
				UpdateQueue[unit_id] = NewUnitInfo[unit_id] ~= nil;
				
			end
		end
	
	-- change in threat situation for a given unit
	
	elseif event == "UNIT_THREAT_SITUATION_UPDATE" then
	
		if ThreatCallbacks[arg1] and #ThreatCallbacks[arg1] > 0 then

			UpdateQueue[arg1] = true;
			NewUnitInfo[arg1] = nUI_Unit:getUnitInfo( arg1 );
		
		end
	end

--	nUI_ProfileStop();
	
end

frame:SetScript( "OnEvent", onThreatEvent );
frame:RegisterEvent( "ADDON_LOADED" );
frame:RegisterEvent( "PLAYER_ENTERING_WORLD" );
frame:RegisterEvent( "UNIT_THREAT_LIST_UPDATE" );
frame:RegisterEvent( "UNIT_THREAT_SITUATION_UPDATE" );

-------------------------------------------------------------------------------

local function onQueueUpdate( who, elapsed )

	queue_timer = queue_timer - elapsed;
	
	if queue_timer <= 0 then -- process the update queue at the user selected frame rate
	
		queue_timer = nUI_Unit.frame_rate;

		for unit_id in pairs( UpdateQueue ) do
		
			if UpdateQueue[unit_id] then
			
				UpdateQueue[unit_id] = false;
				unit_info = NewUnitInfo[unit_id];
								
				if ThreatCallbacks[unit_id] and #ThreatCallbacks[unit_id] > 0 then
					nUI_Unit:notifyCallbacks( 
						nUI_L["unit threat"], ThreatCallbacks, ThreatUnits, 
						unit_info, unit_id, nUI_Unit:updateThreatInfo( unit_id, unit_info ) 
					);
				end
			end
		end
	end	
end

frame:SetScript( "OnUpdate", onQueueUpdate );

-------------------------------------------------------------------------------
-- this callback method is called when one of the unit IDs we are monitoring
-- for unit threat changes GUID or fires an event we care about

frame.newUnitInfo = function( unit_id, unit_info )

--	nUI_ProfileStart( ProfileCounter, "newUnitInfo" );
	
	UpdateQueue[unit_id] = true;
	NewUnitInfo[unit_id] = unit_info;
	
--	nUI_ProfileStop();
	
end

-------------------------------------------------------------------------------
-- initialize configuration for the unit threat bar colors
-- 
-- this method is called when the mod's saved variables have been loaded by Bliz and
-- may be called again whenever the unit bar color configuration has been changed
-- by the player or programmatically. Passing true or a non-nil value for "use_default"
-- will cause the player's current threat color configuration to be replaced with
-- the default settings defined at the top of this file (which cannot be undone!)

function nUI_Unit:configThreat( use_default )
	
--	nUI_ProfileStart( ProfileCounter, "configThreat" );
	
	if not nUI_UnitOptions then nUI_UnitOptions = {}; end
	if not nUI_UnitOptions.BarColors then nUI_UnitOptions.BarColors = {}; end
	if not nUI_UnitOptions.BarColors.Threat then nUI_UnitOptions.BarColors.Threat = {}; end

	local config  = nUI_UnitOptions.BarColors.Threat or {};
	local default = nUI_DefaultConfig.BarColors.Threat;
		
	for range in pairs( default ) do

		local source = default[range];
		local target = config[range] or {};
		
		if use_default then
			
			target.r = source.r;
			target.g = source.g;
			target.b = source.b;
			target.a = source.b;

		else
			
			target.r = tonumber( target.r or source.r );
			target.g = tonumber( target.g or source.g );
			target.b = tonumber( target.b or source.b );
			target.a = tonumber( target.a or source.a );
			
		end
			
		config[range] = target;
			
	end
	
	nUI_Unit:refreshThreatCallbacks();
	
--	nUI_ProfileStop();
	
end

-------------------------------------------------------------------------------
-- add and remove callbacks from the list of unit threat listeners we manage
--
-- calling this method will return the current unit_info structure for this 
-- unit if it exists or nil if the unit does not exist at this time
--
-- Note: these callbacks will be notified both when the underlying GUID for the
--		 unit changes or when the threat info of the underlying GUID changes. 
--       If the underlying unit does not exist, the callback will be passed a 
--       nil unit_info structure

function nUI_Unit:registerThreatCallback( unit_id, callback )
	
--	nUI_ProfileStart( ProfileCounter, "registerThreatCallback" );
	
	unit_info = nil;
	
	if unit_id and callback then
		
		-- get the list of callbacks for this unit id and add this callback
		
		list = ThreatCallbacks[unit_id] or {};
		
		nUI:TableInsertByValue( list, callback );
		
		-- if this is a new unit id, add it to the callback list
		
		if not ThreatCallbacks[unit_id] then
			ThreatCallbacks[unit_id] = list;
		end
		
		-- if this is the first callback for the unit id, then register our
		-- event driver to receive notice when the GUID changes on this id
		
		if #list == 1 then
			nUI_Unit:registerUnitChangeCallback( unit_id, nUI_Unit.Drivers.Threat );
		end
		
		-- collect threat information for this unit as we know it at this time
	
		unit_info = nUI_Unit:getUnitInfo( unit_id );
		
		if unit_info then
			nUI_Unit:updateThreatInfo( unit_id, unit_info );
		end
	end
	
--	nUI_ProfileStop();
	
	return unit_info;
	
end

function nUI_Unit:unregisterThreatCallback( unit_id, callback )
	
--	nUI_ProfileStart( ProfileCounter, "unregisterThreatCallback" );
	
	if unit_id and callback then
		
		-- get the list of current callbacks for this unit ud and remove this callback
		
		list = ThreatCallbacks[unit_id] or {};
		
		nUI:TableRemoveByValue( list, callback );
		
		-- if that's the last callback in the list, then remove our event handler of
		-- the list of unit change callbacks for that unit it
		
		if #list == 0 then
			nUI_Unit:unregisterUnitChangeCallback( unit_id, nUI_Unit.Drivers.Threat );
		end
	end

--	nUI_ProfileStop();
	
end

-------------------------------------------------------------------------------
-- update the threat information for this unit
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

local count = 1;

function nUI_Unit:updateThreatInfo( unit_id, unit_info, mob_id )

--	nUI_ProfileStart( ProfileCounter, "updateThreatInfo" );
	
	modified  = false;
	
	if unit_info then

		local threatTable = {};

		-- update the unit's current threat table
		
		if unit_info.ThreatTable then
		
			for id in pairs( unit_info.ThreatTable ) do
			
				if UnitExists( id ) then

					if mob_id == id then
						mob_id = nil;
					end
					
					threatTable[id] =
					{
						isTanking, 
						status, 
						threatPct, 
						rawThreatPct, 
						threatValue = UnitDetailedThreatSituation( unit_id, id );
					};
				end
			end
		end
		
		-- add this unit to the threat table if it wasn't already in it
		
		if mob_id then		
			threatTable[mob_id] =
			{
				isTanking, 
				status, 
				threatPct, 
				rawThreatPct, 
				threatValue = UnitDetailedThreatSituation( unit_id, mob_id );
			};
		end	
			
		-- calculate colors for all the threats
		
		for id in pairs( threatTable ) do
		
			local color      = {};
			local color_set  = nUI_UnitOptions.BarColors.Threat;
			local pct_threat = min( (threatTable[id].threatPct / 100), 1 );
			local range, color1, color2;
			
			-- select the color set we are going to use

			if pct_threat > 0.5 then
				
				range  = (pct_threat - 0.5) * 2;
				color1 = color_set["mid"];
				color2 = color_set["max"];
				
			else
				
				range  = pct_threat * 2;
				color1 = color_set["min"];
				color2 = color_set["mid"];
				
			end

			color.r = (color2.r - color1.r) * range + color1.r;
			color.g = (color2.g - color1.g) * range + color1.g;
			color.b = (color2.b - color1.b) * range + color1.b;
			color.a = (color2.a - color1.a) * range + color1.a;
			
			threatTable[id].color = color;
			
		end
		
		-- if the unit's threat table changed, then update the cache
		
		if not unit_info.threatTable then
			modified = true;
		elseif #unit_info.threatTable ~= #threatTable then
			modified = true;
		else
			
			-- are there new IDs in the current threat table not in the cached one?
			
			for id in pairs( threatTable ) do
				if not unit_info.threatTable[id] then
					modified = true;
				end
			end
			
			-- are there cached unit IDs not in the current threat table?
			
			if not modified then
				for id in pairs( unit_info.threatTable ) do
					if not threatTable[id] then
						modified = true;
					end
				end
			end
			
			-- has any threat data changed?
			
			if not modified then
				for id in pairs( threatTable ) do
					local newEntry = threatTable[id];
					local oldEntry = unit_info.threatTable[id];
									
					if newEntry.isTanking    ~= oldEntry.isTanking
					or newEntry.status       ~= oldEntry.status 
					or newEntry.threatPct    ~= oldEntry.threatPct
					or newEntry.rawThreatPct ~= oldEntry.rawThreatPct
					or newEntry.threatValue  ~= oldEntry.threatValue
					or newEntry.color.r      ~= oldEntry.color.r
					or newEntry.color.g      ~= oldEntry.color.g
					or newEntry.color.b      ~= oldEntry.color.b
					or newEntry.color.a      ~= oldEntry.color.a
					then
						modified = true;
					end
				end
			end
		end
				
		if modified then
			
			unit_info.modified     = true;
			unit_info.last_change  = GetTime();
			unit_info.threatTable  = threatTable;
		end
	end
		
--	nUI_ProfileStop();
	
	return modified and unit_info or nil;
	
end

-------------------------------------------------------------------------------
-- update all of the registered unit threat listeners, even if there's no 
-- change in data... typically used when the threat color options change
-- or entering the world

function nUI_Unit:refreshThreatCallbacks()

--	nUI_ProfileStart( ProfileCounter, "refreshThreatCallbacks" );
	
	for unit_id in pairs( ThreatCallbacks ) do
		if ThreatCallbacks[unit_id] and #ThreatCallbacks[unit_id] > 0 then
			UpdateQueue[unit_id] = true;
			NewUnitInfo[unit_id] = nUI_Unit:getUnitInfo( unit_id );
		end
	end

--	nUI_ProfileStop();
	
end
