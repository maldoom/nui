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

if not nUI_Options then nUI_Options = {}; end
if not nUI_Profile then nUI_Profile = {}; end;

local GetScreenHeight = GetScreenHeight;
local GetScreenWidth  = GetScreenWidth;
local UIParent        = UIParent;

nUI_Profile.nUI_Bags  = {};

local ProfileCounter  = nUI_Profile.nUI_Bags;

-------------------------------------------------------------------------------

local function ManageBags()

--	nUI_ProfileStart( ProfileCounter, "ManageBags" );
	
	if nUI_BagBar:GetTop() then
			
		local view_height = GetScreenHeight() - nUI_BagBar:GetTop() - VISIBLE_CONTAINER_SPACING - 20;
		local left_edge   = -GetScreenWidth() + VISIBLE_CONTAINER_SPACING;
		local bag_scale   = nUI_Options.bag_scale or 1;
		
		if BankFrame:IsShown() then
			left_edge = left_edge + BankFrame:GetRight();
		end
		
		repeat 
			
			local xOfs      = 0;
			local yOfs      = VISIBLE_CONTAINER_SPACING;
			local bag_width = CONTAINER_WIDTH * bag_scale;
			
			if nUI_ButtonBag and nUI_ButtonBag.shown then
				
				nUI_ButtonBag:SetScale( bag_scale );
				nUI_ButtonBag:ClearAllPoints();
				nUI_ButtonBag:SetPoint( "BOTTOMRIGHT", nUI_BagBar, "TOPRIGHT", xOfs / bag_scale, yOfs / bag_scale );
				
				yOfs = yOfs + nUI_ButtonBag:GetHeight() * bag_scale + VISIBLE_CONTAINER_SPACING * bag_scale;
				
			end
			
			for i, bag_name in ipairs( ContainerFrame1.bags ) do
				
				local frame = getglobal( bag_name );
				local bag_height = frame:GetHeight() * bag_scale;
				
				frame:SetScale( bag_scale );
				
				if (yOfs + bag_height) >= view_height then			
					xOfs = xOfs - bag_width;
					yOfs = VISIBLE_CONTAINER_SPACING;
				end
				
				frame:ClearAllPoints();
				frame:SetPoint( "BOTTOMRIGHT", nUI_BagBar, "TOPRIGHT", xOfs / bag_scale, yOfs / bag_scale );
				
				yOfs = yOfs + bag_height + VISIBLE_CONTAINER_SPACING * bag_scale;
				
			end	
			
			bag_scale = bag_scale - 0.01;
	
		until xOfs - bag_width >= left_edge;	
	end
	
--	nUI_ProfileStop();
	
end

-------------------------------------------------------------------------------

-- 5.0.4 Change Start
-- hooksecurefunc( "updateContainerFrameAnchors", ManageBags );
hooksecurefunc( "UpdateContainerFrameAnchors", ManageBags );
--5.0.4 Change End
-------------------------------------------------------------------------------

nUI_DefaultConfig.bag_scale = 1;

local frame = CreateFrame( "Frame", "nUI_BagEvents", WorldFrame );

local function onBagEvent( who, event, arg1 )

--	nUI_ProfileStart( ProfileCounter, "onBagEvent", event );
	
	if event == "ADDON_LOADED" and arg1 == "nUI" then
		
		nUI_Options.bag_scale = tonumber( nUI_Options.bag_scale or nUI_DefaultConfig.bag_scale );
		
		-- set up a slash command handler for dealing with setting the tooltip mode
		
		local option = nUI_SlashCommands[nUI_SLASHCMD_BAGSCALE];
		
		nUI_SlashCommands:setHandler( option.command, 
			
			function( msg )
				
				local command, scale = strsplit( " ", msg );
				
				scale = tonumber( scale or "1" );
			
				if scale ~= nUI_Options.bag_scale then
					
					DEFAULT_CHAT_FRAME:AddMessage( (option.message):format( scale ), 1, 0.83, 0 );
					nUI_Options.bag_scale = scale;
					ManageBags();
				end					
			end
		);
		
	end
	
--	nUI_ProfileStop();
	
end

frame:SetScript( "OnEvent", onBagEvent );
frame:RegisterEvent( "ADDON_LOADED" );
