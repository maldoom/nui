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

if not nUI_Profile then nUI_Profile = {}; end;

local CreateFrame         = CreateFrame;
local GetPetActionInfo    = GetPetActionInfo;
local GetPetActionsUsable = GetPetActionsUsable;
local RegisterStateDriver = RegisterStateDriver;
local SetDesaturation     = SetDesaturation;
local UnitIsUnit          = UnitIsUnit;

nUI_Profile.nUI_PetBar = {};

local ProfileCounter = nUI_Profile.nUI_PetBar;

-------------------------------------------------------------------------------
-- the pet bar frame

local anchor     = CreateFrame( "Frame", "nUI_PetBarEvents", WorldFrame );
local frame      = CreateFrame( "Frame", "nUI_PetBar", nUI_Dashboard.Anchor, "SecureFrameTemplate" );

RegisterStateDriver( frame, "visibility", "[target=vehicle, exists] hide; [target=pet, exists] show; hide" );

-------------------------------------------------------------------------------
-- button initialization

frame.Buttons = {};

for i=1, NUM_PET_ACTION_SLOTS do

	local button            = CreateFrame( "CheckButton", "$parent_Button"..i, frame, "PetActionButtonTemplate" );	
	local btn_name          = button:GetName();
	frame.Buttons[i]        = button;	
	button.enabled          = true;
	button.layers           = {};
	button.layers.icon      = _G[btn_name.."Icon"];
	button.layers.cooldown  = _G[btn_name.."Cooldown"];
	button.layers.castable  = _G[btn_name.."AutoCastable"];
	button.layers.autocast  = _G[btn_name.."Shine"];	
	button.actionType       = "BONUSACTIONBUTTON";
	button.actionID         = i;
	
	button:SetID( i );
	button:SetNormalTexture( "" );
	frame:SetAttribute( "addchild", button );

	button.SetNormalTexture = function() end;	
	
	button.layers.castable:Show();
	button.layers.autocast:Show();
	
end

-------------------------------------------------------------------------------

frame.applyScale = function( scale )
	
--	nUI_ProfileStart( ProfileCounter, "applyScale" );
	
	local scale   = scale or frame.scale or 1;
	local options = frame.options;
	
	if options and options.enabled then
		
		local btn_hSize = options.btn_size * scale * nUI.hScale;
		local btn_vSize = options.btn_size * scale * nUI.vScale;
		local btn_hGap  = (options.btn_gap or 0) * scale * nUI.hScale;
		local btn_vGap  = (options.btn_gap or 0) * scale * nUI.vScale;
		
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
				button:SetHeight( btn_vSize );
				button:SetWidth( btn_hSize );
				button:SetScale( 1 );

				button.layers.castable:SetHeight( btn_vSize * 2 );
				button.layers.castable:SetWidth( btn_hSize * 2 );

				button.layers.autocast:SetHeight( btn_vSize * 0.8 );
				button.layers.autocast:SetWidth( btn_hSize * 0.8 );
				
--				button:SetScale( btn_size / button:GetHeight() );
				
				if i == 1 then button:SetPoint( "TOPLEFT", frame, "TOPLEFT", 0, 0 );
				else button:SetPoint( "LEFT", frame.Buttons[i-1], "RIGHT", btn_hGap, 0 );
				end
				
			end
						
			local width = btn_hSize * NUM_PET_ACTION_SLOTS + btn_hGap * (NUM_PET_ACTION_SLOTS-1);
			
			if frame.width ~= width then
				frame.width = width;
				frame:SetHeight( btn_vSize );
				frame:SetWidth( width );
				frame:SetAttribute( "nUI_Width", width );
			end			
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
	
	local button = frame.Buttons[index];
	local petActionsUsable = GetPetActionsUsable();
	local name, subtext, texture, isToken, isActive, 
	      autoCastAllowed, autoCastEnabled = GetPetActionInfo( index );
	
	if not isToken then
		button.layers.icon:SetTexture( texture );
		button.tooltipName = name;
	else
		button.layers.icon:SetTexture( getglobal( texture ) );
		button.tooltipName = getglobal( name );
	end
	
	button.isToken        = isToken;
	button.tooltipSubtext = subtext;
	
	if isActive then button:SetChecked( true );
	else button:SetChecked( false );
	end
	
	if name then 

		if not button.enabled then			
			button.enabled = true;
			button:SetAlpha( 1 );
		end
		
		if autoCastAllowed then button.layers.castable:SetAlpha( 1 ); 
		else button.layers.castable:SetAlpha( 0 ); 
		end
		
		if autoCastEnabled then AutoCastShine_AutoCastStart( button.layers.autocast );
		else AutoCastShine_AutoCastStop( button.layers.autocast );
		end
		
		if texture then
			
			if petActionsUsable then
				SetDesaturation( button.layers.icon, nil );
			else
				SetDesaturation( button.layers.icon, 1 );
			end
			
			button.layers.icon:SetAlpha( 1 );
			
		else
			
			button.layers.icon:SetAlpha( 0 );
			
		end

	elseif button.enabled then

		button.enabled = false;
		button:SetAlpha( 0 );
		button.layers.castable:SetAlpha( 0 );
--		button.layers.autocast:SetAlpha( 0 );
		button.layers.icon:SetAlpha( 0 );
		
	end	
	
--	nUI_ProfileStop();
	
end

-------------------------------------------------------------------------------
-- manage the layout of the bar

anchor:SetScript( "OnEvent", 

	function( who, event, arg1 ) 

--		nUI_ProfileStart( ProfileCounter, "OnEvent", event );
	
		local update_state = false;
		
		if event == "UNIT_PET" 
		then
			
			if UnitIsUnit( arg1, "player" ) 
			then update_state = true;
			end
			
		elseif event == "UNIT_FLAGS"
		or     event == "UNIT_AURA"
		then
			
			if UnitIsUnit( arg1, "pet" )
			then update_state = true;
			end
			
		else
			
			update_state = true;

		end
		
		if update_state then
			for i=1, #frame.Buttons do
				frame.updateState( i );
			end
		end		
		
		if event == "PLAYER_ENTERING_WORLD"
		or event == "PET_BAR_UPDATE"
		then
			
			frame.applyScale();
			
		end
		
--		nUI_ProfileStop();
		
	end 
);

anchor:RegisterEvent( "PLAYER_ENTERING_WORLD" );
anchor:RegisterEvent( "PLAYER_CONTROL_LOST" );
anchor:RegisterEvent( "PLAYER_CONTROL_GAINED" );
anchor:RegisterEvent( "PLAYER_FARSIGHT_FOCUS_CHANGED" );
anchor:RegisterEvent( "PET_BAR_UPDATE" );
anchor:RegisterEvent( "UNIT_PET" );
anchor:RegisterEvent( "UNIT_FLAGS" );
anchor:RegisterEvent( "UNIT_AURA" );
