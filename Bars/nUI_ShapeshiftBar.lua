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
local GetShapeshiftFormInfo = GetShapeshiftFormInfo;

nUI_Profile.nUI_ShapeshiftBar = {};

local ProfileCounter = nUI_Profile.nUI_ShapeshiftBar;

local isActive;
local isCastable;

-------------------------------------------------------------------------------
-- the shapeshift bar frame

local anchor     = CreateFrame( "Frame", "nUI_ShapeshiftBarEvents", WorldFrame );
local frame      = CreateFrame( "Frame", "nUI_ShapeshiftBar", nUI_Dashboard.Anchor, "SecureFrameTemplate" );

frame.num_forms  = -1; -- forces the frame to update the first time we look at it

RegisterStateDriver( frame, "visibility", "[bonusbar:5] hide; show" );

-------------------------------------------------------------------------------
-- button initialization

frame.Buttons = {};

for i=1,10 do

	-- 5.0.1 Change Start - Now using StanceTemplate rather than shapeshift
	--local button            = CreateFrame( "CheckButton", "$parent_Button"..i, frame, "ShapeshiftButtonTemplate" );
	local button            = CreateFrame( "CheckButton", "$parent_Button"..i, frame, "StanceButtonTemplate" );	
	-- 5.0.1 change End
	
	local btn_name          = button:GetName();
	frame.Buttons[i]        = button;
	button.enabled          = true;
	button.layers           = {};
	button.layers.icon      = _G[btn_name.."Icon"];
	button.layers.cooldown  = _G[btn_name.."Cooldown"];
	button.actionType       = "SHAPESHIFTBUTTON";
	button.actionID         = i;
	
	button:SetID( i );
	button:SetNormalTexture( "" );

	button.SetNormalTexture = function() end;	
	
	frame:SetAttribute( "addchild", button );		
	
end

-------------------------------------------------------------------------------

frame.applyScale = function( scale )
	
--	nUI_ProfileStart( ProfileCounter, "applyScale" );
	
	local scale   = scale or frame.scale or 1;
	local options = frame.options;
	
	if options and options.enabled then
		
		local btn_hSize   = options.btn_size * scale * nUI.hScale;
		local btn_vSize   = options.btn_size * scale * nUI.vScale;
		local btn_hGap    = (options.btn_gap or 0) * scale * nUI.hScale;
		local btn_vGap    = (options.btn_gap or 0) * scale * nUI.vScale;
		local num_buttons = GetNumShapeshiftForms();
		
		if frame.btn_hSize ~= btn_hSize 
		or frame.btn_vSize ~= btn_vSize
		or frame.btn_hGap  ~= btn_hGap
		or frame.btn_vGap  ~= btn_vGap
		then
			
			frame.btn_hSize = btn_hSize;
			frame.btn_vSize = btn_vSize;
			frame.btn_hGap  = btn_hGap;
			frame.btn_vGap  = btn_vGap;
			
			for i=1,#frame.Buttons do
				
				local button = frame.Buttons[i];
				
				button:ClearAllPoints();
				button:ClearAllPoints();
				button:SetHeight( btn_vSize );
				button:SetWidth( btn_hSize );
				button:SetScale( 1 );
--				button:SetScale( btn_size / button:GetHeight() );
			
				if i == 1 then button:SetPoint( "BOTTOMLEFT", frame, "BOTTOMLEFT", 0, 0 );
				else button:SetPoint( "LEFT", frame.Buttons[i-1], "RIGHT", btn_hGap, 0 );
				end
				
			end
		end
		
		-- show or hide the button based on how many shapeshift forms the player has
		
		for i=1,#frame.Buttons do
			
			local button = frame.Buttons[i];
			
			if i > num_buttons or not frame.enabled then 
				button:Hide();
				button:SetAlpha( 0 );
				button.enabled = false;
			else 
				button:Show();
				button:SetAlpha( 1 );
				button.enabled = true;
			end					
			
		end
		
		-- set the bar width based on how many buttons are visible
		
		local width = btn_hSize * num_buttons + btn_hGap * (num_buttons-1);
		
		if frame.width ~= width then
			frame.width = width;
			frame:SetHeight( btn_vSize );
			frame:SetWidth( width );
			frame:SetAttribute( "nUI_Width", width );
		end			
	end
	
--	nUI_ProfileStop();
	
end

-------------------------------------------------------------------------------

frame.applyOptions = function( options )

--	nUI_ProfileStart( ProfileCounter, "applyOptions" );
	
	frame.options = options;
	
	if options and options.enabled then

		frame:SetParent( nUI_SpecialBars );
		frame:SetFrameStrata( nUI_SpecialBars:GetFrameStrata() );
		frame:SetFrameLevel( nUI_SpecialBars:GetFrameLevel()+1 );
		
		for i=1, #frame.Buttons do
			
			local button = frame.Buttons[i];
			button:SetFrameStrata( frame:GetFrameStrata() );
			button:SetFrameLevel( frame:GetFrameLevel()+1 );
		end
		
		frame.enabled = true;
	
		frame.applyScale( options.scale or frame.scale or 1 );
		
	end
	
--	nUI_ProfileStop();
	
end

-------------------------------------------------------------------------------

frame.updateState = function( index )
	
--	nUI_ProfileStart( ProfileCounter, "updateState" );
	
	local button    = frame.Buttons[index];
	local num_forms = frame.num_forms;

	if index <= num_forms and frame.enabled then

		local texture, name, isActive, isCastable = GetShapeshiftFormInfo( index );
		button.layers.icon:SetTexture( texture );
			
		if ( isActive ) then button:SetChecked( true );
		else button:SetChecked( false );
		end
			
		if ( isCastable ) then button.layers.icon:SetVertexColor( 1.0, 1.0, 1.0 );
		else button.layers.icon:SetVertexColor( 0.4, 0.4, 0.4 );
		end
			
		local start, duration, enable = GetShapeshiftFormCooldown( index );
		
		if start and duration then
			-- Legion Update TJK
			--CooldownFrame_SetTimer( button.layers.cooldown, start, duration, enable );
			CooldownFrame_Set( button.layers.cooldown, start, duration, enable );
			-- Legion Update TJK
		end
	
		if not button.enabled then
			button.enabled = true;
			button:SetAlpha( 1 );
		end
		
	elseif button.enabled then
		
		button.enabled = false;
		button:SetAlpha( 0 );
		
	end		
	
--	nUI_ProfileStop();
	
end

-------------------------------------------------------------------------------
-- manage the layout of the bar

anchor:SetScript( "OnEvent", 

	function() 

--		nUI_ProfileStart( ProfileCounter, "OnEvent" );
	
		local num_forms = GetNumShapeshiftForms();			
		
		-- update the shapeshift bar if the number of forms changes... we use an update
		-- loop here to ensure the update happens the first time we are out of combat
		-- because we cannot update in combat or we'll taint

		if frame.num_forms ~= num_forms then
				
			frame.num_forms = num_forms;

			frame:SetScript( "OnUpdate", 
			
				function() 
					
					if not InCombatLockdown() then
						
						frame.enabled = num_forms and num_forms > 0;					
						frame.applyScale();
				
						for i=1, #frame.Buttons do
							frame.updateState( i );				
						end
						
						frame:SetScript( "OnUpdate", nil );
						
					end
				end
			);
		else
			for i=1, #frame.Buttons do
				frame.updateState( i );				
			end			
		end
		
--		nUI_ProfileStop();
		
	end 
);

anchor:RegisterEvent( "PLAYER_ENTERING_WORLD" );
anchor:RegisterEvent( "UPDATE_SHAPESHIFT_FORMS" );
anchor:RegisterEvent( "PLAYER_AURAS_CHANGED" );
anchor:RegisterEvent( "UPDATE_BONUS_ACTIONBAR" );
anchor:RegisterEvent( "UPDATE_SHAPESHIFT_FORM" );
anchor:RegisterEvent( "ACTIONBAR_PAGE_CHANGED" );
anchor:RegisterEvent( "UPDATE_SHAPESHIFT_USABLE" );
