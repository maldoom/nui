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

nUI_Profile.nUI_ChocolateBar = {};

local ProfileCounter = nUI_Profile.nUI_ChocolateBar;
local ChocolateBar = nil;

local function DetectChocolateBar_Bars()
	
--	nUI_ProfileStart( ProfileCounter, "DetectChocolateBar_Bars" );
	
	local temptop = {};
	local tempbottom = {};
	local chocolateBars = {};
	local ChocolateLowestTopBar = nil;
	local ChocolateHighestBottomBar = nil;

	-- Get the Bars from ChocolateBar
	-- sort{}
	temptop = {}
	tempbottom = {}
	
	chocolateBars = ChocolateBar:GetBars();
	for k,v in pairs(chocolateBars) do
		local settings = v.settings
		local index = settings.index
		if settings.align == "top" then
			table.insert(temptop,{v,index})
			--DEFAULT_CHAT_FRAME:AddMessage( "|cFFFF8080nUI Debug:|r ".."Found Top Chocolate Bar. Name = "..settings.barName.."  index = "..index, 1, 0.83, 0 );
		else
			table.insert(tempbottom,{v,index})
			--DEFAULT_CHAT_FRAME:AddMessage( "|cFFFF8080nUI Debug:|r ".."Found Bottom Chocolate Bar. Name = "..settings.barName.."  index = "..index, 1, 0.83, 0 );
		end
	end
	table.sort(temptop, function(a,b)return a[2] < b[2] end)
	table.sort(tempbottom, function(a,b)return a[2] < b[2] end)

	for i, v in ipairs(temptop) do
		ChocolateLowestTopBar = v[1]
		--DEFAULT_CHAT_FRAME:AddMessage( "|cFFFF8080nUI Debug:|r ".."ChocolateLowestTopBar Name = "..ChocolateLowestTopBar.settings.barName.."  Alpha = "..ChocolateLowestTopBar:GetAlpha(), 1, 0.83, 0 );
	end
	
	for i, v in ipairs(tempbottom) do
		ChocolateHighestBottomBar = v[1]
		--DEFAULT_CHAT_FRAME:AddMessage( "|cFFFF8080nUI Debug:|r ".."ChocolateHighestBottomBar Name = "..ChocolateHighestBottomBar.settings.barName.."  Alpha = "..ChocolateHighestBottomBar:GetAlpha(), 1, 0.83, 0 );
	end

	-- ChocolateLowestTopBar is located at the top of the screen

	nUI_TopBarsLocator:ClearAllPoints();
	
	if ChocolateLowestTopBar and ChocolateLowestTopBar:GetAlpha() > 0 then 
		nUI_TopBarsLocator:SetPoint( "BOTTOM", ChocolateLowestTopBar, "BOTTOM", 0, 0 );
	else
		nUI_TopBarsLocator:SetPoint( "BOTTOM", UIParent, "TOP", 0, 0 );
	end
	
	-- ChocolateHighestBottomBar is located at the bottom of the screen
	
	nUI_BottomBarsLocator:ClearAllPoints();	
	
	if ChocolateHighestBottomBar and ChocolateHighestBottomBar:GetAlpha() > 0 then
		nUI_BottomBarsLocator:SetPoint( "TOP", ChocolateHighestBottomBar, "TOP", 0, 0 );
	else
		nUI_BottomBarsLocator:SetPoint( "TOP", UIParent, "BOTTOM", 0, 0 );
	end
	
--	nUI_ProfileStop();
	
end

-------------------------------------------------------------------------------

local frame = CreateFrame( "Frame", "nUI_ChocolateBarEvents", WorldFrame )

local function onChocolateBarEvent( who, event )

--	nUI_ProfileStart( ProfileCounter, "onChocolateBarEvent", event );
	
	if event == "PLAYER_ENTERING_WORLD" then
		
		if IsAddOnLoaded( "ChocolateBar" ) then

			ChocolateBar = LibStub("AceAddon-3.0"):GetAddon("ChocolateBar");
			
			if ChocolateBar then
				
				ChocolateBar.nUI_AnchorBars	= ChocolateBar.AnchorBars;
		
				ChocolateBar.AnchorBars = function()
					--DEFAULT_CHAT_FRAME:AddMessage( "|cFFFF8080nUI Debug:|r ".."nUI ChocolateBar.AnchorBars() called", 1, 0.83, 0 );
					ChocolateBar:nUI_AnchorBars();
					DetectChocolateBar_Bars();
				end;
				
				DetectChocolateBar_Bars();
			end			
		end
		
		frame:UnregisterEvent( "PLAYER_ENTERING_WORLD" );
		
	end
	
--	nUI_ProfileStop();
	
end

frame:SetScript( "OnEvent", onChocolateBarEvent );
frame:RegisterEvent( "PLAYER_ENTERING_WORLD" );
