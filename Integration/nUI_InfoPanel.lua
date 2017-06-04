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
if not nUI_InfoPanelOptions then nUI_InfoPanelOptions = {}; end
if not nUI_InfoPanels then nUI_InfoPanels = {}; end
if not nUI_Profile then nUI_Profile = {}; end;

local CreateFrame = CreateFrame;
local MouseIsOver = MouseIsOver;

nUI_Profile.nUI_InfoPanel          = {};
nUI_Profile.nUI_InfoPanel.Selector = {};
nUI_Profile.nUI_InfoPanel.Frame    = {};

local ProfileCounter         = nUI_Profile.nUI_InfoPanel;
local SelectorProfileCounter = nUI_Profile.nUI_InfoPanel.Selector;
local FrameProfileCounter    = nUI_Profile.nUI_InfoPanel.Frame;

-------------------------------------------------------------------------------

-- See nUI\Integration\nUI_CombatLog.lua for information on how to integrate
-- a custom plugin into the InfoPanel system

-------------------------------------------------------------------------------
-- method for sorting the info panel options on the selector button. Panels
-- are ordered ascending first by their rotation number, then by their 
-- description and finally by their panel name.

local function SortPanelList( left, right )

--	nUI_ProfileStart( ProfileCounter, "SortPanelList" );
	
	local result;
	
	if left.rotation > right.rotation then
		result = false;
	elseif left.rotation < right.rotation then
		result = true;
	elseif left.desc > right.desc then
		result = false;
	elseif left.desc < right.desc then
		result = true;
	elseif left.name > right.name then
		result = false;
	else
		result = true;
	end
	
--	nUI_ProfileStop();
	
	return result;
	
end

-------------------------------------------------------------------------------

local InfoPanelList  = {};

local background = CreateFrame( "Frame", "nUI_InfoPanelBackground", nUI_Dashboard.Anchor );
local frame      = CreateFrame( "Frame", "nUI_InfoPanelSelector", background, "SecureFrameTemplate" );
frame.button     = CreateFrame( "Button", "$parent_Button", frame, "SecureHandlerClickTemplate" );
frame.text       = frame:CreateFontString( "$parent_Label", "ARTWORK" );

frame.button:RegisterForClicks( "AnyUp" );
frame.button:SetScript( "PreClick", 
	function( self, button, down )
		
		if button == "RightButton"
		and IsAltKeyDown()
		and IsControlKeyDown()
		then
			nUI_KeyBindingFrame.bindAction( frame.button, nUI_L["Info Panel Mode"], "CLICK "..frame.button:GetName()..":LeftButton" );
		end
	end
);

frame.button:SetAttribute( 
	"_onclick",
	[[
		if not IsAltKeyDown() or not IsControlKeyDown() or IsShiftKeyDown() then
				
			if button == "LeftButton" then	
				if CurrentPanel == #PanelList then
					CurrentPanel = 1;
				else
					CurrentPanel = CurrentPanel+1;
				end
			elseif button == "RightButton" then
				if CurrentPanel == 1 then
					CurrentPanel = #PanelList;
				else
					CurrentPanel = CurrentPanel-1;
				end
			end
		
			for i=1,#PanelList do
				local frame = self:GetFrameRef( PanelList[i] );
				
				if i == CurrentPanel then
					frame:Show();
				else
					frame:Hide();
				end
			end
		end
	]]
);

nUI_InfoPanelSelector        = frame;
nUI_InfoPanelSelector.Labels = {};
nUI_InfoPanelSelector.Panels = {};

background:SetAllPoints( frame );
frame.button:SetAllPoints( frame );
frame:SetAttribute( "addchild", frame.button );

frame.button:SetScript( "OnEnter",

	function()

 --		nUI_ProfileStart( SelectorProfileCounter, "OnEnter" );
		
		GameTooltip:SetOwner( frame.button );
		GameTooltip:SetText( frame.desc or nUI_L["Click to change information panels"] );
		if frame.desc then 
			GameTooltip:AddLine( nUI_L["Click to change information panels"] );
		end

		if not InCombatLockdown() then
			
			local key1, key2  = GetBindingKey( "CLICK "..frame.button:GetName()..":LeftButton" );

			if key1 then GameTooltip:AddLine( nUI_L["Key Binding"].." 1: |cFF00FFFF"..GetBindingText( key1, "KEY_" ).."|r", 1, 1, 1 ); end
			if key2 then GameTooltip:AddLine( nUI_L["Key Binding"].." 2: |cFF00FFFF"..GetBindingText( key2, "KEY_" ).."|r", 1, 1, 1 ); end									
			if not key1 and not key2 then GameTooltip:AddLine( nUI_L["No key bindings found"], 1, 1, 1 ); end

			GameTooltip:AddLine( nUI_L["<ctrl-alt-right click> to change bindings"], 0, 1, 1 );
			
		end
		
		GameTooltip:Show();

--		nUI_ProfileStop();
		
	end
);

frame.button:SetScript( "OnLeave", 

	function() 
	
--		nUI_ProfileStart( SelectorProfileCounter, "OnLeave" );		
		GameTooltip:Hide(); 		
--		nUI_ProfileStop();
		
	end 
);

-------------------------------------------------------------------------------

frame.applyScale = function( scale )
	
--	nUI_ProfileStart( SelectorProfileCounter, "applyScale" );
	
	local scale    = scale or frame.scale or 1;
	local options  = frame.options;
	local fontsize = (options and options.label and options.label.fontsize or 12) * nUI.vScale * 1.75;
	
	frame.scale   = scale;
	
	if options then
		
		local width  = options.width * scale * nUI.hScale;
		local height = options.height * scale * nUI.vScale;
		
		if frame.width ~= width
		or frame.height ~= height
		then
			
			frame.width  = width;
			frame.height = height;
			
			frame:SetWidth( width );
			frame:SetHeight( height );
			
		end
	end
	
	if frame.text.fontsize ~= fontsize then
		frame.text.fontsize = fontsize;
		frame.text:SetFont( nUI_L["font1"], fontsize, "OUTLINE" );
	end
	
--	nUI_ProfileStop();
	
end

-------------------------------------------------------------------------------

frame.applyAnchor = function( anchor )
	
--	nUI_ProfileStart( SelectorProfileCounter, "applyAnchor" );
	
	local anchor      = anchor or frame.anchor or {};
	local anchor_pt   = anchor.anchor_pt or "CENTER";
	local relative_to = anchor.relative_to or "nUI_Dashboard";
	local relative_pt = anchor.relative_pt or "CENTER";
	local xOfs        = (anchor.xOfs or 0) * nUI.hScale;
	local yOfs        = (anchor.yOfs or 0) * nUI.vScale;
	
	frame.anchor = anchor;
	
	if frame.xOfs ~= xOfs
	or frame.yOfs ~= yOfs
	or frame.anchor_pt ~= anchor_pt
	or frame.relative_to ~= relative_to
	or frame.relative_pt ~= relative_pt
	then
		
		frame.anchor_pt = anchor_pt;
		frame.relative_to = relative_to;
		frame.relative_pt = relative_pt;
		frame.xOfs        = xOfs;
		frame.yOfs        = yOfs;
		
		frame:SetPoint( anchor_pt, relative_to, relative_pt, xOfs, yOfs );
		
	end

	if frame.options then

		local label = frame.options.label;
		
		if label and label.enabled then
			
			anchor_pt   = label.anchor_pt or "CENTER";
			relative_to = label.relative_to or frame:GetName();
			relative_pt = label.relative_pt or anchor_pt;			
			xOfs        = (label.xOfs or 0) * frame.scale * nUI.hScale;
			yOfs        = (label.yOfs or 0) * frame.scale * nUI.vScale;
			
			if frame.text.xOfs ~= xOfs
			or frame.text.yOfs ~= yOfs
			or frame.text.anchor_pt ~= anchor_pt
			or frame.text.relative_to ~= relative_to
			or frame.text.relative_pt ~= relative_pt
			then
				
				frame.text.anchor_pt   = anchor_pt;
				frame.text.relative_to = relative_to;
				frame.text.relative_pt = relative_pt;
				frame.text.xOfs        = xOfs;
				frame.text.yOfs        = yOfs;
				
				frame.text:SetPoint( anchor_pt, relative_to, relative_pt, xOfs, yOfs );
				
			end			
		end		
	end

--	nUI_ProfileStop();
	
end

-------------------------------------------------------------------------------

frame.applyOptions = function( options )
	
--	nUI_ProfileStart( SelectorProfileCounter, "applyOptions" );
	
	frame.options = options;
	
	if not options or not options.enabled then
		
		frame.enabled = false;
		background:Hide();
		
	else
		
		frame.enabled = true;
		background:Show();
		
		background:SetFrameStrata( options.strata or nUI_Dashboard:GetFrameStrata() );
		background:SetFrameLevel( options.level or nUI_Dashboard:GetFrameLevel()+2 );
		
		if not options.label or not options.label.enabled then
			
			frame.text.enabled = false;
			frame.text.value   = nil;
			frame.text:SetAlpha( 0 );
			frame.text:SetText( "" );
			
		else
			
			frame.text.enabled = true;
			frame.text:SetAlpha( 1 );
			
			local color = options.label.color or {};
			
			frame.text:SetTextColor( color.r or 1, color.g or 0.83, color.b or 0, color.a or 1 );
			
		end
		
		if options.border then
			
			local backdrop_color = options.border.color.backdrop;
			local border_color   = options.border.color.border;
			
			frame:SetBackdrop( options.border.backdrop );
			frame:SetBackdropColor( backdrop_color.r, backdrop_color.g, backdrop_color.b, backdrop_color.a );
			frame:SetBackdropBorderColor( border_color.r, border_color.g, border_color.b, border_color.a );
			
		else
			
			frame:SetBackdrop( nil );
			
		end
		
		if options.background then
			
			local backdrop_color = options.background.color.backdrop;
			local border_color   = options.background.color.border;
			
			frame:SetBackdrop( options.background.backdrop );
			frame:SetBackdropColor( backdrop_color.r, backdrop_color.g, backdrop_color.b, backdrop_color.a );
			frame:SetBackdropBorderColor( border_color.r, border_color.g, border_color.b, border_color.a );
			
		end

		frame.applyScale( options.scale or frame.scale or 1 );
	
	end	

--	nUI_ProfileStop();
	
end

-------------------------------------------------------------------------------

frame.applySkin = function( skin )
	
--	nUI_ProfileStart( SelectorProfileCounter, "applySkin" );
	
	-- we don't allow the skin developer to not include unit panels... if they
	-- don't specify them, we use the default
	
	local skin = skin.InfoPanelSelector or nUI_DefaultConfig.InfoPanelSelector;
	
	if not skin or not skin.options.enabled then
		
		frame.enabled = false;
		background:Hide();
		
	else
		
		local have_selection   = false;
		local rotation         = {};
		local buttonbag_states = nil;
		
		frame.enabled = true;
		background:Show();

		frame.applyOptions( skin.options );
		frame.applyAnchor( skin.anchor );

		-- force the availability of the battlefield minimap panel
		
		nUI_InfoPanels[nUI_INFOPANEL_BMM].enabled = true;
		nUI_InfoPanels[nUI_INFOPANEL_BMM].options.enabled = true;
		
		-- parse the list of available panels.
		
		for panel_name in pairs( nUI_InfoPanels ) do
	
			local panel_config = nUI_InfoPanels[panel_name];
			local panel_info   = nUI_InfoPanelSelector.Panels[panel_name];
			local plugin       = _G[panel_name];
			
			-- make sure the plugin exists
			
			if not plugin then
				
				DEFAULT_CHAT_FRAME:AddMessage( nUI_L["nUI: Cannot initialize the Info Panel plugin [ %s ] -- No global object by that name exists"]:format( panel_name ), 1, 0.5, 0.5 );
				
			-- if it the plugin is diabled, then make sure it's not longer visible
			-- or in the rotation
			
			elseif not panel_config.enabled 
			or not plugin.active
			then
				
				if panel_info then
						
					local pframe  = panel_info.frame;
					local panchor = panel_info.anchor;
					
					if panchor.enabled then
						if plugin.setEnabled then
							if not nUI.SafeCall( plugin.setEnabled, false ) then
								DEFAULT_CHAT_FRAME:AddMessage( "nUI: Could not disable plugin: |cFFFF8080"..panel_name.."|r", 1, 0.83, 0 );
							end
						end
					end
	
					panchor.enabled = false;
					panchor:Hide();
					
					panel_info.enabled = false;
					
				end
				
			else

				if panel_name == nUI_Options.info_panel then
					have_selection = panel_name;
				end
				
				-- create the state button anchor and the content frame for the new panel

				local panchor;
				local pframe;
				
				if not panel_info then 
					
					panchor = CreateFrame( "Frame", panel_name, nUI_InfoPanelSelector, "SecureHandlerStateTemplate" )
					pframe  = CreateFrame( "Frame", panel_name.."Container", panchor, "SecureFrameTemplate" );
					
					panchor:SetAttribute( "nUI_showstate", panel_name );
					
					panchor:SetAttribute( 
						"_onstate-selected",
						[[
							local showstate = self:GetAttribute( "nUI_showstate" );
							
							if newstate and showstate and showstate == newstate then
								self:Show();
							else
								self:Hide();
							end
						]]
					);
					
					panchor.enabled = true;

					panel_info =
					{
						panel_name = panel_name,
						plugin     = plugin,
						config     = panel_config,
						anchor     = panchor,
						frame      = pframe,
					};

					nUI_InfoPanelSelector.Panels[panel_name] = panel_info;				
					
				else

					panel_info.config = panel_config;
					panchor           = panel_info.anchor;
					pframe            = panel_info.frame;
					plugin            = panel_info.plugin;
				
					if not panchor.enabled then
						
						panchor.enabled = true;
						panchor:Show();
						
						if plugin.setEnabled then 
							if not nUI.SafeCall( plugin.setEnabled, true ) then
								DEFAULT_CHAT_FRAME:AddMessage( "nUI: Could not enable plugin: |cFFFF8080"..panel_name.."|r", 1, 0.83, 0 );
							end
						end
					end				
				end

				panel_info.enabled = true;
				
				-- set up the tooltip and selector button labeling and callback notification to the 
				-- underlying info panel addon to let it know when it's been selected and deselected
				
				panchor.plugin = plugin;
				
				pframe:SetFrameStrata( frame:GetFrameStrata() );
				pframe:SetFrameLevel( frame:GetFrameLevel()+1 );
				
				panchor:SetScript( "OnShow",
					function()
						
--						nUI_ProfileStart( FrameProfileCounter, "OnShow" );
						
						nUI_Options.info_panel = panel_name;
						nUI_InfoPanelSelector.text:SetText( panel_config.label );
						nUI_InfoPanelSelector.desc = panel_config.desc;
						
						if GameTooltip:IsOwned( nUI_InfoPanelSelector.button ) then
							GameTooltip:SetText( panel_config.desc or nUI_L["Click to change information panels"] );
						end
						
						if panchor.plugin.setSelected then 
							if not nUI.SafeCall( panchor.plugin.setSelected, true ) then
								DEFAULT_CHAT_FRAME:AddMessage( "nUI: Could not select plugin: |cFFFF8080"..panel_name.."|r", 1, 0.83, 0 );
							end
						else
							DEFAULT_CHAT_FRAME:AddMessage( nUI_L["nUI: cannot select the Info Panel plugin [ %s ] -- it does not have a setSelected() interface method"]:format( panel_name ), 1, 0.5, 0.5 );
						end

--						nUI_ProfileStop();
						
					end
				);
				
				panchor:SetScript( "OnHide",
					function()

--						nUI_ProfileStart( FrameProfileCounter, "OnHide" );
						
						if panchor.plugin.setSelected then 
							if not nUI.SafeCall( panchor.plugin.setSelected, false ) then
								DEFAULT_CHAT_FRAME:AddMessage( "nUI: Could not deselct plugin: |cFFFF8080"..panel_name.."|r", 1, 0.83, 0 );
							end
						else
							DEFAULT_CHAT_FRAME:AddMessage( nUI_L["nUI: cannot select the Info Panel plugin [ %s ] -- it does not have a setSelected() interface method"]:format( panel_name ), 1, 0.5, 0.5 );
						end

--						nUI_ProfileStop();
						
					end
				);
				
				-- add the new panel to the list of panels in the rotation
				
				local item =
				{
					desc     = panel_info.config.desc,
					rotation = panel_info.config.rotation,
					frame    = panel_info.anchor,
					name     = panel_name,
				};

				table.insert( rotation, item );
					
			end
		end
		
		-- create the rotation and select the correct panel
		
		local state_string = nil;
		
		nUI:TableSort( rotation, SortPanelList );

		for item in pairs( rotation ) do		
			local name = rotation[item].name;			
			frame.button:SetAttribute( "nUI_InfoPanel"..item, name );
			frame.button:SetFrameRef( name, rotation[item].frame );
		end
		
		-- lastly, let the info panel sizer deal with sizing and initializing the new frames

		nUI_InfoPanel.applyScale();
		
		-- if we have no selected unit panels (first time loaded) then default to
		-- the solo player unit panel, otherwise, select the last panel the user selected

		local selected   = have_selection or nUI_INFOPANEL_BMM;
		local panel_info = nUI_InfoPanelSelector.Panels[selected];
		
		if not panel_info or not panel_info.enabled then
			selected   = nUI_INFOPANEL_BMM;
			panel_info = nUI_InfoPanelSelector.Panels[selected];
		end
		
		if panel_info then

			for item in pairs( rotation ) do
				
				rotation[item].frame:SetAttribute( "state-selected", selected );
				
				if rotation[item].name == selected then
					frame.button:SetAttribute( "state", item );
				end
			end

			nUI_InfoPanelSelector.text:SetText( panel_info.config.label );
		
			nUI_InfoPanelSelector.desc = panel_info.config.desc;
		
			if panel_info.plugin.setSelected then
				if not nUI.SafeCall( panel_info.plugin.setSelected, true ) then
					DEFAULT_CHAT_FRAME:AddMessage( "nUI: Could not select plugin: |cFFFF8080"..panel_info.panel_name.."|r", 1, 0.83, 0 );
				end;
			end
		
			nUI_Options.info_panel = selected;
		end
		
		frame.button:Execute(
			[[
				local i = 1;
				
				PanelList = newtable();
				
				while true do
					
					local panel_name = self:GetAttribute( "nUI_InfoPanel"..i );
					
					if not panel_name then 
						break;
					end
					
					PanelList[i] = panel_name;
					i = i+1;
					
				end
				
				CurrentPanel = self:GetAttribute( "state" ) or 1;
			]]
		);
	end

--	nUI_ProfileStop();
	
end

-------------------------------------------------------------------------------
-- chat frame event management

local info_background = CreateFrame( "Frame", "nUI_InfoPanel_Background", nUI_Dashboard.Anchor );
local info_frame      = CreateFrame( "Frame", "nUI_InfoPanel", info_background );
nUI.info_frame        = frame;
info_frame.texture    = frame:CreateTexture();

info_background:SetAllPoints( info_frame );
info_frame.texture:SetAllPoints( info_frame );

-------------------------------------------------------------------------------
-- adjust the size of the chat frame according the screen scale

info_frame.applyScale = function( scale )
	
--	nUI_ProfileStart( ProfileCounter, "applyScale" );
	
	local options  = info_frame.options;
	local anchor   = scale and info_frame.anchor or nil;
	local scale    = scale or info_frame.scale or 1;

	info_frame.scale = scale;		
	
	if options then
			
		local width    = options.width  * scale * nUI.hScale;
		local height   = options.height * scale * nUI.vScale;
		
		if info_frame.width  ~= width 
		or info_frame.height ~= height
		then
			
			info_frame.width = width;
			info_frame.height = height;
			
			info_frame:SetWidth( width );
			info_frame:SetHeight( height );
			
		end

		-- size and intialize all of the information panels
		
		local hInset   = options.inset * 2 * scale * nUI.hScale;
		local vInset   = options.inset * 2 * scale * nUI.vScale;
		local pheight = height - vInset;
		local pwidth1 = width - hInset;
		local pwidth2 = pheight * 1.5;
		
		if info_frame.pheight ~= pheight
		or info_frame.pwidth1 ~= pwidth1
		or info_frame.pwdith2 ~= pwidth2
		then

			info_frame.pheight = pheight;
			info_frame.pwidth1 = pwidth1;
			info_frame.pwidth2 = pwidth2;
				
			for panel_name in pairs( nUI_InfoPanelSelector.Panels ) do
				
				local panel   = nUI_InfoPanelSelector.Panels[panel_name];
				local config  = panel.config;
				local pframe  = panel.frame;
				local panchor = panel.anchor;
				local plugin  = panel.plugin;
				
				if panchor.enabled then

					pframe:ClearAllPoints();
					pframe:SetPoint( "TOPLEFT", info_frame, "TOPLEFT", hInset/2, -vInset/2 );
					
					if panchor.pheight ~= pheight
					or panchor.pwidth1 ~= pwidth1
					or panchor.pwidth2 ~= pwidth2
					then
						
						panchor.pheight = pheight;
						panchor.pwidth1 = pwidth1;
						panchor.pwidth2 = pwidth2;
						
						pframe:SetHeight( pheight );
						pframe:SetWidth( config.full_size and pwidth1 or pwidth2 );

						-- if we haven't already, give the panel an opportunity to initialize itself
						
						if not panchor.initialized then
							
							panchor.initialized = true;
							
							if plugin.initPanel then
								if not nUI.SafeCall( plugin.initPanel, pframe, config.options ) then
									DEFAULT_CHAT_FRAME:AddMessage( "nUI: Could not initialize plugin: |cFFFF8080"..panel.panel_name.."|r", 1, 0.83, 0 );
								end
							else
								DEFAULT_CHAT_FRAME:AddMessage( nUI_L["nUI: Cannot initialize the Info Panel plugin [ %s ] -- it does not have an initPanel() interface method"]:format( panel_name ), 1, 0.5, 0.5 );
							end
							
						end
						
						-- then notify the panel of the change in size (or initial size as the case may be)
						
						if plugin.sizeChanged then
							if not nUI.SafeCall( plugin.sizeChanged, scale * nUI.vScale, pheight, config.full_size and pwidth1 or pwidth2 ) then
								DEFAULT_CHAT_FRAME:AddMessage( "nUI: Could not resize plugin: |cFFFF8080"..panel.panel_name.."|r", 1, 0.83, 0 );
							end
						end
					end
				end
			end
		end
		
		if anchor then info_frame.applyAnchor( anchor ); end
		
	end	

--	nUI_ProfileStop();
	
end

-------------------------------------------------------------------------------
-- anchor the chat frame

info_frame.applyAnchor = function( anchor )

--	nUI_ProfileStart( ProfileCounter, "applyAnchor" );
	
	local anchor      = anchor or info_frame.anchor or {};
	local anchor_pt   = anchor.anchor_pt or "CENTER";
	local relative_to = anchor.relative_to or "nUI_Dashboard";
	local relative_pt = anchor.relative_pt or anchor_pt;
	local xOfs        = (anchor.xOfs or 0) * nUI.hScale;
	local yOfs        = (anchor.yOfs or 0) * nUI.vScale;	
	
	info_frame.anchor = anchor;
	
	if info_frame.anchor_pt   ~= anchor_pt
	or info_frame.relative_to ~= relative_to
	or info_frame.relative_pt ~= relative_pt
	or info_frame.xOfs        ~= xOfs
	or info_frame.yOfs        ~= yOfs
	then
		
		info_frame.anchor_pt   = anchor_pt;
		info_frame.relative_to = relative_to;
		info_frame.relative_pt = relative_pt;
		info_frame.xOfs        = xOfs;
		info_frame.yOfs        = yOfs;
		
		info_frame:ClearAllPoints();
		info_frame:SetPoint( anchor_pt, relative_to, relative_pt, xOfs, yOfs );
		
	end

--	nUI_ProfileStop();
	
end

-------------------------------------------------------------------------------
-- apply a set of configuration options to the chat frame

info_frame.applyOptions = function( options )

--	nUI_ProfileStart( ProfileCounter, "applyOptions" );
	
	info_frame.options = options;

	if not options or not options.enabled then
		
		info_frame.enabled = false;
		info_background:Hide();
		
	else
		
		info_frame.enabled = true;
		info_background:Show();
		
		info_background:SetFrameStrata( options.strata or nUI_Dashboard.Anchor:GetFrameStrata() );
		info_background:SetFrameLevel( options.level or nUI_Dashboard.Anchor:GetFrameLevel()+2 );
	
		if options.border then
			
			local backdrop_color = options.border.color.backdrop;
			local border_color   = options.border.color.border;
			
			info_frame:SetBackdrop( options.border.backdrop );
			info_frame:SetBackdropColor( backdrop_color.r, backdrop_color.g, backdrop_color.b, backdrop_color.a );
			info_frame:SetBackdropBorderColor( border_color.r, border_color.g, border_color.b, border_color.a );
			
		else
			
			info_frame:SetBackdrop( nil );
			
		end
		
		if options.background then
			
			local backdrop_color = options.background.color.backdrop;
			local border_color   = options.background.color.border;
			
			info_background:SetBackdrop( options.background.backdrop );
			info_background:SetBackdropColor( backdrop_color.r, backdrop_color.g, backdrop_color.b, backdrop_color.a );
			info_background:SetBackdropBorderColor( border_color.r, border_color.g, border_color.b, border_color.a );
			
		else
			
			info_background:SetBackdrop( nil );
			
		end
		
		info_frame.applyScale( options.scale or info_frame.scale or 1 );
		
	end	

--	nUI_ProfileStop();
	
end

-------------------------------------------------------------------------------

info_frame.applySkin = function( skin )
	
--	nUI_ProfileStart( ProfileCounter, "applySkin" );
	
	-- we don't allow the skin developer to not include the info panels... if they
	-- don't specify them, we use the default
	
	local skin = skin.InfoPanel or nUI_DefaultConfig.InfoPanel;
	
	if not skin or not skin.options.enabled then
		
		info_frame.enabled = false;
		info_background:Hide();
		
	else
		
		info_frame.enabled = true;
		info_background:Show();

		info_frame.applyOptions( skin.options );
		info_frame.applyAnchor( skin.anchor );
		
	end

--	nUI_ProfileStop();
	
end

-------------------------------------------------------------------------------

local function onInfoPanelEvent( who, event, arg1 )
	
--	nUI_ProfileStart( ProfileCounter, "onInfoPanelEvent", event );
	
	if event == "ADDON_LOADED" and arg1 == "nUI" then

		_G["BINDING_HEADER_nUI_MISCKEYS"] = "nUI: "..nUI_L["Miscellaneous Bindings"];		
		_G["BINDING_NAME_CLICK "..frame.button:GetName()..":LeftButton"] = nUI_L["Info Panel Mode"];		
		
		nUI:registerSkinnedFrame( frame );
		nUI:registerScalableFrame( frame );
		
		nUI:registerSkinnedFrame( info_frame );
		nUI:registerScalableFrame( info_frame );
		
	end
	
--	nUI_ProfileStop();
	
end

nUI_InfoPanelSelector:SetScript( "OnEvent", onInfoPanelEvent );
nUI_InfoPanelSelector:RegisterEvent( "ADDON_LOADED" );
