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
if not nUI_Unit.Drivers then nUI_Unit.Drivers = {}; end
if not nUI_UnitOptions then nUI_UnitOptions = {}; end
if not nUI_DefaultConfig then nUI_DefaultConfig = {}; end
if not ClickCastFrames then	ClickCastFrames = {};end
if not nUI_Profile then nUI_Profile = {}; end;

local CreateFrame        = CreateFrame;
local ToggleDropDownMenu = ToggleDropDownMenu;
local UnitName           = UnitName;

-------------------------------------------------------------------------------

nUI_Profile.nUI_UnitFrame       = {};
nUI_Profile.nUI_UnitFrame.Frame = {};

if not nUI_Unit.Drivers then 
	nUI_Unit.Drivers = CreateFrame( "Frame", "nUI_UnitDrivers", WorldFrame ); 
end

local ProfileCounter      = nUI_Profile.nUI_UnitFrame;
local FrameProfileCounter = nUI_Profile.nUI_UnitFrame.Frame;
local tooltipUnit         = nil;
local activeFrame         = nil;

local ClickableFrames   = {};

nUI_Unit.Drivers.UnitID = frame;

-------------------------------------------------------------------------------
-- variables used in methods within this module are declared here to eliminate
-- the use of dynamic memory and the garbage collector

local owner;
local unit_info;
local role;
local range;
local build;
local fmt;
local color;
local wasEnabled;
local targetName;

function nUI_Unit:showTooltip( unit_id )
		
--	nUI_ProfileStart( FrameProfileCounter, "OnEnter" );

	if unit_id
	and tooltipUnit ~= unit_id
	and (unit_id ~= "mouseover" or not activeFrame)
	and UnitExists( unit_id )
	and (nUI_Options.combat_tooltips or not InCombatLockdown()) 
	then
		
		tooltipUnit = unit_id;
		owner       = activeFrame or UIParent;

		while owner.parent and owner.parent.unit_info do
			owner = owner.parent;
		end
				
		tooltipUnit = unit_id;			
		unit_info   = owner.unit_info or nUI_Unit:getUnitInfo( unit_id );
		role        = unit_info and unit_info.role_info and unit_info.role_info.role or nil;
		range       = unit_info and unit_info.range_info and unit_info.range_info.text or nil;
		build       = unit_info and unit_info.build or nil;
		targetName  = UnitExists( unit_id.."target" ) and UnitName( unit_id.."target" ) or nil;
		
		if unit_spec == "normal" then unit_spec = nil; end
		
		if not GameTooltip:IsShown() then
			GameTooltip:SetOwner( unit_id == "mouseover" and UIParent or owner );
			GameTooltip:SetUnit( unit_id ); 
		end

		if unit_info and unit_info.cur_health and unit_info.max_health > 0 then
			local cur      = unit_info.cur_health;
			local max      = unit_info.max_health;
			local curScale = "";
			local maxScale = "";

			if cur >= 1000000000 then 
				cur = cur / 1000000; 
				curScale = "M"; 
			end 

			if max >= 1000000000 then 
				max = max / 1000000; 
				maxScale = "M"; 
			end 

			GameTooltip:AddLine( ("|cFFFFCF00%s:|r %0d%s/%d%s (%0.1f)"):format( nUI_L["HEALTH"], cur, curScale, max, maxScale, (unit_info.pct_health or 0) * 100 ), unit_info.health_color.r, unit_info.health_color.g, unit_info.health_color.b );
		end
		
		if unit_info and unit_info.cur_power and unit_info.max_power > 0 then
			local cur      = unit_info.cur_power;
			local max      = unit_info.max_power;
			local curScale = "";
			local maxScale = "";

			if cur >= 1000000000 then 
				cur = cur / 1000000; 
				curScale = "M"; 
			end 

			if max >= 1000000000 then 
				max = max / 1000000; 
				maxScale = "M"; 
			end 

			GameTooltip:AddLine( ("|cFFFFCF00%s:|r %d%s/%d%s (%0.1f)"):format( unit_info.power_name or "", cur, curScale, max, maxScale, (unit_info.pct_power or 0) * 100 ), unit_info.power_color.r, unit_info.power_color.g, unit_info.power_color.b );
		end
								
		if targetName then
			GameTooltip:AddLine( nUI_L["Target"]..": |cFF00FFFF"..targetName.."|r" );
		end
		
		if role then

			if unit_info.in_raid then fmt = nUI_L["Raid Role: |cFF00FFFF%s|r"];
			else fmt = nUI_L["Party Role: |cFF00FFFF%s|r"];
			end
			
			GameTooltip:AddLine( fmt:format( role ), 1, 1, 1, 1 );
		end
		
		if build and build.name and build.points then 
			GameTooltip:AddLine( nUI_L["Talent Build: <build name> (<talent points>)"]:format( build.name, build.points ), 1, 0.83, 0 ); 
		end 

		if range then
			color = unit_info.range_info.color;
			GameTooltip:AddLine( range, color.r, color.g, color.b, 1 );
		end
		
		if unit_info == nUI_Unit.PlayerInfo and IsPVPTimerRunning() then
			GameTooltip:AddLine( nUI_L["PvP Time Remaining: <time_left>"]:format( nUI_DurationText( GetPVPTimer() / 1000 ) ), 1, 0.83, 0 );
		end
		
		GameTooltip:Show();
	end
	
--	nUI_ProfileStop();
	
end 

function nUI_Unit:hideTooltip() 
--	nUI_ProfileStart( FrameProfileCounter, "OnLeave" );	
	tooltipUnit = nil;
	GameTooltip:Hide(); 
--	nUI_ProfileStop();			
end 

--hooksecurefunc( GameTooltip, "SetUnit", function( who, unit_id ) nUI_Unit:showTooltip( unit_id ); end );

-------------------------------------------------------------------------------
-- toggle click-casting support on/off for known clickable unit frames

function nUI_Unit:toggleClickCasting()
	
--	nUI_ProfileStart( ProfileCounter, "toggleClickCasting" );
	
	local click_cast = strlower( nUI_UnitOptions.click_cast ) == "no";

	DEFAULT_CHAT_FRAME:AddMessage( 
		nUI_L["nUI: click-casting registration is %s"]:format( (click_cast and nUI_L["|cFF00FF00ENABLED|r"] or nUI_L["|cFFFF0000DISABLED|r"]) ), 
		1, 0.83, 0 
	);

	nUI_UnitOptions.click_cast = click_cast and "yes" or "no";
	
	for i,frame in ipairs( ClickableFrames ) do
		
		frame.click_cast       = click_cast;
		ClickCastFrames[frame] = click_cast or nil;
		
	end

--	nUI_ProfileStop();
	
end

-------------------------------------------------------------------------------
-- create a new base unit frame (not the same as creating a unit itself!)

function nUI_Unit:createFrame( name, parent, unit_id, clickable )
	
--	nUI_ProfileStart( ProfileCounter, "createFrame" );
	
	if not parent then
		
		DEFAULT_CHAT_FRAME:AddMessage( nUI_L["nUI: must pass a valid parent frame to nUI_Unit:createFrame() for unit id [%s (%s)]"]:format( unit_id, name ), 1, 0.5, 0.5 ); 
	
	else
			
		local frame      = CreateFrame( "Button", name, parent, clickable and "SecureUnitButtonTemplate" or nil );		
		frame.background = CreateFrame( "Frame", name.."_Background", parent );		
		frame.parent     = parent;
		frame.click_cast = strlower( nUI_UnitOptions.click_cast or "yes" ) ~= "no";
		frame.clickable  = clickable;
		frame.enabled    = true;
		frame.active     = true;
		frame.unit       = unit_id;
		frame.Labels     = {};
		
		frame.background:SetAllPoints( frame );
	
		-- set attributes for secure frames and downline driver use
		
		frame:SetAttribute( "unit", unit_id );	
	
		-- if the frame's not clickable, then do away with the mouse functionality
		
		if not frame.clickable then
	
			frame:RegisterForClicks();
			frame:EnableMouse( false );
			frame:SetScript( "OnClick", nil );
			frame:SetScript( "OnEnter", nil );
			frame:SetScript( "OnLeave", nil );

			if frame.unit == "mouseover" then			
				frame:SetScript( "OnShow", function() nUI_Unit:showTooltip( frame.unit ); end );	
				frame:SetScript( "OnHide", function() nUI_Unit:hideTooltip(); end );
			end
						
		-- implement unit frame click functionality		

		else
			
			-- add this frame to the list of clickable unit frames
			
			table.insert( ClickableFrames, frame );
			
			-- set up click-casting support if it is enabled
			
			if frame.click_cast then
				ClickCastFrames[frame] = true;
			end
			
			-- create a layer for the unit popup

			frame.popup = CreateFrame( "Frame", "$parent_Popup", frame, "UIDropDownMenuTemplate" );
			frame.popup.class = frame;

			frame.popup:SetFrameLevel( 9 );
			frame.popup.texture = frame.popup:CreateTexture( "$parentTexture" );
			frame.popup.texture:SetAllPoints( frame.popup );	
			frame.popup:Hide();

			-- enable click targeting and right-click menu
	
			frame:SetAttribute( "type1", "target" );
			frame:SetAttribute( "type2", "togglemenu" );
	
			frame:EnableMouse( true );
			frame:RegisterForClicks( "AnyUp" );
	
			frame:SetAttribute( "togglemenu", 
				function()
					ToggleDropDownMenu( 1, nil, popup, frame, frame:GetWidth()/2, frame:GetHeight()/2 );
				end		
			);
	
			-- enable mouseover tooltips
			
			frame:SetScript( "OnEnter", function() activeFrame = frame; nUI_Unit:showTooltip( frame:GetAttribute( "unit" ) ); end );	
			frame:SetScript( "OnLeave", function() activeFrame = nil; nUI_Unit:hideTooltip(); end );
			
		end
		
		-- generic "I've got new data" method

		frame.newUnitInfo = function( unit_id, unit_info )

		--			nUI_ProfileStart( FrameProfileCounter, "newUnitInfo" );

			if not unit_id then 				
		--				DEFAULT_CHAT_FRAME:AddMessage( frame:GetName().." called with new unit info and a <nil> unit id" );				
			elseif UnitIsUnit( unit_id, frame:GetAttribute( "unit" ) ) then	
				frame.unit_info = unit_info;				
			end

		--			nUI_ProfileStop();
			
		end
				
		-- method for sizing and anchoring text labels
		
		frame.configText = function( text, config, scale )
	
--			nUI_ProfileStart( FrameProfileCounter, "configText" );

			local hScale      = (scale or frame.scale or 1) * nUI.hScale;
			local vScale      = (scale or frame.scale or 1) * nUI.vScale;
			local font_size   = (config and config.fontsize or 12) * vScale * 1.75;
			local justifyH    = config and config.justifyH or "CENTER";
			local justifyV    = config and config.justifyV or "MIDDLE";
			local r           = config and config.color and config.color.r or 1;
			local g           = config and config.color and config.color.g or 1;
			local b           = config and config.color and config.color.b or 1;
			local a           = config and config.color and config.color.a or 1;			

			frame.Labels[text] = 
			{
				config = config,
				hScale = hScale,
				vScale = vScale,
			};
			
			-- set the text font size
						
			if text.font_size ~= font_size
			then
				
				-- first time here?
				
				if not text.font_size then 
					text.active  = true;
				end
		
				text.font_size = font_size;
				text:SetFont( nUI_L["font1"], font_size, "OUTLINE" );
	
			end

			-- show or hide the text based on whether or not there is a config for it
			
			text.enabled = config and config.enabled or false;
			
			if not config and text.active then

				text.active = false;
				text.value  = nil;				
				text:SetAlpha( 0 );
				text:SetText( "" );				
				
			elseif config then

				text.active = true;
				text:SetAlpha( 1 );
				
			end
			
			-- set text justification
			
			if text.justifyH ~= justifyH then
				text.justifyH = justifyH;
				text:SetJustifyH( justifyH );
			end
			
			if text.justigyV ~= justifyV then
				text.justifyV = justifyV;
				text:SetJustifyV( justifyV );
			end
			
			-- set text color
			
			if text.r ~= r
			or text.g ~= g
			or text.b ~= b
			or text.a ~= a
			then
				
				text.r = r;
				text.g = g;
				text.b = b;
				text.a = a;
				
				text:SetTextColor( r, g, b, a );
				
			end
			
			-- if the text has a fixed value then set it
			
			if config and config.label and text.value ~= config.label then
				text.value = config.label;
				text:SetText( config.label );
			end
			
--			nUI_ProfileStop();
			
		end
		
		-- used to change the scale of the frame... rather than the Bliz widget frame:SetScale()
		-- this method actually recalculates the size of the frame and uses frame:SetHeight()
		-- and frame:SetWidth() to reflect the actual size of the frame. Is also recreates
		-- the font to present clear, sharp, readable text versus the blurred text you get
		-- as a result of frame:SetScale() or text:SetTextHeight()
		
		frame.applyScale = function( scale )
			
--			nUI_ProfileStart( FrameProfileCounter, "applyScale" );

			local anchor = scale and frame.anchor or nil;
			local scale  = scale or frame.scale or 1;			
			local hScale = scale * nUI.hScale;
			local vScale = scale * nUI.vScale;
			
			frame.scale  = scale;
			frame.hScale = hScale;
			frame.vScale = vScale;
			
			if frame.options then
					
				local hSize  = frame.options.size and (frame.options.size * hScale) or nil;
				local vSize  = frame.options.size and (frame.options.size * vScale) or nil;
				local width  = frame.options.width and (frame.options.width * hScale) or nil;
				local height = frame.options.height and (frame.options.height * vScale) or nil;
				local hInset = (frame.options.inset or 0) * hScale;
				local vInset = (frame.options.inset or 0) * vScale;
				
				if frame.vSize  ~= hSize
				or frame.hSize  ~= vSize
				or frame.height ~= height
				or frame.width  ~= width
				or frame.hInset ~= hInset
				or frame.vInset ~= vInset
				then
					
					frame.height = height;
					frame.width  = width;
					frame.hSize  = hSize;
					frame.vSize  = vSize;
					frame.hInset = hInset;
					frame.vInset = vInset;
					
					frame:SetHeight( vSize or height );
					frame:SetWidth( hSize or width );
					
				end
				
				if anchor then frame.applyAnchor(); end
				
			end

--			nUI_ProfileStop();
			
		end
	
		-- this method applies the anchor point of the frame. As with all else, the
		-- frame's anchor is only moved if the point defined is different than the
		-- point that is already known
		
		frame.applyAnchor = function( anchor )
		
--			nUI_ProfileStart( FrameProfileCounter, "applyAnchor" );

			local anchor      = anchor or frame.anchor or {};
			local anchor_pt   = anchor.anchor_pt or "CENTER";
			local relative_to = anchor.relative_to or frame.parent:GetName();
			local relative_pt = anchor.relative_pt or anchor_pt;
			local xOfs        = (anchor.xOfs or 0) * (frame.hScale or 1);
			local yOfs        = (anchor.yOfs or 0) * (frame.vScale or 1);
	
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
				
				frame:ClearAllPoints();
				frame:SetPoint( anchor_pt, relative_to:gsub( "$parent", frame.parent:GetName() ), relative_pt, xOfs, yOfs );
				
			end
			
			-- and anchor the text

			for text in pairs( frame.Labels ) do

				local config      = frame.Labels[text].config;
				local hScale      = frame.Labels[text].hScale;				
				local vScale      = frame.Labels[text].vScale;				
				
				anchor_pt   = (config and config.anchor_pt or "CENTER");
				relative_to = (config and config.relative_to or frame:GetName());
				relative_pt = (config and config.relative_pt or anchor_pt);
				xOfs        = (config and config.xOfs or 0) * hScale;
				yOfs        = (config and config.yOfs or 0) * vScale;
		
				if text.hScale      ~= hScale
				or text.vScale      ~= vScale
				or text.xOfs        ~= xOfs
				or text.yOfs        ~= yOfs
				or text.anchor_pt   ~= anchor_pt
				or text.relative_to ~= relative_to
				or text.relative_pt ~= relative_pt
				then
					
					text.hScale      = hScale;
					text.vScale      = vScale;
					text.xOfs        = xOfs;
					text.yOfs        = yOfs;
					text.anchor_pt   = (config and config.anchor_pt or "CENTER");
					text.relative_to = (config and config.relative_to or frame:GetName());
					text.relative_pt = (config and config.relative_pt or "CENTER");
	
					text:ClearAllPoints();
					text:SetPoint( anchor_pt, relative_to:gsub( "$parent", frame.parent:GetName() ), relative_pt, xOfs, yOfs );
					
				end
			end
			
--			nUI_ProfileStop();
			
		end
		
		-- toggles a frame on or off based on the passed state and whether or not
		-- the frame has an options set and, if it does, is or is not enabled there
		-- returns true if the frame is enabled after the call, false if not
		
		frame.setEnabled = function( enabled )

--			nUI_ProfileStart( FrameProfileCounter, "setEnabled" );

			if frame.options and not frame.options.enabled then
				frame.enabled = false;
			else
				frame.enabled = enabled;
			end
			
--			nUI_ProfileStop();
			
		end
		
		-- this method is used by the raid group sorter to rearrange the raid units when the
		-- roster changes. In the event that the player is in combat when the request occurs
		-- then the request is cached until they are out of combat
		
		frame.setUnitID = function( unit_id )
		
			if not InCombatLockdown() and frame:GetAttribute( "unit" ) ~= unit_id then
				
				unit_info  = nUI_Unit:getUnitInfo( unit_id );		
				wasEnabled = frame.enabled;
			
				frame.setEnabled( false );					
				frame.unit = unit_id;
				frame:SetAttribute( "unit", unit_id );
				frame.newUnitInfo( unit_id, unit_info );
				frame.setEnabled( wasEnabled );
				
				if frame.popup then frame.popup:SetAttribute( "unit", unit_id ); end
				
			end
		end
		
		-- applies the set of frame options to this frame. Typically called when the frame 
		-- is first created or when the user changes options via config.
		
		frame.applyOptions = function( options )
			
--			nUI_ProfileStart( FrameProfileCounter, "applyOptions" );

			frame.options = options;
			
			-- set up frame layering
			
			frame:SetFrameStrata( options.strata or frame.parent:GetFrameStrata() );
			frame:SetFrameLevel( frame.parent:GetFrameLevel() + (options.level or 1) );
			frame.background:SetFrameLevel( frame:GetFrameLevel() - 1 );

			-- set a party or raid id if needed
			
			frame.id = (options.raid_id or options.party_id) or parent.id or nil;
			
			-- if there's a frame border, set it (frame border hides when the frame hides
		
			if options.border then
					
				local border_color = options.border.color.border;
				local backdrop_color = options.border.color.backdrop;
				
				frame:SetBackdrop( options.border.backdrop );
				frame:SetBackdropBorderColor( border_color.r, border_color.g, border_color.b, border_color.a );
				frame:SetBackdropColor( backdrop_color.r, backdrop_color.g, backdrop_color.b, backdrop_color.a );
		
			else 
				
				frame:SetBackdrop( nil );
				
			end
		
			-- if there's a frame background, set it (background does not hide when the frame hides
		
			if options.background then
					
				local border_color = options.background.color.border;
				local backdrop_color = options.background.color.backdrop;
				
				frame.background:SetBackdrop( options.border.backdrop );
				frame.background:SetBackdropBorderColor( border_color.r, border_color.g, border_color.b, border_color.a );
				frame.background:SetBackdropColor( backdrop_color.r, backdrop_color.g, backdrop_color.b, backdrop_color.a );
		
			else 
				
				frame.background:SetBackdrop( nil );
				
			end

			-- size and anchor the frame
			
			frame.applyScale( parent.scale or 1 );

			-- set frame's active state
			
			frame.setEnabled( options.enabled );
			
			if frame.enabled and not frame:IsShown() then frame:Show();
			elseif not frame.enabled and frame:IsShown() then frame:Hide();
			end			
			
--			nUI_ProfileStop();
	
		end
		
		-- register the frame for scaling
		
		nUI:registerScalableFrame( frame );
		
--		nUI_ProfileStop();
		
		return frame;
		
	end	
	
--	nUI_ProfileStop();
	
end

-------------------------------------------------------------------------------

function nUI_Unit:deleteFrame( frame )

--	nUI_ProfileStart( ProfileCounter, "deleteFrame" );

	nUI:unregisterScaleableFrame( frame );

	-- disable the frame (makes sure that chilren can clean up too)
	
	frame.setEnabled( false );
	
	-- if this frame is registered for click-casting, unregister it
	
	if frame.click_cast then
		ClickCastFrames[frame] = nil;
	end
	
	-- if this is a clickable frame, then unregister its state headers

	frame:SetAttribute( "unit", ATTRIBUTE_NOOP );
	
	if frame.clickable then

		nUI:TableRemoveByValue( ClickableFrames, frame );
			
		frame:SetAttribute( "*type1", ATTRIBUTE_NOOP );
		frame:SetAttribute( "type2",  ATTRIBUTE_NOOP );
		
		frame:RegisterForClicks();
		frame:EnableMouse( false );
	
		frame:SetScript( "OnEnter", nil );
		frame:SetScript( "OnLeave", nil );
		
		frame.menu = nil;

	end
	
	-- hide the frame
	
	frame:SetParent( nil );	
	frame:ClearAllPoints();
	frame:Hide();	
	
--	nUI_ProfileStop();
	
end
