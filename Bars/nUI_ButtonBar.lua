﻿--[[---------------------------------------------------------------------------

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
if not nUI_Profile then nUI_Profile = {}; end;
if not nUI_Options then nUI_Options = {}; end;

local CreateFrame         = CreateFrame;
local GetBindingKey       = GetBindingKey;
local RegisterStateDriver = RegisterStateDriver;

nUI_Profile.nUI_ButtonBar = {};
nUI_ButtonMap             = {};
nUI_ButtonTypeMap         = {};

local ProfileCounter = nUI_Profile.nUI_ButtonBar;

nUI_Options.barCooldowns   = true;
nUI_Options.barDurations   = true;
nUI_Options.barMacroNames  = true;
nUI_Options.barStackCounts = true;
nUI_Options.barKeyBindings = true;
nUI_Options.barDimming     = true;
nUI_Options.barMouseover   = false;
nUI_Options.dimmingAlpha   = 0.3;

-------------------------------------------------------------------------------
-- unregister one of Blizz's action buttons

local function ClearButtonHandlers( button )
--[[
    if button then
        
	    button:UnregisterEvent("PLAYER_ENTERING_WORLD");
	    button:UnregisterEvent("ACTIONBAR_SHOWGRID");
	    button:UnregisterEvent("ACTIONBAR_HIDEGRID");
	    button:UnregisterEvent("ACTIONBAR_PAGE_CHANGED");
	    button:UnregisterEvent("ACTIONBAR_SLOT_CHANGED");
	    button:UnregisterEvent("UPDATE_BINDINGS");
	    button:UnregisterEvent("UPDATE_SHAPESHIFT_FORM");
	    button:UnregisterEvent("ACTIONBAR_UPDATE_STATE");
	    button:UnregisterEvent("ACTIONBAR_UPDATE_USABLE");
	    button:UnregisterEvent("ACTIONBAR_UPDATE_COOLDOWN");
	    button:UnregisterEvent("UPDATE_INVENTORY_ALERTS");
	    button:UnregisterEvent("PLAYER_TARGET_CHANGED");
	    button:UnregisterEvent("TRADE_SKILL_SHOW");
	    button:UnregisterEvent("TRADE_SKILL_CLOSE");
	    button:UnregisterEvent("PLAYER_ENTER_COMBAT");
	    button:UnregisterEvent("PLAYER_LEAVE_COMBAT");
	    button:UnregisterEvent("START_AUTOREPEAT_SPELL");
	    button:UnregisterEvent("STOP_AUTOREPEAT_SPELL");
	    button:UnregisterEvent("UNIT_ENTERED_VEHICLE");
	    button:UnregisterEvent("UNIT_EXITED_VEHICLE");
	    button:UnregisterEvent("COMPANION_UPDATE");
	    button:UnregisterEvent("UNIT_INVENTORY_CHANGED");
	    button:UnregisterEvent("LEARNED_SPELL_IN_TAB");
    	
	    button:SetScript( "OnEvent", nil );
	    button:SetScript( "OnUpdate", nil );
	    button:SetScript( "OnEnter", nil );
	    button:SetScript( "OnLeave", nil );
	    button:SetScript( "OnDragStart", nil );
	    button:SetScript( "OnReceiveDrag", nil );
	    button:SetScript( "OnClick", nil );
	    button:SetScript( "PostClick", nil );
	    button:SetScript( "OnAttributeChanged", nil );
    end	
]]--    
end

-------------------------------------------------------------------------------
-- button bar event management

nUI_ButtonBars       = CreateFrame( "Frame", "nUI_ButtonBars", WorldFrame );
nUI_ButtonBars.Bars  = {};

local mouseoverTimer = 1 / nUI_DEFAULT_FRAME_RATE;

local function onButtonBarEvent( who, event, arg1 )
		
--	nUI_ProfileStart( ProfileCounter, "onButtonBarEvent", event );
	
	-- reset the button bar key bindings to Bliz's action bars on log out so users do
	-- not lose their key bindings if they disable or stop using nUI
	
	if event == "PLAYER_LOGOUT" then
	
		nUI_ButtonBars:UnregisterEvent( "UPDATE_BINDINGS" );
		
		nUI.logout = true;
		
		for i in pairs( nUI_ButtonBars.Bars ) do
			
			local bar = nUI_ButtonBars.Bars[i];

			for row in pairs( bar.Buttons ) do
				
				for col in pairs( bar.Buttons[row] ) do
					
					local button      = bar.Buttons[row][col];
					local overlay     = nUI_ButtonMap[button];
							
					if overlay.bindingType then

						local btnName     = button:GetName();
						local actionName  = overlay.bindingType..(overlay.actionID or "");
						local key1, key2  = GetBindingKey( "CLICK "..btnName..":LeftButton" );
						
						if key1 then 
							SetBinding( key1, actionName );
						end
						if key2 then 
							SetBinding( key2, actionName );
						end
					end
				end
			end			
		end

		SaveBindings( GetCurrentBindingSet() );
				
		nUI.logout = false;
		
	-- set up the key bindings
	
	elseif event == "VARIABLES_LOADED" 
	then

		for i in pairs( nUI_ButtonBars.Bars ) do
			
			local bar = nUI_ButtonBars.Bars[i];

			for row in pairs( bar.Buttons ) do
				
				for col in pairs( bar.Buttons[row] ) do
					
					local button      = bar.Buttons[row][col];
					local overlay     = nUI_ButtonMap[button];
							
					if overlay.bindingType then

						local btnName     = button:GetName();
						local actionName  = overlay.bindingType..(overlay.actionID or "");
						local newBinding  = false;
						
						if actionName ~= overlay.bindingType then
						    nUI_ButtonTypeMap[actionName] = button;
						end
												
						-- if nUI is already key bound, then use those bindings
						
						local key1, key2  = GetBindingKey( actionName );
						
						-- otherwise, see if the Blizz bar is bound and use those bindings
						
					    -- set the bindings we have
						
					    if key1 then 
						    SetBinding( key1, "CLICK "..btnName..":LeftButton" );
					    end
					    if key2 then 
						    SetBinding( key2, "CLICK "..btnName..":LeftButton" );
					    end

					    button:SetScript( "OnEnter",
						    function()
								
--								nUI_ProfileStart( ProfileCounter, "OnEnter" );
	
							    if nUI_Options.combat_tooltips or not InCombatLockdown() then
									
								    local key1, key2  = GetBindingKey( "CLICK "..button:GetName()..":LeftButton" );
	
								    ActionButton_SetTooltip( button );
									
								    if key1 then GameTooltip:AddLine( nUI_L["Key Binding"].." 1: |cFF00FFFF"..GetBindingText( key1, "KEY_" ).."|r", 1, 1, 1 ); end
								    if key2 then GameTooltip:AddLine( nUI_L["Key Binding"].." 2: |cFF00FFFF"..GetBindingText( key2, "KEY_" ).."|r", 1, 1, 1 ); end									
								    if not key1 and not key2 then GameTooltip:AddLine( nUI_L["No key bindings found"], 1, 1, 1 ); end

								    GameTooltip:AddLine( nUI_L["<ctrl-alt-right click> to change bindings"], 0, 1, 1 );
								    GameTooltip:Show();
									
							    end
								
--  								nUI_ProfileStop();
								
						    end
					    );
					end
				end
			end			
		end

		local bindingSet = GetCurrentBindingSet() or 1;
		
		if( bindingSet == 1 or bindingSet == 2 )
		then
			SaveBindings( bindingSet );
		end
		
	-- intialize the button bars
	
	elseif event == "ADDON_LOADED" and arg1 == "nUI" then
		
		nUI:patchConfig();
		nUI:setScale();
		
		-- set up the button bar options
		
		if not nUI_ButtonBarOptions then nUI_ButtonBarOptions = {}; end

		for name in pairs( nUI_DefaultConfig.ButtonBars ) do
				
			nUI_ButtonBars:configBar( name, use_default );
			
		end
		
		-- if we already have bars defined, then put them away before we build a new set
		
		for i in pairs( nUI_ButtonBars.Bars ) do
			
			local bar = nUI_ButtonBars.Bars[i];
			
			bar:UnregisterAllEvents();
			bar:Hide();
			bar:SetParent( nil );
			
			for j in pairs( bar.Buttons ) do
				bar.Buttons[j]:UnregisterAllEvents();
			end
		end
		
		-- create the button bars that are defined
		
		nUI_ButtonBars.Bars = {};
		
		for i in pairs( nUI_ButtonBarOptions ) do
			
			nUI_ButtonBars.Bars[i] = nUI_ButtonBars:createBar( i, nUI_ButtonBarOptions[i] );
					
		end

		-- set up the action bar state driver

		nUI_ActionBar = nUI_ButtonBars.Bars["nUI_ActionBar"];

		nUI_ActionBar:SetAttribute( "actionpage", 1 );
		
		nUI_ActionBar:Execute(
			[[
				ChildList     = newtable( self:GetChildren() );
				ActionButtons = newtable();
				actionType    = self:GetAttribute( "nUI_ActionType" );
				
				local j = 1;
				
				for i, button in ipairs( ChildList ) do
					if not button:GetAttribute( "nUI_ActionButtonOverlay" ) then
						ActionButtons[j] = button;
						j = j+1;
					end
				end
			]]
		);

        nUI_ActionBar:SetAttribute( 
			"_onstate-page", 
			[[
			
				self:SetAttribute( "actionpage", tonumber( newstate ) );
				
				for i, button in ipairs( ActionButtons ) do
					if not button:GetAttribute( "nUI_ActionButtonOverlay" ) then
						button:SetAttribute( "touch", nil )					
					end
				end							
			]]
		);        

        nUI_ActionBar:SetAttribute( 
			"_onshow", 
			[[
				for i, button in ipairs( ActionButtons ) do
					if not button:GetAttribute( "nUI_ActionButtonOverlay" ) then
						button:SetAttribute( "touch", nil )
					end				
				end			
			]]
		);        
        
        if nUI_ActionBar.registered then 
			UnregisterStateDriver( nUI_ActionBar, "page" );
		end
		
		if nUI_Options.boomkinBar then
			RegisterStateDriver(
				nUI_ActionBar, "page", string.format(
					"[vehicleui][possessbar] %d; [vehicleui] %d; [overridebar] %d; [shapeshift] %d; " ..
					"[bar:2] 2; [bar:3] 3; [bar:4] 4; [bar:5] 5; [bar:6] 6; " ..
					"[bonusbar:1] 7; [bonusbar:2] 8; [bonusbar:3] 9;   [bonusbar:4] 10; [bonusbar:5] 11; 1",
					GetVehicleBarIndex(), GetVehicleBarIndex(), GetOverrideBarIndex(), GetTempShapeshiftBarIndex()
				)
			);
		else
			RegisterStateDriver(
				nUI_ActionBar, "page", string.format(
					"[vehicleui][possessbar] %d; [vehicleui] %d; [overridebar] %d; [shapeshift] %d; " ..
					"[bar:2] 2; [bar:3] 3; [bar:4] 4; [bar:5] 5; [bar:6] 6; " ..
					"[bonusbar:1] 7; [bonusbar:2] 8; [bonusbar:3] 9; [bonusbar:4] 1; [bonusbar:5] 11; 1",
					GetVehicleBarIndex(), GetVehicleBarIndex(), GetOverrideBarIndex(), GetTempShapeshiftBarIndex()
				)
			);
		end

		OverrideActionBarLeaveFrameLeaveButton:SetParent( nUI_ActionBar );
		OverrideActionBarLeaveFrameLeaveButton:SetAllPoints( nUI_ActionBar_Button12 );
		RegisterStateDriver( OverrideActionBarLeaveFrameLeaveButton, "visibility", "[vehicleui][target=vehicle, exists] show; hide" );		
		nUI_Movers:lockFrame( OverrideActionBarLeaveFrameLeaveButton, true, nil );

		-- 5.0.1 Change End
	
		nUI_ActionBar.registered = true;
		
		-- apply the user action bar preferences to the bars
		
		for i in pairs( nUI_ButtonBars.Bars ) do		
			nUI_ButtonBars:setUserBarOptions( nUI_ButtonBars.Bars[i] );
		end
		
		-- set up a slash command handler for dealing with setting the display of cooldowns on the action bars
		
		local master = nUI_SlashCommands[nUI_SLASHCMD_BAR];
		local option = master.sub_menu[nUI_SLASHCMD_BAR_COOLDOWN];
		
		nUI_SlashCommands:setSubHandler( master.command, option.command,
			
			function( msg )
				
				nUI_Options.barCooldowns = not nUI_Options.barCooldowns;
				
				DEFAULT_CHAT_FRAME:AddMessage( (option.message):format( nUI_Options.barCooldowns and nUI_L["|cFF00FF00ENABLED|r"] or nUI_L["|cFFFF0000DISABLED|r"] ), 1, 0.83, 0 );
				
				for i in pairs( nUI_ButtonBars.Bars ) do		
					nUI_ButtonBars:setUserBarOptions( nUI_ButtonBars.Bars[i] );
				end
			end
		);
		
		-- set up a slash command handler for dealing with setting the display of cooldowns on the action bars
		
		local master = nUI_SlashCommands[nUI_SLASHCMD_BAR];
		local option = master.sub_menu[nUI_SLASHCMD_BAR_BOOMKIN];
		
		nUI_SlashCommands:setSubHandler( master.command, option.command,
			
			function( msg )
				
				if not InCombatLockdown() then
				
					nUI_Options.boomkinBar = nUI_Options.boomkinBar ~= true and true or false;

					if nUI_Options.boomkinBar then
						RegisterStateDriver(
							nUI_ActionBar, "page", string.format(
								"[vehicleui] %d; [overridebar] %d; [shapeshift] %d; [bar:2] 2; [bar:3] 3; [bar:4] 4; [bar:5] 5; [bar:6] 6; [bonusbar:1] 7; [bonusbar:2] 8; [bonusbar:3] 9; [bonusbar:4] 10; [bonusbar:5] 11; 1",
								GetVehicleBarIndex(), GetOverrideBarIndex(), GetTempShapeshiftBarIndex()
							) 
						);
					else
						RegisterStateDriver(
							nUI_ActionBar, "page", string.format(
								"[vehicleui] %d; [overridebar] %d; [shapeshift] %d; [bar:2] 2; [bar:3] 3; [bar:4] 4; [bar:5] 5; [bar:6] 6; [bonusbar:1] 7; [bonusbar:2] 8; [bonusbar:3] 9; [bonusbar:4] 1; [bonusbar:5] 11; 1",
								GetVehicleBarIndex(), GetOverrideBarIndex(), GetTempShapeshiftBarIndex()
							) 
						);
					end

					DEFAULT_CHAT_FRAME:AddMessage( (option.message):format( nUI_Options.boomkinBar and nUI_L["|cFF00FF00ENABLED|r"] or nUI_L["|cFFFF0000DISABLED|r"] ), 1, 0.83, 0 );

				end
			end
		);

		-- set up a slash command handler for dealing with setting the display of spell durations on the action bars
		
		local master = nUI_SlashCommands[nUI_SLASHCMD_BAR];
		local option = master.sub_menu[nUI_SLASHCMD_BAR_DURATION];
		
		nUI_SlashCommands:setSubHandler( master.command, option.command,
			
			function( msg )
				
				nUI_Options.barDurations = not nUI_Options.barDurations;
				
				DEFAULT_CHAT_FRAME:AddMessage( (option.message):format( nUI_Options.barDurations and nUI_L["|cFF00FF00ENABLED|r"] or nUI_L["|cFFFF0000DISABLED|r"] ), 1, 0.83, 0 );
				
				for i in pairs( nUI_ButtonBars.Bars ) do		
					nUI_ButtonBars:setUserBarOptions( nUI_ButtonBars.Bars[i] );
				end
			end
		);
		
		-- set up a slash command handler for dealing with setting the display of macro names on the action bars
		
		local master = nUI_SlashCommands[nUI_SLASHCMD_BAR];
		local option = master.sub_menu[nUI_SLASHCMD_BAR_MACRO];
		
		nUI_SlashCommands:setSubHandler( master.command, option.command,
			
			function( msg )
				
				nUI_Options.barMacroNames = not nUI_Options.barMacroNames;
				
				DEFAULT_CHAT_FRAME:AddMessage( (option.message):format( nUI_Options.barMacroNames and nUI_L["|cFF00FF00ENABLED|r"] or nUI_L["|cFFFF0000DISABLED|r"] ), 1, 0.83, 0 );
				
				for i in pairs( nUI_ButtonBars.Bars ) do		
					nUI_ButtonBars:setUserBarOptions( nUI_ButtonBars.Bars[i] );
				end
			end
		);
		
		-- set up a slash command handler for dealing with setting the display of stack counts on the action bars
		
		local master = nUI_SlashCommands[nUI_SLASHCMD_BAR];
		local option = master.sub_menu[nUI_SLASHCMD_BAR_STACKCOUNT];
		
		nUI_SlashCommands:setSubHandler( master.command, option.command,
			
			function( msg )
				
				nUI_Options.barStackCounts = not nUI_Options.barStackCounts;
				
				DEFAULT_CHAT_FRAME:AddMessage( (option.message):format( nUI_Options.barStackCounts and nUI_L["|cFF00FF00ENABLED|r"] or nUI_L["|cFFFF0000DISABLED|r"] ), 1, 0.83, 0 );
				
				for i in pairs( nUI_ButtonBars.Bars ) do		
					nUI_ButtonBars:setUserBarOptions( nUI_ButtonBars.Bars[i] );
				end
			end
		);
		
		-- set up a slash command handler for dealing with setting the display of key bindings on the action bars
		
		local master = nUI_SlashCommands[nUI_SLASHCMD_BAR];
		local option = master.sub_menu[nUI_SLASHCMD_BAR_KEYBIND];
		
		nUI_SlashCommands:setSubHandler( master.command, option.command,
			
			function( msg )
				
				nUI_Options.barKeyBindings = not nUI_Options.barKeyBindings;
				
				DEFAULT_CHAT_FRAME:AddMessage( (option.message):format( nUI_Options.barKeyBindings and nUI_L["|cFF00FF00ENABLED|r"] or nUI_L["|cFFFF0000DISABLED|r"] ), 1, 0.83, 0 );
				
				for i in pairs( nUI_ButtonBars.Bars ) do		
					nUI_ButtonBars:setUserBarOptions( nUI_ButtonBars.Bars[i] );
				end
			end
		);
		
		-- set up a slash command handler for dealing with setting the dimming of buttons on the action bars
		
		local master = nUI_SlashCommands[nUI_SLASHCMD_BAR];
		local option = master.sub_menu[nUI_SLASHCMD_BAR_DIMMING];
		
		nUI_SlashCommands:setSubHandler( master.command, option.command,
			
			function( msg )
				
				nUI_Options.barDimming = not nUI_Options.barDimming;
				
				DEFAULT_CHAT_FRAME:AddMessage( (option.message):format( nUI_Options.barDimming and nUI_L["|cFF00FF00ENABLED|r"] or nUI_L["|cFFFF0000DISABLED|r"] ), 1, 0.83, 0 );
				
			end
		);
		
		-- set up a slash command handler for dealing with setting the dimming of buttons on the action bars
		
		local master = nUI_SlashCommands[nUI_SLASHCMD_BAR];
		local option = master.sub_menu[nUI_SLASHCMD_BAR_MOUSEOVER];
		
		nUI_SlashCommands:setSubHandler( master.command, option.command,
			
			function( msg )
				
				nUI_Options.barMouseover = not nUI_Options.barMouseover;
				
				DEFAULT_CHAT_FRAME:AddMessage( (option.message):format( nUI_Options.barMouseover and nUI_L["|cFF00FF00ENABLED|r"] or nUI_L["|cFFFF0000DISABLED|r"] ), 1, 0.83, 0 );
				
				for i in pairs( nUI_ButtonBars.Bars ) do
					nUI_ButtonBars.Bars[i]:SetAlpha( nUI_Options.barMouseover and 0 or 1 );
				end
				
				nUI_SpecialBars:SetAlpha( nUI_Options.barMouseover and 0 or 1 );
			end
		);
		
		-- set up a slash command handler for dealing with setting the dimming alpha for buttons on the action bars
		
		local master = nUI_SlashCommands[nUI_SLASHCMD_BAR];
		local option = master.sub_menu[nUI_SLASHCMD_BAR_DIMALPHA];
		
		nUI_SlashCommands:setSubHandler( master.command, option.command,
			
			function( msg, arg1 )
				
				local alpha = tonumber( arg1 or "0.3" );
				
				if not alpha or alpha <= 0 or alpha > 1 then
					
					DEFAULT_CHAT_FRAME:AddMessage( nUI_L["nUI: [ %s ] is not a valid alpha value... please choose a number between 0 and 1 where 0 is fully transparent and 1 is fully opaque."]:format( arg1 ), 1, 0.83, 0 );
					
				elseif nUI_Options.dimmingAlpha ~= alpha then
					
					nUI_Options.dimmingAlpha = alpha;
					
					DEFAULT_CHAT_FRAME:AddMessage( (option.message):format( (alpha or 0.3) * 100 ), 1, 0.83, 0 );

				end
				
			end
		);
		
		-- set up a slash command handler for dealing with hiding the built in Blizzard totem bar
		
		local master = nUI_SlashCommands[nUI_SLASHCMD_BAR];
		local option = master.sub_menu[nUI_SLASHCMD_BAR_TOTEMS];
		
		nUI_SlashCommands:setSubHandler( master.command, option.command,
			
			function( msg )
	
				if not InCombatLockdown() then
								
					nUI_Options.noTotemBar = not nUI_Options.noTotemBar;
					
					DEFAULT_CHAT_FRAME:AddMessage( (option.message):format( nUI_Options.noTotemBar and nUI_L["|cFF00FF00ENABLED|r"] or nUI_L["|cFFFF0000DISABLED|r"] ), 1, 0.83, 0 );
					
					MultiCastActionBarFrame:SetParent( nUI_Options.noTotemBar and MainMenuBar or UIParent );
				end				
			end
		);
		
	end
	
--	nUI_ProfileStop();
	
end

nUI_ButtonBars:RegisterEvent( "ADDON_LOADED" );
nUI_ButtonBars:RegisterEvent( "PLAYER_LOGOUT" );
nUI_ButtonBars:RegisterEvent( "VARIABLES_LOADED" );
nUI_ButtonBars:SetScript( "OnEvent", onButtonBarEvent );

local bar;

local function onButtonBarUpdate( who, elapsed )

	if nUI_Options.barMouseover then
	
		mouseoverTimer = mouseoverTimer - elapsed;
		
		if mouseoverTimer <= 0 then
		
			mouseoverTimer = nUI_Unit.frame_rate;

			for i in pairs( nUI_ButtonBars.Bars ) do
				bar = nUI_ButtonBars.Bars[i];				
				bar:SetAlpha( MouseIsOver( bar ) and 1 or 0 );
			end
		end
	end
	
end

nUI_ButtonBars:SetScript( "OnUpdate", onButtonBarUpdate );
	
-------------------------------------------------------------------------------
-- set configuration data for a single named bar

function nUI_ButtonBars:configBar( name, use_default )

--	nUI_ProfileStart( ProfileCounter, "configBar" );
	
	local config  = nUI_ButtonBarOptions[name] or {};
	local default = nUI_DefaultConfig.ButtonBars[name] or config;

	if use_default then
		
		config.btn_size = default.btn_size;
		config.gap      = default.gap;
		config.anchor   = default.anchor;
		config.xOfs     = default.xOfs;
		config.yOfs     = default.yOfs;
		config.rows     = default.rows;
		config.cols     = default.cols;
		config.binding  = default.binding;
		config.label    = default.label;
		config.page     = default.page;
		config.base_id  = default.base_id;
				
	else
			
		config.btn_size = tonumber( config.btn_size or default.btn_size );
		config.gap      = tonumber( config.gap or default.gap );
		config.anchor   = strupper( config.anchor or default.anchor );
		config.xOfs     = tonumber( config.xOfs or default.xOfs );
		config.yOfs     = tonumber( config.yOfs or default.yOfs );
		config.rows     = tonumber( config.rows or default.rows );
		config.cols     = tonumber( config.cols or default.cols );
		config.binding  = config.binding or default.binding;
		config.nuibind  = config.nuibind or default.nuibind;
		config.label    = config.label or default.label;
		config.page     = config.page or default.page;
		config.base_id  = config.base_id or default.base_id;
		
	end
	
	if config.page then config.page = tonumber( config.page ); end
	if config.base_id then config.base_id = tonumber( config.base_id ); end
	
	nUI_ButtonBarOptions[name] = config;
	
--	nUI_ProfileStop();
	
end

-------------------------------------------------------------------------------
-- create a new named button bar using the passed layout

function nUI_ButtonBars:createBar( name, layout )
	
--	nUI_ProfileStart( ProfileCounter, "createBar" );
	
	local bar  = CreateFrame( "Frame", name, nUI_Dashboard.Anchor, "SecureHandlerStateTemplate" );
	bar.events = CreateFrame( "Frame", name.."_Events", nUI_ButtonBars );
	bar.layout = layout;
	
	bar:SetBackdrop(
		{
			bgFile   = "Interface\\AddOns\\nUI\\Layouts\\Default\\Art\\nUI_BevelboxBg.blp", 
			edgeFile = "Interface\\AddOns\\nUI\\Layouts\\Default\\Art\\nUI_BevelboxBorder.blp", 
			tile     = true, 
			tileSize = 1, 
			edgeSize = 12, 
			insets   = {left = 0, right = 0, top = 0, bottom = 0},
		}
	);
	
	bar:SetBackdropColor( 0, 0, 0, 0.35 );
	bar:SetAttribute( "nUI_ActionType", layout.binding );
	bar:SetAttribute( "nUI_BindingType", layout.nuibind );
	
	_G["BINDING_HEADER_"..layout.nuibind] = "nUI: "..layout.label;
	
	if layout.page then layout.base_id = (layout.page-1) * 12; end
	
	-- button initialization
	
	bar.Buttons = {};

	for i=1,layout.rows do
	
		bar.Buttons[i] = {};
		
		for j=1,layout.cols do
			
			local id         = (i-1)*layout.cols + j;
			local button     = CreateFrame( "CheckButton", "$parent_Button"..id, bar, "ActionBarButtonTemplate" );

			nUI:initActionButton( button );
			
			local overlay = nUI_ButtonMap[button];
								
			_G["BINDING_NAME_CLICK "..button:GetName()..":LeftButton"] = "Button #"..id;
			
			bar.Buttons[i][j] = button;
		
			overlay.action                   = layout.base_id + id;
			overlay.bindingType              = layout.binding;
			overlay.actionType               = layout.nuibind;
			overlay.actionID                 = id;

            if layout.binding then ClearButtonHandlers( _G[layout.binding .. id] ); end
            
			button.bindAction = function()
				nUI_KeyBindingFrame.bindAction( button, bar.layout.label.." -- #"..id, "CLICK "..button:GetName()..":LeftButton" );
			end
		
			button:SetScript( "PreClick", 
				function( self, button, down )
					
--					nUI_ProfileStart( ProfileCounter, "PreClick" );
	
					if not InCombatLockdown()
					and button == "RightButton" 
					and IsControlKeyDown() 
					and IsAltKeyDown()
					then
						self:SetAttribute( "alt-ctrl-type2", "bindAction" );
					end
					
--					nUI_ProfileStop();
					
				end
			);
						
			button:SetScript( "PostClick", 
				function( self, button, down )
					
--					nUI_ProfileStart( ProfileCounter, "PostClick" );
	
					if not InCombatLockdown()
					and button == "RightButton" 
					and IsControlKeyDown() 
					and IsAltKeyDown()
					then
						self:SetAttribute( "alt-ctrl-type2", nil );
						self:SetChecked( false );
					end
					
--					nUI_ProfileStop();
					
				end
			);
						
			-- for the main action bar, we need the button ID set to support paging
			
			if name == "nUI_ActionBar" then
				bar:SetAttribute( "addchild", button );
				bar:SetFrameRef( "nUI_ActionBarButton"..id, button );
				button:SetID(id);
			else
				button:SetAttribute( "action", overlay.action ); 
			end			
		end
	end

	-- manage the layout of the bar
	
	bar.events:RegisterEvent( "DISPLAY_SIZE_CHANGED" );
	bar.events:RegisterEvent( "PLAYER_LOGIN" );
	bar.events:SetScript( "OnEvent", function() nUI_ButtonBars:layoutFrame( bar ); end );
		
--	nUI_ProfileStop();
	
	return bar;
	
end

-------------------------------------------------------------------------------
-- actually perform the layout on the indicated bar. If no layout is passed
-- then the current layout for this bar is used. Otherwise the passed layout
-- will replace the current layout

function nUI_ButtonBars:layoutFrame( bar, layout )

--	nUI_ProfileStart( ProfileCounter, "layoutFrame" );
	
	if layout then bar.layout = layout;
	else layout = bar.layout;
	end
	
	nUI:setScale();
				
	local btn_hSize   = layout.btn_size * nUI.hScale;
	local btn_vSize   = layout.btn_size * nUI.vScale;
	local btn_hGap    = layout.gap * nUI.hScale;
	local btn_vGap    = layout.gap * nUI.vScale;
	
	bar:SetFrameStrata( nUI_Dashboard:GetFrameStrata() );
	bar:SetFrameLevel( nUI_Dashboard:GetFrameLevel()+2 );
	
	for row in pairs( bar.Buttons ) do
		
		for col in pairs( bar.Buttons[row] ) do
			
			local button      = bar.Buttons[row][col];
			local overlay     = nUI_ButtonMap[button];

			-- save the binding we're using
	
			button:SetFrameStrata( bar:GetFrameStrata() );
			button:SetFrameLevel( bar:GetFrameLevel()+1 );

			if overlay then
				overlay:SetFrameStrata( button:GetFrameStrata() );
				overlay:SetFrameLevel( button:GetFrameLevel()+1 );
			end
			
			button:SetScale( 1 );
			button:SetHeight( btn_vSize );
			button:SetWidth( btn_hSize );
			
--			button:SetScale( btn_size / button:GetHeight() );			
	
			button:ClearAllPoints();
			
			if col == 1 and row == 1 then 
				button:SetPoint( "TOPLEFT", bar, "TOPLEFT", btn_hSize * 0.05, -btn_vSize * 0.05 );
			elseif col == 1 then
				button:SetPoint( "TOPLEFT", bar.Buttons[row-1][1], "BOTTOMLEFT", 0, -btn_vGap );
			else 
				button:SetPoint( "TOPLEFT", bar.Buttons[row][col-1], "TOPRIGHT", btn_hGap, 0 );
			end
			
			nUI:initActionButton( button );
			
		end
	end		
		
	bar:SetHeight( layout.rows * btn_vSize + (layout.rows-1) * btn_vGap + btn_vSize * 0.1 );
	bar:SetWidth( layout.cols * btn_hSize + (layout.cols-1) * btn_hGap + btn_hSize * 0.1 );
	bar:SetPoint( layout.anchor, nUI_Dashboard, "CENTER", layout.xOfs * nUI.hScale, layout.yOfs * nUI.vScale );
	
	nUI_Movers:lockFrame( bar, true, layout.label );
	
	-- if this is the action bar, then add the paging buttons to it
	
	if bar:GetName() == "nUI_ActionBar" then

		ActionBarUpButton:SetParent( bar );
		ActionBarUpButton:SetFrameStrata( bar:GetFrameStrata() );
		ActionBarUpButton:SetFrameLevel( bar:GetFrameLevel() );
		ActionBarUpButton:SetScale( 1.5 * nUI.vScale );
		ActionBarUpButton:ClearAllPoints();
		ActionBarUpButton:SetPoint( "TOPLEFT", bar, "TOPRIGHT", -10 * nUI.hScale, 12 * nUI.vScale );
		ActionBarUpButton:Show();
	
		ActionBarDownButton:SetParent( bar );
		ActionBarDownButton:SetFrameStrata( bar:GetFrameStrata() );
		ActionBarDownButton:SetFrameLevel( bar:GetFrameLevel() );
		ActionBarDownButton:SetScale( 1.5 * nUI.vScale );
		ActionBarDownButton:ClearAllPoints();
		ActionBarDownButton:SetPoint( "BOTTOMLEFT", bar, "BOTTOMRIGHT", -10 * nUI.hScale, -12 * nUI.vScale  );
		ActionBarDownButton:Show();
		
	end
	
--	nUI_ProfileStop();
	
end

-- method used to apply the user's preferences to the action bar

function nUI_ButtonBars:setUserBarOptions( bar )

	for i=1,#bar.Buttons do
		for j=1,#bar.Buttons[i] do
		
			local overlay = nUI_ButtonMap[bar.Buttons[i][j]];
	
			overlay.layers.count:SetAlpha( nUI_Options.barStackCounts and 1 or 0 );
			overlay.layers.name:SetAlpha( nUI_Options.barMacroNames and 1 or 0 );
			overlay.layers.hotkey:SetAlpha( nUI_Options.barKeyBindings and 1 or 0 );

			if not nUI_Options.barCooldowns or not nUI_Options.barDurations then
				overlay.layers.cdc.value = nil;
				overlay.layers.cdc:SetText( "" );
			end								
		end
	end
end