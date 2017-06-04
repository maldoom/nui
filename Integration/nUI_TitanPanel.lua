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

nUI_Profile.nUI_TitanPanel = {};

local ProfileCounter      = nUI_Profile.nUI_TitanPanel;

-------------------------------------------------------------------------------

local frame = CreateFrame( "Frame", "nUI_TitanPanelEvents", WorldFrame );
local defaultMinimapSetting = false;

local function onTitanPanelEvent( who, event, ... )
	
	if event == "PLAYER_ENTERING_WORLD" and TitanUtils_GetBarAnchors then
	
		local topAnchor, bottomAnchor = TitanUtils_GetBarAnchors();
			
		nUI_TopBarsLocator:ClearAllPoints();
		nUI_TopBarsLocator:SetPoint( "TOPLEFT", topAnchor, "TOPLEFT", 0, 0 );
		nUI_TopBarsLocator:SetPoint( "BOTTOMLEFT", topAnchor, "TOPLEFT", 0, 0 );
		
		nUI_BottomBarsLocator:ClearAllPoints();
		nUI_BottomBarsLocator:SetPoint( "TOPLEFT", bottomAnchor, "BOTTOMLEFT", 0, 0 );
		nUI_BottomBarsLocator:SetPoint( "BOTTOMLEFT", bottomAnchor, "BOTTOMLEFT", 0, 0 );
		
		frame:UnregisterEvent( "PLAYER_ENTERING_WORLD" );

	elseif event == "VARIABLES_LOADED" and TitanUtils_MinimapAdjust then
	
		defaultMinimapSetting = TitanUtils_GetMinimapAdjust();
		
		TitanUtils_SetMinimapAdjust( false );
		
	elseif event == "PLAYER_LOGOUT" and TitanUtils_MinimapAdjust then
	
		TitanUtils_SetMinimapAdjust( defaultMinimapSetting );
		
	end	
end

frame:SetScript( "OnEvent", onTitanPanelEvent );

frame:RegisterEvent( "PLAYER_LOGOUT" );
frame:RegisterEvent( "PLAYER_ENTERING_WORLD" );
frame:RegisterEvent( "VARIABLES_LOADED" );
