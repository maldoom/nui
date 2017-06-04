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

if not nUI_InfoPanels then nUI_InfoPanels = {}; end

local CreateFrame = CreateFrame;
local MouseIsOver = MouseIsOver;

-------------------------------------------------------------------------------
-- default configuration for the combat log info panel

nUI_InfoPanels[nUI_INFOPANEL_COMBATLOG] =
{	
	enabled   = true,
	desc      = nUI_L[nUI_INFOPANEL_COMBATLOG],				-- player friendly name/description of the panel
	label     = nUI_L[nUI_INFOPANEL_COMBATLOG.."Label"],	-- label to use on the panel selection button face
	rotation  = nUI_INFOMODE_COMBATLOG,						-- index or position this panel appears on/in when clicking the selector button
	full_size = true;										-- this plugin requires the entire info panel port without the button bag
	
	options  =
	{
		enabled  = true,
		btn_size = 45,
		btn_gap  = -8,
	},
};

-------------------------------------------------------------------------------
-- master frame for the plugin

local plugin        = CreateFrame( "Frame", nUI_INFOPANEL_COMBATLOG, nUI_Dashboard.Anchor );
local COMBAT_LOG    = ChatFrame2;

-------------------------------------------------------------------------------
-- we want and need the combat log for this panel to function

local function onCombatLogEvent()
	
	if not IsAddOnLoaded( "Blizzard_CombatLog" ) then
		LoadAddOn( "Blizzard_CombatLog" );
	end
	
	plugin.active = IsAddOnLoaded( "Blizzard_CombatLog" );
	
	if SIMPLE_CHAT then
		DEFAULT_CHAT_FRAME:AddMessage( nUI_L["nUI: You need to go to the WoW Interface menu, select the 'Social' option and turn off the 'Simple Chat' menu option to enable integrated combat log support in nUI."], 1, 0.83, 0 );
		plugin.active = false;
	end
	
end
		
--###########################################################################--
--             INFO PANEL INTERFACE COMPLIANCE INITIALIZATION                --
--###########################################################################--

-------------------------------------------------------------------------------
-- this option allows a plugin to disable itself prior to being loaded and
-- independantly of whether or not the user has enabled/disabled the panel
-- or the skinner has. For example, if a plugin is dependant on another mod
-- or library which is missing or some other runtime condition. This value 
-- should be set withing the timeframe of the "ADDON_LOADED" event or
-- earlier so that it is predefined by the time the "PLAYER_LOGIN" event fires

plugin.active = true;

-------------------------------------------------------------------------------
-- integration into the info panel system... this is the primary entry point
-- into the InfoPanel and is called the first time the InfoPanel tries to
-- size this new panel or when the user changes skins or skin options on
-- the InfoPanel. As a rule, an InfoPanel plug-in should allow for having to
-- initialize itself more than once and potentially with a different set of
-- underlying options.
--
-- NOTE: This callback will not be executed until the PLAYER_LOGIN event
--		 is triggered. Therefore, plugin authors have the opportunity to
--		 add themselves to the nUI_InfoPanels table during the ADDON_LOADED
--		 event, including tweaking their default configuration options
--		 before nUI will "see" or attempt to intiialize their plugin.
--
-- container		this is the frame assigned to contain this plugin which
--					the plugin author is pretty much free to do with as they
--					please. It is a SecureStateHeaderTemplate frame which is
--					centered on the InfoPanel and after PLAYER_LOGIN has been
--					executed, will be sized to fit inside the InfoPanel. The
--					only caveat for the plugin author is that their visual
--					components should all reside within the boundaries of 
--					the container and the author should never call SetWidth(),
--					SetHeight(), SetPoint(), SetAllPoints() or ClearAllPoints()
--					on this frame... the nUI_InfoPanel system manages those.
--					Otherwise, the author is free to Show() and Hide() and
--					modify the look and content of the container to their
--					heart's content.
--
-- options			When defining an InfoPanel entry, the plugin author may
--					include a set of options as a table within the definition
--					which will be made part of the "skin" and saved accordingly.
--					As a rule, any component you would like to allow the user
--					or an nUI skinner access to in order to modify the look
--					and feel of your plugin should be contained in those options
--					so that the user can create custome skins with the settings
--					they prefer for those skins. The content of the options table
--					is entirely up to the plugin author and strictly for their
--					use in customizing their plugin and saving those options as
--					a part of nUI's configuration table.

plugin.initPanel = function( container, options )

	plugin.container = container;
	plugin.options   = options;

	if options and options.enabled then
			
		container.texture = container:CreateTexture( "$parentBackdrop", "BACKGROUND" );		
		container.texture:SetAllPoints( container );		
					
		plugin.setEnabled( true );
		
	end
end

-------------------------------------------------------------------------------
-- this is part of the InfoPanel interface and called when the frame is first
-- created for this panel or when the size of the InfoPanel changes because of
-- user modification or change in skin.
--
-- scale		this is the actual nUI scale which is being applied to the 
--				frame and NOT the same as frame:SetScale() -- As a rule,
--				nUI does not use frame:SetScale() due to issues with font
--				readability and some other artifacts. nUI users two internal
--				scaling numbers. One is a global value nUI.scale which is a
--				fixed value based on the user's current display resolution
--				and is calculated to keep nUI's full dashboard within the 
--				boundaries of the display. The second scale value is one 
--				that is used by the skinning system to change the size of
--				components relative to their default definition... for 
--				example allowing a user to increase or decrease the size of
--				a unit frame or button bar. So, for a given element that
--				is defined to be width X height by default, within any
--				given skin and at any given display resolution, it's actual
--				width on screen would be (width * nUI.scale * scale). The
--				value of "scale" that is passed here is the calculated value
--				of (nUI.scale * skin.scale) so the plugin knows exactly how
--				to size its internal elements relative to the current view,
--				so if by default the plugin contains a bar the is X by Y in
--				size, then when this method is called, the bar can be set
--				to "fit" correctly in the vies using bar:SetWidth( X * scale )
--				and bar:SetHeight( Y * scale ). Likewise, if the bar is set to
--				be N points from the center of the panel, then the location
--				of the bar can be reset as 
--
--					bar:SetPoint( "CENTER", mypanel, "CENTER", N * scale, 0 );
--
-- height		This is the actual height and width of the container panel the
-- width		plugin has been assigned to and is sized to fit exactly within
--				the region the user / skinner has set aside for InfoPanel
--				functionality. Custom plugins should always ensure their
--				visual components reside within these boundaries. The height
--				and width values have already been scaled by the InfoPanel
--				system, so you should not apply the "scale" value to them.

plugin.sizeChanged = function( scale, height, width )
	
	local options  = plugin.options;
	local btn_size = options.btn_size * scale;
	local bottom   = _G["ChatFrame2ButtonFrameBottomButton"];
	local down     = _G["ChatFrame2ButtonFrameDownButton"];
	local up       = _G["ChatFrame2ButtonFrameUpButton"];
	
	plugin.scale = scale;
	
	COMBAT_LOG:SetWidth( width );
	COMBAT_LOG:SetHeight( height );
	
	-- set the size of the scroll buttons in the chat frames
	
	if plugin.btn_size ~= btn_size then
		plugin.btn_size = btn_size;

		-- size the scroll buttons

		bottom:SetWidth( btn_size );
		bottom:SetHeight( btn_size );
		
		down:SetWidth( btn_size );
		down:SetHeight( btn_size );
		
		up:SetWidth( btn_size );
		up:SetHeight( btn_size );

	end
		
	-- set the locations of the buttons relative to their chat frame
	
	bottom:ClearAllPoints();
	bottom:SetPoint( "BOTTOMLEFT", COMBAT_LOG, "BOTTOMLEFT", -3 * scale, -8 * scale );
	
	down:ClearAllPoints();
	down:SetPoint( "BOTTOM", bottom, "TOP", 0, options.btn_gap * scale );
	
	up:ClearAllPoints();				
	up:SetPoint( "BOTTOM", down, "TOP", 0, options.btn_gap * scale );
		
end	

-------------------------------------------------------------------------------
-- this interace method is called by the Info Panel system when the plugin is being
-- enabled or disabled either as a result of the user changing options or the user
-- changing skins.
--
-- enabled		this is a boolean value set true or false between the user wanting
--				the plugin in their UI and wanting it turned off. Plugins should
--				honor the user preference and suspend all activity and system usage
--				when disabled as well as remove all visual compenents from the screen

plugin.setEnabled = function( enabled )

	if plugin.enabled ~= enabled then
		
		plugin.enabled = enabled;
		
		-- if we're diabling the combat log after having already enabled it, then
		-- return it to its rightful parent and dock is back on the chat frame
		
		if not enabled then

			if plugin.combattab_parent then
				
				ChatFrame2Tab:SetParent( plugin.combattab_parent );
				plugin.combattab_parent = nil;
				
			end
			
			if plugin.combatlog_parent then
				
				COMBAT_LOG:SetParent( plugin.combatlog_parent );
				FCF_DockFrame( COMBAT_LOG, #DOCKED_CHAT_FRAMES+1, true );
				plugin:SetScript( "OnUpdate", nil );
				
				plugin.combatlog_parent = nil;

				ChatFrame2Background.SetPoint = ChatFrame2Background.cachedSetPoint;

				ChatFrame2Background:ClearAllPoints();
				ChatFrame2Background:SetPoint( "TOPLEFT", COMBAT_LOG, "TOPLEFT", -2, 3 );
				ChatFrame2Background:SetPoint( "TOPRIGHT", COMBAT_LOG, "TOPRIGHT", 2, 3 );
				ChatFrame2Background:SetPoint( "BOTTOMLEFT", COMBAT_LOG, "BOTTOMLEFT", -2, -6 );
				ChatFrame2Background:SetPoint( "BOTTOMRIGHT", COMBAT_LOG, "BOTTOMRIGHT", 3, -6 );

			end
			
		-- if we're enabling the combat log plugin, then move the combat log to the
		-- info panel and set up the rest of of combat log modifications
		
		else

			plugin.combatlog_parent = COMBAT_LOG:GetParent();
			plugin.combattab_parent = ChatFrame2Tab:GetParent();

			-- make sure the combat log is active
			
			if not COMBAT_LOG:IsShown() then
				COMBAT_LOG:Show();
			end
			
			-- relocate the chat frame to the area we have set aside for it on the dashboard
				
			FCF_SetLocked( COMBAT_LOG, nil );
			
			if COMBAT_LOG.isDocked then
				FCF_UnDockFrame( COMBAT_LOG );
			end
			
			ChatFrame2.buttonSide = "LEFT";
			
			ChatFrame2Tab:SetParent( plugin.container );
			ChatFrame2Tab:Hide();
			
			ChatFrame2ClickAnywhereButton:EnableMouse( false );
			ChatFrame2ClickAnywhereButton:Hide();
			
			ChatFrame2Background:ClearAllPoints();
			ChatFrame2Background:SetAllPoints( ChatFrame2 );
			
			ChatFrame2Background.cachedSetPoint = ChatFrame2Background.SetPoint;
			ChatFrame2Background.SetPoint       = function() end;
			
			CombatLogQuickButtonFrame_Custom:ClearAllPoints();
			CombatLogQuickButtonFrame_Custom:SetPoint( "TOPLEFT", COMBAT_LOG, "TOPLEFT", 0, 0 );
			CombatLogQuickButtonFrame_Custom:SetPoint( "TOPRIGHT", COMBAT_LOG, "TOPRIGHT", 0, 0 );
						
			COMBAT_LOG:SetClampedToScreen( nil );
			COMBAT_LOG:SetMovable( true );
			COMBAT_LOG:SetResizable( true );
			COMBAT_LOG:SetParent( plugin.container );
			COMBAT_LOG:ClearAllPoints();
			COMBAT_LOG:SetPoint( "BOTTOMRIGHT", plugin.container, "BOTTOMRIGHT", 0, 0 );
			COMBAT_LOG:SetPoint( "TOPLEFT", plugin.container, "TOPLEFT", 0, 0 );
			COMBAT_LOG:Show();
		
			-- clean up the combat frame
		
			ChatFrame_RemoveAllChannels( COMBAT_LOG );
			ChatFrame_RemoveAllMessageGroups( COMBAT_LOG );
			ChatFrame_ActivateCombatMessages( COMBAT_LOG );
		
			-- set strata, etc, for all defined frames, make sure they're all docked
			
			COMBAT_LOG:SetUserPlaced( true );
					
			FCF_SetLocked( COMBAT_LOG, 1 );
			FCF_SetWindowAlpha( COMBAT_LOG, 0 );
					
			-- relocate the chat frame buttons
		
			local minimize = _G["ChatFrame2ButtonFrameMinimizeButton"];
			local bottom   = _G["ChatFrame2ButtonFrameBottomButton"];
			local down     = _G["ChatFrame2ButtonFrameDownButton"];
			local up       = _G["ChatFrame2ButtonFrameUpButton"];
			
			nUI.HideDefaultFrame( minimize ); 
			
			bottom:SetAlpha( 0 );			
			down:SetAlpha( 0 );			
			up:SetAlpha( 0 );
				
			-- set method to show or hide the scroll buttons based on whether or
			-- not the mouse is in the frame
			
			COMBAT_LOG.showButtons = function( enabled )
		
				if enabled ~= COMBAT_LOG.buttons_visible then
					
					COMBAT_LOG.buttons_visible = enabled;
					bottom:SetAlpha( enabled and 1 or 0 );
					down:SetAlpha( enabled and 1 or 0 );
					up:SetAlpha( enabled and 1 or 0 );

					if enabled then CombatLogQuickButtonFrame_Custom:Show();
					else CombatLogQuickButtonFrame_Custom:Hide();
					end
					
				end
			end
			
			-- fix the button frame by making to too narrow to see
			
			ChatFrame2ButtonFrame:ClearAllPoints();
			ChatFrame2ButtonFrame:SetPoint( "TOPLEFT", ChatFrame2, "TOPLEFT", 0, 0 );
			ChatFrame2ButtonFrame:SetPoint( "BOTTOMRIGHT", ChatFrame2, "BOTTOMLEFT", 1, 0 );
			
			-- disable the double click on the combat log tab so it doesn't throw errors because
			-- there is no edit box on the frame
			
			ChatFrame2Tab:RegisterForClicks( "RightButtonDown" );
			
			-- allow scrolling of the combat log frame with the mouse wheel
			
			COMBAT_LOG:EnableMouseWheel( true );	
			
			COMBAT_LOG:SetScript( "OnMouseWheel", 
				function( who, arg1 )
					if arg1 > 0 then COMBAT_LOG:ScrollUp();
					else COMBAT_LOG:ScrollDown();
					end	
				end
			);	
			
			-- fix the layering of the combat log buttons so they don't get hidden under the combat log text
			
			CombatLogQuickButtonFrame_Custom:SetFrameStrata( "LOW" );			
			CombatLogQuickButtonFrame_Custom:SetFrameLevel( 20 );
				
		end				
	end			
end

-------------------------------------------------------------------------------
-- this interface method is called to notify the plugin when the user has selected
-- this plugin as the active view within the info panel and to notify the plugin
-- again when the user has selected a different plugin as their active view. 
--
-- selected		this is a boolean value set true when the plugin is chosen as the
--				active view port in the user's Info Panel and false when another
--				plugin is selected as the active view. As a rule, the plugin is
--				not expected to show or hide elements that are children of the
--				plugin's container as the Info Panel system manages that. But,
--				if the plugin has any visual screen elements which are not children
--				of the container it should hide them when selected is set false.
--				Likewise, for the benefit of the user's system performance, any
--				processing that is not required by the plugin when not visually
--				active should be suspended (such as updating screen components
--				that are, obviously, not visible and so on.

plugin.setSelected = function( selected )

	if selected ~= plugin.selected then

		plugin.selected = selected;
				
		-- when the combat log is active, we want to watch for mouseover so we
		-- can show and hide the scroll buttons... we can't use OnEnter or
		-- OnLeave because the buttons would hide when the mouse entered them
		-- because WoW then sees the mouse as leaving the combat log frame
		
		if selected then
			
			local mouseover_timer = 0;
			
			local function onCombatLogUpdate( who, elapsed )
			
				mouseover_timer = mouseover_timer + elapsed;
				
				if mouseover_timer > 0.2 then -- 5 fps is plenty fast enough to show these buttons
				
					mouseover_timer = 0;
				
					COMBAT_LOG.showButtons( MouseIsOver( COMBAT_LOG ) );
			
				end
			end
			
			plugin:SetScript( "OnUpdate", onCombatLogUpdate );
			
		-- otherwise, when deselected, we don't need to burn up the frame update 
		-- engine looking for mouseovers on a hidden frame
		
		else
			
			plugin:SetScript( "OnUpdate", nil );
			
		end
	end
end

