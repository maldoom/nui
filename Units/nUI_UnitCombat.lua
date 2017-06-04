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

-------------------------------------------------------------------------------
-- unit combat event management

if not nUI_Unit.Drivers then 
	nUI_Unit.Drivers = CreateFrame( "Frame", "nUI_UnitDrivers", WorldFrame ); 
end

nUI_Profile.nUI_UnitCombat       = {};
nUI_Profile.nUI_UnitCombat.Frame = {};

local ProfileCounter      = nUI_Profile.nUI_UnitCombat;
local FrameProfileCounter = nUI_Profile.nUI_UnitCombat.Frame;

local frame = CreateFrame( "Frame", "$parent_Combat", nUI_Unit.Drivers )

local CombatCallbacks    = {};
local CombatUnits        = {};
local CombatStatus       = {};
local NewUnitInfo        = {};
local UpdateQueue        = {};
local queue_timer        = 1 / nUI_DEFAULT_FRAME_RATE;

nUI_Unit.Drivers.Combat  = frame;

-------------------------------------------------------------------------------
-- variables used in methods within this module are declared here to eliminate
-- the use of dynamic memory and the garbage collector

local unit_id;
local unit_info;
local list;
local modified;
local status_info;
local in_combat;
local prior_state;

-------------------------------------------------------------------------------

local function onCombatUpdate( who, elapsed )

	queue_timer = queue_timer - elapsed;
	
	if queue_timer <= 0 then -- process the update queue at the user selected frame rate
	
		queue_timer = nUI_Unit.frame_rate;

		for unit_id in pairs( UpdateQueue ) do
		
			if UpdateQueue[unit_id] then
			
				UpdateQueue[unit_id] = false;
				unit_info = NewUnitInfo[unit_id];
								
				if CombatCallbacks[unit_id] and #CombatCallbacks[unit_id] > 0 then
					nUI_Unit:notifyCallbacks( 
						nUI_L["unit combat"], CombatCallbacks, CombatUnits,
						unit_info, unit_id, nUI_Unit:updateCombatInfo( unit_id, unit_info ) 
					);
				end
			end
		end
	end	
end	

frame:SetScript( "OnUpdate", onCombatUpdate );

-------------------------------------------------------------------------------
-- this callback method is called when one of the unit IDs we are monitoring
-- for unit combat changes GUID

frame.newUnitInfo = function( unit_id, unit_info )

--	nUI_ProfileStart( ProfileCounter, "newUnitInfo" );
	
	UpdateQueue[unit_id] = true;
	NewUnitInfo[unit_id] = unit_info;

--	nUI_ProfileStop();
	
end

-------------------------------------------------------------------------------
-- add and remove callbacks from the list of unit combat listeners we manage
--
-- calling this method will return the current unit_info structure for this 
-- unit if it exists or nil if the unit does not exist at this time
--
-- Note: these callbacks will be notified both when the underlying GUID for the
--		 unit changes or when the combat info of the underlying GUID to the
--		 player changes. If the underlying unit does not exist, the callback
--		 will be passed a nil unit_info structure

function nUI_Unit:registerCombatCallback( unit_id, callback )
	
--	nUI_ProfileStart( ProfileCounter, "registerCombatCallback" );
	
	unit_info = nil;
	
	if unit_id and callback then
		
		-- get the list of callbacks for this unit id and add this callback
		
		list = CombatCallbacks[unit_id] or {};
		
		nUI:TableInsertByValue( list, callback );
		
		-- if this is a new unit id, add it to the callback list
		
		if not CombatCallbacks[unit_id] then
			CombatCallbacks[unit_id] = list;
		end
		
		-- if this is the first callback for the unit id, then register our
		-- event driver to receive notice when the GUID changes on this id
		
		if #list == 1 then
			nUI_Unit:registerStatusCallback( unit_id, nUI_Unit.Drivers.Combat );
		end
		
		-- collect combat information for this unit as we know it at this time
	
		unit_info = nUI_Unit:getUnitInfo( unit_id );
		
		if unit_info then
			nUI_Unit:updateCombatInfo( unit_id, unit_info );
		end
	end
	
--	nUI_ProfileStop();
	
	return unit_info;
	
end

function nUI_Unit:unregisterCombatCallback( unit_id, callback )
	
--	nUI_ProfileStart( ProfileCounter, "unregisterCombatCallback" );
	
	if unit_id and callback then
		
		-- get the list of current callbacks for this unit ud and remove this callback
		
		list = CombatCallbacks[unit_id] or {};
		
		nUI:TableRemoveByValue( list, callback );
		
		-- if that's the last callback in the list, then remove our event handler of
		-- the list of unit change callbacks for that unit it
		
		if #list == 0 then
			nUI_Unit:unregisterStatusCallback( unit_id, nUI_Unit.Drivers.Combat );
		end
	end

--	nUI_ProfileStop();
	
end

-------------------------------------------------------------------------------
-- update the combat information for this unit
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

function nUI_Unit:updateCombatInfo( unit_id, unit_info )

--	nUI_ProfileStart( ProfileCounter, "updateCombatInfo" );
	
	modified  = false;
	
	if unit_info then

		status_info = unit_info.status_info;
		in_combat   = status_info and status_info.in_combat or false;
		
		if CombatStatus[unit_id] ~= in_combat
		then
			
			modified              = true;
			CombatStatus[unit_id] = in_combat;
			
		end
	end
	
--	nUI_ProfileStop();
	
	return modified and unit_info or nil;
	
end

-------------------------------------------------------------------------------
-- update all of the registered unit combat listeners, even if there's no 
-- change in data... typically used when entering the world

function nUI_Unit:refreshCombatCallbacks()

--	nUI_ProfileStart( ProfileCounter, "refreshCombatCallbacks" );
	
	for unit_id in pairs( CombatCallbacks ) do
		if CombatCallbacks[unit_id] and #CombatCallbacks[unit_id] > 0 then
			UpdateQueue[unit_id] = true;
			NewUnitInfo[unit_id] = nUI_Unit:getUnitInfo( unit_id );
		end
	end

--	nUI_ProfileStop();
	
end

-------------------------------------------------------------------------------
-- create a new unit combat frame

function nUI_Unit:createCombatFrame( parent, unit_id, id, options )

--	nUI_ProfileStart( ProfileCounter, "createCombatFrame" );
	
	local frame   = nUI_Unit:createFrame( "$parent_Combat"..(id or ""), parent, unit_id, options and options.clickable );
	frame.texture = frame:CreateTexture( "$parentTexture", "BACKGROUND" );
	frame.Super   = {};

	frame.texture:SetPoint( "CENTER", frame, "CENTER", 0, 0 );
	frame.texture:SetTexture( "Interface\\AddOns\\nUI\\Layouts\\Default\\Art\\nUI_StateIcon" );
	frame.texture:SetTexCoord( 0.5, 0, 0.5, 1, 1, 0, 1, 1 );

	-- called when the underlying GUID for the unit changes or when the
	-- content of the GUID is updated

	frame.Super.newUnitInfo = frame.newUnitInfo;
	frame.newUnitInfo       = function( list_unit, unit_info )
		
--		nUI_ProfileStart( FrameProfileCounter, "newUnitInfo" );
	
		frame.Super.newUnitInfo( list_unit, unit_info );
		
		if frame.enabled then
			nUI_Unit:updateCombatFrame( frame );
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
				frame.unit_info = nUI_Unit:registerCombatCallback( frame.unit, frame );
				nUI_Unit:updateCombatFrame( frame );
			else
				nUI_Unit:unregisterCombatCallback( frame.unit, frame );
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
		
		if frame.texture.hSize  ~= frame.hSize 
		or frame.texture.vSize  ~= frame.vSize 
		or frame.texture.width  ~= frame.width
		or frame.texture.height ~= frame.height 
		or frame.texture.hInset ~= frame.hInset
		or frame.texture.vInset ~= frame.vInset
		then
			
			frame.texture.hSize  = frame.hSize;
			frame.texture.vSize  = frame.vSize;
			frame.texture.width  = frame.width;
			frame.texture.height = frame.height;
			frame.texture.hInset = frame.hInset;
			frame.texture.vInset = frame.vInset;
			
			frame.texture:SetWidth( (frame.hSize or frame.width) - frame.hInset );
			frame.texture:SetHeight( (frame.vSize or frame.height) - frame.vInset );

		end		

--		nUI_ProfileStop();
		
	end
	
	-- applies the set of frame options to this frame. Typically called when the frame 
	-- is first created or when the user changes options via config.
	
	frame.Super.applyOptions = frame.applyOptions;
	frame.applyOptions       = function( options )

--		nUI_ProfileStart( FrameProfileCounter, "applyOptions" );
	
		frame.Super.applyOptions( options );
		nUI_Unit:updateCombatFrame( frame );
		
--		nUI_ProfileStop();
		
	end

	-- initiate the frame
	
	frame.unit_info = nUI_Unit:registerCombatCallback( frame.unit, frame );
	
	frame.applyOptions( options );
	
--	nUI_ProfileStop();
	
	return frame;
	
end

-------------------------------------------------------------------------------
-- remove a unit combat frame

function nUI_Unit:deleteCombatFrame( frame )

--	nUI_ProfileStart( ProfileCounter, "deleteCombatFrame" );

	nUI_Unit:unregisterCombatCallback( frame.unit, frame );
	nUI_Unit:deleteFrame( frame );
	
--	nUI_ProfileStop();
	
end

-------------------------------------------------------------------------------
-- display the appropriate icon for the unit's combat status
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

function nUI_Unit:updateCombatFrame( frame )
	
--	nUI_ProfileStart( ProfileCounter, "updateCombatFrame" );

	unit_info = frame.unit_info;
	
	-- if there is no unit or we don't know it's combat status, then hide the icon
	
	if not unit_info 
	or not unit_info.status_info 
	or not unit_info.status_info.in_combat 
	then
		
		if frame.active then
			frame.active = false;
			frame:SetAlpha( 0 );
		end
	
	-- otherwise, show the icon
	
	else

		-- if the combat icon is hidden, show it
		
		if not frame.active then
			frame.active = true;
			frame:SetAlpha( 1 );
		end
		
	end

--	nUI_ProfileStop();
	
end
