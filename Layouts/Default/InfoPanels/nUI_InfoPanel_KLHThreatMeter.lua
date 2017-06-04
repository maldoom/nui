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
-- default configuration for the KLH Threat Meter info panel

nUI_InfoPanels[nUI_INFOPANEL_KLH] =
{	
	enabled   = true,
	desc      = nUI_L[nUI_INFOPANEL_KLH],				-- player friendly name/description of the panel
	label     = nUI_L[nUI_INFOPANEL_KLH.."Label"],		-- label to use on the panel selection button face
	rotation  = nUI_INFOMODE_KLH,						-- index or position this panel appears on/in when clicking the selector button
	full_size = true;									-- this plugin requires the entire info panel port without the button bag
	
	options  =
	{
		enabled  = true,
	},
};

-------------------------------------------------------------------------------
-- master frame for the plugin

local plugin    = CreateFrame( "Frame", nUI_INFOPANEL_KLH, nUI_Dashboard.Anchor );
plugin.active   = true;

local function onKLHEvent( who, event, arg1 )
	
	if event == "ADDON_LOADED" and arg1 == "nUI" then
		
		if not IsAddOnLoaded( "KLHThreatMeter" ) then 
			LoadAddOn( "KLHThreatMeter" );
		end
		
		plugin.active = IsAddOnLoaded( "KLHThreatMeter" );

	end	
	
end

plugin:SetScript( "OnEvent", onKLHEvent );
plugin:RegisterEvent( "ADDON_LOADED" );

-------------------------------------------------------------------------------

plugin.initPanel = function( container, options )

	plugin.container = container;
	plugin.options   = options;

	if options and options.enabled then
			
		plugin.setEnabled( true );
		
	end
end

-------------------------------------------------------------------------------

plugin.sizeChanged = function( scale, height, width )
	
	local options  = plugin.options;
	local kframe   = plugin.kframe;
	
	plugin.scale = scale;

--	nUI_Movers:lockFrame( kframe.table, false, nil );
	kframe.table:ClearAllPoints();
	kframe.table:SetPoint( "TOPLEFT", plugin.container, "TOPLEFT", 0, 0 );
	kframe.table:SetPoint( "BOTTOMLEFT", plugin.container, "BOTTOMLEFT", 0, 0 );
--	nUI_Movers:lockFrame( kframe.table, true, nil );
			
end	

-------------------------------------------------------------------------------

plugin.setEnabled = function( enabled )

	if plugin.enabled ~= enabled then
		
		plugin.enabled = enabled;
		
		if not enabled then

			local kframe = plugin.kframe;
			
			if kframe.saved_parent then
				
--				nUI_Movers:lockFrame( kframe.table, false, nil );
				
				kframe:SetParent( kframe.saved_parent );
				kframe:SetBackdropColor( kframe.backdrop_color );
				kframe:SetBackdropBorderColor( kframe.border_color );
				
				kframe.header.options:SetParent( kframe.header );
				kframe.header.options:ClearAllPoints();
				kframe.header.options:SetPoint( kframe.option_pt );
				
				kframe.header.setmt:SetParent( kframe.header );
				kframe.header.setmt:ClearAllPoints();
				kframe.header.setmt:SetPoint( kframe.setmt_pt );
				
				kframe.Show       = kframe.cachedShow;
				kframe.Hide       = kframe.cachedHide;
				kframe.table.Show = kframe.table.cachedShow;
				kframe.table.Hide = kframe.table.cachedHide;
				
			end
		else

			local kframe = klhtm.raidtable.instances[1].gui;

			plugin.kframe = kframe;
			
			if not kframe.saved_parent then
				
				kframe.saved_parent   = kframe:GetParent();
				kframe.backdrop_color = kframe:GetBackdropColor();
				kframe.border_color   = kframe:GetBackdropBorderColor();

			end
			
			kframe:SetParent( plugin.container );
			kframe:SetScale( 1 );
			
			-- move the options and master target to the info selection button so
			-- the user has easy access to them
			
			kframe.option_pt = kframe.header.options:GetPoint( 1 );
			kframe.header.options:SetParent( kframe.table );
			kframe.header.options:ClearAllPoints();
			kframe.header.options:SetScale( 0.8 );
			kframe.header.options:SetPoint( "TOPRIGHT", plugin.container, "TOPRIGHT", -1, -1 )
			kframe.header.options:Show();
			
			kframe.setmt_pt = kframe.header.setmt:GetPoint( 1 );
			kframe.header.setmt:SetParent( kframe.table );
			kframe.header.setmt:ClearAllPoints();
			kframe.header.setmt:SetScale( 0.8 );
			kframe.header.setmt:SetPoint( "TOP", kframe.header.options, "BOTTOM", 0, -1 )
			kframe.header.setmt:Show();
			
			-- the KTM header is wasted space now, so lose it

			kframe.header:Hide();
			
			kframe.cachedShow = kframe.Show;
			kframe.cachedHide = kframe.Hide;
			
			kframe.header.Show = function() end;
			kframe.header.Hide = function() end;
			
			-- posistion the threat table over the stats frame
			
			kframe.table:SetBackdropColor( 0, 0, 0, 0 );
			kframe.table:SetBackdropBorderColor( 0, 0, 0, 0 );
			
			kframe.table:Show();
			
			kframe.table.cachedShow = kframe.table.Show;
			kframe.table.cachedHide = kframe.table.Hide;
			
			kframe.table.Show = function() end;
			kframe.table.Hide = function() end;

--			nUI_Movers:lockFrame( kframe.table, true, nil );
			
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
