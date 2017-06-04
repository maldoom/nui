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

local CreateFrame = CreateFrame;

nUI_Profile.nUI_PossessBar = {};

local ProfileCounter = nUI_Profile.nUI_PossessBar;

-------------------------------------------------------------------------------
-- the possess bar frame

local anchor     = CreateFrame( "Frame", "nUI_PossessBarEvents", WorldFrame );
local frame      = CreateFrame( "Frame", "nUI_PossessBar", nUI_Dashboard.Anchor, "SecureFrameTemplate" );

RegisterStateDriver( frame, "visibility", "[bonusbar:5] show; hide" );

-------------------------------------------------------------------------------
-- button initialization

frame.Buttons = {};

for i=1,10 do

	local button            = CreateFrame( "CheckButton", "$parent_Button"..i, frame, "PossessButtonTemplate" );	
	local btn_name          = button:GetName();
	frame.Buttons[i]        = button;	
	button.enabled          = true;
	button.layers           = {};
	button.layers.icon      = _G[btn_name.."Icon"];
	button.layers.cooldown  = _G[btn_name.."Cooldown"];
	
	button:SetID( i );
	button:SetChecked( false );
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
				button:ClearAllPoints();
				button:SetHeight( btn_vSize );
				button:SetWidth( btn_hSize );
				button:SetScale( 1 );
--				button:SetScale( btn_size / button:GetHeight() );
				
				if i == 1 then button:SetPoint( "TOPLEFT", frame, "TOPLEFT", 0, 0 );
				else button:SetPoint( "LEFT", frame.Buttons[i-1], "RIGHT", btn_hGap, 0 );
				end
				
			end
						
			local width = btn_hSize * NUM_POSSESS_SLOTS + btn_hGap * (NUM_POSSESS_SLOTS-1);
			
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

	if index <= NUM_POSSESS_SLOTS then
		
		local texture, name = GetPossessInfo( index );
	
		button:SetChecked( false );
		button.layers.icon:SetTexture( texture );	
		button.layers.icon:SetVertexColor( 1.0, 1.0, 1.0 );
	
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
-- manage the layout of the Possess Bar

anchor:SetScript( "OnEvent", 

	function( who, event ) 

--		nUI_ProfileStart( ProfileCounter, "OnEvent", event );
	
		if event == "PLAYER_ENTERING_WORLD"
		or event == "UPDATE_BONUS_ACTIONBAR"
		then
			
			frame.applyScale();
			
		end
		
		-- update the bar
		
		for i=1, #frame.Buttons do
			frame.updateState( i );				
		end
		
--		nUI_ProfileStop();
		
	end 
);

anchor:RegisterEvent( "PLAYER_ENTERING_WORLD" );
anchor:RegisterEvent( "PLAYER_AURAS_CHANGED" );
anchor:RegisterEvent( "UPDATE_BONUS_ACTIONBAR" );
anchor:RegisterEvent( "SPELL_UPDATE_COOLDOWN" );
anchor:RegisterEvent( "SPELL_UPDATE_USABLE" );
