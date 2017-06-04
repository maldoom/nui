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

nUI_Profile.nUI_Tooltips = {};

local ProfileCounter = nUI_Profile.nUI_Tooltips;

nUI_Tooltips = CreateFrame( "Frame", "nUI_TooltipEvents", WorldFrame );

-------------------------------------------------------------------------------

nUI_Options.tooltips = "owner";

-------------------------------------------------------------------------------

local settingTooltipOwner = false;

local function nUI_Tooltip_SetOwner( owner, anchor, xOfs, yOfs, tooltip )

--	nUI_ProfileStart( ProfileCounter, "nUI_Tooltip_SetOwner" );
	
	if not tooltip then tooltip = this; end
	if not xOfs then xOfs = 0; end
	if not yOfs then yOfs = 0; end

	if not owner.GetLeft
	and owner.GetRight
	or not owner.GetCenter 
	then		
		owner = UIParent;
	end

	if nUI_MoverFrames[GameTooltip] and nUI_Options.tooltips == "fixed" or not owner or owner == UIParent then

		tooltip:Hide();
		
		local overlay = nUI_MoverFrames[GameTooltip].overlay;
		
		nUI_SavedTooltip_SetOwner( tooltip, owner or UIParent, "ANCHOR_NONE" );
		
		tooltip:ClearAllPoints();
		tooltip:SetPoint( "BOTTOMRIGHT", UIParent, "BOTTOMLEFT", overlay:GetRight(), overlay:GetBottom() );

	elseif nUI_Options.tooltips == "mouse" then
		
		tooltip:ClearAllPoints();
		
		if tooltip == GameTooltip then
			nUI_SavedTooltip_SetOwner( tooltip, UIParent, "ANCHOR_CURSOR" );
		else
			tooltip:SetParent( UIParent, "ANCHOR_CURSOR" );
		end
		
	else
		
		local width;
		local x, y         = owner:GetCenter();
		local left         = owner:GetLeft();
		local right        = owner:GetRight();
		local top          = owner:GetTop();
		local bottom       = owner:GetBottom();
		local screenWidth  = UIParent:GetRight() - UIParent:GetLeft();
		local screenHeight = UIParent:GetTop() - UIParent:GetBottom();
		local scale        = owner:GetEffectiveScale();
		local point        = "";
		
		if x ~= nil and y ~= nil and left ~= nil and right ~= nil and top ~= nil 
		and bottom ~= nil and screenWidth > 0 and screenHeight > 0 then
			
			xOfs   = xOfs * scale;
			yOfs   = yOfs * scale;
			x      = x * scale;
			y      = y * scale;		
			left   = left * scale;
			right  = right * scale;
			width  = right - left;
			top    = top * scale;
			bottom = bottom * scale;		
			
			if y <= (screenHeight * (1/2)) then
				
				top   = top + yOfs;
				point = "TOP";
				
				if (top < 0) then yOfs = yOfs - top; end
				
			else
				
				yOfs   = -yOfs;
				bottom = bottom + yOfs;
				point  = "BOTTOM";
				
				if bottom > screenHeight then yOfs = yOfs + (screenHeight - bottom); end
			end
			
			if x <= (screenWidth * (1/2)) then
				
				left = left + xOfs;
				
				if point == "BOTTOM" then
					
					point = point.."RIGHT";
					xOfs  = xOfs - width;
					
					if left < 0 then xOfs = xOfs - left; end
					
				else
					
					point = point.."LEFT";
					
					if left < 0 then xOfs = xOfs - left; end
				end
				
			else
				
				xOfs  = -xOfs;
				right = right + xOfs;
				
				if point == "BOTTOM" then
					
					point = point.."LEFT";
					xOfs  = xOfs + width;
					
					if right > screenWidth then xOfs = xOfs - (right - screenWidth); end
					
				else
	
					point = point.."RIGHT";
					
					if right > screenWidth then xOfs = xOfs + (screenWidth - right); end
				end
			end
			
			if point == "" then point = "TOPLEFT"; end
			
			scale = tooltip:GetScale();
			
			if scale then
				xOfs = xOfs / scale;
				yOfs = yOfs / scale;
			end
		
			if tooltip == GameTooltip then
				nUI_SavedTooltip_SetOwner( tooltip, owner, "ANCHOR_"..point, xOfs, yOfs );
			else
				tooltip:SetOwner( owner, "ANCHOR_"..point, xOfs, yOfs );
			end
		end
	end

--	nUI_ProfileStop();
	
end

-------------------------------------------------------------------------------

local function tooltipSetDefaultAnchor( tooltip, owner )
	
--	nUI_ProfileStart( ProfileCounter, "tooltipSetDefaultAnchor" );
	
	local mode = nUI_Options.tooltips or "default";

	if mode ~= "default" then
		
		nUI_Tooltip_SetOwner( owner, "ANCHOR_NONE", 0, 0, tooltip );
		
	else
		
		nUI_SavedTooltip_SetDefaultAnchor( tooltip, owner );		

	end	

--	nUI_ProfileStop();
	
end

-------------------------------------------------------------------------------

local function tooltipSmartSetOwner( owner, tooltip, xOfs, yOfs )

--	nUI_ProfileStart( ProfileCounter, "tooltipSmartSetOwner" );
	
	local mode = nUI_Options.tooltips or "default";
	if not owner then owner = nUI_MoverFrames[GameTooltip] and nUI_MoverFrames[GameTooltip].overlay or UIParent; end
	if not tooltip then tooltip = GameTooltip; end

	if mode ~= "default" then
	
		nUI_Tooltip_SetOwner( owner, "ANCHOR_NONE", xOfs, yOfs, tooltip );
		
	else
		
		nUI_SavedTooltip_SmartSetOwner( owner, "ANCHOR_NONE", xOfs, yOfs, tooltip );

	end

--	nUI_ProfileStop();
	
end

-------------------------------------------------------------------------------

local function tooltipSetOwner( tooltip, owner, anchor, xOfs, yOfs )
	
--	nUI_ProfileStart( ProfileCounter, "tooltipSetOwner" );
	
	local mode = nUI_Options.tooltips or "default";
	
	if mode ~= "default" then		
		
		tooltipSmartSetOwner( owner, tooltip, xOfs, yOfs );		
		
	else
		
		nUI_SavedTooltip_SetOwner( tooltip, owner, anchor, xOfs, yOfs );
		
	end
	
--	nUI_ProfileStop();
	
end

-------------------------------------------------------------------------------

local function onTooltipEvent( who, event, arg1 )

--	nUI_ProfileStart( ProfileCounter, "onTooltipeEvent", event );
	
	if event == "ADDON_LOADED" then
		
		if arg1 == "nUI" then
			
			nUI_Options.tooltips = strlower( nUI_Options.tooltips or "owner" );

			-- set up a slash command handler to toggle display of action button tooltips in combat on and off
			
			local option = nUI_SlashCommands[nUI_SLASHCMD_COMBATTIPS];
			
			nUI_SlashCommands:setHandler( option.command,
				
				function( msg )
					
					nUI_Options.combat_tooltips = not nUI_Options.combat_tooltips and true or false;
					
					DEFAULT_CHAT_FRAME:AddMessage( (option.message):format( nUI_Options.combat_tooltips and nUI_L["|cFF00FF00ENABLED|r"] or nUI_L["|cFFFF0000DISABLED|r"] ), 1, 0.83, 0 );
					
				end
			);

			-- set up a slash command handler for dealing with setting the tooltip mode
			
			local option = nUI_SlashCommands[nUI_SLASHCMD_TOOLTIPS];
			
			nUI_SlashCommands:setHandler( option.command, 
				
				function( msg )
					
					local command, mode = strsplit( " ", msg );
					local use_mode = "owner";
					
					mode = strlower( mode or nUI_L[nUI_SLASHCMD_OPTIONS( nUI_SLASHCMD_TOOLTIPS, "owner" )] );
					
					if     mode == nUI_L[nUI_SLASHCMD_OPTIONS( nUI_SLASHCMD_TOOLTIPS, "owner" )]   then use_mode = "owner" 
					elseif mode == nUI_L[nUI_SLASHCMD_OPTIONS( nUI_SLASHCMD_TOOLTIPS, "mouse" )]   then use_mode = "mouse"
					elseif mode == nUI_L[nUI_SLASHCMD_OPTIONS( nUI_SLASHCMD_TOOLTIPS, "fixed" )]   then use_mode = "fixed"
					elseif mode == nUI_L[nUI_SLASHCMD_OPTIONS( nUI_SLASHCMD_TOOLTIPS, "default" )] then use_mode = "default"
					else   
					
						DEFAULT_CHAT_FRAME:AddMessage( 
							nUI_L["nUI: [ %s ] is not a valid tooltip settings option... please choose from %s, %s, %s or %s"]:format( 
							mode or "", nUI_L[nUI_SLASHCMD_OPTIONS( nUI_SLASHCMD_TOOLTIPS, "owner" )], 
							nUI_L[nUI_SLASHCMD_OPTIONS( nUI_SLASHCMD_TOOLTIPS, "mouse" )],
							nUI_L[nUI_SLASHCMD_OPTIONS( nUI_SLASHCMD_TOOLTIPS, "fixed" )],
							nUI_L[nUI_SLASHCMD_OPTIONS( nUI_SLASHCMD_TOOLTIPS, "default" )] ), 1, 0.83, 0
						);
						
						mode = nUI_L[nUI_SLASHCMD_OPTIONS( nUI_SLASHCMD_TOOLTIPS, "owner" )];
						
					end
				
					if use_mode ~= nUI_Options.tooltips then
						
						if use_mode == "default" then
							
							ReloadUI();

						elseif nUI_Options.tooltips == "default" then

							nUI_SavedTooltip_SetDefaultAnchor = GameTooltip_SetDefaultAnchor;
							nUI_SavedTooltip_SetOwner         = GameTooltip.SetOwner;
							nUI_SavedTooltip_SmartSetOwner    = SmartSetOwner;
							
							GameTooltip:ClearAllPoints();
							GameTooltip:SetPoint( "LEFT", WorldFrame, "LEFT", 0, 0 );
							nUI_Movers:lockFrame( GameTooltip, true, nUI_L["In-Game Tooltips"] );
							nUI_Movers:lockFrame( GameTooltip, false, nUI_L["In-Game Tooltips"] );
							
							-- manage tooltips
							
							hooksecurefunc( "GameTooltip_SetDefaultAnchor", tooltipSetDefaultAnchor );
							
							--GameTooltip.SetOwner         = tooltipSetOwner; -- temp taint
							--SmartSetOwner                = tooltipSmartSetOwner; -- temp taint
							
						end
						
						DEFAULT_CHAT_FRAME:AddMessage( (option.message):format( mode ), 1, 0.83, 0 );			
						nUI_Options.tooltips = use_mode;
					end
				end
			);
		end
					
	elseif nUI_Options.tooltips ~= "default" then
					
		nUI_SavedTooltip_SetDefaultAnchor = GameTooltip_SetDefaultAnchor;
		nUI_SavedTooltip_SetOwner         = GameTooltip.SetOwner;
		nUI_SavedTooltip_SmartSetOwner    = SmartSetOwner;
		
		GameTooltip:ClearAllPoints();
		GameTooltip:SetPoint( "LEFT", WorldFrame, "LEFT", 0, 0 );
		nUI_Movers:lockFrame( GameTooltip, true, nUI_L["In-Game Tooltips"] );
		nUI_Movers:lockFrame( GameTooltip, false, nUI_L["In-Game Tooltips"] );
		
		-- manage tooltips
		
		hooksecurefunc( "GameTooltip_SetDefaultAnchor", tooltipSetDefaultAnchor );
		
		--GameTooltip.SetOwner = tooltipSetOwner; -- temp taint
		--SmartSetOwner        = tooltipSmartSetOwner; -- temp taint
		
	end	
	
--	nUI_ProfileStop();
	
end

nUI_Tooltips:SetScript( "OnEvent", onTooltipEvent );
nUI_Tooltips:RegisterEvent( "PLAYER_LOGIN" );
nUI_Tooltips:RegisterEvent( "ADDON_LOADED" );
