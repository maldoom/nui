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

local GetTime   = GetTime;
local UnitName  = UnitName;

-------------------------------------------------------------------------------
-- unit label event management

if not nUI_Unit.Drivers then 
	nUI_Unit.Drivers = CreateFrame( "Frame", "nUI_UnitDrivers", WorldFrame ); 
end

nUI_Profile.nUI_UnitLabel       = {};
nUI_Profile.nUI_UnitLabel.Frame = {};

local ProfileCounter      = nUI_Profile.nUI_UnitLabel;
local FrameProfileCounter = nUI_Profile.nUI_UnitLabel.Frame;

local frame = CreateFrame( "Frame", "$parent_Label", nUI_Unit.Drivers )

local LabelCallbacks    = {};
local LabelUnits        = {};
local NewUnitInfo       = {};
local UpdateQueue       = {};
local queue_timer       = 1 / nUI_DEFAULT_FRAME_RATE;

nUI_Unit.Drivers.Label  = frame;

-------------------------------------------------------------------------------
-- variables used in methods within this module are declared here to eliminate
-- the use of dynamic memory and the garbage collector

local unit_id;
local unit_info;
local list;
local modified;
local name, realm;
local prior_state;
local class_colors;
local label_color;
local show_reaction;
local reaction_color;
local r;
local g;
local b;
local a;

-------------------------------------------------------------------------------

local function onLabelEvent( who, event, arg1 )

--	nUI_ProfileStart( ProfileCounter, "onLabelEvent", event );
	
	-- for these events, we don't know which units are affected, so
	-- we span the list of all known interested units to see who is watching
		
	if event == "PLAYER_ENTERING_WORLD" then
		
		nUI_Unit:refreshLabelCallbacks();
		
	-- we're only going to look at the event if there's someone who cares about it
		
	elseif LabelCallbacks[arg1] and #LabelCallbacks[arg1] > 0 then
			
		UpdateQueue[arg1] = true;
		NewUnitInfo[arg1] = nUI_Unit:getUnitInfo( arg1 );
		
	end		

--	nUI_ProfileStop();
	
end

frame:SetScript( "OnEvent", onLabelEvent );
frame:RegisterEvent( "PLAYER_ENTERING_WORLD" );
frame:RegisterEvent( "UNIT_NAME_UPDATE" );

-------------------------------------------------------------------------------

local function onQueueUpdate( who, elapsed )

	queue_timer = queue_timer - elapsed;
	
	if queue_timer <= 0 then -- process the update queue at the user selected frame rate
	
		queue_timer = nUI_Unit.frame_rate;

		for unit_id in pairs( UpdateQueue ) do
		
			if UpdateQueue[unit_id] then
			
				UpdateQueue[unit_id] = false;
				unit_info = NewUnitInfo[unit_id];
								
				if LabelCallbacks[unit_id] and #LabelCallbacks[unit_id] > 0 then
					nUI_Unit:notifyCallbacks( 
						nUI_L["unit label"], LabelCallbacks, LabelUnits, 
						unit_info, unit_id, nUI_Unit:updateLabelInfo( unit_id, unit_info ) 
					);
				end
			end
		end
	end	
end

frame:SetScript( "OnUpdate", onQueueUpdate );

-------------------------------------------------------------------------------
-- this callback method is called when one of the unit IDs we are monitoring
-- for unit label changes GUID or when the unit reaction information changes

frame.newUnitInfo = function( unit_id, unit_info )

--	nUI_ProfileStart( ProfileCounter, "newUnitInfo" );
	
	UpdateQueue[unit_id] = true;
	NewUnitInfo[unit_id] = unit_info;
	
--	nUI_ProfileStop();
	
end

-------------------------------------------------------------------------------
-- add and remove callbacks from the list of unit label listeners we manage
--
-- calling this method will return the current unit_info structure for this 
-- unit if it exists or nil if the unit does not exist at this time
--
-- Note: these callbacks will be notified both when the underlying GUID for the
--		 unit changes or when the label info of the underlying GUID to the
--		 player changes. If the underlying unit does not exist, the callback
--		 will be passed a nil unit_info structure

function nUI_Unit:registerLabelCallback( unit_id, callback )
	
--	nUI_ProfileStart( ProfileCounter, "registerLabelCallback" );
	
	unit_info = nil;
	
	if unit_id and callback then
		
		-- get the list of callbacks for this unit id and add this callback
		
		list = LabelCallbacks[unit_id] or {};
		
		nUI:TableInsertByValue( list, callback );
		
		-- if this is a new unit id, add it to the callback list
		
		if not LabelCallbacks[unit_id] then
			LabelCallbacks[unit_id] = list;
		end
		
		-- if this is the first callback for the unit id, then register our
		-- event driver to receive notice when the GUID changes on this id
		
		if #list == 1 then
			nUI_Unit:registerStatusCallback( unit_id, nUI_Unit.Drivers.Label );
		end
		
		-- collect label information for this unit as we know it at this time
	
		unit_info = nUI_Unit:getUnitInfo( unit_id );
		
		if unit_info then
			nUI_Unit:updateLabelInfo( unit_id, unit_info );
		end
	end
	
--	nUI_ProfileStop();
	
	return unit_info;
	
end

function nUI_Unit:unregisterLabelCallback( unit_id, callback )
	
--	nUI_ProfileStart( ProfileCounter, "unregisterLabelCallback" );
	
	if unit_id and callback then
		
		-- get the list of current callbacks for this unit id and remove this callback
		
		list = LabelCallbacks[unit_id] or {};
		
		nUI:TableRemoveByValue( list, callback );
		
		-- if that's the last callback in the list, then remove our event handler of
		-- the list of unit change callbacks for that unit it
		
		if #list == 0 then
			nUI_Unit:unregisterStatusCallback( unit_id, nUI_Unit.Drivers.Label );
		end
	end

--	nUI_ProfileStop();
	
end

-------------------------------------------------------------------------------
-- update the label information for this unit
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

function nUI_Unit:updateLabelInfo( unit_id, unit_info )

--	nUI_ProfileStart( ProfileCounter, "updateLabelInfo" );
	
	modified  = false;
	
	if unit_info then
		
		-- check to see if the label has changed
		
		name, realm = UnitName( unit_id );

		if unit_info.status_info and unit_info.status_info.is_dnd then
			name = ("%s |cFF00FFFF(%s)|r"):format( name or "", nUI_L["DND"] );
		end
		
		if unit_info.name ~= name
		or unit_info.realm ~= realm
		then
			
			modified              = true;
			unit_info.last_change = GetTime();
			unit_info.name        = name;
			unit_info.realm       = realm;
			
		end
	end
	
--	nUI_ProfileStop();
	
	return modified and unit_info or nil;
	
end

-------------------------------------------------------------------------------
-- update all of the registered unit label listeners, even if there's no 
-- change in data.

function nUI_Unit:refreshLabelCallbacks()
	
--	nUI_ProfileStart( ProfileCounter, "refreshLabelCallbacks" );
	
	for unit_id in pairs( LabelCallbacks ) do
		if LabelCallbacks[unit_id] and #LabelCallbacks[unit_id] > 0 then
			UpdateQueue[unit_id] = true;
			NewUnitInfo[unit_id] = nUI_Unit:getUnitInfo( unit_id );
		end
	end

--	nUI_ProfileStop();
	
end

-------------------------------------------------------------------------------
-- create a new unit label frame

function nUI_Unit:createLabelFrame( parent, unit_id, id, options )

--	nUI_ProfileStart( ProfileCounter, "createLabelFrame" );
	
	local frame          = nUI_Unit:createFrame( "$parent_Label"..(id or ""), parent, unit_id, options and options.clickable );	
	frame.text           = frame:CreateFontString( "$parentText", "OVERLAY" );
	frame.texture        = frame:CreateTexture( "$parentReaction", "ARTWORK" );
	frame.texture.active = true;
	frame.Super   = {};
		
	frame.texture:SetPoint( "CENTER", frame, "CENTER", 0, 0 );
	frame.texture:SetColorTexture( 1, 1, 1, 1 );
	frame.texture:SetTexCoord( 0, 0, 0, 1, 1, 0, 1, 1 );
	
	-- called when the underlying GUID for the unit changes or when the
	-- content of the GUID is updated
	
	frame.Super.newUnitInfo = frame.newUnitInfo;
	frame.newUnitInfo       = function( list_unit, unit_info )
		
--		nUI_ProfileStart( FrameProfileCounter, "newUnitInfo" );
		
		frame.Super.newUnitInfo( list_unit, unit_info );
		
		if frame.enabled then
			nUI_Unit:updateLabelFrame( frame );
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
				if frame.show_reaction then 
					nUI_Unit:registerReactionCallback( frame.unit, frame );
				end
				if frame.class_colors then
					nUI_Unit:registerClassCallback( frame.unit, frame );
				end
				frame.unit_info = nUI_Unit:registerLabelCallback( frame.unit, frame );
				nUI_Unit:updateLabelFrame( frame );
			else
				if frame.show_reaction then
					nUI_Unit:unregisterReactionCallback( frame.unit, frame );
				end
				if frame.class_colors then
					nUI_Unit:unregisterClassCallback( frame.unit, frame );
				end
				nUI_Unit:unregisterLabelCallback( frame.unit, frame );
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
		
		-- if we want to show unit reaction in the frame background then
		-- register for callbacks on reaction updates
		
		if options.show_reaction and not frame.show_reaction then
			frame.show_reaction = true;
			frame.unit_info = nUI_Unit:registerReactionCallback( frame.unit, frame );
			
		-- otherwise make sure we're not getting callbacks we don't cre about
		
		elseif frame.show_reaction then
			frame.show_reaction = false;
			nUI_Unit:unregisterReactionCallback( frame.unit, frame );
		end
		
		-- if we want to use class colors on the label text, then register
		-- for callbacks on class updates
		
		if options.class_colors and not frame.class_colors then
			frame.class_colors = true;
			frame.unit_info = nUI_Unit:registerClassCallback( frame.unit, frame );
			
		-- otthewise, again, makes sure we're not wasting CPU cycles
		
		elseif frame.class_colors then
			frame.class_colors = false;
			nUI_Unit:unregisterClassCallback( frame.unit, frame );
		end
		
		-- refresh the frame
		
		nUI_Unit:updateLabelFrame( frame );
		
--		nUI_ProfileStop();
		
	end
	
	-- initiate the frame
	
	frame.unit_info = nUI_Unit:registerLabelCallback( frame.unit, frame );
	
	frame.applyOptions( options );
	
--	nUI_ProfileStop();
	
	return frame;
	
end

-------------------------------------------------------------------------------
-- remove a unit label frame

function nUI_Unit:deleteLabelFrame( frame )

--	nUI_ProfileStart( ProfileCounter, "deleteLabelFrame" );
		
	nUI_Unit:unregisterLabelCallback( frame.unit, frame );
	nUI_Unit:deleteFrame( frame );
	
--	nUI_ProfileStop();
	
end

-------------------------------------------------------------------------------
-- display the appropriate icon for the unit's label
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

function nUI_Unit:updateLabelFrame( frame )
	
--	nUI_ProfileStart( ProfileCounter, "updateLabelFrame" );
		
	unit_info = frame.unit_info;
	
	-- if there is no unit or we don't know it's label, then hide the panel
	
	if not unit_info or not unit_info.name then
		
		if frame.active then
			frame.active = false;
			frame:SetAlpha( 0 );
		end
	
	-- otherwise, show the label
	
	else

		-- if the label is hidden, show it
		
		if not frame.active then
			frame.active = true;
			frame:SetAlpha( 1 );
		end

		-- if the label has changed from what we last knew, then update 
		
		name = frame.options.text or unit_info.name;

		if frame.name ~= name then

			frame.name = name;
			
			frame.text:SetText( name );
		
		end
		
		-- check and see if the label color has changed (showing class colors)

		class_colors = frame.options.class_colors and unit_info.class_info and unit_info.class_info.color ~= nil;
		label_color  = class_colors and unit_info.class_info.color;
		
		if label_color
		and frame.class_color ~= label_color
		then
							
			frame.class_color = label_color;
			
			frame.text:SetTextColor( label_color.r, label_color.g, label_color.b, 1 );
			
		end

		-- check and see if the unit reaction color has changed
		
		show_reaction  = frame.show_reaction and unit_info.reaction_color ~= nil;
		reaction_color = show_reaction and unit_info.reaction_color or (frame.options.border and frame.options.border.color.backdrop or {});
		
		r = reaction_color.r or 0;
		g = reaction_color.g or 0;
		b = reaction_color.b or 0;
		a = reaction_color.a or 0;
		
		if frame.reaction_r ~= r
		or frame.reaction_g ~= g
		or frame.reaction_b ~= b
		or frame.reaction_a ~= a
		then
							
			frame.reaction_r = r;
			frame.reaction_g = g;
			frame.reaction_b = b;
			frame.reaction_a = a;
			
			frame.texture:SetVertexColor( r, g, b, 1 );
			frame.texture:SetAlpha( a );
			
		end
		
	end
	
--	nUI_ProfileStop();
	
end
