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
if not nUI_InfoPanels then nUI_InfoPanels = {}; end

local CreateFrame = CreateFrame;
local MouseIsOver = MouseIsOver;

-------------------------------------------------------------------------------
-- default configuration for the minimap info panel

nUI_InfoPanels[nUI_INFOPANEL_MINIMAP] =
{	
	enabled   = true,
	desc      = nUI_L[nUI_INFOPANEL_MINIMAP],			-- player friendly name/description of the panel
	label     = nUI_L[nUI_INFOPANEL_MINIMAP.."Label"],	-- label to use on the panel selection button face
	rotation  = nUI_INFOMODE_MINIMAP,					-- index or position this panel appears on/in when clicking the selector button
	full_size = false;									-- this plugin requires the entire info panel port without the button bag
	
	options  =
	{
		enabled  = true,
	},
};

-------------------------------------------------------------------------------
-- master frame for the plugin

local plugin  = CreateFrame( "Frame", nUI_INFOPANEL_MINIMAP, nUI_Dashboard.Anchor );
plugin.active = true;

local function onMinimapEvent( who, event, arg1 )
	
	if event == "ADDON_LOADED" and arg1 == "nUI" then
	
		-- set up a slash command handler for choosing the minimap shape
		
		local option = nUI_SlashCommands[nUI_SLASHCMD_ROUNDMAP];
		
		nUI_SlashCommands:setHandler( option.command,
			
			function( msg, arg1 )
				
				nUI_Options.round_map = not nUI_Options.round_map;
				
				DEFAULT_CHAT_FRAME:AddMessage( (option.message):format( nUI_Options.round_map and nUI_L["round"] or nUI_L["square"] ), 1, 0.83, 0 );

				if nUI_Options.round_map then
					Minimap:SetMaskTexture( "Interface\\AddOns\\nUI\\Integration\\InfoPanels\\Art\\nUI_RoundMinimapMask" );
				else
					Minimap:SetMaskTexture( "Interface\\AddOns\\nUI\\Integration\\InfoPanels\\Art\\nUI_SquareMinimapMask" );
				end
			end
		);		
		
		
	elseif event == "PLAYER_ENTERING_WORLD" then

		if TimeManagerClockButton then
			TimeManagerClockButton:Hide();
		end
		
		plugin:UnregisterEvent( "PLAYER_ENTERING_WORLD" );
		
	end	
	
end

plugin:SetScript( "OnEvent", onMinimapEvent );
plugin:RegisterEvent( "ADDON_LOADED" );
plugin:RegisterEvent( "PLAYER_ENTERING_WORLD" );

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
	local xOfs     = MinimapCluster:GetLeft() - Minimap:GetLeft();
	local yOfs     = MinimapCluster:GetTop() - Minimap:GetTop();
	
	plugin.scale = scale;
			
	nUI_Movers:lockFrame( MinimapCluster, false, nil );
	
	MinimapCluster:ClearAllPoints();
	MinimapCluster:SetPoint( "TOPLEFT", plugin.container, "TOPLEFT", xOfs, yOfs );
	
	MinimapCluster:SetScale( height / Minimap:GetHeight() );
	
	nUI_Movers:lockFrame( MinimapCluster, true, nil );
	
end	

-------------------------------------------------------------------------------

plugin.setEnabled = function( enabled )

	if plugin.enabled ~= enabled then
		
		if not enabled then

			DEFAULT_CHAT_FRAME:AddMessage( nUI_L["The %s Info Panel plugin is a core plugin to nUI and cannot be disabled"]:format( nUI_L["Minimap"] ), 1, 0.83, 0 );
			
			enabled = true;
		end
		
		plugin.enabled = enabled;
		
		if nUI_Options.round_map then
			Minimap:SetMaskTexture( "Interface\\AddOns\\nUI\\Integration\\InfoPanels\\Art\\nUI_RoundMinimapMask" );
		else
			Minimap:SetMaskTexture( "Interface\\AddOns\\nUI\\Integration\\InfoPanels\\Art\\nUI_SquareMinimapMask" );
		end
		
		MinimapCluster:SetParent( plugin.container );
		MinimapCluster:SetFrameStrata( plugin.container:GetFrameStrata() );
		MinimapCluster:SetFrameLevel( plugin.container:GetFrameLevel()+1 );
	
		MinimapCluster:SetMovable( true );
		MinimapCluster:StartMoving()
		MinimapCluster:StopMovingOrSizing()	
		nUI_Movers:lockFrame( MinimapCluster, true, nil );
	
		MinimapBorder:SetParent( Minimap );
		MinimapBorder:Hide();

		MinimapBorderTop:Hide();
		MinimapToggleButton:Hide();
		MinimapZoneTextButton:Hide();
		
		MiniMapTracking:SetParent( Minimap );
		MiniMapTracking:SetScale( 0.55 );
		MiniMapTracking:ClearAllPoints();
		MiniMapTracking:RegisterForDrag();
		MiniMapTracking:SetScript( "OnDragStart", nil );
		MiniMapTracking:SetScript( "OnDragStop", nil );
		MiniMapTracking:SetPoint( "TOPLEFT", Minimap, "TOPLEFT", 5, -5 );
		
		MiniMapWorldMapButton:SetParent( Minimap );
		MiniMapWorldMapButton:SetScale( 0.7 );
		MiniMapWorldMapButton:ClearAllPoints();
		MiniMapWorldMapButton:RegisterForDrag();
		MiniMapWorldMapButton:SetScript( "OnDragStart", nil );
		MiniMapWorldMapButton:SetScript( "OnDragStop", nil );
		MiniMapWorldMapButton:SetPoint( "TOPRIGHT", Minimap, "TOPRIGHT", -5, -5 );

		MinimapZoomIn:SetParent( Minimap );
		MinimapZoomIn:SetScale( 0.7 );
		MinimapZoomIn:RegisterForDrag();
		MinimapZoomIn:ClearAllPoints();
		MinimapZoomIn:SetScript( "OnDragStart", nil );
		MinimapZoomIn:SetScript( "OnDragStop", nil );
		MinimapZoomIn:SetPoint( "BOTTOMRIGHT", Minimap, "BOTTOMRIGHT", -5, 5 );
	
		MinimapZoomOut:SetParent( Minimap );
		MinimapZoomOut:SetScale( 0.7 );
		MinimapZoomOut:ClearAllPoints();
		MinimapZoomOut:RegisterForDrag();
		MinimapZoomOut:SetScript( "OnDragStart", nil );
		MinimapZoomOut:SetScript( "OnDragStop", nil );
		MinimapZoomOut:SetPoint( "BOTTOMLEFT", Minimap, "BOTTOMLEFT", 5, 5 );

		MiniMapCompassRing:ClearAllPoints();
		MiniMapCompassRing:SetParent( Minimap );
		MiniMapCompassRing:SetPoint( "CENTER", Minimap, "CENTER", 0, 0 );
				
		Minimap:EnableMouseWheel( true );	
		
		Minimap:SetScript( "OnMouseWheel", function()
			if arg1 > 0 then Minimap_ZoomIn();
			else Minimap_ZoomOut();
			end	
		end	);
	
		Minimap:SetBackdrop( 
			{
				bgFile   = "Interface\\Tooltips\\UI-Tooltip-Background", 
				edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border", 
				tile     = true, 
				tileSize = 1, 
				edgeSize = 4, 
				insets   = { left = 0, right = 0, top = 0, bottom = 0 },
			}				
		);
		
		Minimap:SetBackdropColor( 0, 0, 0, 0.5 );
		
		-- relocate the zone text
		
		MinimapZoneText:ClearAllPoints();
		MinimapZoneText:Hide();
		MinimapZoneText:SetParent( Minimap );
		
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

-------------------------------------------------------------------------------

local index = 1;

function nUI_parseMinimap( frame )
	
	if not frame then 
		frame = MinimapCluster;
		nUI.MapFrames = {};
		nUI_DebugLog["map_frames"] = {};
	end
	
	local name = frame:GetName() or (frame.GetTexture and frame:GetTexture() or frame:GetObjectType() or "unnamed frame");
	
	table.insert( nUI.MapFrames, frame );
	table.insert( nUI_DebugLog["map_frames"], name );
	
	if name == "Model" then
		label = Minimap:CreateFontString( "nUI_MapLabel"..index, "OVERLAY" );
		label:SetPoint( "CENTER", frame, "CENTER", 0, 0 );
		label:SetJustifyH( "CENTER" );
		label:SetJustifyV( "MIDDLE" );
		label:SetFont( nUI_L["font1"], 12, "OUTLINE" );
		label:SetText( index );
		index = index+1;
	end
	
	if frame.GetChildren then
		
		local children = { frame:GetChildren() };
		
		for i,child in ipairs( children ) do
			nUI_parseMinimap( child );
		end
	end
end