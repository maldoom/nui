﻿--[[---------------------------------------------------------------------------

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

if not nUI_Options then nUI_Options = {}; end

local function onSplashEvent( who, event, arg1 )

	if event == "PLAYER_ENTERING_WORLD" then

		nUI.playerName = nUI.playerName or UnitName( "player" ) or "";
		nUI.realmName  = nUI.realmName or GetRealmName():trim() or "";
		
		if nUI_Options.show_splash then
			nUI_Options.show_splash = false;
			nUI_Splash_Title:SetText( nUI_L["splash title"]:format( "|cFF00FFFF"..nUI.playerName.."|r", nUI_Package, nUI_Version ) );
			nUI_Splash_Message:SetText( nUI_L["public info"] );
		else
			nUI_SplashFrame:Hide();							
			DEFAULT_CHAT_FRAME:AddMessage( "nUI: "..nUI_L["public info"], 0, 1.0, 0.50 );
		end	
		
		nUI_SplashFrame:UnregisterEvent( "PLAYER_ENTERING_WORLD" );
	end		
end

nUI_SplashFrame:SetScript( "OnEvent", onSplashEvent );
nUI_SplashFrame:RegisterEvent( "PLAYER_ENTERING_WORLD" );
