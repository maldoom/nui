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
if not nUI_UnitSkins then nUI_UnitSkins = {}; end
if not nUI_UnitOptions then nUI_UnitOptions = {}; end
if not nUI_DefaultConfig then nUI_DefaultConfig = {}; end
if not nUI_Profile then nUI_Profile = {}; end;

nUI_DefaultConfig.UnitOptions =
{
	click_cast = "yes",
};

nUI_Profile.nUI_Unit       = {};
nUI_Profile.nUI_Unit.Frame = {};
nUI_Unit.frame_rate        = 1 / nUI_DEFAULT_FRAME_RATE;
nUI_UnitOptions.click_cast = strlower( nUI_UnitOptions.click_cast or nUI_DefaultConfig.UnitOptions.click_cast );

local ProfileCounter      = nUI_Profile.nUI_Unit;
local FrameProfileCounter = nUI_Profile.nUI_Unit.Frame;

-------------------------------------------------------------------------------
-- variables used within the various methods are declared here rather in the
-- method in order to avoid all use of dynamic memory to reduce the exercising
-- of the garbage collector as much as humanly possible

local clickable;
local unit_id;
local frame;
local element;
local skin;
local skin_elements;
local update_elements;
local update;
local unit_info;
local unit_popup;
local raid_id;
local unit_name;
local anchor;
local scale;
local height;
local width;
local alpha;
local anchor_pt;
local relative_to;
local relative_pt;
local xOfs;
local yOfs;
local name;
local border_color;
local backdrop_color;
local color;

-------------------------------------------------------------------------------
-- create a unit frame element

local function CreateElement( parent, type, id, options, anchor )

--	nUI_ProfileStart( ProfileCounter, "CreateElement" );
	
	clickable = parent.options.clickable;
	unit_id   = parent:GetAttribute( "unit" );

	if     type == "Aura"        then frame = nUI_Unit:createAuraFrame( parent, unit_id, id, options );
	elseif type == "Casting"     then frame = nUI_Unit:createCastingFrame( parent, unit_id, id, options );
	elseif type == "Class"       then frame = nUI_Unit:createClassFrame( parent, unit_id, id, options );
	elseif type == "Combat"      then frame = nUI_Unit:createCombatFrame( parent, unit_id, id, options );
	elseif type == "ComboPoints" then frame = nUI_Unit:createComboPointsFrame( parent, unit_id, id, options );
	elseif type == "Feedback"    then frame = nUI_Unit:createFeedbackFrame( parent, unit_id, id, options );
	elseif type == "GCD"         then frame = nUI_Unit:createGCDFrame( parent, unit_id, id, options );
	elseif type == "Health"      then frame = nUI_Unit:createHealthFrame( parent, unit_id, id, options );
	elseif type == "Label"       then frame = nUI_Unit:createLabelFrame( parent, unit_id, id, options );
	elseif type == "Level"       then frame = nUI_Unit:createLevelFrame( parent, unit_id, id, options );
	elseif type == "Portrait"    then frame = nUI_Unit:createPortraitFrame( parent, unit_id, id, options );
	elseif type == "Power"       then frame = nUI_Unit:createPowerFrame( parent, unit_id, id, options );
	elseif type == "PvP"         then frame = nUI_Unit:createPvPFrame( parent, unit_id, id, options );
	elseif type == "RaidGroup"   then frame = nUI_Unit:createRaidGroupFrame( parent, unit_id, id, options );
	elseif type == "RaidTarget"  then frame = nUI_Unit:createRaidTargetFrame( parent, unit_id, id, options );
	elseif type == "Range"       then frame = nUI_Unit:createRangeFrame( parent, unit_id, id, options );
	elseif type == "ReadyCheck"  then frame = nUI_Unit:createReadyCheckFrame( parent, unit_id, id, options );
	elseif type == "Resting"     then frame = nUI_Unit:createRestingFrame( parent, unit_id, id, options );
	elseif type == "Role"        then frame = nUI_Unit:createRoleFrame( parent, unit_id, id, options );
	elseif type == "Runes"       then frame = nUI_Unit:createRunesFrame( parent, unit_id, id, options );
	elseif type == "Spec"        then frame = nUI_Unit:createSpecFrame( parent, unit_id, id, options );
	elseif type == "Status"      then frame = nUI_Unit:createStatusFrame( parent, unit_id, id, options );
	elseif type == "Frame"       then frame = nUI_Unit:createFrame( options.name, parent, unit_id, options.clickable ); frame.applyOptions( options );
	else
		DEFAULT_CHAT_FRAME:AddMessage( nUI_L["nUI_Unit: [%s] is not a valid unit frame element type!"]:format( type ), 1, 0.5, 0.5 );
		frame = CreateFrame( "Frame", nil, parent );
	end

	element =
	{
		type    = type,
		id      = id,
		options = options,
		anchor  = anchor,
		frame   = frame,
	};
	
--	nUI_ProfileStop();

	return frame and element or nil;
	
end

-------------------------------------------------------------------------------
-- apply a unit skin to a unit

local function ApplySkin( unit, skin )
	
--	nUI_ProfileStart( ProfileCounter, "ApplySkin" );
	
	skin = skin or unit.skin;
	
	if skin then
		
		skin_elements   = skin.elements;
		update_elements = {};

		unit.skin = skin;
		
		-- first step is to delete any unit frame elements that are no longer desired...
		-- this only happens when a user is editing a unit skin and disables an element
		
		for i,element in ipairs( unit.Elements ) do
			
			if not skin_elements[element.type] then
				
				nUI_Unit:deleteFrame( element.frame );
				nUI:TableRemoveByValue( unit.Elements, element );
				
			elseif element.id and not skin_elements[element.type][element.id] then
				
				nUI_Unit:deleteFrame( element.frame );
				nUI:TableRemoveByValue( unit.Elements, element );
				
			else
				
				if not update_elements[element.type] then 
					update_elements[element.type] = {}; 
				end
				
				update_elements[element.type..(element.id or "")] = element;
				
			end			
		end
		
		-- now span the skin and either create a new unit frame element that 
		-- is needed if it does not exist, or update the element's options if
		-- is does already exist
		
		for type in pairs( skin_elements ) do
			
			local element = skin_elements[type];
			
			-- is this an array of elements (such as buffs or frames?)
			
			if element[1] then
				
				-- create a new unit frame element for each index in the array
				
				for id=1, #element do
					
					update = update_elements[type..id];
				
					-- if the element does not already exist, create it
					
					if not update then
						
						update = CreateElement( unit, type, id, element[id].options, element[id].anchor );
						
						if update then
							table.insert( unit.Elements, update );
						end
						
					-- otherwise, update the information about it and update the element's options
					
					else
						
						update.options = element[id].options;
						update.anchor  = element[id].anchor;
						
						update.frame.applyOptions( update.options );
						
					end
				end
				
			-- otherwise, there's no sub-array to parse, so use this leg
			
			else
				
				update = update_elements[type];
			
				-- if the element does not already exist, create it
				
				if not update then
					
					update = CreateElement( unit, type, nil, element.options, element.anchor );
					
					if update then
						table.insert( unit.Elements, update );
					end
					
				-- otherwise, update the information about it and update the element's options
				
				else
					
					update.options = element.options;
					update.anchor  = element.anchor;
					
					update.frame.applyOptions( update.options );
					
				end
			end
		end
		
		-- now that we have created all of the frame elements, apply the anchors to them

		for i=1, #unit.Elements do			
			if unit.Elements[i].frame.applyAnchor then
				unit.Elements[i].frame.applyAnchor( unit.Elements[i].anchor );
			else
				local parentName = frame:GetParent():GetName() or "unknown frame";
				local frameName = frame:GetName() or ("child #"..i.." of "..parentName);
				print( (unit.Elements[i].frame:GetName() or "unknown frame").." does not have an applyAnchor method" );
			end
		end
		
	end	

--	nUI_ProfileStop();
	
end

-------------------------------------------------------------------------------
-- create a new unit

function nUI_Unit:createUnit( name, parent, options )
	
--	nUI_ProfileStart( ProfileCounter, "createUnit" );
	
	-- create the frame itself if it doesn't already exist
	
	local frame = _G[name] or nUI_Unit:createFrame( name, parent, options.unit_id, false );
	
	frame:SetAttribute( "raidID", options.raid_id );
	
	frame.Elements    = {}; 
	frame.Faders      = {};
	frame.parent      = parent;
	frame.enabled     = true;
	
	-- create a background frame
	
	frame.background = CreateFrame( "Frame", name.."_Background", parent );
	frame.background:SetAllPoints( frame );

	-- prepare a unit frame popup menu for display
--[[
	frame.popup.onUnitPopupUpdate = function()
	
--		nUI_ProfileStart( FrameProfileCounter, "onUnitPopupUpdate" );
		
		local unit_info  = frame.unit_info;
		local unit_id    = frame.popup:GetAttribute( "unit" );
		local unit_popup = nil;
		local raid_id    = nil;
		local unit_name  = nil;
		
		-- select the popup menu to be displayed
	
		if unit_info then
				
			if unit_info.is_self
			or unit_info == nUI_Unit.PlayerInfo
			then
				
				unit_popup = "SELF";
				
			elseif unit_info.is_pet 
			or unit_info == nUI_Unit.PetInfo
			then
				
				unit_popup = "PET";
		
			elseif unit_info.is_player then
				
				if unit_info.in_raid then
					
					unit_popup = "RAID_PLAYER";
					unit_name  = unit_info.unit_name;
					
				elseif unit_info.in_party then
					
					unit_popup = "PARTY";
					
				else
					
					unit_popup = "PLAYER";
					
				end
				
			else
				unit_popup = "RAID_TARGET_ICON";
				unit_name  = RAID_TARGET_ICON;
			end
			
			-- enable it
			
			UnitPopup_ShowMenu( frame.popup, unit_popup, unit_id, unit_name, unit_info.in_raid );
			
		end	

--		nUI_ProfileStop();
	
	end

	-- initialize the popup handler
	
	UIDropDownMenu_Initialize( frame.popup, frame.popup.onUnitPopupUpdate, "MENU" ); -- temp taint
	HideDropDownMenu( 1 );
]]--
	-- there's no point in doing all of the graphics updates on the frame's
	-- elements if the frame itself is hidden (such as a solo unit frame panel
	-- member like "player" trying to update the unit graphics when the party
	-- unit frame panel is the one that's being displayed. So, in order to
	-- reduce drag on the graphics engine and the frame rate, when this unit
	-- frame is hidden, we disabled all of the frame elements. When the frame
	-- is shown, we enabled its graphic elements if the frame itself is enabled
	
	frame:SetScript( "OnShow",
		function()
			
--			nUI_ProfileStart( FrameProfileCounter, "OnShow" );
		
			frame.setEnabled( true );
			
--			nUI_ProfileStop();
	
		end
	);
	
	frame:SetScript( "OnHide",
		function()
			
--			nUI_ProfileStart( FrameProfileCounter, "OnHide" );

			frame.setEnabled( false );

--			nUI_ProfileStop();
	
		end
	);
	
	-- called when the underlying GUID for the unit changes or when the
	-- content of the GUID is updated
	
	frame.newUnitInfo = function( list_unit, unit_info )
		
--		nUI_ProfileStart( FrameProfileCounter, "newUnitInfo" );
		
		frame.unit_info = unit_info;
		
--		nUI_ProfileStop();
	
	end
	
	-- setting enabled to false will prevent the frame from updating when new
	-- unit information is received (saves framerate). Setting enabled true will
	-- call the frame to immediately update if its content has changed since it
	-- was disabled
	
	frame.setEnabled = function( enabled )

--		nUI_ProfileStart( FrameProfileCounter, "setEnabled" );
		
		if enabled ~= frame.enabled then
				
			frame.enabled = enabled;

			if enabled then
				frame.unit_info = nUI_Unit:registerUnitChangeCallback( frame:GetAttribute( "unit" ), frame );
				nUI_Unit:registerRaidSortFrame( frame, frame.options.raid_id );
			end
				
			for i in pairs( frame.Elements ) do
				element = frame.Elements[i];
				element.frame.setEnabled( enabled );
			end

			if not enabled then
				nUI_Unit:unregisterRaidSortFrame( frame );
				nUI_Unit:unregisterUnitChangeCallback( frame:GetAttribute( "unit" ), frame );
			end
				
		end		

--		nUI_ProfileStop();
	
	end
	
	-- used to change the scale of the frame... rather than the Bliz widget frame:SetScale()
	-- this method actually recalculates the size of the frame and uses frame:SetHeight()
	-- and frame:SetWidth() to reflect the actual size of the frame.
	
	frame.applyScale = function( scale )

--		nUI_ProfileStart( FrameProfileCounter, "applyScale" );
		
		anchor    = scale and frame.anchor or nil;
		scale     = scale or frame.scale or 1;
		height    = frame.skin.height * scale * nUI.vScale;
		width     = frame.skin.width * scale * nUI.hScale;
		
		frame.scale  = scale;
		
		if frame.height         ~= height
		or frame.width          ~= width
		then

			frame.height         = height;
			frame.width          = width;
			
			frame:SetHeight( height );
			frame:SetWidth( width );
			
--			frame.popup:ClearAllPoints();
--			frame.popup:SetPoint( "BOTTOMLEFT", frame, "CENTER", 0, 0 );

		end
		
		if anchor then frame.applyAnchor(); end
		
--		nUI_ProfileStop();
	
	end

	-- change the scale of the unit frame and all its children
	
	frame.changeScale = function( scale )
		
--		nUI_ProfileStart( FrameProfileCounter, "changeScale" );
		
		frame.applyScale( scale );
		
		for i in pairs( frame.Elements ) do
			element = frame.Elements[i];
			element.frame.applyScale( scale );
		end
		
--		nUI_ProfileStop();
	
	end

	-- this method allows for multiple unit modules to manage frame fading
	
	frame.applyFrameFader = function( owner, fade_alpha )
	
--		nUI_ProfileStart( FrameProfileCounter, "applyFrameFader" );
		
		alpha         = 1;		
		frame.Faders[owner] = fade_alpha;
		
		for owner in pairs( frame.Faders ) do
			
			if frame.Faders[owner]
			and frame.Faders[owner] < alpha
			then alpha = frame.Faders[owner];
			end
			
		end
		
		if frame.alpha ~= alpha then
			frame.alpah = alpha;
			frame:SetAlpha( alpha );
		end
		
--		nUI_ProfileStop();
	
	end
				
	-- this method applies the anchor point of the frame. As with all else, the
	-- frame's anchor is only moved if the point defined is different than the
	-- point that is already known
	
	frame.applyAnchor = function( anchor )

--		nUI_ProfileStart( FrameProfileCounter, "applyAnchor" );
		
		anchor      = anchor or frame.anchor or {};
		anchor_pt   = anchor.anchor_pt or "CENTER";
		relative_to = anchor.relative_to or frame.parent:GetName() or "nUI_Dashboard";
		relative_pt = anchor.relative_pt or "CENTER";
		xOfs        = (anchor.xOfs or 0) * nUI.hScale;
		yOfs        = (anchor.yOfs or 0) * nUI.vScale;

		frame.anchor = anchor;
		
		if frame.anchor_pt   ~= anchor_pt
		or frame.relative_to ~= relative_to
		or frame.relative_pt ~= relative_pt
		or frame.xOfs        ~= xOfs
		or frame.yOfs        ~= yOfs
		then
			
			frame.anchor_pt   = anchor_pt;
			frame.relative_to = relative_to;
			frame.relative_pt = relative_pt;
			frame.xOfs        = xOfs;
			frame.yOfs        = yOfs;
			
			if not anchor.relative_to then
				DEFAULT_CHAT_FRAME:AddMessage( nUI_L["nUI: Warning.. anchoring %s to %s -- anchor point has a <nil> value."]:format( (frame:GetName() or nUI_L["<unnamed frame>"] ), relative_to ) );
			else
				frame:ClearAllPoints();
				frame:SetPoint( anchor_pt, relative_to:gsub( "$parent", (frame.parent:GetName() or "nUI_Dashboard") ), relative_pt, xOfs, yOfs );
			end	
		end

--		nUI_ProfileStop();
	
	end
	
	-- applies the set of frame options to this frame. Typically called when the frame 
	-- is first created or when the user changes options via config.
	
	frame.applyOptions = function( options )
	
--		nUI_ProfileStart( FrameProfileCounter, "applyOptions" );
		
		name   = options.skinName or nUI_UNITSKIN_SOLOPLAYER;
		skin   = nUI_UnitSkins[name];
		
		if not skin then
			
			DEFAULT_CHAT_FRAME:AddMessage( nUI_L["nUI_Unit: [%s] is not a known unit skin name!"]:format( name ), 1, 0.5, 0.5 );
			
		else
	
			frame.options  = options;	
			frame.skinName = name;
			frame.skin     = skin;
			
			-- set the raid/party id if required
		
			frame.id = options.raid_id or options.party_id;
			
			if frame.id then frame:SetID( frame.id ); end
		
			-- set up frame layering
			
			frame:SetFrameStrata( options.strata or frame.parent:GetFrameStrata() );
			frame:SetFrameLevel( options.level or (frame.parent:GetFrameLevel()+1) );
			frame.background:SetFrameLevel( (options.level or frame:GetFrameLevel())-1 );
			
			-- if there's a border, set it
			
			if options.border then
					
				border_color = options.border.color.border;
				backdrop_color = options.border.color.backdrop;
				
				frame:SetBackdrop( options.border.backdrop );
				frame:SetBackdropBorderColor( border_color.r, border_color.g, border_color.b, border_color.a );
				frame:SetBackdropColor( backdrop_color.r, backdrop_color.g, backdrop_color.b, backdrop_color.a );
		
			else 
				
				frame:SetBackdrop( nil );
				
			end
			
			-- if there's a background, set it
			
			if options.background then
					
				border_color = options.background.color.border;
				backdrop_color = options.background.color.backdrop;
				
				frame.background:SetAlpha( 1 );
				frame.background:SetBackdrop( options.background.backdrop );
				frame.background:SetBackdropBorderColor( border_color.r, border_color.g, border_color.b, border_color.a );
				frame.background:SetBackdropColor( backdrop_color.r, backdrop_color.g, backdrop_color.b, backdrop_color.a );
		
			else 
				
				frame.background:SetAlpha( 0 );
				frame.background:SetBackdrop( nil );
				
			end
	
			-- size and anchor the frame
			
			frame.applyScale( options.scale or frame.scale or 1 );
			
			-- register the frame for raid sorting if applicable
			
			nUI_Unit:registerRaidSortFrame( frame, frame.options.raid_id );
			
		end		
		
--		nUI_ProfileStop();
	
	end
	
	-- apply a skin to the frame, or refresh the current skin
	
	frame.applySkin = function( skinName )

--		nUI_ProfileStart( FrameProfileCounter, "applySkin" );
		
		name   = skinName or frame.skinName or nUI_UNITSKIN_SOLOPLAYER;
		skin   = nUI_UnitSkins[name];
		
		if not skin then
			
			DEFAULT_CHAT_FRAME:AddMessage( nUI_L["nUI_Unit: [%s] is not a known unit skin name!"]:format( name ), 1, 0.5, 0.5 );
			
		else

			ApplySkin( frame, skin );
			
		end

--		nUI_ProfileStop();
	
	end
	
	-- if this frame is using the named skin then refresh it
	
	frame.refreshSkin = function( skinName )
		
--		nUI_ProfileStart( FrameProfileCounter, "refreshSkin" );
		
		if frame.skinName == skinName then frame.applySkin(); end
		
--		nUI_ProfileStop();
	
	end

	-- change the frame's visibility management rules
	
	frame.setVisibility = function( visibility )
	
		if visibility then 
			UnregisterUnitWatch( frame );
			UnregisterStateDriver( frame, "visibility" );
			RegisterStateDriver( frame, "visibility", visibility );
		else
			UnregisterStateDriver( frame, "visibility" );
			RegisterUnitWatch( frame );
		end
	end

	-- change the unit ID associated with the frame -- this is used primarily by the raid group sort engine
		
	frame.cachedSetUnitID = frame.setUnitID;	
	frame.setUnitID = function( unit_id )

		if not InCombatLockdown() and frame:GetAttribute( "unit" ) ~= unit_id then

			--print( frame:GetName().." set unit to ["..(unit_id or "nil").."]" );
				
			nUI_Unit:unregisterUnitChangeCallback( frame:GetAttribute( "unit" ), frame );
						
			frame.cachedSetUnitID( unit_id );
		
			frame.setVisibility( frame.options.visibility );

			frame.unit_info = nUI_Unit:registerUnitChangeCallback( frame:GetAttribute( "unit" ), frame );
			frame.lastID    = unit_id;
			
			for i in pairs( frame.Elements ) do
				element = frame.Elements[i];
				element.frame.setUnitID( unit_id );
			end
		end
	end
		
	-- initiate the frame
	
	frame.unit_info = nUI_Unit:registerUnitChangeCallback( frame:GetAttribute( "unit" ), frame );
	
	frame.applyOptions( options );
	frame.applySkin();
	
	-- register the frame for scaling
	
	nUI:registerScalableFrame( frame );
	
	-- register the unit frame with the game engine
	
	frame.setVisibility( frame.options.visibility );
	
--	nUI_ProfileStop();
	
	return frame;
	
end

-------------------------------------------------------------------------------
-- delete an existing unit

function nUI_Unit:deleteUnit( frame )

--	nUI_ProfileStart( ProfileCounter, "deleteUnit" );
	
	if frame.Elements then
		
		for i in pairs( frame.Elements ) do
			element = frame.Elements[i];
			nUI_Unit:deleteFrame( element.frame );
		end
		
		frame.Elements = {};
		
	end	
	
	UnregisterStateDriver( frame, "visibility" );
	UnregisterUnitWatch( frame );
	
	nUI:unregisterScalableFrame( frame );
	nUI_Unit:unregisterRaidSortFrame( frame );
	nUI_Unit:unregisterUnitChangeCallback( frame:GetAttribute( "unit" ), frame );
	nUI_Unit:deleteUnit( frame );
	
--	nUI_ProfileStop();
end
