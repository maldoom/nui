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

if not nUI_DefaultConfig then nUI_DefaultConfig = {}; end
if not nUI_Profile then nUI_Profile = {}; end;

local CreateFrame           = CreateFrame;
local GetNumShapeshiftForms = GetNumShapeshiftForms;

nUI_Profile.nUI_SpecialBars = {};

local ProfileCounter = nUI_Profile.nUI_SpecialBars;

-------------------------------------------------------------------------------

local anchor     = CreateFrame( "Frame", "nUI_SpecialBarEvents", WorldFrame );
local background = CreateFrame( "Frame", "nUI_SpecialBarsBackground", nUI_Dashboard.Anchor );
local frame      = CreateFrame( "Frame", "nUI_SpecialBars", nUI_Dashboard.Anchor, "SecureHandlerStateTemplate" );

background:SetAllPoints( frame );

-------------------------------------------------------------------------------

local scaledFrame = false;

frame.applyScale = function( scale )
	
--	nUI_ProfileStart( ProfileCounter, "applyScale" );
	
	local anchor  = scale and frame.anchor or nil;
	local scale   = scale or frame.scale or 1;
	local options = frame.options;
	
	if options then
		
		local btn_hSize = options.btn_size * scale * nUI.hScale;
		local btn_vSize = options.btn_size * scale * nUI.vScale;
		local btn_hGap  = (options.btn_gap or 0) * scale * nUI.hScale;		
		local btn_vGap  = (options.btn_gap or 0) * scale * nUI.vScale;		
		local hInset    = (options.inset or 0) * scale * nUI.hScale;
		local vInset    = (options.inset or 0) * scale * nUI.vScale;
		local blockGap  = (options.blockGap or 0) * scale * nUI.hScale;
		local bars      = 0;
	
		if frame.btn_hSize ~= btn_hSize 
		or frame.btn_vSize ~= btn_vSize 
		or frame.btn_hGap  ~= btn_hGap
		or frame.btn_vGap  ~= btn_vGap
		or frame.hInset    ~= hInset
		or frame.vInset    ~= vInset
		then
			
			frame.btn_hSize = btn_hSize;
			frame.btn_vSize = btn_vSize;
			frame.btn_hGap  = btn_hGap;
			frame.btn_vGap  = btn_vGap;
			frame.hInset    = hInset;
			frame.vInset    = vInset;
				
			frame:SetAttribute( "nUI_hInset", hInset );
			frame:SetAttribute( "nUI_vInset", vInset );
			frame:SetAttribute( "nUI_btnHsize", btn_hSize );
			frame:SetAttribute( "nUI_btnVsize", btn_vSize );
			frame:SetAttribute( "nUI_btnHgap", btn_hGap );
			frame:SetAttribute( "nUI_btnVgap", btn_vGap );
			frame:SetAttribute( "nUI_blockGap", blockGap );
			
			nUI_PetBar.applyScale( scale );
			nUI_PossessBar.applyScale( scale );
			nUI_ShapeshiftBar.applyScale( scale );
			
			MainMenuBarVehicleLeaveButton:SetHeight( frame.btn_vSize );
			MainMenuBarVehicleLeaveButton:SetWidth( frame.btn_hSize );
			
		end

		frame.layoutBar();
		
	end
	
	if anchor then frame.applyAnchor(); end
	
--	nUI_ProfileStop();
	
end

-------------------------------------------------------------------------------

frame.applyAnchor = function( anchor )
	
--	nUI_ProfileStart( ProfileCounter, "applyAnchor" );
	
	local anchor      = anchor or frame.anchor or {};
	local anchor_pt   = anchor.anchor_pt or "CENTER";
	local relative_to = anchor.relative_to or frame:GetParent():GetName();
	local relative_pt = anchor.relative_pt or anchor_pt;
	local xOfs        = (anchor.xOfs or 0) * nUI.hScale;
	local yOfs        = (anchor.yOfs or 0) * nUI.vScale;
	local hInset      = frame.hInset;
	local vInset      = frame.vInset;
	local hGap        = frame.btn_hGap;
	
	if scaledFrame then
		
		if frame.anchor_pt   ~= anchor_pt
		or frame.relative_to ~= relative_to
		or frame.relative_pt ~= relative_pt
		or frame.xOfs        ~= xOfs
		or frame.yOfs        ~= yOfs
		then
			
			frame.anchor_pt   = anchor_pt;
			frame.relative_to = relative_to;
			frame.relative_pt = relative_pt;
			frame.xOfs        = xOfs;
			frame.yOfs        = yOfs;

			if nUI_MoverFrames[frame] then	
				nUI_MoverFrames[frame].ClearAllPoints( frame );
				nUI_MoverFrames[frame].SetPoint( frame, anchor_pt, relative_to, relative_pt, xOfs, yOfs );
			else
				frame:ClearAllPoints();
				frame:SetPoint( anchor_pt, relative_to, relative_pt, xOfs, yOfs );
				nUI_Movers:lockFrame( frame, true, nUI_L["Pet/Stance/Shapeshift Bar"] );
			end		
		end
	end
		
	if nUI_ShapeshiftBar and hInset and vInset then
		nUI_ShapeshiftBar:ClearAllPoints();
		nUI_ShapeshiftBar:SetPoint( "TOPLEFT", frame, "TOPLEFT", hInset, -vInset );
	end
	
	if nUI_PossessBar and hInset and vInset then
		nUI_PossessBar:ClearAllPoints();
		nUI_PossessBar:SetPoint( "TOPRIGHT", frame, "TOPRIGHT", -hInset, -vInset );
	end
	
	if nUI_PetBar and hInset and vInset then
		nUI_PetBar:ClearAllPoints();
		nUI_PetBar:SetPoint( "TOPRIGHT", frame, "TOPRIGHT", -hInset, -vInset );
	end
		
--	nUI_ProfileStop();
	
end

-------------------------------------------------------------------------------

frame.applyOptions = function( options )

--	nUI_ProfileStart( ProfileCounter, "applyOptions" );
	
	frame.options = options;
	
	if not options or not options.enabled then
		
		nUI_PetBar.applyOptions( nil );
		nUI_ShapeshiftBar.applyOptions( nil );
		nUI_PossessBar.applyOptions( nil );
		
		frame.enabled = false;
		UnregisterStateDriver( frame, "specialbars" );
		frame:Hide();
		
	else

		background:SetFrameStrata( options.strata or frame:GetParent():GetFrameStrata() );
		background:SetFrameLevel( options.level or frame:GetParent():GetFrameLevel()+1 );
		
		frame:SetFrameStrata( background:GetFrameStrata() );
		frame:SetFrameLevel( background:GetFrameLevel()+1 );

		nUI_PetBar.applyOptions( frame.options );
		nUI_ShapeshiftBar.applyOptions( frame.options );
		nUI_PossessBar.applyOptions( frame.options );
		
		frame.enabled = true;
	
		frame.applyScale( options.scale or frame.scale or 1 );
		
		if options.border then
			
			local border_color   = options.border.border_color;
			local backdrop_color = options.border.backdrop_color;
			
			frame:SetBackdrop( options.border.backdrop );
			frame:SetBackdropColor( backdrop_color.r, backdrop_color.g, backdrop_color.b, backdrop_color.a );
			frame:SetBackdropBorderColor( border_color.r, border_color.g, border_color.b, border_color.a );
			
		end
		
		if options.background then
			
			local border_color   = options.background.border_color;
			local backdrop_color = options.background.backdrop_color;
			
			background:SetBackdrop( options.background.backdrop );
			background:SetBackdropColor( backdrop_color.r, backdrop_color.g, backdrop_color.b, backdrop_color.a );
			background:SetBackdropBorderColor( border_color.r, border_color.g, border_color.b, border_color.a );
			
		end

		RegisterStateDriver( frame, "specialbars", "[bonusbar:5] 1; [target=pet, exists] 2; [target=vehicle, exists] 2; 3" );
		
	end

--	nUI_ProfileStop();
	
end

-------------------------------------------------------------------------------

frame.applySkin = function( skin )
	
--	nUI_ProfileStart( ProfileCounter, "applySkin" );
	
	frame.skin = skin.SpecialBars or nUI_DefaultConfig.SpecialBars;
	
	if not frame.skin or not frame.skin.enabled then
		
		frame.enabled = false;		
		UnregisterStateDriver( frame, "specialbars" );
		frame:Hide();
	
	else
		
		frame.enabled = true;
		
		frame.applyOptions( frame.skin.options );
		frame.applyAnchor( frame.skin.anchor );
		
	end
	
--	nUI_ProfileStop();
	
end

-------------------------------------------------------------------------------

frame.layoutBar = function()

--	nUI_ProfileStart( ProfileCounter, "layoutBar" );
	
	if frame.options and frame.options.enabled and not InCombatLockdown() then
		
		-- if there's a possession bar, then everything else is hidden
		
		local hInset = frame.hInset;
		local vInset = frame.vInset;
		local hGap   = frame.btn_hGap;
		local vSize  = frame.btn_vSize;
		local forms  = GetNumShapeshiftForms();
		local width  = max( nUI_PossessBar:GetWidth(), nUI_PetBar:GetWidth() ) + nUI_ShapeshiftBar:GetWidth();
	
		frame:SetAttribute( "nUI_numforms", forms );

		-- set the size of the special bar frame
		
		if not InCombatLockdown() then
				
			if width == 0 then
				frame:Hide();
			else
				scaledFrame = true;
				frame:SetWidth( width + hInset * 2 );
				frame:SetHeight( vSize + vInset * 2 );
				frame:Show();
			end
		end
	end	
	
--	nUI_ProfileStop();
	
end

-------------------------------------------------------------------------------
-- manage the layout of the bar

anchor:SetScript( "OnEvent", 

	function( who, event, arg1 ) 

--		nUI_ProfileStart( ProfileCounter, "OnEvent" );
	
		-- initializs the skinner
		
		if event == "ADDON_LOADED" then
			
			if arg1 == "nUI" then
				
				nUI:registerScalableFrame( frame );
				nUI:registerSkinnedFrame( frame );

				frame:SetFrameRef( "nUI_PetBar", nUI_PetBar );
				frame:SetFrameRef( "nUI_ShapeshiftBar", nUI_ShapeshiftBar );
				frame:SetFrameRef( "nUI_PossessBar", nUI_PossessBar );
			
				-- add the vehicle dismount button to the end of the bar
				
				MainMenuBarVehicleLeaveButton:SetParent( nUI_ActionBar );
				MainMenuBarVehicleLeaveButton:ClearAllPoints();
				MainMenuBarVehicleLeaveButton:SetPoint( "LEFT", nUI_SpecialBars, "RIGHT", 5, 0 );
				
				nUI_Movers:lockFrame( MainMenuBarVehicleLeaveButton, true, nil );
				
				frame:Execute(
					[[		
						nUI_PetBar         = self:GetFrameRef( "nUI_PetBar" );
						nUI_PossessBar     = self:GetFrameRef( "nUI_PossessBar" );
						nUI_ShapeshiftBar  = self:GetFrameRef( "nUI_ShapeshiftBar" );
					]]
				);
				
				frame:SetAttribute( 
					"_onstate-specialbars", 
					[[
						-- if there's a possession bar, then everything else is hidden
						
						frame = self;
						hInset = frame:GetAttribute( "nUI_hInset" ) or 0;
						vInset = frame:GetAttribute( "nUI_vInset" ) or 0;
						hGap   = frame:GetAttribute( "nUI_btnHgap" ) or 0;
						vSize  = frame:GetAttribute( "nUI_btnVsize" ) or 39;
						forms  = frame:GetAttribute( "nUI_numforms" ) or 0;
						blkGap = frame:GetAttribute( "nUI_blockGap" ) or 0;
						width  = max( nUI_PossessBar:GetWidth(), nUI_PetBar:GetWidth() ) + nUI_ShapeshiftBar:GetWidth();
						
						-- set the size of the special bar frame
						
						if width == 0 then
							frame:Hide();
						else
							frame:SetWidth( width + hInset * 2 );
							frame:SetHeight( vSize + vInset * 2 );
							frame:Show();
						end
					]]
				);        
			end
								
		else

			if arg1 == "player" then
				frame.layoutBar();
			end
			
		end
		
--		nUI_ProfileStop();
		
	end 
);

anchor:RegisterEvent( "ADDON_LOADED" );
anchor:RegisterEvent( "PET_BAR_UPDATE" );
anchor:RegisterEvent( "PLAYER_CONTROL_GAINED" );
anchor:RegisterEvent( "PLAYER_CONTROL_LOST" );
anchor:RegisterEvent( "PLAYER_ENTERING_WORLD" );
anchor:RegisterEvent( "PLAYER_FARSIGHT_FOCUS_CHANGED" );
anchor:RegisterEvent( "UPDATE_BONUS_ACTIONBAR" );
anchor:RegisterEvent( "UPDATE_SHAPESHIFT_FORMS" );
anchor:RegisterEvent( "UNIT_PET" );
anchor:RegisterEvent( "UNIT_FLAGS" );

local mouseoverTimer = 1 / nUI_DEFAULT_FRAME_RATE;

local function onSpecialBarUpdate( who, elapsed )

	if nUI_Options.barMouseover then
	
		mouseoverTimer = mouseoverTimer - elapsed;		
		frame:SetAlpha( MouseIsOver( frame ) and 1 or 0 );
		
	end	
end

anchor:SetScript( "OnUpdate", onSpecialBarUpdate );
