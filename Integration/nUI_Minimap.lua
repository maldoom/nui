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

nUI_Profile.nUI_Minimap = {};

local ProfileCounter = nUI_Profile.nUI_Minimap;

nUI_Options.minimap = true;

-------------------------------------------------------------------------------
-- master frame for minimap management

local background = CreateFrame( "Frame", "nUI_MinimapManagerBackground", nUI_Dashboard.Anchor );
local frame      = CreateFrame( "Frame", "nUI_MinimapManager", nUI_Dashboard.Anchor, "SecureHandlerStateTemplate" );

background:SetAllPoints( frame );

local hMapRatio = MinimapCluster:GetWidth() / Minimap:GetWidth();
local vMapRatio = MinimapCluster:GetHeight() / Minimap:GetHeight();

-------------------------------------------------------------------------------
-- event management

local function onMinimapEvent( who, event, arg1 )
	
--	nUI_ProfileStart( ProfileCounter, "onMinimapEvent", event );
	
	if event == "ADDON_LOADED" and arg1 == "nUI" then

		nUI:registerSkinnedFrame( frame );
		nUI:registerScalableFrame( frame );
	
		-- set up a slash command handler for choosing the minimap shape
		
		local option = nUI_SlashCommands[nUI_SLASHCMD_ROUNDMAP];
		
		nUI_SlashCommands:setHandler( option.command,
			
			function( msg, arg1 )
				
				nUI_Options.round_map = not nUI_Options.round_map;
				
				DEFAULT_CHAT_FRAME:AddMessage( (option.message):format( nUI_Options.round_map and nUI_L["round"] or nUI_L["square"] ), 1, 0.83, 0 );

				if nUI_Options.round_map then
					Minimap:SetMaskTexture( frame.options.round_mask or "Interface\\AddOns\\nUI\\Layouts\\Default\\Art\\nUI_RoundMinimapMask" );
				else
					Minimap:SetMaskTexture( frame.options.square_mask or "Interface\\AddOns\\nUI\\Layouts\\Default\\Art\\nUI_SquareMinimapMask" );
				end
			end
		);				
	
		-- set up a slash command handler for choosing whether or not nUI will manage the minimap
		
		local option = nUI_SlashCommands[nUI_SLASHCMD_MINIMAP];
		
		nUI_SlashCommands:setHandler( option.command,
			
			function( msg, arg1 )
				
				nUI_Options.minimap = not nUI_Options.minimap;
				
				DEFAULT_CHAT_FRAME:AddMessage( (option.message):format( nUI_Options.minimap and nUI_L["|cFF00FF00ENABLED|r"] or nUI_L["|cFFFF0000DISABLED|r"] ), 1, 0.83, 0 );

				ReloadUI();

			end
		);		
	
		-- let the user know if we're managing the minimap or not
		
		DEFAULT_CHAT_FRAME:AddMessage( (option.message):format( nUI_Options.minimap and nUI_L["|cFF00FF00ENABLED|r"] or nUI_L["|cFFFF0000DISABLED|r"] ), 1, 0.83, 0 );
	
	-- lay out the minimap on the dashboard
	
	elseif event == "PLAYER_ENTERING_WORLD" then
	
		-- create the show/hide logic for the minimap frame... if we have a focus frame, then we hide the minimap
		-- frame, otherwise, the minimap frame is visible
		
		frame:SetAttribute( "unit", "focus" );

		frame:SetAttribute( "_onstate-unitexists",
			[[
				if UnitExists( "focus" )
				then self:Hide();
				else self:Show();
				end
			]]
		);
		
		-- we only need to do this once
		
		frame:UnregisterEvent( "PLAYER_ENTERING_WORLD" );
		
	end		
	
--	nUI_ProfileStop();
	
end

frame:SetScript( "OnEvent", onMinimapEvent );
frame:RegisterEvent( "ADDON_LOADED" );
frame:RegisterEvent( "PLAYER_ENTERING_WORLD" );

-------------------------------------------------------------------------------

frame.applyScale = function( scale )
	
--	nUI_ProfileStart( ProfileCounter, "applyScale" );
	
	local anchor   = scale and frame.anchor or nil;
	local scale    = scale or frame.scale or 1;
	local options  = frame.options;
	
	if options then
	
		local height   = options.height * scale * nUI.vScale;
		local width    = options.width * scale * nUI.hScale;
		local mHeight  = (options.mapHeight or (options.height * 0.9)) * scale * nUI.vScale;
		local mWidth   = (options.mapWidth or (options.width * 0.9)) * scale * nUI.hScale;

		if frame.width    ~= width
		or frame.height   ~= height
		or frame.mHeight  ~= mHeight
		or frame.mWidth   ~= mWidth
		then

			frame.height   = height;
			frame.width    = width;
			frame.mHeight  = mHeight;
			frame.mWidth   = mWidth;
			
			frame:SetHeight( height );
			frame:SetWidth( width );
				
			nUI_Movers:lockFrame( MinimapCluster, false, nil );
			
			MinimapCluster:SetScale( mHeight / Minimap:GetHeight() );
			
			local xCluster, yCluster = MinimapCluster:GetCenter();
			local xMap, yMap         = Minimap:GetCenter();
			local xOfs               = xCluster - xMap;
			local yOfs               = yCluster - yMap;
			
			MinimapCluster:ClearAllPoints();
			MinimapCluster:SetPoint( "CENTER", frame, "CENTER", xOfs / MinimapCluster:GetScale(), yOfs / MinimapCluster:GetScale() );
			
			nUI_Movers:lockFrame( MinimapCluster, true, nil );
			
		end
	end

--	nUI_ProfileStop();
	
end

-------------------------------------------------------------------------------

frame.applyAnchor = function( anchor )
	
--	nUI_ProfileStart( ProfileCounter, "applyAnchor" );
	
	local anchor = anchor or frame.anchor or {};
	local anchor_pt   = anchor.anchor_pt or "CENTER";
	local relative_to = anchor.relative_to or frame:GetParent():GetName();
	local relative_pt = anchor.relative_pt or anchor_pt;
	local xOfs        = (anchor.xOfs or 0) * nUI.hScale;
	local yOfs        = (anchor.yOfs or 0) * nUI.vScale;
	
	frame.anchor = anchor;
	
	if frame.xOfs ~= xOfs
	or frame.yOfs ~= yOfs
	or frame.anchor_pt ~= anchor_pt
	or frame.relative_to ~= relative_to
	or frame.relative_pt ~= relative_pt
	then
		
		frame.anchor_pt   = anchor_pt;
		frame.relative_to = relative_to;
		frame.relative_pt = relative_pt;
		frame.xOfs        = xOfs;
		frame.yOfs        = yOfs;
		
		frame:ClearAllPoints();
		frame:SetPoint( anchor_pt, relative_to, relative_pt, xOfs, yOfs );
		
	end

--	nUI_ProfileStop();
	
end

-------------------------------------------------------------------------------

frame.applyOptions = function( options )
	
--	nUI_ProfileStart( ProfileCounter, "applyOptions" );
	
	frame.options = options;
	
	if not options 
	or not options.enabled 
	or not nUI_Options.minimap
	then
		
--		nUI:debug( "nUI_Minimap: minimap manager is disabled", 1 );
		
		frame:SetAlpha( 0 );
		
	else
	
--		nUI:debug( "nUI_Minimap: minimap manager is enabled", 1 );

		nUI_ResetWatchFrame();
		
		if UnitExists( "focus" ) 
		then frame:Hide();
		else frame:Show();
		end
		
		background:SetFrameStrata( options.strata or frame:GetParent():GetFrameStrata() );
		background:SetFrameLevel( frame:GetParent():GetFrameLevel() + (options.level or 1) );
		
		frame:SetFrameStrata( background:GetFrameStrata() );
		frame:SetFrameLevel( background:GetFrameLevel()+1 );
		frame:SetAlpha( 1 );
		
		-- if there's a border, set it
		
		if options.border then
				
			local border_color = options.border.color.border;
			local backdrop_color = options.border.color.backdrop;
			
			frame:SetBackdrop( options.border.backdrop );
			frame:SetBackdropBorderColor( border_color.r, border_color.g, border_color.b, border_color.a );
			frame:SetBackdropColor( backdrop_color.r, backdrop_color.g, backdrop_color.b, backdrop_color.a );
	
		else 
			
			frame:SetBackdrop( nil );
			
		end
		
		-- if there's a background, set it
		
		if options.background then
				
			local border_color = options.background.color.border;
			local backdrop_color = options.background.color.backdrop;
			
			background:SetBackdrop( options.background.backdrop );
			background:SetBackdropBorderColor( border_color.r, border_color.g, border_color.b, border_color.a );
			background:SetBackdropColor( backdrop_color.r, backdrop_color.g, backdrop_color.b, backdrop_color.a );
	
		else 
			
			background:SetBackdrop( nil );
			
		end

		-- okay -- now attach the minimap to the frame
		
		MinimapCluster:EnableMouse( false );
		MinimapCluster:SetParent( frame );
		MinimapCluster:SetFrameStrata( frame:GetFrameStrata() );
		MinimapCluster:SetFrameLevel( frame:GetFrameLevel()+1 );
	
		MinimapCluster:SetMovable( true );
		MinimapCluster:StartMoving()
		MinimapCluster:StopMovingOrSizing()
		
		nUI_Movers:lockFrame( MinimapCluster, true, nil );
	
		MinimapBorder:SetParent( nUI.BlizUI );
		MinimapBorderTop:SetParent( nUI.BlizUI );
		
		if MinimapToggleButton then
			MinimapToggleButton:SetParent( nUI.BlizUI );
		end
		
		MinimapZoneTextButton:SetParent( nUI.BlizUI );

		MiniMapMailFrame:SetParent( Minimap );
		MiniMapMailFrame:SetScale( 0.8 );
		MiniMapMailFrame:ClearAllPoints();
		MiniMapMailFrame:RegisterForDrag();
		MiniMapMailFrame:SetScript( "OnDragStart", nil );
		MiniMapMailFrame:SetScript( "OnDragStop", nil );
		MiniMapMailFrame:SetPoint( "BOTTOMLEFT", MiniMapTracking, "TOPRIGHT", 4, -12 );
		MiniMapMailFrame:SetFrameStrata( Minimap:GetFrameStrata() );
		MiniMapMailFrame:SetFrameLevel( Minimap:GetFrameLevel()+5 );
		
		
		-- 5.0.1 Change start
		QueueStatusMinimapButton:SetParent( Minimap );
		QueueStatusMinimapButton:SetScale( 0.8 );
		QueueStatusMinimapButton:ClearAllPoints();
		QueueStatusMinimapButton:RegisterForDrag();
		QueueStatusMinimapButton:SetScript( "OnDragStart", nil );
		QueueStatusMinimapButton:SetScript( "OnDragStop", nil );
		QueueStatusMinimapButton:SetPoint( "BOTTOM", Minimap, "TOP", 0, -10 );
		QueueStatusMinimapButton:SetFrameStrata( Minimap:GetFrameStrata() );
		QueueStatusMinimapButton:SetFrameLevel( Minimap:GetFrameLevel()+5 );
		--MiniMapBattlefieldFrame:SetParent( Minimap );
		--MiniMapBattlefieldFrame:SetScale( 0.8 );
		--MiniMapBattlefieldFrame:ClearAllPoints();
		--MiniMapBattlefieldFrame:RegisterForDrag();
		--MiniMapBattlefieldFrame:SetScript( "OnDragStart", nil );
		--MiniMapBattlefieldFrame:SetScript( "OnDragStop", nil );
		--MiniMapBattlefieldFrame:SetPoint( "BOTTOMRIGHT", MiniMapWorldMapButton, "TOPLEFT", 2, -12 );
		--MiniMapBattlefieldFrame:SetFrameStrata( Minimap:GetFrameStrata() );
		--MiniMapBattlefieldFrame:SetFrameLevel( Minimap:GetFrameLevel()+5 );
		--MiniMapLFGFrame:SetParent( Minimap );
		--MiniMapLFGFrame:SetScale( 0.8 );
		--MiniMapLFGFrame:ClearAllPoints();
		--MiniMapLFGFrame:RegisterForDrag();
		--MiniMapLFGFrame:SetScript( "OnDragStart", nil );
		--MiniMapLFGFrame:SetScript( "OnDragStop", nil );
		--MiniMapLFGFrame:SetPoint( "BOTTOM", Minimap, "TOP", 0, -10 );
		--MiniMapLFGFrame:SetFrameStrata( Minimap:GetFrameStrata() );
		--MiniMapLFGFrame:SetFrameLevel( Minimap:GetFrameLevel()+5 );
		-- 5.0.1 Change End
		
		MiniMapWorldMapButton:SetParent( Minimap );
		MiniMapWorldMapButton:SetScale( 0.8 );
		MiniMapWorldMapButton:ClearAllPoints();
		MiniMapWorldMapButton:RegisterForDrag();
		MiniMapWorldMapButton:SetScript( "OnDragStart", nil );
		MiniMapWorldMapButton:SetScript( "OnDragStop", nil );
		MiniMapWorldMapButton:SetPoint( "TOPRIGHT", Minimap, "TOPRIGHT", 2, 1 );
		MiniMapWorldMapButton:SetFrameStrata( Minimap:GetFrameStrata() );
		MiniMapWorldMapButton:SetFrameLevel( Minimap:GetFrameLevel()+5 );
		
		MiniMapTracking:SetParent( Minimap );
		MiniMapTracking:SetScale( 0.65 );
		MiniMapTracking:ClearAllPoints();
		MiniMapTracking:RegisterForDrag();
		MiniMapTracking:SetScript( "OnDragStart", nil );
		MiniMapTracking:SetScript( "OnDragStop", nil );
		MiniMapTracking:SetPoint( "TOPLEFT", Minimap, "TOPLEFT", 0, 1 );
		MiniMapTracking:SetFrameStrata( Minimap:GetFrameStrata() );
		MiniMapTracking:SetFrameLevel( Minimap:GetFrameLevel()+5 );

		MinimapZoomIn:SetParent( Minimap );
		MinimapZoomIn:SetScale( 0.8 );
		MinimapZoomIn:RegisterForDrag();
		MinimapZoomIn:ClearAllPoints();
		MinimapZoomIn:SetScript( "OnDragStart", nil );
		MinimapZoomIn:SetScript( "OnDragStop", nil );
		MinimapZoomIn:SetPoint( "BOTTOMRIGHT", Minimap, "BOTTOMRIGHT", 1, -1 );
		MinimapZoomIn:SetFrameStrata( Minimap:GetFrameStrata() );
		MinimapZoomIn:SetFrameLevel( Minimap:GetFrameLevel()+5 );
	
		MinimapZoomOut:SetParent( Minimap );
		MinimapZoomOut:SetScale( 0.8 );
		MinimapZoomOut:ClearAllPoints();
		MinimapZoomOut:RegisterForDrag();
		MinimapZoomOut:SetScript( "OnDragStart", nil );
		MinimapZoomOut:SetScript( "OnDragStop", nil );
		MinimapZoomOut:SetPoint( "BOTTOMLEFT", Minimap, "BOTTOMLEFT", -1, -1 );
		MinimapZoomOut:SetFrameStrata( Minimap:GetFrameStrata() );
		MinimapZoomOut:SetFrameLevel( Minimap:GetFrameLevel()+5 );				

		frame.setGameTimeFrame();
		
		if MiniMapCompassRing then
			MiniMapCompassRing:ClearAllPoints();
			MiniMapCompassRing:SetParent( Minimap );
			MiniMapCompassRing:SetPoint( "CENTER", Minimap, "CENTER", 0, 0 );
		end
						
		Minimap:EnableMouseWheel( true );	
		
		if nUI_Options.round_map then
			Minimap:SetMaskTexture( frame.options.round_mask or "Interface\\AddOns\\nUI\\Layouts\\Default\\Art\\nUI_RoundMinimapMask" );
		else
			Minimap:SetMaskTexture( frame.options.square_mask or "Interface\\AddOns\\nUI\\Layouts\\Default\\Art\\nUI_SquareMinimapMask" );
		end
		
		Minimap:SetScript( "OnMouseWheel", function( self, arg1 )
			if arg1 > 0 then Minimap_ZoomIn();
			else Minimap_ZoomOut();
			end	
		end	);
			
		-- and size it all
		
		frame.applyScale( options.scale or frame.scale or 1 );
	end

--	nUI_ProfileStop();
	
end

-------------------------------------------------------------------------------

frame.setGameTimeFrame = function()
		
	GameTimeFrame:SetParent( Minimap );
	GameTimeFrame:SetScale( 0.55 );
	GameTimeFrame:ClearAllPoints();
	GameTimeFrame:RegisterForDrag();
	GameTimeFrame:SetScript( "OnDragStart", nil );
	GameTimeFrame:SetScript( "OnDragStop", nil );
	GameTimeFrame:SetPoint( "CENTER", Minimap, "BOTTOM", 0, -5 );
	GameTimeFrame:SetFrameStrata( Minimap:GetFrameStrata() );
	GameTimeFrame:SetFrameLevel( Minimap:GetFrameLevel()+1 );	
	GameTimeFrame:Show();
	
end

-------------------------------------------------------------------------------

frame.applySkin = function( skin )
	
--	nUI_ProfileStart( ProfileCounter, "applySkin" );
	
	local skin = skin and skin.Minimap or nUI_DefaultConfig.Minimap;
	
	if skin and skin.enabled then
		
--		nUI:debug( "nUI_Minimap: setting skin", 1 );
		
		frame.applyOptions( skin.options );
		frame.applyAnchor( skin.anchor );
		RegisterUnitWatch( frame, true );
	
	else
		
		UnregisterUnitWatch( frame );
		frame:SetScript( "OnUpdate", nil );
		frame:SetAlpha( 0 );
		
	end
	
--	nUI_ProfileStop();
	
end

function nUI_ResetWatchFrame()
			
	local objectiveFrame = WatchFrame or ObjectiveTrackerFrame;

	nUI_Options.movedWatchFrame = true;
	
	objectiveFrame:SetMovable( true );
	objectiveFrame:SetResizable( true );
	objectiveFrame:SetUserPlaced( true );
	objectiveFrame:StartMoving();
	objectiveFrame:StartSizing( "BOTTOMRIGHT" );
	
	objectiveFrame:ClearAllPoints();
	objectiveFrame:SetPoint( "TOPLEFT", nUI_TopBars, "BOTTOMLEFT", 30, 60 * nUI.vScale );
	objectiveFrame:SetHeight( 600 );
	objectiveFrame:SetWidth( 250 );

	objectiveFrame:StopMovingOrSizing();

	-- I hate this hack -- it's going to cause taint issues, I'm sure, but it's the only 
	-- way I have found, so far, to keep the "new & improved" ObjectiveTrackerFrame working

	--objectiveFrame.SetPoint = function() end;
	--objectiveFrame.ClearAllPoints = function() end;

end