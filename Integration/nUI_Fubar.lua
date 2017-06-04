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

nUI_Profile.nUI_Fubar = {};

local ProfileCounter = nUI_Profile.nUI_Fubar;

local function DetectFubarBars()
	
--	nUI_ProfileStart( ProfileCounter, "DetectFubarBars" );
	
	local	bar1 = FuBar:GetBottommostTopPanel();
	local	bar2 = FuBar:GetTopmostBottomPanel();
	
	if bar1 then bar1 = bar1.frame; end
	if bar2 then bar2 = bar2.frame; end
	
	-- bar 1 is located at the top of the screen

	nUI_TopBarsLocator:ClearAllPoints();
	
	if bar1 and bar1:GetAlpha() > 0 then 
		nUI_TopBarsLocator:SetPoint( "BOTTOM", bar1, "BOTTOM", 0, 0 );
	else
		nUI_TopBarsLocator:SetPoint( "BOTTOM", UIParent, "TOP", 0, 0 );
	end
	
	-- bar 2 is located at the bottom of the screen
	
	nUI_BottomBarsLocator:ClearAllPoints();
	
	if bar2 and bar2:GetAlpha() > 0 then
		nUI_BottomBarsLocator:SetPoint( "TOP", bar2, "TOP", 0, 0 );
	else
		nUI_BottomBarsLocator:SetPoint( "TOP", UIParent, "BOTTOM", 0, 0 );
	end
	
--	nUI_ProfileStop();
	
end

-------------------------------------------------------------------------------

local frame = CreateFrame( "Frame", "nUI_FubarEvents", WorldFrame )

local function onFubarEvent( who, event )

--	nUI_ProfileStart( ProfileCounter, "onFubarEvent", event );
	
	if event == "PLAYER_ENTERING_WORLD" then
		
		if IsAddOnLoaded( "Fubar" ) and FuBar then
			
			FuBar.nUI_OnUpdate_AutohideTop    = FuBar.OnUpdate_AutoHideTop;
			FuBar.nUI_OnUpdate_AutohideBottom = FuBar.OnUpdate_AutoHideBottom;
			FuBar.nUI_Update                  = FuBar.Update;
			FuBar.nUI_ToggleAutoHidingTop     = FuBar.ToggleAutoHidingTop;
			FuBar.nUI_ToggleAutoHidingBottom  = FuBar.ToggleAutoHidingBottom;
			FuBar.nUI_Panel_OnEnter           = FuBar.Panel_OnEnter;
			FuBar.nUI_Panel_OnLeave           = FuBar.Panel_OnLeave;
			
			FuBar.Panel_OnEnter = function( who, plugin )
				FuBar:nUI_Panel_OnEnter(plugin );
				DetectFubarBars();
			end;
			
			FuBar.Panel_OnLeave = function( who, plugin )
				FuBar:nUI_Panel_OnLeave( plugin );
				DetectFubarBars();
			end;
			
			FuBar.ToggleAutoHidingTop = function()
				FuBar:nUI_ToggleAutoHidingTop();
				DetectFubarBars();
			end;
			
			FuBar.ToggleAutoHidingBottom = function()
				FuBar:nUI_ToggleAutoHidingBottom();
				DetectFubarBars();
			end;
			
			FuBar.OnUpdate_AutoHideTop = function()
				FuBar:nUI_OnUpdate_AutohideTop();
				DetectFubarBars();
			end;
			
			FuBar.OnUpdate_AutoHideBottom = function()
				FuBar:nUI_OnUpdate_AutohideBottom();
				DetectFubarBars();
			end;
			
			FuBar.Update = function()
				FuBar:nUI_Update();
				DetectFubarBars();
			end;
			
			DetectFubarBars();
			
		end

		frame:UnregisterEvent( "PLAYER_ENTERING_WORLD" );	
	
	end

--	nUI_ProfileStop();
	
end

frame:SetScript( "OnEvent", onFubarEvent );
frame:RegisterEvent( "PLAYER_ENTERING_WORLD" );
