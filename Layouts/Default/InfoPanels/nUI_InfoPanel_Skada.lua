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
local GetTime     = GetTime;

-------------------------------------------------------------------------------
-- default configuration for the Skada info panel

nUI_InfoPanels[nUI_INFOPANEL_SKADA] =
{	
	enabled   = false,
	desc      = nUI_L[nUI_INFOPANEL_SKADA],				-- player friendly name/description of the panel
	label     = nUI_L[nUI_INFOPANEL_SKADA.."Label"],	-- label to use on the panel selection button face
	rotation  = nUI_INFOMODE_SKADA,						-- index or position this panel appears on/in when clicking the selector button
	full_size = true;									-- this plugin requires the entire info panel port without the button bag
	
	options  =
	{
		enabled  = false,
	},
};

-------------------------------------------------------------------------------
-- master frame for the plugin

local plugin   = CreateFrame( "Frame", nUI_INFOPANEL_SKADA, nUI_Dashboard.Anchor );
plugin.enabled = false;
plugin.doInit  = false;
plugin.active  = false;

local function onSkadaEvent( who, event, arg1 )

	if event == "ADDON_LOADED" and arg1 == "nUI" then
	
		if not IsAddOnLoaded( "Skada" ) then 
			LoadAddOn( "Skada" );
		end
		
		if IsAddOnLoaded( "Skada" ) then
			plugin.active  = true;
			plugin.enabled = true;
			plugin.doInit  = true;
		end
		
	elseif event == "ADDON_LOADED" and arg1 == "Skada" then
		
		plugin.active  = true;
		plugin.enabled = true;
		plugin.doInit  = true;

	elseif event == "PLAYER_ENTERING_WORLD" then
	
		plugin:UnregisterEvent( "PLAYER_ENTERING_WORLD" );
							
		plugin.setEnabled( IsAddOnLoaded( "Skada" ) );
		
	end	
	
end

plugin:SetScript( "OnEvent", onSkadaEvent );
plugin:RegisterEvent( "ADDON_LOADED" );
plugin:RegisterEvent( "PLAYER_ENTERING_WORLD" );
-------------------------------------------------------------------------------

plugin.initPanel = function( container, options )

	plugin.container = container;
	plugin.options   = options;

	if options and options.enabled then
	end
end

-------------------------------------------------------------------------------

plugin.sizeChanged = function( scale, height, width )
	
	local options  = plugin.options;
	local windows  = Skada and Skada:GetWindows() or {};
	local window1  = nil;
	local window2  = nil;
	local count    = 0;
	
	plugin.scale  = scale;
	plugin.height = height;
	plugin.width  = width;
	
	-- find the two key nUI windows
	
	for i,win in ipairs( windows ) do
	
		if win.db.name == "nUI_Skada1" then 
			window1 = win; 
			count   = count+1; 
		end
		if win.db.name == "nUI_Skada2" then 
			window2 = win; 
			count   = count+1;
		end		
	end
	
	if not window1 and window2 then
		window1 = window2;
		window2 = nil;
	end

	if window1 then	

		window1.bargroup:ClearAllPoints();
		window1.bargroup:SetPoint( "TOPLEFT", plugin.container, "TOPLEFT", 2, 0 );
		window1.db.barwidth = width / count * 0.975;
		window1.db.barheight = height / 11;
		window1.db.barslocked = not nil;
		window1.db.background.height = height;
		
		if plugin.initWindows then
			Skada.db.profile.hidedisables = nil;
			Skada:RestoreView( window1, nil, "Damage" );
			window1.db.modeincombat = "Threat";
			window1.db.returnaftercombat = not nil;
		end
		
	end
	
	if window2 then

		window2.db.barwidth = width / count * 0.975;
		window2.db.background.height = height;
		window2.db.barheight = height / 11;
		window2.db.barslocked = not nil;
		window2.bargroup:SetPoint( "TOPRIGHT", plugin.container, "TOPRIGHT", -2, 0 );
		
		if plugin.initWindows then
			Skada:RestoreView( window2, nil, "DPS" );
			window2.db.modeincombat = "DPS";
			window2.db.returnaftercombat = not nil;
		end
	end
	
	if plugin.enabled then Skada:ApplySettings(); end

	plugin.initWindows = false;
	
end	

-------------------------------------------------------------------------------

plugin.setEnabled = function( enabled )

	local windows = Skada and Skada:GetWindows() or {};
	enabled       = Skada and enabled or false;		
	
    if plugin.doInit or plugin.enabled ~= enabled then		
		doInit = true;
		
		plugin.enabled = enabled;
		
		if not enabled then

			for i, win in ipairs( windows ) do
   
				if win.bargroup.saved_bar_parent then

					win.bargroup:SetParent( win.bargroup.saved_bar_parent );					
					win.bargroup.saved_bar_parent = nil;
					
				end
			end
			
		else

			-- have we already defined Skada windows for use with nUI?

			local matched = false;			
			local window1 = nil;
			local window2 = nil;

			for i,win in ipairs( windows ) do	
				if win.db.name == "nUI_Skada1" then
					window1 = win;
				end
				if win.db.name == "nUI_Skada2" then
					window2 = win;
				end
			end
			
			if not window1 then
				plugin.initWindows = true;
				Skada:CreateWindow( "nUI_Skada1" );
			end
				
			if not window2 then
				plugin.initWindows = true;
				Skada:CreateWindow( "nUI_Skada2" );
			end
								
			windows = Skada:GetWindows();
			
			-- reparent the windows
			
			for i, win in ipairs( windows ) do
   
				if i == 1 then
				
					win.bargroup.saved_bar_parent = win.bargroup:GetParent();
					win.bargroup:SetParent( nUI_BlizUI );
					
				elseif not win.bargroup.saved_bar_parent then

					win.bargroup.saved_bar_parent = win.bargroup:GetParent();
					win.bargroup:SetParent( plugin.container );					
					
				end
			end	
			
			if plugin.scale and plugin.height and plugin. width then
				plugin.sizeChanged( plugin.scale, plugin.height, plugin.width )
			end
					
		end				
	end			
end

-------------------------------------------------------------------------------

plugin.setSelected = function( selected )

	if selected ~= plugin.selected then

		plugin.selected = selected;
		
		if selected then
			
			
		else
			
			
		end
	end
end
