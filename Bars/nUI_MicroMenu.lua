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

if not nUI_MicroMenuOptions then nUI_MicroMenuOptions = {}; end
if not nUI_Profile then nUI_Profile = {}; end;

local CreateFrame = CreateFrame;

nUI_Profile.nUI_MicroMenu = {};

local ProfileCounter = nUI_Profile.nUI_MicroMenu;

-------------------------------------------------------------------------------
-- create the MicroMenu bar frame

local frame      = CreateFrame( "Frame", "nUI_MicroMenu", nUI_TopBars.Anchor );

frame.Buttons     = {};

local function MicroButtonList(...)
    for i=1, select('#', ...) 
    do
        local button = select( i, ... );
        local name   = button:GetName();


        if name and name:match('(%w+)MicroButton$') 
        then table.insert( frame.Buttons, button );
        end
    end
end

MicroButtonList( _G['MainMenuBarArtFrame']:GetChildren() );

hooksecurefunc( 
	
	"UpdateMicroButtonsParent", 
	
	function() 
		if not InCombatLockdown() then
			for i in pairs( nUI_MicroMenu.Buttons ) do
	
				local button = frame.Buttons[i];
	
				button:SetParent( frame );
				button:SetMovable( true );		
				button:SetUserPlaced( true );	

			end
		end 
	end 
);

local lastScale = nil;

hooksecurefunc(

	"MoveMicroButtons",

	function()
		if frame.scale and not InCombatLockdown() then
			frame.btn_size = nil;
			nUI_MicroMenu.applyScale( frame.scale ); 
		end
	end
);

UpdateMicroButtonsParent( frame );

nUI_MicroMenu = frame;

-------------------------------------------------------------------------------
-- set the size of the bar and its elements

nUI_MicroMenu.applyScale = function( scale )
	
--	nUI_ProfileStart( ProfileCounter, "applyScale" );

	local options     = frame.options;
	local anchor      = scale and frame.anchor or nil;	
	local scale       = scale or frame.scale or 1;
	local btn_size    = options.btn_size * scale * nUI.vScale;
	local btn_gap     = options.btn_gap * scale * nUI.hScale;

	frame.scale = scale;

	if frame.btn_size ~= btn_size 
	or frame.btn_gap  ~= btn_gap
	then
			
		local firstButton = C_StorePublic.IsEnabled() and StoreMicroButton or EJMicroButton;
		local lastButton  = firstButton;
		local width       = 0;
		
		for i in pairs(frame.Buttons) do
			
			local button    = frame.Buttons[i];
			local btnWidth  = button:GetWidth();
			local btn_scale = btn_size / btnWidth;
			
			if button:IsShown() then

				if i == 1 then 
					width = (btnWidth+0.6) * btn_scale;
				else
					width = width + (btnWidth+0.6) * btn_scale + btn_gap;
				end
			end
			
			button:SetMovable( true );
			button:SetUserPlaced( true );
			button:ClearAllPoints();
			button:SetScale( btn_scale  );			

		end

		firstButton:SetPoint( "BOTTOMLEFT", frame, "BOTTOMLEFT", 3 * scale * nUI.hScale, 3 * scale * nUI.vScale );				

		for i in pairs(frame.Buttons) do
			
			local button = frame.Buttons[i];
			
			if button ~= firstButton and button:IsShown() then 
				button:SetPoint( "LEFT", lastButton, "RIGHT", btn_gap, 0 );
				lastButton = button;
			end

		end		

		frame:SetHeight( btn_size + 6 * scale * nUI.vScale );
		frame:SetWidth( width + 6 * scale * nUI.hScale );

	end
	
--	nUI_ProfileStop();



end

-------------------------------------------------------------------------------
-- set the location of the bar

nUI_MicroMenu.applyAnchor = function( anchor )

	if anchor or nUI_MicroMenu.anchor then
		
		local anchor      = anchor or nUI_MicroMenu.anchor;
		local xOfs        = (anchor.xOfs or 0) * nUI.hScale;
		local yOfs        = (anchor.yOfs or 0) * nUI.vScale;
		local anchor_pt   = anchor.anchor_pt or "CENTER";
		local relative_to = anchor.relative_to or nUI_MicroMenu:GetParent() or UIParent;
		local relative_pt = anchor.relative_pt or anchor_pt;
	
		nUI_MicroMenu.anchor = anchor;
		
		if nUI_MicroMenu.anchor_pt   ~= anchor.anchor_pt
		or nUI_MicroMenu.relative_to ~= anchor.relative_to
		or nUI_MicroMenu.relative_pt ~= anchor.relative_pt
		or nUI_MicroMenu.xOfs        ~= xOfs
		or nUI_MicroMenu.yOfs        ~= yOfs
		then
		
			nUI_MicroMenu.anchor_pt   = anchor.anchor_pt;
			nUI_MicroMenu.relative_to = anchor.relative_to;
			nUI_MicroMenu.realtive_pt = anchor.relative_pt;
			nUI_MicroMenu.xOfs        = xOfs;
			nUI_MicroMenu.yOfs        = yOfs;


			if nUI_MoverFrames[nUI_MicroMenu] then 
				nUI_MoverFrames[nUI_MicroMenu].ClearAllPoints( nUI_MicroMenu );
				nUI_MoverFrames[nUI_MicroMenu].SetPoint( nUI_MicroMenu, anchor_pt, relative_to, relative_pt, xOfs, yOfs );			
				
			else 
				nUI_MicroMenu:ClearAllPoints();	
				nUI_MicroMenu:SetPoint( anchor_pt, relative_to, relative_pt, xOfs, yOfs );
			end			
		end	
	end
end

-------------------------------------------------------------------------------
-- set the bar options

nUI_MicroMenu.applyOptions = function( options )
	
--	nUI_ProfileStart( ProfileCounter, "applyOptions" );
	
	if options then
		
		frame.options = options;
		
		nUI_MicroMenu:SetFrameStrata( options.strata or nUI_TopBars:GetFrameStrata() );
		nUI_MicroMenu:SetFrameLevel( options.layer or nUI_TopBars:GetFrameLevel()+2 );		

		if options.enabled ~= "no" then
			frame:Show();
		else
			frame:Hide();
		end
		
		if options.background then
			
			local backdrop_color = options.background.color.backdrop;
			local border_color   = options.background.color.border;
			
			frame:SetBackdrop( options.background.backdrop );
			frame:SetBackdropColor( backdrop_color.r, backdrop_color.g, backdrop_color.b, backdrop_color.a );
			frame:SetBackdropBorderColor( border_color.r, border_color.g, border_color.b, border_color.a );		
				
			for i in pairs( frame.Buttons ) do
				
				local button = frame.Buttons[i];
				
				button:SetFrameStrata( frame:GetFrameStrata() );
				button:SetFrameLevel( frame:GetFrameLevel()+1 );
				button:SetScale( options.btn_size / 36 );
			
			end
			
		else
			
			frame:SetBackdrop( nil );
			
		end
		
		frame.applyScale( options.scale or frame.scale or 1 );    
	end
	
--	nUI_ProfileStop();
	
end

-------------------------------------------------------------------------------
-- bar event management

local function onMicroMenuEvent( who, event, arg1 )

--	nUI_ProfileStart( ProfileCounter, "onMicroMenuEvent", event );
	
	if event == "ADDON_LOADED" then
		
		if arg1 == "nUI" then
			nUI:setScale();
			nUI_MicroMenu:configBar();
		end

	-- 5.4.2 Added to restore Blizzard Layout settings in case user stops using nUI
	elseif event == "PLAYER_LOGOUT" then
		for i in pairs( frame.Buttons ) do
			local button = frame.Buttons[i]	
			button:SetUserPlaced( false )
		end

	else
			
		if nUI_MoverFrames[frame] then nUI_Movers:lockFrame( frame, false ); end
		
		frame.applyOptions( nUI_MicroMenuOptions.options );
		frame.applyAnchor( nUI_MicroMenuOptions.anchor );
		
		nUI_Movers:lockFrame( frame, true, nUI_L["Micro-Menu"] );
		
		frame:UnregisterEvent( "PLAYER_ENTERING_WORLD" );
		
	end
	
--	nUI_ProfileStop();
	
end

frame:SetScript( "OnEvent", onMicroMenuEvent );
frame:RegisterEvent( "ADDON_LOADED" );
frame:RegisterEvent( "PLAYER_ENTERING_WORLD" );
frame:RegisterEvent( "PLAYER_LOGOUT" )					-- 5.4.2 Added

-------------------------------------------------------------------------------

function nUI_MicroMenu:configBar( use_default )
	
--	nUI_ProfileStart( ProfileCounter, "configBar" );
	
	local default = nUI_DefaultConfig.MicroMenu;
	local config  = nUI_MicroMenuOptions or {};
	
	if not config.anchor then config.anchor = {}; end
	if not config.options then config.options = {}; end
	
	if use_default then
		
		config.anchor.anchor_pt   = default.anchor.anchor_pt;
		config.anchor.relative_to = default.anchor.relative_to;
		config.anchor.relative_pt = default.anchor.relative_pt;
		config.anchor.xOfs        = default.anchor.xOfs;
		config.anchor.yOfs        = default.anchor.yOfs;
		
		config.options.enabled  = default.options.enabled;
		config.options.strata   = default.options.strata;
		config.options.level    = default.options.level;
		config.options.scale    = default.options.scale;
		config.options.btn_size = default.options.btn_size;
		config.options.btn_gap  = default.options.btn_gap;

		if default.options.background then
			
			if not config.options.background then config.options.background = {}; end
			if not config.options.background.backdrop then config.options.background.backdrop = {}; end
			if not config.options.background.backdrop.insets then config.options.background.backdrop.insets = {}; end
			if not config.options.background.color then config.options.background.color = {}; end
			if not config.options.background.color.border then config.options.background.color.border = {}; end
			if not config.options.background.color.backdrop then config.options.background.color.backdrop = {}; end
			
			config.options.background.backdrop.bgFile   = default.options.background.backdrop.bgFile;
			config.options.background.backdrop.edgeFile = default.options.background.backdrop.edgeFile;
			config.options.background.backdrop.tile     = default.options.background.backdrop.tile;
			config.options.background.backdrop.tileSize = default.options.background.backdrop.tileSize;
			config.options.background.backdrop.edgeSize = default.options.background.backdrop.edgeSize;
			
			config.options.background.backdrop.insets.left   = default.options.background.backdrop.insets.left;
			config.options.background.backdrop.insets.right  = default.options.background.backdrop.insets.right;
			config.options.background.backdrop.insets.top    = default.options.background.backdrop.insets.top;
			config.options.background.backdrop.insets.bottom = default.options.background.backdrop.insets.bottom;
			
			config.options.background.color.border.r = default.options.background.color.border.r;
			config.options.background.color.border.g = default.options.background.color.border.g;
			config.options.background.color.border.b = default.options.background.color.border.b;
			config.options.background.color.border.a = default.options.background.color.border.a;
			
			config.options.background.color.backdrop.r = default.options.background.color.backdrop.r;
			config.options.background.color.backdrop.g = default.options.background.color.backdrop.g;
			config.options.background.color.backdrop.b = default.options.background.color.backdrop.b;
			config.options.background.color.backdrop.a = default.options.background.color.backdrop.a;
			
		else
			
			config.options.background = nil;
			
		end		
	else
		
		config.anchor.anchor_pt   = strupper( default.anchor.anchor_pt or config.anchor.anchor_pt );
		config.anchor.relative_to = default.anchor.relative_to or config.anchor.relative_to;
		config.anchor.relative_pt = strupper( default.anchor.relative_pt or config.anchor.relative_pt );
		config.anchor.xOfs        = tonumber( default.anchor.xOfs or config.anchor.xOfs );
		config.anchor.yOfs        = tonumber( default.anchor.yOfs or config.anchor.yOfs );
		
		config.options.enabled  = strlower( default.options.enabled or config.options.enabled );
		config.options.strata   = strupper( default.options.strata or config.options.strata );
		config.options.level    = tonumber( default.options.level or config.options.level );
		config.options.scale    = tonumber( default.options.scale or config.options.scale );
		config.options.btn_size = tonumber( default.options.btn_size or config.options.btn_size );
		config.options.btn_gap  = tonumber( default.options.btn_gap or config.options.btn_gap );

		if (not nUI_MicroMenuOptions and default.options.background)
		or (nUI_MicroMenuOptions and nUI_MicroMenuOptions.options.background)
		then
			
			if not config.options.background then config.options.background = {}; end
			if not config.options.background.backdrop then config.options.background.backdrop = {}; end
			if not config.options.background.backdrop.insets then config.options.background.backdrop.insets = {}; end
			if not config.options.background.color then config.options.background.color = {}; end
			if not config.options.background.color.border then config.options.background.color.border = {}; end
			if not config.options.background.color.backdrop then config.options.background.color.backdrop = {}; end
			
			config.options.background.backdrop.bgFile   = default.options.background.backdrop.bgFile or config.options.background.backdrop.bgFile;
			config.options.background.backdrop.edgeFile = default.options.background.backdrop.edgeFile or config.options.background.backdrop.edgeFile;
			config.options.background.backdrop.tile     = default.options.background.backdrop.tile or config.options.background.backdrop.tile;
			config.options.background.backdrop.tileSize = tonumber( default.options.background.backdrop.tileSize or config.options.background.backdrop.tileSize );
			config.options.background.backdrop.edgeSize = tonumber( default.options.background.backdrop.edgeSize or config.options.background.backdrop.edgeSize );
			
			config.options.background.backdrop.insets.left   = tonumber( default.options.background.backdrop.insets.left or config.options.background.backdrop.insets.left );
			config.options.background.backdrop.insets.right  = tonumber( default.options.background.backdrop.insets.right or config.options.background.backdrop.insets.right );
			config.options.background.backdrop.insets.top    = tonumber( default.options.background.backdrop.insets.top or config.options.background.backdrop.insets.top );
			config.options.background.backdrop.insets.bottom = tonumber( default.options.background.backdrop.insets.bottom or config.options.background.backdrop.insets.bottom );
			
			config.options.background.color.border.r = tonumber( default.options.background.color.border.r or config.options.background.color.border.r );
			config.options.background.color.border.g = tonumber( default.options.background.color.border.g or config.options.background.color.border.g );
			config.options.background.color.border.b = tonumber( default.options.background.color.border.b or config.options.background.color.border.b );
			config.options.background.color.border.a = tonumber( default.options.background.color.border.a or config.options.background.color.border.a );
			
			config.options.background.color.backdrop.r = tonumber( default.options.background.color.backdrop.r or config.options.background.color.backdrop.r );
			config.options.background.color.backdrop.g = tonumber( default.options.background.color.backdrop.g or config.options.background.color.backdrop.g );
			config.options.background.color.backdrop.b = tonumber( default.options.background.color.backdrop.b or config.options.background.color.backdrop.b );
			config.options.background.color.backdrop.a = tonumber( default.options.background.color.backdrop.a or config.options.background.color.backdrop.a );

		else
			
			config.options.background = nil;
			
		end
	end		
	
	nUI_MicroMenuOptions = config;

	frame.applyOptions( config.options );
	frame.applyAnchor( config.anchor );
	
--	nUI_ProfileStop();
	
end
