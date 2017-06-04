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
if not nUI.UnitPanels then nUI.UnitPanels = {}; end
if not nUI.UnitFrame then nUI.UnitFrames = {}; end
if not nUI_UnitPanels then nUI_UnitPanels = {}; end
if not nUI_DefaultConfig then nUI_DefaultConfig = {}; end
if not nUI_Profile then nUI_Profile = {}; end;
if not nUI_Options then nUI_Options = {}; end;

local CreateFrame = CreateFrame;

nUI_Profile.nUI_UnitPanel       = {};
nUI_Profile.nUI_UnitPanel.Frame = {};

local ProfileCounter      = nUI_Profile.nUI_UnitPanel;
local FrameProfileCounter = nUI_Profile.nUI_UnitPanel.Frame;

nUI_Options.auto_group = true;

-------------------------------------------------------------------------------
-- method for sorting the unit panel options on the selector button. Panels
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

local UnitPanelList    = {};
local AutoSwitchPanels = {};

local background = CreateFrame( "Frame", "nUI_UnitPanelBackground", nUI_Dashboard.Anchor );
local frame      = CreateFrame( "Frame", "nUI_UnitPanelSelector", background, "SecureFrameTemplate" );
frame.button     = CreateFrame( "Button", "$parent_Button", frame, "SecureHandlerClickTemplate" );
frame.text       = frame:CreateFontString( "$parent_Label", "ARTWORK" );

frame.button:RegisterForClicks( "AnyUp" );
frame.button:SetScript( "PreClick", 
	function( self, button, down )
		
		if button == "RightButton"
		and IsAltKeyDown()
		and IsControlKeyDown()
		then
			nUI_KeyBindingFrame.bindAction( frame.button, nUI_L["Unit Panel Mode"], "CLICK "..frame.button:GetName()..":LeftButton" );
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

nUI_UnitPanelSelector        = frame;
nUI_UnitPanelSelector.Labels = {};

background:SetAllPoints( frame );
frame.button:SetAllPoints( frame );
frame:SetAttribute( "addchild", frame.button );

frame.button:SetScript( "OnEnter",

	function()
		GameTooltip:SetOwner( frame.button );
		GameTooltip:SetText( frame.desc or nUI_L["Click to change unit frame panels"] );
		if frame.desc then 
			GameTooltip:AddLine( nUI_L["Click to change unit frame panels"] );
		end

		if not InCombatLockdown() then
			
			local key1, key2  = GetBindingKey( "CLICK "..frame.button:GetName()..":LeftButton" );

			if key1 then GameTooltip:AddLine( nUI_L["Key Binding"].." 1: |cFF00FFFF"..GetBindingText( key1, "KEY_" ).."|r", 1, 1, 1 ); end
			if key2 then GameTooltip:AddLine( nUI_L["Key Binding"].." 2: |cFF00FFFF"..GetBindingText( key2, "KEY_" ).."|r", 1, 1, 1 ); end									
			if not key1 and not key2 then GameTooltip:AddLine( nUI_L["No key bindings found"], 1, 1, 1 ); end

			GameTooltip:AddLine( nUI_L["<ctrl-alt-right click> to change bindings"], 0, 1, 1 );
			
		end
		
		GameTooltip:Show();
	end
);

frame.button:SetScript( "OnLeave", function() GameTooltip:Hide(); end );

-------------------------------------------------------------------------------

frame.applyScale = function( scale )
	
--	nUI_ProfileStart( ProfileCounter, "applyScale" );
	
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
	
--	nUI_ProfileStart( ProfileCounter, "applyAnchor" );
	
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
	
--	nUI_ProfileStart( ProfileCounter, "applyOptions" );
	
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
	
--	nUI_ProfileStart( ProfileCounter, "applySkin" );
	
	-- we don't allow the skin developer to not include unit panels... if they
	-- don't specify them, we use the default
	
	local skin = skin.UnitPanelSelector or nUI_DefaultConfig.UnitPanelSelector;
	
	if not skin or not skin.options.enabled then
		
		frame.enabled = false;
		background:Hide();
		
	else
		
		AutoSwitchPanels = {};
		
		frame.enabled = true;
		background:Show();

		frame.applyOptions( skin.options );
		frame.applyAnchor( skin.anchor );

		-- spin the list of unit frame panels and create each as required
		
		local have_selection = false;
		
		for panel_name in pairs( nUI_UnitPanels ) do
					
			local panel_config = nUI_UnitPanels[panel_name];
			local panel        = _G[panel_name];
		
			-- if this panel has not been disabled by the player, create it
			
			if not panel_config.enabled then						
				
				if panel then
					
					panel.enabled = false;
					panel:Hide();
					
					for i = #UnitPanelList, 1, -1 do
						if UnitPanelList[i].panel_name == panel_name then
							table.remove( UnitPanelList, i );
							break;
						end
					end
					
					for i = #nUI.UnitPanels, 1, -1 do
						if nUI.UnitPanels[i].panel_name == panel_name then
							table.remove( nUI.UnitPanels, i );
							break;
						end
					end
					
					for i = #UnitPanelSelector.Labels, 1, -1 do
						if nUI_UnitPanelSelector.Labels[i] == panel.label then
							table.remove( nUI_UnitPanelSelector.Labels, i );
							break;
						end
					end
				end

			else
				
				-- if this is a panel the player wants to auto-switch to, then set it up in the table
				
				if panel_config.automode then
					AutoSwitchPanels[panel_config.automode] = panel_name;
				end
				
				-- create a sort list of panels so we can organize the button rotation
				
				local panel_item = 
				{ 
					name     = panel_name, 
					desc     = panel_config.desc,
					rotation = panel_config.rotation,
				};
				
				nUI:TableInsertByValue( UnitPanelList, panel_item );
				
				-- create an anchor frame for the panel
				
				local pframe     =  panel or CreateFrame( "Frame", panel_name, nUI_UnitPanelSelector, "SecureHandlerStateTemplate" );
				local unit_panel =
				{
					name    = panel_name,
					options = panel_options,
					frame   = pframe,
				};
				
				panel_item.frame = pframe;
				
				pframe.Units = {};
				pframe:Hide();
				pframe:SetPoint( "CENTER", nUI_Dashboard, "CENTER", 0, 0 );
				
				nUI:TableInsertByValue( nUI.UnitPanels, unit_panel );

				-- register this panel with the selector
				
				pframe:SetAttribute( "nUI_showstate", panel_name );
				
				pframe:SetAttribute( 
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
								
				panel_config.selected = false;
		
				if panel_name == nUI_Options.unit_panel then
					have_selection = true;
				end
				
				-- script to enable and disabl the attached unit frames when the
				-- panel is shown or hidden... this way when we're using, for example,
				-- the 25 man raid unit panel, the 10 man raid, 15 man raid and the
				-- 40 man raid panel units are not trying to update their unit frames
				-- because they are disabled while the 25 man panel is enabled... this
				-- saves much on graphics engine and CPU load
				
				pframe:SetScript( "OnShow",
				
					function()

--						nUI_ProfileStart( FrameProfileCounter, "OnShow" );
						
						if GameTooltip:IsOwned( nUI_UnitPanelSelector.button ) then
							GameTooltip:SetText( panel_config.desc or nUI_L["Click to change unit frame panels"] );
						end
						
						nUI_Options.unit_panel = panel_name;
						panel_config.selected = true;
				
						nUI_UnitPanelSelector.text:SetText( panel_config.label );
						nUI_UnitPanelSelector.desc = panel_config.desc;
						
						for name in pairs( pframe.Units ) do
							pframe.Units[name].setEnabled( true );
						end

--						nUI_ProfileStop();
						
					end
				);
				
				pframe:SetScript( "OnHide",
				
					function()
						
--						nUI_ProfileStart( FrameProfileCounter, "OnHide" );
						
						panel_config.selected = false;
						
						for name in pairs( pframe.Units ) do
							pframe.Units[name].setEnabled( false );
						end
						
--						nUI_ProfileStop();
						
					end
				);
				
				-- create an ordered list of units to be included in the panel
				
				local loadOrder = {};
				
				if not panel_config.loadOrder then
					for unit_name in pairs( panel_config.units ) do
						table.insert( loadOrder, unit_name );
					end
				else
					for i=1, #panel_config.loadOrder do
						local unit_name = panel_config.loadOrder[i];
						if panel_config.units[unit_name] then
							table.insert( loadOrder, unit_name );
						end
					end
				end
				
				-- spin the list of unit's in the panel and create as required
				
				for i=1, #loadOrder do
				
					local unit_name = loadOrder[i];
					local config    = panel_config.units[unit_name];
					local options   = config.options;
					local anchor    = config.anchor;
				
					-- if the unit is enabled, create it
					
					if options.enabled then

						local unit =
						{
							frame   = nUI_Unit:createUnit( unit_name, unit_panel.frame, options ),
							panel   = panel_name,
							name    = unit_name,
							options = options,
							anchor  = anchor,
						};
						
						unit.frame.setEnabled( false );
						pframe.Units[unit_name] = unit.frame;
						
						nUI:TableInsertByValue( nUI.UnitFrames, unit );
						
					end
				end			
			end
		end
		
		-- spin the list of all of the units we created and anchor them
		
		for i=1,#nUI.UnitFrames do
			nUI.UnitFrames[i].frame.applyAnchor( nUI.UnitFrames[i].anchor );
		end
		
		-- sort the list of panels by selector order then create a state
		-- rotation string for the selector button
		
		nUI:TableSort( UnitPanelList, SortPanelList );
		
		for item in pairs( UnitPanelList ) do		
			local name = UnitPanelList[item].name;			
			frame.button:SetAttribute( "nUI_UnitPanel"..item, name );
			frame.button:SetFrameRef( name, UnitPanelList[item].frame );
		end

		-- if we have no selected unit panels (first time loaded) then default to
		-- the solo player unit panel

		local selected = have_selection and nUI_Options.unit_panel or nUI_UNITPANEL_PLAYER;
		
		
		for item in pairs( UnitPanelList ) do
			
			UnitPanelList[item].frame:SetAttribute( "state-selected", selected );
			
			if UnitPanelList[item].name == selected then
				frame.button:SetAttribute( "state", item );
			end
		end

		nUI_Options.unit_panel = selected;
	
		frame.button:Execute(
			[[
				local i = 1;
				
				PanelList = newtable();
				
				while true do
					
					local panel_name = self:GetAttribute( "nUI_UnitPanel"..i );
					
					if not panel_name then 
						break;
					end
					
					PanelList[i] = panel_name;
					i = i+1;
					
				end
				
				CurrentPanel = self:GetAttribute( "state" ) or 1;
			]]
		);

		nUI_Unit:registerReactionCallback( "player", frame );
		
	end

--	nUI_ProfileStop();
	
end

-------------------------------------------------------------------------------
-- called when the underlying GUID for the unit changes or when the
-- content of the GUID is updated... this is where the auto panel switching
-- is managed

frame.newUnitInfo = function( list_unit, unit_info )

--	nUI_ProfileStart( ProfileCounter, "newUnitInfo" );
	
	if unit_info then
		
		if nUI_Options.auto_group 
		and not InCombatLockdown() then
				
			local panel_mode = "solo";
			
			if unit_info.in_raid then
			
				-- 5.0.1 Change Start - Function name change
				-- local size = GetNumRaidMembers();		
				local size = GetNumGroupMembers();		
				-- 5.0.1 Change End
				
				if size > 25 and AutoSwitchPanels["raid40"] then
					panel_mode = "raid40";
				elseif size > 20 and AutoSwitchPanels["raid25"] then
					panel_mode = "raid25";
				elseif size > 15 and AutoSwitchPanels["raid20"] then
					panel_mode = "raid20";
				elseif size > 10 and AutoSwitchPanels["raid15"] then
					panel_mode = "raid15";
					
				--5.0.4 Change Start
				--elseif size > 5 and AutoSwitchPanels["raid10"] then
				--	panel_mode = "raid10";
					
				elseif size > 5 and AutoSwitchPanels["raid10"] then
					panel_mode = "raid10";

				--5.0.4 Change end

				else
					panel_mode = "party";
				end
				
			elseif unit_info.in_party then
				panel_mode = "party";
			end
			
			if frame.panel_mode ~= panel_mode then
				
				frame.panel_mode = panel_mode;
			
				if AutoSwitchPanels[panel_mode] 
				then
					for i in pairs( nUI.UnitPanels ) do
						local panel = nUI.UnitPanels[i];
						
						if panel.name == AutoSwitchPanels[panel_mode] then
							panel.frame:Show();
						else
							panel.frame:Hide();
						end
					end
				end
			end
		end
	end

--	nUI_ProfileStop();
	
end

-------------------------------------------------------------------------------

local function onUnitPanelEvent( who, event, arg1 )
	
--	nUI_ProfileStart( ProfileCounter, "onUnitPanelEvent", event );
	
	if event == "ADDON_LOADED" and arg1 == "nUI" then

		_G["BINDING_HEADER_nUI_MISCKEYS"] = "nUI: "..nUI_L["Miscellaneous Bindings"];		
		_G["BINDING_NAME_CLICK "..frame.button:GetName()..":LeftButton"] = nUI_L["Unit Panel Mode"];		
		
		nUI:registerSkinnedFrame( frame );
		nUI:registerScalableFrame( frame );

		-- set up a slash command handler for dealing with toggling the auto-switch of unit panels when grouping
		
		local option = nUI_SlashCommands[nUI_SLASHCMD_AUTOGROUP];
		
		nUI_SlashCommands:setHandler( option.command, 
		
			function( cmd, arg1 ) 
			
				nUI_Options.auto_group = not nUI_Options.auto_group;

				DEFAULT_CHAT_FRAME:AddMessage( (option.message):format( nUI_Options.auto_group and nUI_L["|cFF00FF00ENABLED|r"] or nUI_L["|cFFFF0000DISABLED|r"] ), 1, 0.83, 0 );
									
			end
		);		
		
	end
	
--	nUI_ProfileStop();
	
end

nUI_UnitPanelSelector:SetScript( "OnEvent", onUnitPanelEvent );
nUI_UnitPanelSelector:RegisterEvent( "ADDON_LOADED" );
