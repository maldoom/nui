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

WorldFrame:SetPoint( "BOTTOM", nUI_Dashboard, "CENTER", 0, 0 );

if not nUI then nUI = {}; end
if not nUI_Skins then nUI_Skins = {}; end
if not nUI_UnitPanels then nUI_UnitPanels = {}; end
if not nUI_UnitFrames then nUI_UnitFrames = {}; end
if not nUI_XpErrata then nUI_XpErrata = {}; end
if not nUI.FrameList then nUI.FrameList = {}; end
if not nUI.SkinnedFrames then nUI.SkinnedFrames = {}; end
if not nUI_L then nUI_L = {}; end
if not nUI_DefaultConfig then  nUI_DefaultConfig = {}; end
if not nUI_Options then nUI_Options = {}; end;
if not nUI_DebugLog then nUI_DebugLog = {}; end;
if not nUI_Profile then nUI_Profile = {}; end;

nUI_Profile.nUI = {};

local ProfileCounter    = nUI_Profile.nUI;
local ScalableFrameList = {};

nUI.latency   = 0;
nUI.framerate = 0;

-------------------------------------------------------------------------------
-- everything in nUI is anchored to, and a child of, the dashboard anchor
-- frame or one of the bar anchor frames. The purpose in doing this is to tie 
-- everything into a universal scale so that nUI can adjust itself to fit 
-- whatever display it is thrown at.

nUI_BottomBars.Anchor = CreateFrame( "Frame", "$parent_Anchor", nUI_BottomBars );
nUI_BottomBarsLocator:SetPoint( "BOTTOM", nUI_MasterFrame, "BOTTOM", 0, 0 );
nUI_BottomBars:SetPoint( "TOP", nUI_BottomBarsLocator, "TOP", 0, 0 );
nUI_BottomBars.Anchor:SetPoint( "TOP", nUI_BottomBars, "TOP", 0, 0 );

nUI_Dashboard.Anchor = CreateFrame( "Frame", "$parent_Anchor", nUI_Dashboard );
nUI_Dashboard:SetPoint( "BOTTOM", nUI_BottomBarsLocator, "TOP", 0, 0 );
nUI_Dashboard.Anchor:SetPoint( "CENTER", nUI_Dashboard, "CENTER", 0, 0 );

nUI_TopBars.Anchor = CreateFrame( "Frame", "$parent_Anchor", nUI_TopBars );
nUI_TopBarsLocator:SetPoint( "BOTTOM", nUI_MasterFrame, "TOP", 0, 0 );
nUI_TopBars:SetPoint( "BOTTOM", nUI_TopBarsLocator, "BOTTOM", 0, -115 );
nUI_TopBars.Anchor:SetPoint( "BOTTOM", nUI_TopBars, "BOTTOM", 0, 0 );

nUI.BlizUI = CreateFrame( "Frame", "nUI_BlizUI", UIParent, "SecureFrameTemplate" );

-------------------------------------------------------------------------------
-- the main nUI event driver

local function nUI_OnEvent( who, event, arg1, arg2 )
	
--	nUI_ProfileStart( ProfileCounter, "nUI_OnEvent", event );
	
	nUI:setScale();
		
	-- select the skin to be used
	
	if event == "ADDON_LOADED" then
	
		if arg1 == "nUI" then

			-- SetCVar( "raidFramesDisplayIncomingHeals", 1 );

			if GetCVar( "countdownForCooldowns" ) == "1" then
				SetCVar( "countdownForCooldowns", 0, "countdownForCooldowns" );
				print( "set CVAR" );
			end

			nUI.playerName = UnitName( "player" );
			nUI.realmName  = GetRealmName():trim();

			-- zero out the debug log for a new session
			
			if not nUI_DebugLog[nUI.realmName] then
				nUI_DebugLog[nUI.realmName] = {};
			end
			
			nUI_DebugLog[nUI.realmName][nUI.playerName] = {};
			
			-- attempt to load a skin by name... note that if the user
			-- wants to use a customized skin, they can use the skin
			-- name "custom" which will not match a known skin name
			-- and thus will set nUI_CurrentSkin nil, but the next
			-- test will see nUI_CurrentSkin already non-nil because of
			-- the data load and, thus, will use the player's custom skin

			if nUI_Options.skin
			and nUI_Options.skin ~= "default"
			and nUI_Options.skin ~= "custom"
			then
			
				if not nUI_CurrentSkin
				or nUI_CurrentSkin.name ~= nUI_Options.skin
				then
					nUI_CurrentSkin = nUI_Skins[nUI_Options.skin];
				end
			end
			
			-- if we do not have a skin loaded then either we have an
			-- invalid skin name, a skin name for an optional skin that's
			-- currently disabled or the user has not selected any skin
			-- and is using the built in default values
			
			if not nUI_CurrentSkin then
				
				if nUI_Options.skin 
				and nUI_Options.skin ~= "default" 
				and nUI_Options.skin ~= "custom"
				then
					DEFAULT_CHAT_FRAME:AddMessage( nUI_L["nUI could not load the currently selected skin [ %s ]... perhaps you have it disabled? Switching to the default nUI skin."]:format( nUI_Options.skin ), 1, 0.83, 0 );
				end
				
				nUI_Options.skin = "default";
				nUI_CurrentSkin  = nUI_DefaultConfig;
				
			end
			
			nUI_CurrentSkin.name = nUI_Options.skin;
			
			-- set the player's top console according to their current preference

			nUI:setConsoleVisibility( nUI_Options.console or "on" );
		end
	
	elseif event == "VARIABLES_LOADED" 
	then

		-- initialize the slash command handler for selecting the mover state
		
		local option = nUI_SlashCommands[nUI_SLASHCMD_VIEWPORT];
		
		nUI_SlashCommands:setHandler( option.command,
		
			function()

				if not InCombatLockdown() then
					if not nUI_Options.viewportDisabled then 
						nUI_Options.viewportDisabled = true;
						WorldFrame:SetPoint( "BOTTOM" );
					else 
						nUI_Options.viewportDisabled = false;
						WorldFrame:SetPoint( "BOTTOM", nUI_Dashboard, "CENTER", 0, 0 );
					end
				
					DEFAULT_CHAT_FRAME:AddMessage( (option.message):format(nUI_Movers.enabled and nUI_L["|cFF00FF00ENABLED|r"] or nUI_L["|cFFFF0000DISABLED|r"]), 1, 0.83, 0 );
				end				
				
			end
		);
		
		if not nUI_Options.viewportDisabled	
		then
			WorldFrame:SetPoint( "BOTTOM", nUI_Dashboard, "CENTER", 0, 0 );
		end
				
	-- the first time the player logs in we need to do some setup work
	
	elseif event == "PLAYER_LOGIN"
	then

		DEFAULT_CHAT_FRAME:AddMessage( (nUI_L["Welcome back to %s, %s..."].."\n"..nUI_L["nUI %s version %s is loaded!"].."\n"..nUI_L["Type '/nui' for a list of available nUI commands."].."\n"):format( (nUI.realmName or "World of Warcraft"), (nUI.playerName or ""), nUI_Package, nUI_Version ), 0, 1.0, 0.50 );
		
		-- hide away the Bliz UI elements we're replacing
			
		nUI.HideDefaultFrame( PossessBarFrame );
		nUI.HideDefaultFrame( ShapeshiftBarFrame );
		nUI.HideDefaultFrame( PetActionBarFrame );
		nUI.HideDefaultFrame( MultiBarBottomLeft );
		nUI.HideDefaultFrame( MultiBarBottomRight );
		nUI.HideDefaultFrame( MultiBarLeft );
		nUI.HideDefaultFrame( MultiBarRight );
		nUI.HideDefaultFrame( MainMenuBar );
		nUI.HideDefaultFrame( PartyMemberBackground );
		nUI.HideDefaultFrame( TemporaryEnchantFrame );
		nUI.HideDefaultFrame( ComboFrame );
		nUI.HideDefaultFrame( BuffFrame );
		nUI.HideDefaultFrame( CastingBarFrame );
		nUI.HideDefaultFrame( PetCastingBarFrame );
		nUI.HideDefaultFrame( PlayerFrame );
		nUI.HideDefaultFrame( FocusFrame );
		nUI.HideDefaultFrame( PetFrame );
		nUI.HideDefaultFrame( TargetFrame );
		nUI.HideDefaultFrame( ConsolidatedBuffs );
		nUI.HideDefaultFrame( TargetofTargetFrame );
		nUI.HideDefaultFrame( PlayerPowerAltBar );
		-- 5.0.1 Change Start - VehicleBar no longer exists
		--nUI.HideDefaultFrame( VehicleMenuBar );	
		-- 5.0.1 Change End
		--nUI.HideDefaultFrame( RuneFrame );	-- Legion Temp Change TJK
		
		for i=1,4 do
		    nUI.HideDefaultFrame( _G["Boss"..i.."TargetFrame"] );
			nUI.HideDefaultFrame( _G["PartyMemberFrame"..i] );
			nUI.HideDefaultFrame( _G["PartyMemberFrame"..i.."PetFrame"] );
		end		

		nUI.BlizUI:Hide();

		-- check for aura bars

		if IsAddOnLoaded( "nUI_AuraBars" ) then
			message( nUI_L["nUI has disabled the plugin 'nui_AuraBars' as it is now incorporated in nUI 5.0 -- Please use '/nui rl' to reload the UI. You should uninstall nUI_AuraBars as well."] );
			DisableAddOn( "nUI_AuraBars" );
		end
		
	-- layout the info panels
	
	elseif event == "PLAYER_ENTERING_WORLD"
	then

		nUI_MasterFrame:UnregisterEvent( "PLAYER_ENTERING_WORLD" );
		
		-- apply the current skin
		
		for i=1, #nUI.SkinnedFrames do
			nUI.SkinnedFrames[i].applySkin( nUI_CurrentSkin );
		end

	elseif event == "CVAR_UPDATE"
	then

		if GetCVar( "countdownForCooldowns" ) ~= "0" then
			SetCVar( "countdownForCooldowns", 0, "countdownForCooldowns" );
			print( "set CVAR again" );
		end

	end
	
--	nUI_ProfileStop();
	
end

nUI_MasterFrame:SetScript( "OnEvent", nUI_OnEvent );
nUI_MasterFrame:RegisterEvent( "PLAYER_ENTERING_WORLD" );
nUI_MasterFrame:RegisterEvent( "PLAYER_LOGIN" );
nUI_MasterFrame:RegisterEvent( "ADDON_LOADED" );
nUI_MasterFrame:RegisterEvent( "VARIABLES_LOADED" );
nUI_MasterFrame:RegisterEvent( "DISPLAY_SIZE_CHANGED" );
nUI_MasterFrame:RegisterEvent( "CVAR_UPDATE" );

-------------------------------------------------------------------------------

local bar_fade_timer = 0;
local fade_in_rate   = 0.5;
local fade_out_rate  = 1;
local now;
local mouseover;
local hover;

local function nUI_OnUpdate( who, elapsed )

--	nUI_ProfileStart( ProfileCounter, "nUI_OnUpdate" );
	
	-- manage top bar fade in and out visibility... note... none of this matter
	-- unless and until the bar visibility is defined
	
	if nUI_TopBars.visibility then
			
		bar_fade_timer = bar_fade_timer + elapsed;
		
		if bar_fade_timer > 0.08 then -- 12.5fps update... plenty fast enough I should think
		
			now       = GetTime();
			mouseover = nUI_TopBars.visibility == "mouseover";
			hover     = mouseover and MouseIsOver( nUI_TopBars );
			
			bar_fade_timer = 0;
	
			-- if the mouse is over the top bars and we're in mouseover mode
			-- then start a fade in if the bars aren't already visibile
			
			if mouseover and hover
			and not nUI_TopBars.startFadeIn
			and not nUI_TopBars.stopFadeIn
			and nUI_TopBars:GetAlpha() == 0
			then
				
				nUI_TopBars.startFadeIn = now+0.25;
				
			end
			
			-- if the mouse is not hovering over the top bars and we're
			-- in mouseover mode, then if the bars are still visible
			-- we need to start a fade out
			
			if mouseover and not hover
			and not nUI_TopBars.startFadeOut
			and not nUI_TopBars.endFadeOut
			and nUI_TopBars:GetAlpha() == 1
			then
				
				nUI_TopBars.startFadeOut = now + 1;
				
			end
			
			-- if we think we need to start a fade in, check to ensure
			-- the user's mouse is still over the bars... they may have
			-- been just passing by, so don't start a false fade in
			
			if nUI_TopBars.startFadeIn then
				
				if mouseover
				and not MouseIsOver( nUI_TopBars ) then
					nUI_TopBars.startFadeIn = nil;
				else
					nUI_TopBars.stopFadeIn   = nUI_TopBars.startFadeIn + fade_in_rate;
					nUI_TopBars.startFadeOut = nil;
					nUI_TopBars.stopFadeOut  = nil;
					nUI_TopBars.startFadeIn  = nil;
				end
				
			-- likewise, if the mouse has left the top bars make sure it wasn't
			-- momentary... if we're in mouseover mode and the mouse is over
			-- the bars when we're actually ready to start the fade out, then
			-- abort it
			
			elseif nUI_TopBars.startFadeOut then
				
				if now >= nUI_TopBars.startFadeOut then
					
					if mouseover and MouseIsOver( nUI_TopBars )
					then
						nUI_TopBars.startFadeOut = nil;
					else
						nUI_TopBars.stopFadeOut  = nUI_TopBars.startFadeOut + fade_out_rate;
						nUI_TopBars.startFadeOut = nil;
					end			
				end
			end

			-- fade the bar in
			
			if nUI_TopBars.stopFadeIn then
				
				if now >= nUI_TopBars.stopFadeIn then
					nUI_TopBars:SetAlpha( 1 );
					nUI_TopBars.stopFadeIn = nil;
				else
					local dx = nUI_TopBars.stopFadeIn - now;
					nUI_TopBars:SetAlpha( (1 - dx) / fade_in_rate );			
				end
			end
			
			-- fade the bar out
			
			if nUI_TopBars.stopFadeOut and not InCombatLockdown() then
				
				if now >= nUI_TopBars.stopFadeOut then
					nUI_TopBars:SetAlpha( 0 );
					nUI_TopBars.stopFadeOut = nil;
					
					if nUI_Options.console == "off" then
						nUI_MicroMenu:SetParent( nUI.BlizUI );
						nUI_HUDLayoutSelector_Button:SetParent( nUI.BlizUI );
						nUI_SysInfo_Latency:SetParent( nUI.BlizUI )
						nUI_SysInfo_FrameRate:SetParent( nUI.BlizUI )
					end
					
				else
					local dx = nUI_TopBars.stopFadeOut - now;
					nUI_TopBars:SetAlpha( dx / fade_out_rate );
				end			
			end
		end
	end
	
--	nUI_ProfileStop();
	
end

nUI_MasterFrame:SetScript( "OnUpdate", nUI_OnUpdate );

-------------------------------------------------------------------------------
-- methods for adding frames to and removing frames from the list of known
-- scalable frames. A scaleable frame has two methods in its interface...
--
-- frame.applyScale()  -- called to alert the frame that there has been some
--                        change in the scaling of the frame in order to allow
--                        the frame to adjust layouts, sizes, fonts or whatever
--                        else may be necessary
--
-- frame.applyAnchor() -- the anchoring of some frames relative to other frames
--                        may vary based on the scale of the nUI Dashboard. This
--                        method is called to let the frame know that the scale
--                        has changed in order to allow the frame to adjust its
--                        anchor point if required
--

function nUI:registerScalableFrame( frame )
	
--	nUI_ProfileStart( ProfileCounter, "registerScalableFrame" );
	
	local register = true;
	local name     = frame:GetName() or nUI_L["<unnamed frame>"];
	
	-- ensure the registered frame will not blow up the interface
	
	if not frame.applyScale then
		
		register = false;
		DEFAULT_CHAT_FRAME:AddMessage( nUI_L["nUI: Cannot register %s for scaling... frame does not have an applyScale() method"]:format( name ), 1, 0.5, 0.5 );
		
	end
	
	if not frame.applyAnchor then
		
		register = false;
		DEFAULT_CHAT_FRAME:AddMessage( nUI_L["nUI: Cannot register %s for scaling... frame does not have an applyAnchor() method"]:format( name ), 1, 0.5, 0.5 );
		
	end
	
	-- if the frame conforms to the interface, register it
	
	if register then
		
		nUI:TableInsertByValue( ScalableFrameList, frame );
		
	end
	
--	nUI_ProfileStop();
	
end

function nUI:unregisterScalableFrame( frame )
	
--	nUI_ProfileStart( ProfileCounter, "unregisterScalableFrame" );
	nUI:TableRemoveByValue( ScalableFrameList, frame );
--	nUI_ProfileStop();
	
end

-------------------------------------------------------------------------------
-- methods for adding frames to and removing frames from the list of known
-- skinned frames. A skinned frame has a single in its interface...
--
-- frame.applySkin( skin ) -- called to alert the frame that there has been some
--                            change in the skinning of nUI in order to allow
--                            the frame to adjust layouts, sizes, fonts or whatever
--                            else may be necessary. The passed value is the users
--                            currently chosen skin, the called object should be
--                            both aware of where its definition is supposed to
--                            be located within the skin and should be able to
--                            handle its configuration being missing entirely or
--                            having and element named "enabled" set to false...
--                            in either case, the object should consider itself
--                            to not exist in either case and should not display
--                            anything on screen or perform and operations in the
--                            background in that event. Either case is a declaration
--                            that the user does not want that object in their UI
--
-- NOTE: To apply itself, a custom addon should watch for the "ADDON_LOADED" event
--       and register itself with nUI at that time via nUI:registerSkinnedFrame() and
--       do no more. nUI will call the addon's frame.applySkin() method when it is
--       ready for the addon to do its layout. It may call the method again if the
--       user changes skins, so be ready to handle a new layout in realtime... see
--       AddOns\nUI_SysInfo.lua for a fairly simple example.
--
-- NOTE: A well behaved 3rd party addon should also register itself as a scalable
--       frame and use the combination of nUI.scale and the user selected scale value (below)
--       to alter its size and the orientation of its internal elements as well as anchoring
--
-- NOTE: nUI Core elements will inser themselves into any skin and cannot be disabled. If, for example,
--       your addon is defining a new skin and is does not contain values for casting bar colors, nUI
--       will insert its default values mercilessly. In short, any nUI core element not specifically 
--       defined in a skin is assumed to be whatever the nUI default value is. However, nUI defaults
--       can be overloaded by defining specific values for them in the skin definition.
--
-- NOTE: Third party addons should use (and expect) the following data logic to include 
--       themselves in a skin...
--
-- MyAddOnConfig =
-- {
--     anchor  = 	   -- where the user wants your addon to appear in their skin... suitable for frame:SetPoint()
--     {
--         anchor_pt   = value,			-- if nil, your addon should choose a sane anchor point
--         relative_to = frame_name,    -- if nil, your addon should choose its parent frame (by name as a string, not by refernce!)
--         relative_pt = value,         -- if nil, your addon should use the anchor_pt value
--         xOfs        = value,         -- if nil, your addon should use 0
--         yOfs        = value,         -- if nil, your addon should use 0
--     },
--     options =  						-- configuration options for the addon
--     {
--         enabled = value,				-- if false, the user has turned your addon off
--         scale   = value,				-- increases or descreases the size of your addon without altering dimesions
--         strata  = value,				-- if nil, you should use the parent frame's strata
--         level   = value,				-- if nil, you should use the parent frame's level + 1
--                                      -- whatever custom data/options your addon requires or offers
--
--          -- if not nil, your addon should have this border which is only visible when your addon is visible
--          -- otherwise, if border is nil, your addon should not display a border/background
--
--          -- see: frame:SetBackdrop(), frame:SetBackdropColor() and frame:SetBackdropBorderColor() for application
--
--			border =					
--			{							
--				backdrop =				-- suitable for passing into SetBackdrop()
--				{
--					bgFile   = value, 	-- path to the background texture file or nil for no background
--					edgeFile = value,	-- path to the border/edge texture file or nil for no edge
--					tile     = true, 	-- whether or not the background should be tiled
--					tileSize = n, 		-- how big to make each background tile
--					edgeSize = 5, 		-- how big to make the border
--					insets   = { left = 0, right = 0, top = 0, bottom = 0 },
--				},					
--				color =					-- if nil, select a set of sane default colors for your addon
--				{
--					border   = { r = 1, g = 1, b = 1, a = 0.5 }, -- suitable for passing to SetBackdropBorderColor()
--					backdrop = { r = 0, g = 0, b = 0, a = 0 },	 -- suitable for passing to SetBackdropColor()
--				},
--			},
--
--          -- background is identical to border in content and use, it differs in application... if not nil, this 
--          -- background should be displayed even when your addon is not (but IS enabled -- never diplay anything 
--          -- if your addon is disabled)... in practice, if background is non-nil, then create a second frame with
--          -- the same parent as your addon and one frame level below your addon. When you Show()/Hide() your addon, 
--          -- you do not Show()/Hide() this frame... this provides an "always on" backdrop for your addon (like a unit frame)
--
--			background =
--			{
--			},
--     },
-- };

function nUI:registerSkinnedFrame( frame )
	
--	nUI_ProfileStart( ProfileCounter, "registerSkinnedFrame" );
	
	local register = true;
	local name     = frame:GetName() or nUI_L["<unnamed frame>"];
	
	-- ensure the registered frame will not blow up the interface
	
	if not frame.applySkin then
		
		register = false;
		DEFAULT_CHAT_FRAME:AddMessage( nUI_L["nUI: Cannot register %s for skinning... frame does not have an applySkin() method"]:format( name ), 1, 0.5, 0.5 );
		
	end
	
	-- if the frame conforms to the interface, register it
	
	if register then
		
		nUI:TableInsertByValue( nUI.SkinnedFrames, frame );
		
	end
	
--	nUI_ProfileStop();
	
end

function nUI:unregisterSkinnedFrame( frame )
	
--	nUI_ProfileStart( ProfileCounter, "unregisterSkinnedFrame" );	
	nUI:TableRemoveByValue( nUI.SkinnedFrames, frame );
--	nUI_ProfileStop();
	
end

-------------------------------------------------------------------------------
-- this method adjusts the size and location of a frame according to the
-- current scale of the nUI dashboard and is called when the player first
-- initializes nUI and again any time the display size changes

function nUI:setScale()

--	nUI_ProfileStart( ProfileCounter, "setScale" );
	
	local hScale;
	local vScale;

	-- what should the scale be now?

	if nUI_Options.scale and nUI_Options.scale > 0 then
		hScale = nUI_Options.hScale;
		vScale = nUI_Options.vScale;
	else
		local height = UIParent:GetTop() - UIParent:GetBottom();
		local width  = UIParent:GetRight() - UIParent:GetLeft();
		local ratio  = ("%0.3f"):format( width / height );
		
		hScale = width / 2560;
		vScale = height / 1600;
		
		-- adjust vertical scales to produce square buttons
		
		if ratio == "1.778" then	-- 1920x1080, 1280x720, etc.
		
			vScale = vScale * 0.95;
			
		elseif ratio == "1.250" then -- 1280x1024, etc.
		
			vScale = vScale * 0.75;
		
		elseif ratio == "1.333" then -- 800x600, 1024x768, 1600x1200, etc.
		
			vScale = vScale * 0.8;
			
		elseif ratio == "1.600" then  -- 1920,1200, 1440x900, 1280x800, etc.
		
			vScale = vScale * 0.95;
			
		end
		
	end

	-- if it is different than what we know the scale to be, then we need
	-- to update the size and position of all of our known scalable frames
	
	if nUI.hScale ~= hScale 
	or nUI.vScale ~= vScale
	then
	
		local height = 512 * vScale / hScale;
		
		nUI.scale  = hScale;
		nUI.hScale = hScale;
		nUI.vScale = vScale;
		
		nUI_MasterFrame:SetScale( nUI.scale );
		nUI_TopBars.Anchor:SetScale( 1.0 / nUI.scale );
		nUI_Dashboard.Anchor:SetScale( 1.0 / nUI.scale );
	
		nUI_TopBars:SetHeight( height );
		nUI_BottomBars:SetHeight( height );
		nUI_Dashboard:SetHeight( height );
		
		for i=1,5 do
			_G["nUI_TopBars"..i]:SetHeight( height );
			_G["nUI_BottomBars"..i]:SetHeight( height );
			_G["nUI_Dashboard_Panel"..i]:SetHeight( height );
		end
		
		-- update each known scalable frame
		
		for i,frame in ipairs( ScalableFrameList ) do
			
			frame.applyScale();
			frame.applyAnchor();
		
		end
	end
	
--	nUI_ProfileStop();
	
end

-------------------------------------------------------------------------------
-- disable unit frames to keep them from hammering the engine 

local health;
local mana;

function nUI:disableUnitFrame( frame )
	
--	nUI_ProfileStart( ProfileCounter, "disableUnitFrame" );
	
	UnregisterUnitWatch( frame );
	
	frame:UnregisterAllEvents();	

	frame:SetClampedToScreen( false );
	frame:ClearAllPoints();
	frame:SetPoint( "TOPRIGHT", UIParent, "TOPRIGHT", -1000, -1000 );
	frame:Hide();
	
	frame.Show           = function() end;
	frame.ClearAllPoints = function() end;
	frame.SetPoint       = function() end;
	frame.SetAllPoints   = function() end;

	health = getglobal( frame:GetName().."HealthBar" );
	if health then health:UnregisterAllEvents(); end

	mana = getglobal( frame:GetName().."ManaBar" );
	if mana then mana:UnregisterAllEvents(); end

--	nUI_ProfileStop();
	
end

-------------------------------------------------------------------------------
-- simple helper untility to remove an entry from a table by value 

local tracker = {};
local ndx;
local i,j;

function nUI:TableRemoveByValue( list, key )
	
--	nUI_ProfileStart( ProfileCounter, "TableRemoveByValue" );

	if tracker[list] and tracker[list][key] then

		for i in pairs( list ) do
			if list[i] == key then						
				table.remove( list, i );
				break;
			end
		end				
		tracker[list][key] = false;

	end
	
--	nUI_ProfileStop();
	
end

-------------------------------------------------------------------------------
-- there's a bug in the Lua table.sort() method which causes it to fail to
-- sort the last element in a table if the table size meets certain conditions,
-- so this is a simple modified bubble sort written to replace that buggy sort

local left;
local right;
local limit;

function nUI:TableSort( table, sortMethod, tableLength )

	limit = tableLength or #table;
		
	for i=1, limit-1 do
		left = table[i];
		for j=i+1, limit do
			right = table[j];
			if not sortMethod( left, right ) then
				table[i] = right;
				table[j] = left;
				left     = right;
			end
		end
	end
end

-------------------------------------------------------------------------------
-- simple helper untility to insert a value into a table if it isn't already

function nUI:TableInsertByValue( list, key )

--	nUI_ProfileStart( ProfileCounter, "TableInsertByValue" );
	
	if not tracker[list] then tracker[list] = {}; end
	
	if not tracker[list][key] then
		table.insert( list, key );
		tracker[list][key] = true;
	end

--	nUI_ProfileStop();
	
end

-------------------------------------------------------------------------------
-- method for setting and initializing the console visibility mode to on, off
-- or mouseover as well as setting the OnEnter and OnLeave functions

function nUI:setConsoleVisibility( option )

--	nUI_ProfileStart( ProfileCounter, "setConsoleVisibility" );
	
	if option ~= nUI_TopBars.visibility then

		if option ~= "off" 
		and nUI_TopBars.visibility == "off" then
			nUI_MicroMenu:SetParent( nUI_TopBars );
			nUI_HUDLayoutSelector_Button:SetParent( nUI_TopBars );
			nUI_SysInfo_Latency:SetParent( nUI_TopBars );
			nUI_SysInfo_FrameRate:SetParent( nUI_TopBars );
		end
		
		if not nUI_TopBars.visibility 
		and option ~= "on" then
			nUI_TopBars.startFadeOut = GetTime() + 15;
		elseif option == "on" then
			nUI_TopBars.startFadeIn = GetTime() + 1;
		elseif nUI_Options.console == "on" then
			nUI_TopBars.startFadeOut = GetTime() + 5;
		end
		
		nUI_TopBars.visibility = option;				
		nUI_Options.console    = option;
	end	
	
--	nUI_ProfileStop();
	
end

-------------------------------------------------------------------------------

nUI.HideDefaultFrame = function( frame )

	if frame then 
		frame:SetParent( nUI.BlizUI );
	end
end

-------------------------------------------------------------------------------
-- extracts the Bliz item ID from the Bliz item link

local itemId;
local v1, v2, id;

function nUI_GetItemIdFromLink( itemLink )

--	nUI_ProfileStart( ProfileCounter, "nUI_GetItemIdFromLink" );
	
	itemId = nil;
	
	if itemLink then
		
		v1, v2, id  = string.find( itemLink, "item:(%d+)" );
	
		itemId = tonumber( id );

	end

--	nUI_ProfileStop();
	
	return itemId;
end

-- this method is responsible for performing a deep copy of a table
-- inclusive of preserving the metatable if applicable

nUI_TableCopy = function( item )

    local hashTable = {}

    local function CopyItem( item )
    
        if type( item ) ~= "table" then return item;
        elseif hashTable[item]     then return hashTable[item];
        end
        
        local newTable = {};
        
        hashTable[item] = newTable;
        
        for index, value in pairs( item ) do
            newTable[CopyItem( index )] = CopyItem( value );
        end
        
        return setmetatable( newTable, CopyItem( getmetatable( item ) ) );
        
    end
    
    return CopyItem( item );
    
end;

-------------------------------------------------------------------------------
-- sort the profile by elapsed time, then by number of hits

local function SortProfileByTime( left, right )

	if left.elapsed > right.elapsed then
		return true;
	elseif left.elapsed < right.elapsed then
		return false;
	elseif left.count > right.count then
		return true;
	else
		return false;
	end
	
end

nUI_MasterFrame:SetHeight( 1080 );
nUI_MasterFrame:SetWidth( 1920 );
nUI_MasterFrame:ClearAllPoints();
nUI_MasterFrame:SetPoint( "BOTTOM", UIParent, "BOTTOM", 0, 0 );
nUI_MasterFrame:SetPoint( "TOP", UIParent, "TOP", 0, 0 );
