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

local GetComboPoints = GetComboPoints;

-------------------------------------------------------------------------------
-- unit combo points event management

if not nUI_Unit.Drivers then 
	nUI_Unit.Drivers = CreateFrame( "Frame", "nUI_UnitDrivers", WorldFrame ); 
end

nUI_Profile.nUI_UnitComboPoints       = {};
nUI_Profile.nUI_UnitComboPoints.Frame = {};

local ProfileCounter      = nUI_Profile.nUI_UnitComboPoints;
local FrameProfileCounter = nUI_Profile.nUI_UnitComboPoints.Frame;

local frame = CreateFrame( "Frame", "$parent_ComboPoints", nUI_Unit.Drivers )

local ComboPointsCallbacks    = {};
local ComboPointsUnits        = {};
local ComboPointsStatus       = {};
local NewUnitInfo             = {};
local UpdateQueue             = {};
local queue_timer             = 1 / nUI_DEFAULT_FRAME_RATE;

nUI_Unit.Drivers.ComboPoints  = frame;

-------------------------------------------------------------------------------
-- variables used in methods within this module are declared here to eliminate
-- the use of dynamic memory and the garbage collector

local unit_id;
local unit_info;
local list;
local modified;
local prior_state;
local texture;
local highlight;
local combo_points;

-------------------------------------------------------------------------------
--[[
local function onComboPointsEvent( self, event, ... )
	
	UpdateQueue["target"] = true;
	NewUnitInfo["target"] = nUI_Unit:getUnitInfo( "target" );

	nUI_Unit:updateComboPointsInfo( "target", unit_info );
	
end

frame:SetScript( "OnEvent", onComboPointsEvent );
frame:RegisterEvent( "PLAYER_ENTERING_WORLD" );
frame:RegisterEvent( "UNIT_POWER" );
]]--
-------------------------------------------------------------------------------

local function onQueueUpdate( who, elapsed )

	queue_timer = queue_timer - elapsed;
	
	if queue_timer <= 0 then -- process the update queue at the user selected frame rate
	
		queue_timer = nUI_Unit.frame_rate;

		for unit_id in pairs( UpdateQueue ) do
		
			if UpdateQueue[unit_id] then
			
				UpdateQueue[unit_id] = false;
				unit_info = NewUnitInfo[unit_id];
								
				if ComboPointsCallbacks[unit_id] and #ComboPointsCallbacks[unit_id] > 0 then
					nUI_Unit:notifyCallbacks( 
						nUI_L["unit combo points"], ComboPointsCallbacks, ComboPointsUnits, 
						unit_info, unit_id, nUI_Unit:updateComboPointsInfo( unit_id, unit_info ) 
					);
				end
			end
		end
	end	
end

frame:SetScript( "OnUpdate", onQueueUpdate );

-------------------------------------------------------------------------------
-- this callback method is called when one of the unit IDs we are monitoring
-- for unit combo points changes GUID

frame.newUnitInfo = function( unit_id, unit_info )

	UpdateQueue[unit_id] = true;
	NewUnitInfo[unit_id] = unit_info;

end

-------------------------------------------------------------------------------
-- add and remove callbacks from the list of unit combo points listeners we manage
--
-- calling this method will return the current unit_info structure for this 
-- unit if it exists or nil if the unit does not exist at this time
--
-- Note: these callbacks will be notified both when the underlying GUID for the
--		 unit changes or when the combo points info of the underlying GUID to the
--		 player changes. If the underlying unit does not exist, the callback
--		 will be passed a nil unit_info structure

function nUI_Unit:registerComboPointsCallback( unit_id, callback )

	unit_info = nil;

	if unit_id and callback then
		
		-- get the list of callbacks for this unit id and add this callback
		
		list = ComboPointsCallbacks[unit_id] or {};
		
		nUI:TableInsertByValue( list, callback );
		
		-- if this is a new unit id, add it to the callback list
		
		if not ComboPointsCallbacks[unit_id] then
			ComboPointsCallbacks[unit_id] = list;
		end
		
		-- if this is the first callback for the unit id, then register our
		-- event driver to receive notice when the GUID changes on this id
		
		if #list == 1 then
			nUI_Unit:registerUnitChangeCallback( unit_id, nUI_Unit.Drivers.ComboPoints );
		end
		
		-- collect combo points information for this unit as we know it at this time
	
		unit_info = nUI_Unit:getUnitInfo( unit_id );
		
		if unit_info then
			nUI_Unit:updateComboPointsInfo( unit_id, unit_info );
		end
	end

	return unit_info;

end

function nUI_Unit:unregisterComboPointsCallback( unit_id, callback )

	if unit_id and callback then
		
		-- get the list of current callbacks for this unit ud and remove this callback
		
		list = ComboPointsCallbacks[unit_id] or {};
		
		nUI:TableRemoveByValue( list, callback );
		
		-- if that's the last callback in the list, then remove our event handler of
		-- the list of unit change callbacks for that unit it
		
		if #list == 0 then
			nUI_Unit:unregisterUnitChangeCallback( unit_id, nUI_Unit.Drivers.ComboPoints );
		end
	end

end

-------------------------------------------------------------------------------
-- update the combo points information for this unit
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

function nUI_Unit:updateComboPointsInfo( unit_id, unit_info )

	modified  = false;
	
	if unit_info then

		combo_points = UnitPower( UnitExists( "vehicle" ) and "vehicle" or "player", SPELL_POWER_COMBO_POINTS );
		
		if unit_info.combo_points ~= combo_points
		then
			
			modified               = true;
			unit_info.modified     = true;
			unit_info.last_change  = GetTime();
			unit_info.combo_points = combo_points;
			
		end
	end
	
	return modified and unit_info or nil;
	
end

-------------------------------------------------------------------------------
-- update all of the registered unit combo points listeners, even if there's no 
-- change in data... typically used when entering the world

function nUI_Unit:refreshComboPointsCallbacks()

	for unit_id in pairs( ComboPointsCallbacks ) do
		if ComboPointsCallbacks[unit_id] and #ComboPointsCallbacks[unit_id] > 0 then
			UpdateQueue[unit_id] = true;
			NewUnitInfo[unit_id] = nUI_Unit:getUnitInfo( unit_id );
		end
	end
end

-------------------------------------------------------------------------------
-- create a new unit combo points frame

function nUI_Unit:createComboPointsFrame( parent, unit_id, id, options )

	local frame    = nUI_Unit:createFrame( "$parent_ComboPoints"..(id or ""), parent, unit_id, options and options.clickable );
	frame.textures = {};
	frame.Super    = {};

	for i=1, MAX_COMBO_POINTS do
		
		local texture = frame:CreateTexture( "$parent_Icon"..i, "ARTWORK" );
		
		texture:SetTexture( "Interface\\AddOns\\nUI\\Layouts\\Default\\Art\\nUI_ComboPoints" );
		texture:SetTexCoord( 0, 0, 0, 1, 0.5, 0, 0.5, 1 );
		texture:SetAlpha( 0 );
		
		texture.active    = false;
		texture.highlight = false;
		frame.textures[i] = texture;
		
	end

	-- called when the underlying GUID for the unit changes or when the
	-- content of the GUID is updated

	frame.Super.newUnitInfo = frame.newUnitInfo;
	frame.newUnitInfo       = function( list_unit, unit_info )
		
		frame.Super.newUnitInfo( list_unit, unit_info );
		
		if frame.enabled then
			nUI_Unit:updateComboPointsFrame( frame );
		end
	end

	frame.comboEventHandler = function( self, event, ... )

		if "ON_SHOW" == event then

			frame:RegisterEvent( "UNIT_POWER", frame.onComboPointsEvent );
			
		elseif "ON_HIDE" == event then 

			frame:UnregisterEvent( "UNIT_POWER" );		
			
		else
		
			UpdateQueue["target"] = true;
			NewUnitInfo["target"] = nUI_Unit:getUnitInfo( "target" );

		end

		nUI_Unit:updateComboPointsInfo( "target", unit_info );
		nUI_Unit:updateComboPointsFrame( frame );
	end
	
	frame:SetScript( "OnEvent", frame.comboEventHandler );
	frame:RegisterEvent( "ON_SHOW", frame.comboEventHandler );
	frame:RegisterEvent( "ON_HIDE", frame.comboEventHandler );
	
	if frame:IsVisible() then
		frame:RegisterEvent( "UNIT_POWER", frame.comboEventHandler );
	end

	-- setting enabled to false will prevent the frame from updating when new
	-- unit information is received (saves framerate). Setting enabled true will
	-- call the frame to immediately update if its content has changed since it
	-- was disabled

	frame.Super.setEnabled = frame.setEnabled;	
	frame.setEnabled       = function( enabled )
		
		prior_state = frame.enabled;
		
		frame.Super.setEnabled( enabled );
		
		if frame.enabled ~= prior_state then
		
			if frame.enabled then
				frame.unit_info = nUI_Unit:registerComboPointsCallback( frame.unit, frame );
				nUI_Unit:updateComboPointsFrame( frame );
			else
				nUI_Unit:unregisterComboPointsCallback( frame.unit, frame );
			end
		end
	end
	
	-- used to change the scale of the frame... rather than the Bliz widget frame:SetScale()
	-- this method actually recalculates the size of the frame and uses frame:SetHeight()
	-- and frame:SetWidth() to reflect the actual size of the frame.
	
	frame.Super.applyScale = frame.applyScale;	
	frame.applyScale       = function( scale )

		frame.Super.applyScale( scale );
		
		if frame.textures[1].hSize  ~= frame.hSize 
		or frame.textures[1].vSize  ~= frame.vSize 
		or frame.textures[1].width  ~= frame.width
		or frame.textures[1].height ~= frame.height 
		or frame.textures[1].hInset ~= frame.hInset
		or frame.textures[1].vInset ~= frame.vInset
		then
			
			frame.textures[1].hSize  = frame.hSize;
			frame.textures[1].vSize  = frame.vSize;
			frame.textures[1].width  = frame.width;
			frame.textures[1].height = frame.height;
			frame.textures[1].hInset = frame.hInset;
			frame.textures[1].vInset = frame.vInset;
			
			for i=1, #frame.textures do
				
				frame.textures[i]:SetWidth( (frame.hSize or frame.width) - frame.hInset );
				frame.textures[i]:SetHeight( (frame.vSize or frame.height) - frame.vInset );

			end
		end		
	end
	
	-- applies the set of frame options to this frame. Typically called when the frame 
	-- is first created or when the user changes options via config.
	
	frame.Super.applyOptions = frame.applyOptions;
	frame.applyOptions       = function( options )

		local last_texture, first, left, right;
		
		frame.Super.applyOptions( options );
		
		for i=1, #frame.textures do
			
			local texture = frame.textures[i];
			
			texture:ClearAllPoints();
			
			if options.orient == "RIGHT" then
				if i == 1 then texture:SetPoint( "RIGHT", frame, "RIGHT", 0, 0 );
				else texture:SetPoint( "RIGHT", last_texture, "LEFT", 0, 0 );
				end
			elseif options.orient == "CENTER" then
				if i == 1 then texture:SetPoint( "CENTER", frame, "CENTER", 0, 0 ); first = texture;
				elseif (i % 2) == 0 then texture:SetPoint( "RIGHT", left or first, "LEFT", 0, 0 ); left = texture;
				else texture:SetPoint( "LEFT", right or first, "RIGHT", 0, 0 ); right = texture;
				end
			elseif options.orient == "TOP" then
				if i == 1 then texture:SetPoint( "TOP", frame, "TOP", 0, 0 );
				else texture:SetPoint( "TOP", last_texture, "BOTTOM", 0, 0 );
				end
			elseif options.orient == "BOTTOM" then
				if i == 1 then texture:SetPoint( "BOTTOM", frame, "BOTTOM", 0, 0 );
				else texture:SetPoint( "BOTTOM", last_texture, "TOP", 0, 0 );
				end
			elseif options.orient == "MIDDLE" then
				if i == 1 then texture:SetPoint( "CENTER", frame, "CENTER", 0, 0 ); first = texture;
				elseif (i % 2) == 0 then texture:SetPoint( "TOP", left or first, "BOTTOM", 0, 0 ); left = texture;
				else texture:SetPoint( "BOTTOM", right or last_first, "TOP", 0, 0 ); right = texture;
				end
			else
				if i == 1 then texture:SetPoint( "LEFT", frame, "LEFT", 0, 0 );
				else texture:SetPoint( "LEFT", last_texture, "RIGHT", 0, 0 );
				end				
			end
			
			last_texture = texture;
			
		end
		
		nUI_Unit:updateComboPointsFrame( frame );
		
	end

	-- initiate the frame
	
	frame.unit_info = nUI_Unit:registerComboPointsCallback( frame.unit, frame );
	
	frame.applyOptions( options );
	
	return frame;
	
end

-------------------------------------------------------------------------------
-- remove a unit combo points frame

function nUI_Unit:deleteComboPointsFrame( frame )

	nUI_Unit:unregisterComboPointsCallback( frame.unit, frame );
	nUI_Unit:deleteFrame( frame );
	
end

-------------------------------------------------------------------------------
-- display the appropriate icon for the unit's combo points status
--
-- note: this method expends extra energy in state management... as in knowing
--       exactly what state it is currently in and only updating the frame text,
--       content, colors, alphas, etc. when a change in state occurs. The extra
--       effort is spent on state management in order to reduce impact to the
--       graphics engine so as to preserve frame rate. It costs far less to check
--		 a memory value that and burn through the graphics geometry. It does not
--       matter how many times the unit changes GUID or how many times this 
--       method will call, it will only alter the graphics elements when its
--       relative state changes.

function nUI_Unit:updateComboPointsFrame( frame )
	
	unit_info = frame.unit_info;
	
	-- if there is no unit or we don't know it's combo points status, then hide the icons
	
	if not unit_info 
	or not unit_info.combo_points
	then
		if frame.active then
			frame.active = false;
			frame:SetAlpha( 0 );
		end
	
	-- otherwise, show the icon
	
	else

		highlight = unit_info.combo_points == MAX_COMBO_POINTS;
		-- if the combo points icon is hidden, show it
		
		if not frame.active then
			frame.active = true;
			frame:SetAlpha( 1 );
		end
		
		for i=1, #frame.textures do
			
			texture = frame.textures[i];

			if i > unit_info.combo_points then
				
				if texture.active then
					
					texture.active = false;
					texture:SetAlpha( 0 );
					
				end
				
			else
				
				if not texture.active then
					
					texture.active = true;
					texture:SetAlpha( 1 );
					
				end
				
				if texture.highlight ~= highlight then
					
					texture.highlight = highlight;
					
					if highlight then
						texture:SetTexCoord( 0.5, 0, 0.5, 1, 1, 0, 1, 1 );
					else
						texture:SetTexCoord( 0, 0, 0, 1, 0.5, 0, 0.5, 1 );
					end
				end
			end
		end
	end
end
