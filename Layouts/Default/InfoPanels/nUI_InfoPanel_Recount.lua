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
-- default configuration for the Recount info panel

nUI_InfoPanels[nUI_INFOPANEL_RECOUNT] =
{	
	enabled   = true,
	desc      = nUI_L[nUI_INFOPANEL_RECOUNT],			-- player friendly name/description of the panel
	label     = nUI_L[nUI_INFOPANEL_RECOUNT.."Label"],	-- label to use on the panel selection button face
	rotation  = nUI_INFOMODE_RECOUNT,					-- index or position this panel appears on/in when clicking the selector button
	full_size = true;									-- this plugin requires the entire info panel port without the button bag
	
	options  =
	{
		enabled  = true,
	},
};

-------------------------------------------------------------------------------
-- master frame for the plugin

local plugin    = CreateFrame( "Frame", nUI_INFOPANEL_RECOUNT, nUI_Dashboard.Anchor );
plugin.active   = true;

local function onRecountEvent( who, event, arg1 )
	
	if event == "ADDON_LOADED" and arg1 == "nUI" then
		
		if not IsAddOnLoaded( "Recount" ) then 
			LoadAddOn( "Recount" );
		end
		
		plugin.active = IsAddOnLoaded( "Recount" );

	end	
	
end

plugin:SetScript( "OnEvent", onRecountEvent );
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
	local rframe   = plugin.rframe;
	
	plugin.scale = scale;

	nUI_Movers:lockFrame( rframe, false, nil );
	Recount:LockWindows( false );

	rframe:SetWidth( width ); 
	rframe:SetHeight( height+10 ); 

	Recount:ResizeMainWindow();
	Recount:LockWindows( true );
	nUI_Movers:lockFrame( rframe, true, nil );
			
end	

-------------------------------------------------------------------------------

plugin.setEnabled = function( enabled )

	if plugin.enabled ~= enabled then
		
		plugin.enabled = enabled;
		
		if not enabled then

			local rframe = plugin.rframe;
			
			if rframe.saved_parent then

				nUI_Movers:lockFrame( rframe, false, nil );
				Recount:LockWindows( false );
				
				rframe:SetParent( rframe.saved_parent );
				rframe:SetBackdropBorderColor( rframe.border_color );
				rframe:SetBackdropColor( rframe.backdrop_color );

				rframe.Show = rframe.cachedShow;
				rframe.Hide = rframe.cachedHide;
				
			end
		
		else

			local rframe = Recount.MainWindow;
			
			plugin.rframe = rframe;
			
			if not rframe.saved_parent then
				rframe.saved_parent   = rframe:GetParent();
				rframe.border_color   = rframe:GetBackdropBorderColor();
				rframe.backdrop_color = rframe:GetBackdropColor();
			end
			
			rframe:SetParent( plugin.container );
			rframe:SetPoint( "TOPLEFT", plugin.container, "TOPLEFT", 0, 10 );
			rframe:SetPoint( "BOTTOMRIGHT", plugin.container, "BOTTOMRIGHT", 0, 0 );
			rframe:SetFrameStrata( plugin.container:GetFrameStrata() );
			rframe:SetFrameLevel( plugin.container:GetFrameLevel()+1 );
			rframe:SetBackdropBorderColor( 0, 0, 0, 1 );
			rframe:SetBackdropColor( 0, 0, 0, 0 );
			rframe:Show();
			
			rframe.CloseButton:Hide();			

			rframe.cachedShow = rframe.Show;
			rframe.cachedHide = rframe.Hide;
			
			rframe.Show = function() end;
			rframe.Hide = function() end;
			
			Recount:LockWindows( true );
			nUI_Movers:lockFrame( rframe, true, nil );
			
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
