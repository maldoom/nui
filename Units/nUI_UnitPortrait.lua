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
if not nUI_Options then nUI_Options = {}; end
if not nUI_UnitOptions then nUI_UnitOptions = {}; end
if not nUI_DefaultConfig then nUI_DefaultConfig = {}; end
if not nUI_Profile then nUI_Profile = {}; end;

local CreateFrame        = CreateFrame;
local GetTime            = GetTime;
local InCombatLockdown   = InCombatLockdown;
local SetPortraitTexture = SetPortraitTexture;
local UnitIsVisible      = UnitIsVisible;

-------------------------------------------------------------------------------
-- unit portrait event management

if not nUI_Unit.Drivers then 
	nUI_Unit.Drivers = CreateFrame( "Frame", "nUI_UnitDrivers", WorldFrame ); 
end

nUI_Profile.nUI_UnitPortrait       = {};
nUI_Profile.nUI_UnitPortrait.Frame = {};

local ProfileCounter      = nUI_Profile.nUI_UnitPortrait;
local FrameProfileCounter = nUI_Profile.nUI_UnitPortrait.Frame;

local frame = CreateFrame( "Frame", "$parent_Portrait", nUI_Unit.Drivers )

local animState            = true;
local PortraitCallbacks    = {};
local PortraitUnits        = {};
local VisibilityState      = {};
local UpdateQueue          = {};
local NewUnitInfo          = {};
local queue_timer          = 1 / nUI_DEFAULT_FRAME_RATE;
local visibility_timer     = 1 / nUI_DEFAULT_FRAME_RATE;

nUI_Unit.Drivers.Portrait  = frame;

-------------------------------------------------------------------------------
-- variables used in methods within this module are declared here to eliminate
-- the use of dynamic memory and the garbage collector

local unit_id;
local unit_info;
local new_info;
local list;
local modified;
local prior_state;

-------------------------------------------------------------------------------

local function onPortraitEvent( who, event, arg1 )
	
--	nUI_ProfileStart( ProfileCounter, "onPortraitEvent", event );
	
	-- for these events, we don't know which units are affected, so
	-- we span the list of all known interested units to see who is watching
		
	if event == "PLAYER_ENTERING_WORLD" then
	
		nUI_Unit:refreshPortraitCallbacks();
		
	elseif event == "ADDON_LOADED" then
		
		if arg1 == "nUI" then
			animState = nUI_Options.show_anim;
		end
		
	-- we're only going to look at the event if there's someone who cares about it
		
	elseif PortraitCallbacks[arg1] and #PortraitCallbacks[arg1] > 0 then
			
		UpdateQueue[arg1] = true;
		NewUnitInfo[arg1] = nUI_Unit:getUnitInfo( arg1 );
		
	end

--	nUI_ProfileStop();
	
end

frame:SetScript( "OnEvent", onPortraitEvent );
frame:RegisterEvent( "ADDON_LOADED" );
frame:RegisterEvent( "PLAYER_ENTERING_WORLD" );
frame:RegisterEvent( "UNIT_MODEL_CHANGED" );
frame:RegisterEvent( "UNIT_PORTRAIT_UPDATE" );

-------------------------------------------------------------------------------
-- visibility update handler... periodically test each unit to see if the
-- unit's visibility has changed as this affects our ability to show an
-- animated model of the unit.

local function onVisibilityUpdate( who, elapsed )
	
--	nUI_ProfileStart( ProfileCounter, "onVisibilityUpdate" );
	
	visibility_timer = visibility_timer - elapsed;
	
	if visibility_timer <= 0 then
		
		visibility_timer = nUI_Unit.frame_rate;
		
		-- if the user has toggled animation on or off, then
		-- update all of the portraits
		
		if animState ~= nUI_Options.show_anim then
			animState = nUI_Options.show_anim;
			for i in pairs( UpdateQueue ) do
				UpdateQueue[i] = false;
			end
			nUI_Unit:refreshPortraitCallbacks();
		end
			
		for unit_id in pairs( PortraitCallbacks ) do
			
			unit_info = nUI_Unit:getUnitInfo( unit_id );
			
			if unit_info and #PortraitCallbacks[unit_id] > 0 then
				
				if VisibilityState[unit_id] ~= unit_info.is_visible 
				then
					UpdateQueue[unit_id] = true;
					NewUnitInfo[unit_id] = nUI_Unit:getUnitInfo( unit_id );
				end
			end
		end
	end

	queue_timer = queue_timer - elapsed;
	
	if queue_timer <= 0 then -- process the update queue at the user selected frame rate
	
		queue_timer = nUI_Unit.frame_rate;

		for unit_id in pairs( UpdateQueue ) do
		
			if UpdateQueue[unit_id] then
			
				UpdateQueue[unit_id] = false;
				unit_info = NewUnitInfo[unit_id];
				new_info  = nUI_Unit:updatePortraitInfo( unit_id, unit_info );

				VisibilityState[unit_id] = unit_info and unit_info.is_visible or false;
				
				if PortraitCallbacks[unit_id] and #PortraitCallbacks[unit_id] > 0 then
					nUI_Unit:notifyCallbacks( 
						nUI_L["unit portrait"], PortraitCallbacks, PortraitUnits, 
						unit_info, unit_id, new_info
					);
				end
			end
		end
	end	
	
--	nUI_ProfileStop();
	
end
	
frame:SetScript( "OnUpdate", onVisibilityUpdate );

-------------------------------------------------------------------------------
-- this callback method is called when one of the unit IDs we are monitoring
-- for unit portrait changes GUID

frame.newUnitInfo = function( unit_id, unit_info )

--	nUI_ProfileStart( ProfileCounter, "newUnitInfo" );
	
	UpdateQueue[unit_id] = true;
	NewUnitInfo[unit_id] = unit_info;
	
--	nUI_ProfileStop();
	
end

-------------------------------------------------------------------------------
-- add and remove callbacks from the list of unit portrait listeners we manage
--
-- calling this method will return the current unit_info structure for this 
-- unit if it exists or nil if the unit does not exist at this time
--
-- Note: these callbacks will be notified both when the underlying GUID for the
--		 unit changes or when the portrait of the underlying GUID changes. 
--       If the underlying unit does not exist, the callback will be passed 
--       a nil unit_info structure

function nUI_Unit:registerPortraitCallback( unit_id, callback )
	
--	nUI_ProfileStart( ProfileCounter, "registerPortraitCallback" );
	
	unit_info = nil;
	
	if unit_id and callback then
		
		-- get the list of callbacks for this unit id and add this callback
		
		list = PortraitCallbacks[unit_id] or {};
		
		nUI:TableInsertByValue( list, callback );
		
		-- if this is a new unit id, add it to the callback list
		
		if not PortraitCallbacks[unit_id] then
			PortraitCallbacks[unit_id] = list;
		end
		
		-- if this is the first callback for the unit id, then register our
		-- event driver to receive notice when the GUID changes on this id
		
		if #list == 1 then
			nUI_Unit:registerUnitChangeCallback( unit_id, nUI_Unit.Drivers.Portrait );
		end
		
		-- determine the portrait for this unit as we know it at this time
	
		unit_info = nUI_Unit:getUnitInfo( unit_id );
		
		if unit_info then
			nUI_Unit:updatePortraitInfo( unit_id, unit_info );
		end
	end
	
--	nUI_ProfileStop();
	
	return unit_info;
	
end

function nUI_Unit:unregisterPortraitCallback( unit_id, callback )
	
--	nUI_ProfileStart( ProfileCounter, "unregisterPortraitCallback" );
	
	if unit_id and callback then
		
		-- get the list of current callbacks for this unit ud and remove this callback
		
		list = PortraitCallbacks[unit_id] or {};
		
		nUI:TableRemoveByValue( list, callback );
		
		-- if that's the last callback in the list, then remove our event handler of
		-- the list of unit change callbacks for that unit it
		
		if #list == 0 then
			nUI_Unit:unregisterUnitChangeCallback( unit_id, nUI_Unit.Drivers.Portrait );
		end
	end

--	nUI_ProfileStop();
	
end

-------------------------------------------------------------------------------
-- update the portrait for this unit
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

function nUI_Unit:updatePortraitInfo( unit_id, unit_info )

--	nUI_ProfileStart( ProfileCounter, "updatePortraitInfo" );
	
	modified  = false;
	
	if unit_info then

		-- stubbed out to support future changes in how models are handled
		-- for now, if the unit exists, assume that we need to update the
		-- model or portrait any time we are called (new unit, change in
		-- visibility, user toggled animation on/off, etc.)
		
		modified = true;
		
	end
	
--	nUI_ProfileStop();
	
	return modified and unit_info or nil;
	
end

-------------------------------------------------------------------------------
-- update all of the registered unit portrait listeners, even if there's no 
-- change in data... typically used when the portrait options change
-- or entering the world

function nUI_Unit:refreshPortraitCallbacks()

--	nUI_ProfileStart( ProfileCounter, "refreshPortraitCallbacks" );
	
	for unit_id in pairs( PortraitCallbacks ) do
		if PortraitCallbacks[unit_id] and #PortraitCallbacks[unit_id] > 0 then
			UpdateQueue[unit_id] = true;
			NewUnitInfo[unit_id] = nUI_Unit:getUnitInfo( unit_id );
		end
	end

--	nUI_ProfileStop();
	
end

-------------------------------------------------------------------------------
-- create a new unit portrait frame

function nUI_Unit:createPortraitFrame( parent, unit_id, id, options )

--	nUI_ProfileStart( ProfileCounter, "createPortraitFrame" );
	
	local frame           = nUI_Unit:createFrame( "$parent_Portrait"..(id or ""), parent, unit_id, options and options.clickable );
	frame.texture         = frame:CreateTexture( "$parentTexture", "ARTWORK" );
	frame.overlay         = frame:CreateTexture( "$parentOverlay", "OVERLAY" );
	frame.model           = CreateFrame( "PlayerModel", "$parentModel", frame );
	frame.model.overlay   = frame.model:CreateTexture( "$parentOverlay", "OVERLAY" );
	frame.model.backdrop  = frame.model:CreateTexture( "$parentBackdrop", "BACKGROUND" );
	frame.model.visible   = true;
	frame.Super           = {};

	if not nUI_Options.show_anim then
		frame.model:Hide();
	else
		frame.model:Show();
	end
	
	frame.model:SetAlpha( 1 );
	frame.model:SetPoint( "CENTER", frame, "CENTER", 0, 0 );
	frame.texture:SetPoint( "CENTER", frame, "CENTER", 0, 0 );
	frame.texture:SetAlpha( 0 );	
	
	frame.overlay:SetHeight( 128 );
	frame.overlay:SetWidth( 128 );
	frame.overlay:SetAllPoints( frame.texture );
	frame.overlay:SetTexture( "Interface\\AddOns\\nUI\\Layouts\\Default\\Art\\nUI_PortraitFrame" );
	frame.overlay:SetTexCoord( 0, 1, 0, 0.98 );
	frame.overlay:SetAlpha( 0 );
	
	frame.model.overlay:SetHeight( 128 );
	frame.model.overlay:SetWidth( 128 );
	frame.model.overlay:SetAllPoints( frame.texture );
	frame.model.overlay:SetTexture( "Interface\\AddOns\\nUI\\Layouts\\Default\\Art\\nUI_ModelFrame" );
	frame.model.overlay:SetTexCoord( 0, 1, 0, 1 );

	frame.model.backdrop:SetColorTexture( 0, 0, 0, 1 );
	frame.model.backdrop:SetAllPoints( frame.model );

	-- called when the underlying GUID for the unit changes or when the
	-- content of the GUID is updated

	frame.Super.newUnitInfo = frame.newUnitInfo;
	frame.newUnitInfo       = function( list_unit, unit_info )
		
--		nUI_ProfileStart( FrameProfileCounter, "newUnitInfo" );
		
		frame.Super.newUnitInfo( list_unit, unit_info );
		
		if frame.enabled then
			nUI_Unit:updatePortraitFrame( frame );
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
				if nUI_Options.show_anim and frame.model.visible then 
					frame.model:SetUnit( frame.unit );
					frame.model:SetCamera( frame.options.model and 1 or 0 );
					frame.model:SetAlpha( 1 );
				end
				frame.unit_info = nUI_Unit:registerPortraitCallback( frame.unit, frame );
				nUI_Unit:updatePortraitFrame( frame );
			else
				nUI_Unit:unregisterPortraitCallback( frame.unit, frame );
				frame.model:SetUnit( "none" );
				frame.model:ClearModel();
				frame.model:SetAlpha( 0 );
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
			
			frame.model:SetWidth( (frame.hSize or frame.width) - frame.hInset );
			frame.model:SetHeight( (frame.vSize or frame.height) - frame.vInset );

		end		

--		nUI_ProfileStop();
		
	end
	
	-- applies the set of frame options to this frame. Typically called when the frame 
	-- is first created or when the user changes options via config.

	frame.Super.applyOptions = frame.applyOptions;
	frame.applyOptions       = function( options )

--		nUI_ProfileStart( FrameProfileCounter, "applyOptions" );
		
		frame.Super.applyOptions( options );
		
		-- set the camera
		
		frame.model:SetFrameStrata( frame:GetFrameStrata() );
		frame.model:SetFrameLevel( frame:GetFrameLevel() );		

		if options.show_anim and nUI_Options.show_anim then
			
			frame.model:SetUnit( unit_id );
			frame.model:SetCamera( options.model and 1 or 0 );
			frame.model:Show();
			
			frame.model:SetScript( "OnShow",
				function()
					frame.model:SetCamera( frame.options.model and 1 or 0 );
				end
			);

		else
			
			frame.model:SetScript( "OnShow", nil );
			frame.model:SetUnit( "none" );
			frame.model:ClearModel();
			frame.model:Hide();
			
		end

		-- set visibility of the frame overlays
		
		frame.overlay:SetAlpha( not frame.model.visible and frame.options.outline and 1 or 0 );
		frame.model.overlay:SetAlpha( frame.model.visible and frame.options.outline and 1 or 0 );
		frame.model.backdrop:SetAlpha( frame.options.outline and 1 or 0 );
		
		-- and refresh the frame
		
		nUI_Unit:updatePortraitFrame( frame );
		
--		nUI_ProfileStop();
		
	end

	-- initiate the frame
	
	frame.unit_info = nUI_Unit:registerPortraitCallback( frame.unit, frame );
		
	frame.applyOptions( options );
	
--	nUI_ProfileStop();
	
	return frame;
	
end

-------------------------------------------------------------------------------
-- remove a unit class frame

function nUI_Unit:deletePortraitFrame( frame )

--	nUI_ProfileStart( ProfileCounter, "deletePortraitFrame" );
		
	nUI_Unit:unregisterPortraitCallback( frame.unit, frame );
	nUI_Unit:deleteFrame( frame );
	
--	nUI_ProfileStop();
	
end

-------------------------------------------------------------------------------
-- display the appropriate image for the unit's portrait
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

function nUI_Unit:updatePortraitFrame( frame )
	
--	nUI_ProfileStart( ProfileCounter, "updatePortraitFrame" );
		
	unit_info = frame.unit_info;

	-- if there is no unit or we don't know it's portrait, then hide the image

	if not unit_info 
	then

		if frame.active then
			frame.active = false;
			frame.texture:SetAlpha( 0 );
			frame.model:SetAlpha( 0 );
		end
	
	-- otherwise, show the icon and clip the appropriate region
	
	else

		-- if the portrait is hidden, show it
		
		if not frame.active then
			frame.active = true;
			
			if not nUI_Options.show_anim then 
				frame.texture:SetAlpha( 1 );
			else 
				frame.model:SetAlpha( 1 );
			end
		end

		-- if animation is active and the unit is in visible range
		-- we just need to reset the model
		
		if nUI_Options.show_anim 
		and unit_info.is_visible
		then

			if not frame.model.visible then
				frame.model:Show();
				frame.model:SetAlpha( 1 );
				frame.texture:SetAlpha( 0 );
				frame.overlay:SetAlpha( 0 );
				frame.model.overlay:SetAlpha( frame.options.outline and 1 or 0 );
				frame.model.visible = true;
			end

			frame.model:SetUnit( frame.unit );
			frame.model:SetCamera( frame.options.model and 1 or 0 );
			
		-- otherwise, we either are not using animation or the unit is out of
		-- range and we need to use a portrait
		
		else

			-- make sure the animation model is hidden

			if frame.model.visible or frame.model:GetAlpha() > 0 then
				frame.model:Hide();
				frame.model:SetAlpha( 0 );
				frame.texture:SetAlpha( 1 );				
				frame.overlay:SetAlpha( frame.options.outline and 1 or 0 );
				frame.model.overlay:SetAlpha( 0 );
				frame.model.visible = false;
			end
			
			-- and update the portrait if needed
			
			SetPortraitTexture( frame.texture, frame.unit );
				
		end
	end
	
--	nUI_ProfileStop();
	
end
