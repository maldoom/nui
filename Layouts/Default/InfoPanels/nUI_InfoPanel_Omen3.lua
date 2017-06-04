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
-- default configuration for the Omen3 info panel

nUI_InfoPanels[nUI_INFOPANEL_OMEN3] =
{	
	enabled   = true,
	desc      = nUI_L[nUI_INFOPANEL_OMEN3],				-- player friendly name/description of the panel
	label     = nUI_L[nUI_INFOPANEL_OMEN3.."Label"],	-- label to use on the panel selection button face
	rotation  = nUI_INFOMODE_OMEN3,						-- index or position this panel appears on/in when clicking the selector button
	full_size = true;									-- this plugin requires the entire info panel port without the button bag
	
	options  =
	{
		enabled  = true,
	},
};

-------------------------------------------------------------------------------
-- master frame for the plugin

local plugin    = CreateFrame( "Frame", nUI_INFOPANEL_OMEN3, nUI_Dashboard.Anchor );
plugin.active   = true;

local function onOmenEvent( who, event, arg1 )
	
	if event == "ADDON_LOADED" and arg1 == "nUI" then
		
		if not IsAddOnLoaded( "Omen" ) then 
			LoadAddOn( "Omen" );
		end
		
		plugin.active = IsAddOnLoaded( "Omen" );

	end	
	
end

plugin:SetScript( "OnEvent", onOmenEvent );
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
	
	plugin.scale = scale;

	Omen:ResizeBars()
	Omen:ReAnchorLabels()
	Omen:UpdateBars()

end	

-------------------------------------------------------------------------------

plugin.setEnabled = function( enabled )

	if plugin.enabled ~= enabled then
		
		plugin.enabled = enabled;
		
		if not enabled then

			if plugin.saved_bar_parent then

				nUI_Movers:lockFrame( Omen.Anchor, false, nil );
				
				Omen.Anchor.Show = Omen.Anchor.nUI_CachedShow;
				Omen.Grip.Show   = Omen.Grip.nUI_CachedShow;
				
				Omen.Anchor:SetParent( Omen.Anchor.saved_bar_parent );
				
				Omen.Anchor.saved_bar_parent = nil;
				
			end
			
		else

			if not plugin.saved_omen_parent then
				plugin.saved_omen_parent = Omen.Anchor:GetParent();
			end
			
			Omen.Anchor:SetParent( plugin.container );
			Omen.Anchor:ClearAllPoints();
			Omen.Anchor:SetAllPoints( plugin.container );
			
			nUI_Movers:lockFrame( Omen.Anchor, true, nil );

			Omen.Anchor.nUI_CachedShow = Omen.Anchor.Show;
			Omen.Grip.nUI_CachedShow   = Omen.Grip.Show;
			
			Omen.Anchor:Show();			
			Omen.Grip:Hide();
			
			Omen.Anchor.Hide = function() end;
			Omen.Grip.Show = function() end;

			Omen:ResizeBars()
			Omen:ReAnchorLabels()
			Omen:UpdateBars()
			
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
