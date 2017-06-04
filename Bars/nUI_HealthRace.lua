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

if not nUI_Bars then nUI_Bars = {}; end
if not nUI_Profile then nUI_Profile = {}; end;

local CreateFrame         = CreateFrame;
local InCombatLockdown    = InCombatLockdown;
local RegisterUnitWatch   = RegisterUnitWatch;
local UnregisterUnitWatch = UnregisterUnitWatch;

nUI_Profile.nUI_HealthRace = {};

local ProfileCounter = nUI_Profile.nUI_HealthRace;

-------------------------------------------------------------------------------

local function FillTooltip( frame )
	
--	nUI_ProfileStart( ProfileCounter, "FillTooltip" );	
	
	GameTooltip:ClearLines();
	GameTooltip:AddLine( nUI_L["nUI Health Race Stats..."], 1, 0.83, 0 );
	
	if frame.player_info then
		GameTooltip:AddLine( nUI_L["<unit name>'s Health: <current>/<maximum> (<percent>)"]:format( frame.player_info.name, frame.player_info.cur_health, frame.player_info.max_health, frame.player_info.pct_health * 100 ), 1, 0.83, 0 );
	end
	
	if frame.target_info then
		GameTooltip:AddLine( nUI_L["<unit name>'s Health: <current>/<maximum> (<percent>)"]:format( frame.target_info.name, frame.target_info.cur_health, frame.target_info.max_health, frame.target_info.pct_health * 100 ), 1, 0.83, 0 );
	end

	if frame.player_info and frame.target_info and frame.relative_btn.pct then
		if frame.relative_btn.pct < 0 then
			GameTooltip:AddLine( nUI_L["Advantage to <player>: <pct>"]:format( frame.player_info.name, frame.relative_btn.pct * -100 ), 1, 0.83, 0 );
		elseif frame.relative_btn.pct > 0 then
			GameTooltip:AddLine( nUI_L["Advantage to <target>: <pct>"]:format( frame.target_info.name, frame.relative_btn.pct * -100 ), 1, 0.83, 0 );
		else
			GameTooltip:AddLine( nUI_L["No current advantage to <player> or <target>"]:format( frame.player_info.name, frame.target_info.name ), 1, 0.83, 0 );
		end
	end
	
--	nUI_ProfileStop();
	
end

-------------------------------------------------------------------------------

function nUI_Bars:createHealthRaceBar( name, parent, options )
	
--	nUI_ProfileStart( ProfileCounter, "createHealthRaceBar" );	
	
	local frame        = CreateFrame( "Frame", name, parent );
	frame.left_bar     = frame:CreateTexture( "$parent_LeftBar", "BACKGROUND" );
	frame.right_bar    = frame:CreateTexture( "$parent_RightBar", "BACKGROUND" );
	frame.border       = frame:CreateTexture( "$parent_Border", "BORDER" );
	frame.player_btn   = frame:CreateTexture( "$parent_PlayerBtn", "ARTWORK" );
	frame.target_btn   = frame:CreateTexture( "$parent_TargetBtn", "ARTWORK" );
	frame.relative_btn = frame:CreateTexture( "$parent_RelativeBtn", "ARTWORK" );		
	frame.parent       = parent;
	frame.unit         = "target";
	frame.active       = true;

	frame:SetAttribute( "unit", "target" );
	
	frame.border:SetAllPoints( frame );
	frame.border:SetTexture( "Interface\\AddOns\\nUI\\Layouts\\Default\\Art\\nUI_Threat_Frame" );
	frame.border:SetTexCoord( 0, 0, 0, 1, 1, 0, 1, 1 );
	
	frame.left_bar:SetAllPoints( frame );
	frame.left_bar:SetTexture( "Interface\\AddOns\\nUI\\Layouts\\Default\\Art\\nUI_Threat_LeftBar" );
	frame.left_bar:SetTexCoord( 0, 0, 0, 1, 1, 0, 1, 1 );
	
	frame.right_bar:SetAllPoints( frame );
	frame.right_bar:SetTexture( "Interface\\AddOns\\nUI\\Layouts\\Default\\Art\\nUI_Threat_RightBar" );
	frame.right_bar:SetTexCoord( 0, 0, 0, 1, 1, 0, 1, 1 );

	frame.player_btn:SetTexture( "Interface\\AddOns\\nUI\\Layouts\\Default\\Art\\nUI_Threat_Button1" );
	frame.player_btn:SetTexCoord( 0, 0, 0, 1, 1, 0, 1, 1 );

	frame.target_btn:SetTexture( "Interface\\AddOns\\nUI\\Layouts\\Default\\Art\\nUI_Threat_Button1" );
	frame.target_btn:SetTexCoord( 0, 0, 0, 1, 1, 0, 1, 1 );

	frame.relative_btn:SetTexture( "Interface\\AddOns\\nUI\\Layouts\\Default\\Art\\nUI_Threat_Button2" );
	frame.relative_btn:SetTexCoord( 0, 0, 0, 1, 1, 0, 1, 1 );
	
	frame:SetScript( "OnShow", 
	
		function()
--			nUI_ProfileStart( ProfileCounter, "OnShow" );	
			frame.setEnabled( true );
--			nUI_ProfileStop();
		end
	);
	
	frame:SetScript( "OnHide", 
	
		function()
--			nUI_ProfileStart( ProfileCounter, "OnHide" );	
			frame.setEnabled( false );
--			nUI_ProfileStop();
		end
	);

	-- notify the bar it is no longer needed
	
	frame.deleteBar = function()

--		nUI_ProfileStart( ProfileCounter, "deleteBar" );	
	
		UnregisterUnitWatch( frame );
		
--		nUI:debug( "nUI_HealthRace: setting health race bar enabled state = false for "..frame:GetName().." in deleteBar()", 1 );			

		frame.setEnabled( false );
		frame:SetAlpha( 0 );
		
		if not InCombatLockdown() then frame:Hide(); end
		
--		nUI_ProfileStop();
		
	end
	
	-- set the enabled state of the bar...
	
	frame.setEnabled = function( enabled )
	
--		nUI_ProfileStart( ProfileCounter, "setEnabled" );	
	
		if frame.enabled ~= enabled then
			
			frame.enabled = enabled;
			
			if enabled then 
				
				frame:SetAlpha( frame.active and 1 or 0 );
			
				frame.newUnitInfo( "player", nUI_Unit:registerHealthCallback( "player", frame ) );
				frame.newUnitInfo( "target", nUI_Unit:registerHealthCallback( "target", frame ) );
				
			elseif not enabled then 	
				
				nUI_Unit:unregisterHealthCallback( "target", frame );
				nUI_Unit:unregisterHealthCallback( "player", frame );
				
				frame:SetAlpha( 0 );				
			end
			
		end
		
--		nUI_ProfileStop();
		
	end

	-- set the scale of the bar
	
	frame.applyScale = function( scale )
		
--		nUI_ProfileStart( ProfileCounter, "applyScale" );	
	
		if frame.options then
				
			local anchor     = scale and frame.anchor or nil;
			local scale      = scale or frame.scale or 1;
			local width      = frame.bar_width * scale * nUI.hScale;
			local height     = frame.bar_height * scale * nUI.vScale;
			local btn_width  = frame.btn_width * scale * nUI.hScale;
			
			if frame.width     ~= width
			or frame.height    ~= height
			or frame.btn_width ~= btn_width
			then
				
				frame.width     = width;
				frame.height    = height;
				frame.btn_width = btn_width;
				
				frame:SetWidth( width );
				frame:SetHeight( height );
				
				frame.player_btn:SetWidth( btn_width );
				frame.player_btn:SetHeight( height );
				
				frame.target_btn:SetWidth( btn_width );
				frame.target_btn:SetHeight( height );
				
				frame.relative_btn:SetWidth( btn_width );
				frame.relative_btn:SetHeight( height );
			
				frame.player_btn:SetPoint( "CENTER", frame, "CENTER", -width/2 * (frame.player_btn.pct or 1), 0 );
				frame.target_btn:SetPoint( "CENTER", frame, "CENTER", width/2 * (frame.target_btn.pct or 1), 0 );
				frame.relative_btn:SetPoint( "CENTER", frame, "CENTER", width/2 * (frame.relative_btn.pct or 0), 0 );
				
			end
		end
		
--		nUI_ProfileStop();
		
	end
	
	-- set the bar's anchor point
	
	frame.applyAnchor = function( anchor )
		
--		nUI_ProfileStart( ProfileCounter, "applyAnchor" );	
	
		local anchor      = anchor or frame.anchor or {};
		local anchor_pt   = anchor.anchor_pt or "CENTER";
		local relative_to = anchor.relative_to or frame.parent:GetName();
		local relative_pt = anchor.relative_pt or anchor_pt;
		local xOfs        = (anchor.xOfs or 0) * nUI.hScale;
		local yOfs        = (anchor.yOfs or 0) * nUI.vScale;
		
		frame.anchor = anchor;
		
		if frame.xOfs ~= xOfs
		or frame.yOfs ~= yOfs
		or frame.anchor_pt ~= anchor_pt
		or frame.relative_to ~= relative_to
		or frame.relative_pt ~= relative_pt
		then
			
			frame.anchor_pt   = anchor_pt;
			frame.relative_to = relative_to;
			frame.relative_pt = relative_pt;
			frame.xOfs        = xOfs;
			frame.yOfs        = yOfs;
			
			frame:ClearAllPoints();
			frame:SetPoint( anchor_pt, relative_to, relative_pt, xOfs, yOfs );
			
		end
		
--		nUI_ProfileStop();
		
	end
	
	-- set the bar's options
	
	frame.applyOptions = function( options )
		
--		nUI_ProfileStart( ProfileCounter, "applyOptions" );	
	
		frame.options = options;
		
		if not options or not options.enabled then
			
--			nUI:debug( "nUI_HealthRace: setting health race bar enabled state = false for "..frame:GetName().." in applyOptions()", 1 );			
			frame.setEnabled( false );
			
		else
			
			frame.bar_width  = frame.options.width;
			frame.bar_height = frame.bar_width / 8;
			frame.btn_width  = frame.bar_height / 2;
			
			frame.applyScale( options.scale or frame.scale or 1 );
	
--			nUI:debug( "nUI_HealthRace: setting health race bar enabled state = "..(frame:IsShown() and "true" or "false").." for "..frame:GetName().." in applyOptions()", 1 );			
			frame.setEnabled( frame:IsShown() );
			
		end
		
--		nUI_ProfileStop();
		
	end

	-- handle new info about the player or target
	
	frame.newUnitInfo = function( unit_id, unit_info )
		
--		nUI_ProfileStart( ProfileCounter, "newUnitInfo" );	
	
		local player_pct;
		local target_pct;
		local ratio;
		
		-- where's everyone's health at the moment?
		
		if unit_id == "player" then
			
			frame.player_info = unit_info;
			player_pct        = unit_info and unit_info.pct_health or 1;	
			target_pct        = frame.target_info and frame.target_info.pct_health or frame.target_btn.pct or 1;
			
		elseif unit_id == "target" then
			
			frame.target_info = unit_info;
			target_pct        = unit_info and unit_info.pct_health or 1;
			player_pct        = frame.player_info and frame.player_info.pct_health or frame.player_btn.pct or 1;
			
		else
			
			player_pct        = frame.player_info and frame.player_info.pct_health or frame.player_btn.pct or 1;
			target_pct        = frame.target_info and frame.target_info.pct_health or frame.target_btn.pct or 1;

		end

		if nUI_Options.hplost then
			if frame.player_info then
				player_pct = 1 - player_pct;
			end
			if frame.target_info then
				target_pct = 1 - target_pct;
			end
		end
		
		-- if we don't have a target, or we can't attack the target we have
		-- then the health race means nothing
		
		if not frame.target_info or not frame.target_info.attackable then
			
--			nUI:debug( "nUI_HealthRace: no attackable target", 1 );
			
			if frame.active then
				
				frame.active = false;
				
				frame:SetAlpha( 0 );
				
			end

		-- otherwise update the health race bar
		
		else

--			nUI:debug( "nUI_HealthRace: attackable target", 1 );
			
			-- make sure the frame is visible
			
			if not frame.active then
				
				frame.active = true;
				frame:SetAlpha( 1 );
				
			end
			
			-- do we need to update the player's health?
			
			if frame.player_btn.pct ~= player_pct then
				
				local color = frame.player_info and frame.player_info.health_color or { r=1,g=1,b=1 };
				
				frame.player_btn.pct = player_pct;
				frame.player_btn:SetPoint( "CENTER", frame, "CENTER", -frame.width/2 * player_pct, 0 );
				frame.left_bar:SetVertexColor( color.r, color.g, color.b, 1 );
				
			end
			
			-- do we need to update the target's health?
			
			if frame.target_btn.pct ~= target_pct then
				
				local color = frame.target_info and frame.target_info.health_color or { r=1,g=1,b=1 };
				
				frame.target_btn.pct = target_pct;
				frame.target_btn:SetPoint( "CENTER", frame, "CENTER", frame.width/2 * target_pct, 0 );
				frame.right_bar:SetVertexColor( color.r, color.g, color.b, 1 );
				
			end
	
			-- and where are we relative to one another?
			
			if player_pct > target_pct then
				ratio = -(1 - target_pct / player_pct);
			else
				ratio = (1 - player_pct / target_pct );
			end
			
			if frame.relative_btn.pct ~= ratio then
				
				local r = 0.5 * ratio;
				local g = 0.5 * -ratio;
				
				frame.relative_btn.pct = ratio;
				frame.relative_btn:SetPoint( "CENTER", frame, "CENTER", frame.width/2 * ratio, 0 );
				frame.border:SetVertexColor( r + 0.5, g + 0.5, 0, 1 );
				
			end
		end
		
--		nUI_ProfileStop();
		
	end
	
	-- initialize the bar
	
	nUI:registerScalableFrame( frame );
	
	frame.applyOptions( options );
	
	RegisterUnitWatch( frame );
	
--	nUI_ProfileStop();
	
	return frame;
end