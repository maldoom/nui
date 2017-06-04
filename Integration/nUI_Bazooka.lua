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

nUI_Profile.nUI_Bazooka = {};

local ProfileCounter = nUI_Profile.nUI_Bazooka;
local Bazooka = nil;


local function pre180()
	local BAZOOKA_VERSION = GetAddOnMetadata('Bazooka', 'Version')
	if (BAZOOKA_VERSION < '1.8.0') then
		local vBazookaTop = false
		local vBazookaBottom = false
		local bar
		
		for i = 1, Bazooka.numBars do
			bar = Bazooka.bars[i]
			if (bar) then
				if (bar.db.attach == "top") then
					vBazookaTop = bar.id;
				end
				if (bar.db.attach == "bottom") then
					vBazookaBottom = bar.id ;
				end
			end
		end
		
		nUI_TopBarsLocator:ClearAllPoints();
		nUI_BottomBarsLocator:ClearAllPoints();
	  
		if (vBazookaTop) then
			nUI_TopBarsLocator:SetPoint("BOTTOM", "BazookaBar_" .. vBazookaTop, "BOTTOM", 0, 0);
		else
			nUI_TopBarsLocator:SetPoint("BOTTOM", UIParent, "TOP", 0, 0);
		end
		
		if (vBazookaBottom) then
			nUI_BottomBarsLocator:SetPoint("TOP", "BazookaBar_" .. vBazookaBottom, "TOP", 0, 0);
		else
			nUI_BottomBarsLocator:SetPoint("TOP", UIParent, "BOTTOM", 0, 0);
		end
		
		return true
	end
	
	return false
end


local function DetectBazooka_Bars()
--	nUI_ProfileStart( ProfileCounter, "DetectBazooka_Bars" );
	
	if (pre180() == true) then return end

	nUI_TopBarsLocator:ClearAllPoints();
	if (Bazooka.TopAnchor) then
    	nUI_TopBarsLocator:SetPoint("BOTTOM", Bazooka.TopAnchor, "BOTTOM", 0, 0);
    else
		nUI_TopBarsLocator:SetPoint("BOTTOM", UIParent, "TOP", 0, 0);
	end
	
	nUI_BottomBarsLocator:ClearAllPoints();
	if (Bazooka.BottomAnchor) then
    	nUI_BottomBarsLocator:SetPoint("TOP", Bazooka.BottomAnchor, "TOP", 0, 0);
    else
		nUI_BottomBarsLocator:SetPoint("TOP", UIParent, "BOTTOM", 0, 0);
	end
	
--	nUI_ProfileStop();
	
end

-------------------------------------------------------------------------------

local frame = CreateFrame( "Frame", "nUI_BazookaEvents", WorldFrame )

local function onBazookaEvent( self, event, arg1 )

--	nUI_ProfileStart( ProfileCounter, "onBazookaEvent", event );
	
	if event == "PLAYER_LOGIN" then
		if IsAddOnLoaded("Bazooka") then
			Bazooka = LibStub("AceAddon-3.0"):GetAddon("Bazooka");
			if Bazooka then
				DetectBazooka_Bars();
			end
		end
	end
	
--	nUI_ProfileStop();
	
end

frame:SetScript( "OnEvent", onBazookaEvent );
frame:RegisterEvent( "PLAYER_LOGIN" );
