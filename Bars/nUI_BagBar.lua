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
if not nUI_Options then nUI_Options = {}; end
if not nUI_Profile then nUI_Profile = {}; end;

nUI_Profile.nUI_BagBar = {};
nUI_Options.bagbar     = "on";
nUI_Options.onebag     = false;

local ProfileCounter = nUI_Profile.nUI_BagBar;

-------------------------------------------------------------------------------
-- create the BagBar frame

local frame = CreateFrame( "Frame", "nUI_BagBar", nUI_Dashboard.Anchor ); -- , "SecureHandlerClickTemplate" );
nUI_BagBar  = frame;

nUI_BagBar:SetBackdrop(
	{
		bgFile   = "Interface\\AddOns\\nUI\\Layouts\\Default\\Art\\nUI_BevelboxBg.blp", 
		edgeFile = "Interface\\AddOns\\nUI\\Layouts\\Default\\Art\\nUI_BevelboxBorder.blp", 
		tile     = true, 
		tileSize = 1, 
		edgeSize = 12, 
		insets   = {left = 0, right = 0, top = 0, bottom = 0},
	}
);

nUI_BagBar:SetBackdropColor( 0, 0, 0, 0.35 );

-------------------------------------------------------------------------------
-- button initialization

nUI_BagBar.Buttons = {};

if _G["KeyRingButton"] then
	nUI_BagBar.Buttons[1] = _G["KeyRingButton"];
	nUI_BagBar.Buttons[2] = nUI_ButtonBagButton;
	nUI_BagBar.Buttons[3] = _G["CharacterBag3Slot"];
	nUI_BagBar.Buttons[4] = _G["CharacterBag2Slot"];
	nUI_BagBar.Buttons[5] = _G["CharacterBag1Slot"];
	nUI_BagBar.Buttons[6] = _G["CharacterBag0Slot"];
	nUI_BagBar.Buttons[7] = _G["MainMenuBarBackpackButton"];
else
	nUI_BagBar.Buttons[1] = nUI_ButtonBagButton;
	nUI_BagBar.Buttons[2] = _G["CharacterBag3Slot"];
	nUI_BagBar.Buttons[3] = _G["CharacterBag2Slot"];
	nUI_BagBar.Buttons[4] = _G["CharacterBag1Slot"];
	nUI_BagBar.Buttons[5] = _G["CharacterBag0Slot"];
	nUI_BagBar.Buttons[6] = _G["MainMenuBarBackpackButton"];
end
for i in pairs( nUI_BagBar.Buttons ) do
	
	local button = nUI_BagBar.Buttons[i];
	
	button:SetParent( nUI_BagBar );

	button.nUI_CachedClearAllPoints = button.ClearAllPoints;
	button.nUI_CachedSetAllPoints   = button.SetAllPoints;
	button.nUI_CachedSetPoint       = button.SetPoint;

	button.ClearAllPoints = function() end;
	button.SetAllPoints   = function() end;
	button.SetPoint       = function() end;
	
--	button:SetNormalTexture( "" );
--	button.SetNormalTexture = function() end;
	
end

-------------------------------------------------------------------------------
	
local timer = 0.033;

local function onBagBarUpdate( self, elapsed )
	
	-- if the mouse is currently over the button bag, then fade it in or out as 
	-- the case may be
	
	if nUI_Options.bagbar == "mouseover" then
	
		timer = timer - elapsed;
		
		if timer <= 0 then -- there's no need to update this any faster than 30fps
		
			local mouseOver = MouseIsOver( frame );
				
			timer = 0.0333;
							
			if not frame.alpha then
				frame.alpha = 1;
				frame.startFade = GetTime() + 15;
			end
			
			if frame.startFade and GetTime() >= frame.startFade then
				frame.startFade = nil;
				frame.fadeOut   = GetTime() + 2;
			end
			
			if mouseOver and not frame.fadeIn and frame.alpha < 1 then
				frame.fadeIn  = GetTime() + (1 - frame:GetAlpha()) * 0.75;
				frame.fadeOut = nil;
			elseif not mouseOver and frame.fadeIn then
				frame.fadeIn  = nil;
				frame.fadeOut = GetTime() + frame:GetAlpha() * 2;
			end
			
			if frame.fadeOut then
				frame.alpha = max( 0, (frame.fadeOut - GetTime()) / 2 );
				if frame.alpha == 0 then frame.fadeOut = nil; end
				frame:SetAlpha( frame.alpha );
			elseif frame.fadeIn and (not frame.alpha or frame.alpha < 1) then
				frame.alpha = min( 1, (1 - (frame.fadeIn - GetTime()) / 0.75) );
				frame:SetAlpha( frame.alpha );
			end
		end
	end	
end	

-------------------------------------------------------------------------------
-- bag bar event management

local function onBagBarEvent( who, event, arg1 )
	
--	nUI_ProfileStart( ProfileCounter, "onBagBarEvent", event );
	
	if event == "ADDON_LOADED" and arg1 == "nUI" then
		
		nUI:patchConfig();
		nUI_BagBar:configBar();

		-- set the appropriate bag bar visibility
		
		if nUI_Options.bagbar == "off" then
			frame:SetAlpha( 0 );
			frame.alpha = 0;
			nUI_BagBar:SetParent( nUI.BlizUI );
		elseif nUI_Options.bagbar == "mouseover" then		
			nUI_BagBar:SetScript( "OnUpdate", onBagBarUpdate );
			nUI_BagBar:SetParent( nUI_Dashboard.Anchor );
		else
			frame:SetAlpha( 1 );
			frame.alpha = 1;
			nUI_BagBar:SetParent( nUI_Dashboard.Anchor );
		end
		
		-- console visibility mode
		
		local option = nUI_SlashCommands[nUI_SLASHCMD_BAGBAR];
		
		nUI_SlashCommands:setHandler( option.command, 
		
			function( cmd, arg1 ) 
			
				local mode;
				
				if arg1 == nUI_L[nUI_SLASHCMD_OPTIONS( nUI_SLASHCMD_BAGBAR, "on" )] then mode = "on"
				elseif arg1 == nUI_L[nUI_SLASHCMD_OPTIONS( nUI_SLASHCMD_BAGBAR, "off" )] then mode = "off"
				elseif arg1 == nUI_L[nUI_SLASHCMD_OPTIONS( nUI_SLASHCMD_BAGBAR, "mouseover" )] then mode = "mouseover"
				else
					
					DEFAULT_CHAT_FRAME:AddMessage( 
						nUI_L["nUI: [ %s ] is not a valid bag bar visibility option... please choose from %s, %s or %s"]:format( 
						arg1 or "", nUI_L[nUI_SLASHCMD_OPTIONS( nUI_SLASHCMD_BAGBAR, "on" )], nUI_L[nUI_SLASHCMD_OPTIONS( nUI_SLASHCMD_BAGBAR, "off" )],
						nUI_L[nUI_SLASHCMD_OPTIONS( nUI_SLASHCMD_BAGBAR, "mouseover" )] ), 1, 0.83, 0
					);
				end
				
				if not InCombatLockdown() and mode and mode ~= nUI_Options.bagbar then
	
					nUI_Options.bagbar = mode;
					
					if mode == "off" then				
						nUI_BagBar:SetAlpha( 0 );
						nUI_BagBar.alpha = 0;
						nUI_BagBar:SetScript( "OnUpdate", nil );
						nUI_BagBar:SetParent( nUI.BlizUI );
					elseif mode == "on" then
						nUI_BagBar:SetAlpha( 1 );
						nUI_BagBar.alpha = 1;
						nUI_BagBar:SetScript( "OnUpdate", nil );
						nUI_BagBar:SetParent( nUI_Dashboard.Anchor );
					else
						frame.fadeIn  = nil;
						frame.fadeOut = GetTime() + frame:GetAlpha() * 2;
						nUI_BagBar:SetScript( "OnUpdate", onBagBarUpdate );
						nUI_BagBar:SetParent( nUI_Dashboard.Anchor );
					end
	
					DEFAULT_CHAT_FRAME:AddMessage( (option.message):format( "|cFF00FFFF"..arg1.."|r" ), 1, 0.83, 0 );
					
				end
			end 
		);
		-- set up a slash command handler for dealing with setting the onebag toggle
		
		local option = nUI_SlashCommands[nUI_SLASHCMD_ONEBAG];
		
		nUI_SlashCommands:setHandler( option.command,
			
			function( msg )
				
				if InCombatLockdown() then
					
					DEFAULT_CHAT_FRAME:AddMessage( nUI_L["nUI: You cannot change your bag bar's visibility while in combat. Please try again later"], 1, 0.83, 0 );
					
				else
						
					nUI_Options.onebag = not nUI_Options.onebag;
					
					DEFAULT_CHAT_FRAME:AddMessage( (option.message):format( nUI_Options.onebag and nUI_L["|cFF00FF00ENABLED|r"] or nUI_L["|cFFFF0000DISABLED|r"] ), 1, 0.83, 0 );
					
					nUI_BagBar:layoutFrame();
					
				end
			end
		);
		
	end
	
	nUI_BagBar:layoutFrame();

	if nUI_Options.bagbar then nUI_BagBar:Show();
	else nUI_BagBar:Hide();
	end

--	nUI_ProfileStop();
	
end

nUI_BagBar:SetScript( "OnEvent", onBagBarEvent );
nUI_BagBar:RegisterEvent( "ADDON_LOADED" );
nUI_BagBar:RegisterEvent( "DISPLAY_SIZE_CHANGED" );

-------------------------------------------------------------------------------
-- initialize the bag bar configuration

function nUI_BagBar:configBar( use_default )
	
--	nUI_ProfileStart( ProfileCounter, "configBar" );
	
	local config  = nUI_BagBarOptions or {};
	local default = nUI_DefaultConfig.BagBar;

	if use_default then
		
		config.btn_size = default.btn_size;
		config.gap      = default.gap;
		config.anchor   = default.anchor;
		config.xOfs     = default.xOfs;
		config.yOfs     = default.yOfs;
				
	else
			
		config.btn_size = tonumber( config.btn_size or default.btn_size );
		config.gap      = tonumber( config.gap or default.gap );
		config.anchor   = strupper( config.anchor or default.anchor );
		config.xOfs     = tonumber( config.xOfs or default.xOfs );
		config.yOfs     = tonumber( config.yOfs or default.yOfs );
		
	end
	
	nUI_BagBarOptions = config;
	
--	nUI_ProfileStop();
	
end

-------------------------------------------------------------------------------
-- apply the current layout configuration to the bag bar

function nUI_BagBar:layoutFrame()
				
--	nUI_ProfileStart( ProfileCounter, "layoutFrame" );
	
	nUI:setScale();
			
	if not nUI_BagBarOptions then nUI_BagBar:configBar(); end
	
--	if nUI_MoverFrames[nUI_BagBar] then nUI_Movers:lockFrame( nUI_BagBar, false ); end
	
	local btn_hSize   = nUI_BagBarOptions.btn_size * nUI.hScale;
	local btn_vSize   = nUI_BagBarOptions.btn_size * nUI.vScale;
	local btn_hGap    = nUI_BagBarOptions.gap * nUI.hScale;
	local btn_vGap    = nUI_BagBarOptions.gap * nUI.vScale;
	local width       = 0;
	local last_button;
	
	nUI_BagBar:SetFrameStrata( nUI_Dashboard:GetFrameStrata() );
	nUI_BagBar:SetFrameLevel( nUI_Dashboard:GetFrameLevel()+2 );

	if nUI_MoverFrames[nUI_BagBar] then
		nUI_Movers:lockFrame( nUI_BagBar, false );
		nUI_MoverFrames[nUI_BagBar] = nil;
	end

	nUI_BagBar:ClearAllPoints();
	nUI_BagBar:SetPoint( nUI_BagBarOptions.anchor, nUI_Dashboard, "CENTER", nUI_BagBarOptions.xOfs * nUI.hScale, nUI_BagBarOptions.yOfs * nUI.vScale );
	
	for i in pairs( nUI_BagBar.Buttons ) do
		
		local button = nUI_BagBar.Buttons[i];

		button:SetFrameStrata( nUI_BagBar:GetFrameStrata() );
		button:SetFrameLevel( nUI_BagBar:GetFrameLevel()+1 );
		
		if button == _G["KeyRingButton"] then -- special handling for the keyring button which is not square
		
			button:SetScale( btn_vSize / button:GetHeight() );
			
		else
			
			local count = _G[button:GetName().."Count"];
				
			button:SetScale( 1 );
			button:SetWidth( btn_hSize );
			button:SetHeight( btn_vSize );

			if button ~= nUI_ButtonBagButton then -- hide the bag borders
				button:SetNormalTexture( "" );
			end
			
			if count then
				count:ClearAllPoints();
				count:SetPoint( "BOTTOMRIGHT", button, "BOTTOMRIGHT", btn_hSize * -0.05, btn_vSize * 0.05 );
				count:SetFont( nUI_L["font1"], btn_vSize * 0.45, "OUTLINE" );
				count:SetJustifyH( "RIGHT" );
				count:SetJustifyV( "BOTTOM" );
			end
		end
		
		button:nUI_CachedClearAllPoints();

        if not nUI_Options.onebag
        or button:GetName() == "KeyRingButton"
        or button:GetName() == nUI_ButtonBagButton:GetName()
        or button:GetName() == "MainMenuBarBackpackButton"
        then
            
			button:SetParent( nUI_BagBar );
			button:Show();
			
            if i == 1 then 
                button:nUI_CachedSetPoint( "TOPLEFT", nUI_BagBar, "TOPLEFT", btn_hSize * 0.05, -btn_vSize * 0.05 );
            else 
                button:nUI_CachedSetPoint( "TOPLEFT", last_button, "TOPRIGHT", btn_hGap, 0 );
            end
    
            width = width + button:GetWidth() * button:GetScale() + (i > 1 and btn_hGap or 0);
    
            last_button = button;
			
		else
			
			button:Hide();
			nUI.HideDefaultFrame( button )
			
        end
	end		
	
	nUI_BagBar:SetHeight( btn_vSize * 1.1 );
	nUI_BagBar:SetWidth( width + btn_hSize * 0.05 );
			
	nUI_Movers:lockFrame( nUI_BagBar, true, nUI_L["Bag Bar"] );
		
--	nUI_ProfileStop();
	
end
