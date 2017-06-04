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

if not nUI then nUI = {}; end
if not nUI_HUDLayoutOptions then nUI_HUDLayoutOptions = {}; end
if not nUI_HUDLayouts then nUI_HUDLayouts = {}; end
if not nUI_Options then nUI_Options = {}; end
if not nUI_Profile then nUI_Profile = {}; end;

local CreateFrame = CreateFrame;
local MouseIsOver = MouseIsOver;

nUI_Profile.nUI_HUD       = {};
nUI_Profile.nUI_HUD.Frame = {};

local ProfileCounter      = nUI_Profile.nUI_HUD;
local FrameProfileCounter = nUI_Profile.nUI_HUD.Frame;

-------------------------------------------------------------------------------

nUI_Options.hud_healthrace = true;
nUI_Options.hud_cooldown   = true;
nUI_Options.hud_cdalert    = true;
nUI_Options.hud_cdsound    = true;
nUI_Options.hud_threatbar  = true;
nUI_Options.hud_scale      = 1;

-- See nUI\Integration\nUI_CombatLog.lua for information on how to integrate
-- a custom plugin into the InfoPanel system

-------------------------------------------------------------------------------
-- method for sorting the info panel options on the selector button. Panels
-- are ordered ascending first by their rotation number, then by their 
-- description and finally by their panel name.

local function SortLayoutList( left, right )

--	nUI_ProfileStart( ProfileCounter, "SortLayoutList" );
	
	local result;
	
	if left.rotation and not right.rotation then
		result = true;
	elseif right.rotation and not left.rotation then
	    result = false;
	elseif left.rotation > right.rotation then
		result = false;
	elseif left.rotation < right.rotation then
		result = true;
	elseif left.desc > right.desc then
		result = false;
	elseif left.desc < right.desc then
		result = true;
	elseif left.name > right.name then
		result = false;
	else
		result = true;
	end
	
--	nUI_ProfileStop();
	
	return result;
	
end

-------------------------------------------------------------------------------

local HUDPanelList  = {};

local background = CreateFrame( "Frame", "nUI_HUDLayoutBackground", nUI_TopBars.Anchor );
local frame      = CreateFrame( "Frame", "nUI_HUDLayoutSelector", background, "SecureHandlerStateTemplate" );
frame.button     = CreateFrame( "Button", "$parent_Button", frame, "SecureHandlerClickTemplate" );
frame.text       = frame:CreateFontString( "$parent_Label", "ARTWORK" );

frame.button:RegisterForClicks( "AnyUp" );
frame.button:SetScript( "PreClick", 
	function( self, button, down )
		
		if button == "RightButton"
		and IsAltKeyDown()
		and IsControlKeyDown()
		then
			nUI_KeyBindingFrame.bindAction( frame.button, nUI_L["HUD Layout"], "CLICK "..frame.button:GetName()..":LeftButton" );
		end
	end
);

frame.button:SetAttribute( 
	"_onclick",
	[[
		if not IsAltKeyDown() or not IsControlKeyDown() or IsShiftKeyDown() then
				
			if button == "LeftButton" then	
				if CurrentPanel == #PanelList then
					CurrentPanel = 1;
				else
					CurrentPanel = CurrentPanel+1;
				end
			elseif button == "RightButton" then
				if CurrentPanel == 1 then
					CurrentPanel = #PanelList;
				else
					CurrentPanel = CurrentPanel-1;
				end
			end
		
			for i=1,#PanelList do
				local frame = self:GetFrameRef( PanelList[i] );
				
				if i == CurrentPanel then
					frame:Show();
				else
					frame:Hide();
				end
			end
		end
	]]
);

nUI_HUDLayoutSelector         = frame;
nUI_HUDLayoutSelector.Labels  = {};
nUI_HUDLayoutSelector.Layouts = {};

background:SetAllPoints( frame );
frame.button:SetAllPoints( frame );
--frame:SetAttribute( "addchild", frame.button );

frame.button:SetScript( "OnEnter",

	function()

--		nUI_ProfileStart( ProfileCounter, "OnEnter" );
		
		GameTooltip:SetOwner( frame.button );
		GameTooltip:SetText( frame.desc or nUI_L["Click to change HUD layouts"] );
		if frame.desc then 
			GameTooltip:AddLine( nUI_L["Click to change HUD layouts"] );
		end

		if not InCombatLockdown() then
			
			local key1, key2  = GetBindingKey( "CLICK "..frame.button:GetName()..":LeftButton" );

			if key1 then GameTooltip:AddLine( nUI_L["Key Binding"].." 1: |cFF00FFFF"..GetBindingText( key1, "KEY_" ).."|r", 1, 1, 1 ); end
			if key2 then GameTooltip:AddLine( nUI_L["Key Binding"].." 2: |cFF00FFFF"..GetBindingText( key2, "KEY_" ).."|r", 1, 1, 1 ); end									
			if not key1 and not key2 then GameTooltip:AddLine( nUI_L["No key bindings found"], 1, 1, 1 ); end

			GameTooltip:AddLine( nUI_L["<ctrl-alt-right click> to change bindings"], 0, 1, 1 );
			
		end
		
		GameTooltip:Show();

--		nUI_ProfileStop();
		
	end
);

frame.button:SetScript( "OnLeave", 

	function() 
--		nUI_ProfileStart( ProfileCounter, "OnLeave" );	
		GameTooltip:Hide(); 
--		nUI_ProfileStop();		
	end 
);

-------------------------------------------------------------------------------

frame.npc_target    = false;
frame.have_target   = false;
frame.player_combat = false;
frame.player_regen  = false;
frame.player_debuff = false;
frame.pet_combat    = false;
frame.pet_regen     = false;
frame.pet_debuff    = false;
frame.cur_alpha     = 1;

frame.newUnitInfo = function( unit_id, unit_info )
	
--	nUI_ProfileStart( ProfileCounter, "newUnitInfo" );
	
	local new_alpha;
	local hplost = nUI_Options.hplost;
	
	-- does the player have a target?
	
	if unit_id == "target" then
		frame.have_target = unit_info ~= nil;
		frame.live_target = unit_info and (not unit_info.status_info or (not unit_info.status_info.is_dead and not unit_info.status_info.is_ghost));
		
		if frame.have_target then
			frame.npc_target = not unit_info.is_controlled and not unit_info.attackable or false;
		else
			frame.npc_target = false;
		end
		
	-- does the player have a pet?
	
	elseif unit_id == "pet" and not unit_info then
		frame.pet_combat = false;
		frame.pet_regen  = false;
		frame.pet_debuff = false;
		
	-- if the player has a pet, is it in combat or a regenerative state?
	
	elseif unit_id == "pet" then
		frame.pet_combat = unit_info.status_info and unit_info.status_info.in_combat or false;
		frame.pet_regen  = (not hplost and unit_info.cur_health ~= unit_info.max_health) or (hplost and unit_info.cur_health > 0);
		frame.pet_regen  = frame.pet_regen or unit_info.cur_power ~= unit_info.max_power;
		frame.pet_debuff = unit_info.aura_info and unit_info.aura_info.debuff_list and #unit_info.aura_info.debuff_list > 0 or false;
		
	-- otherwise, we're processing the player
	
	elseif unit_id == "player" and unit_info then
		frame.player_combat = unit_info.status_info and unit_info.status_info.in_combat or false;
		frame.player_regen  = (not hplost and unit_info.cur_health ~= unit_info.max_health) or (hplost and unit_info.cur_health > 0);
		frame.player_regen  = frame.player_regen or unit_info.cur_power ~= ((unit_info.power_type == 1 or unit_info.power_type == 6 or unit_info.power_type == 17 or unit_info.power_type == 18) and 0 or unit_info.max_power);
		frame.player_debuff = unit_info.aura_info and unit_info.aura_info.debuff_list and #unit_info.aura_info.debuff_list > 0 or false;

		-- for death knights, also check to see if any runes are on cooldown
		
		if not player_combat 
		and not player_debuff
		and not player_regen
		and unit_info.runes		
		then		
			-- Legion Update TJK
			-- for i=1,6 do
			for i=1,#unit_info.runes do
			-- Legion Update TJK
				frame.player_regen = frame.player_regen or not unit_info.runes[i].ready;
			end
		end				
	end
	
	-- if we are in combat, then we use a full alpha HUD
	
	if frame.player_combat or frame.pet_combat then
		new_alpha = frame.alpha.combat;
		
	-- otherwise, if we have a target that is attackable, a player or want to show non-attackable NPCs, use the targeting alpha
	
	elseif frame.have_target and frame.live_target and (not frame.npc_target or nUI_Options.show_npc) then
		new_alpha = frame.alpha.target;
		
	-- if the player or player's pet is not a full health, full power or has debuffs, use the regen alpha
	
	elseif frame.player_regen or frame.pet_regen or frame.player_debuff or frame.pet_debuff then
		new_alpha = frame.alpha.regen;
		
	-- otherwise use the idle alpha
	
	else
		new_alpha = frame.alpha.idle;
	end
	
	if frame.cur_alpha ~= new_alpha then
		
		frame.cur_alpha = new_alpha;

		if frame.hud then 
			frame.hud.fader:SetAlpha( new_alpha );
		end
	end	

--	nUI_ProfileStop();
	
end

-------------------------------------------------------------------------------

frame.applyScale = function( scale )
	
--	nUI_ProfileStart( ProfileCounter, "applyScale" );
	
	local scale    = scale or frame.scale or 1;
	local options  = frame.options;
	local fontsize = (options and options.label and options.label.fontsize or 12) * nUI.vScale * 1.75;
	
	frame.scale   = scale;
	
	if options then
		
		local width  = options.width * scale * nUI.hScale;
		local height = options.height * scale * nUI.vScale;
		
		if frame.width ~= width
		or frame.height ~= height
		then
			
			frame.width  = width;
			frame.height = height;
			
			frame:SetWidth( width );
			frame:SetHeight( height );
			
		end
	end
	
	if frame.text.fontsize ~= fontsize then
		frame.text.fontsize = fontsize;
		frame.text:SetFont( nUI_L["font1"], fontsize, "OUTLINE" );
	end
	
--	nUI_ProfileStop();
	
end

-------------------------------------------------------------------------------

frame.applyAnchor = function( anchor )
	
--	nUI_ProfileStart( ProfileCounter, "applyAnchor" );
	
	local anchor      = anchor or frame.anchor or {};
	local anchor_pt   = anchor.anchor_pt or "CENTER";
	local relative_to = anchor.relative_to or "nUI_TopBars";
	local relative_pt = anchor.relative_pt or "CENTER";
	local xOfs        = (anchor.xOfs or 0) * nUI.hScale;
	local yOfs        = (anchor.yOfs or 0) * nUI.vScale;
	
	frame.anchor = anchor;
	
	if frame.xOfs ~= xOfs
	or frame.yOfs ~= yOfs
	or frame.anchor_pt ~= anchor_pt
	or frame.relative_to ~= relative_to
	or frame.relative_pt ~= relative_pt
	then
		
		frame.anchor_pt = anchor_pt;
		frame.relative_to = relative_to;
		frame.relative_pt = relative_pt;
		frame.xOfs        = xOfs;
		frame.yOfs        = yOfs;
		
		frame:ClearAllPoints();
		frame:SetPoint( anchor_pt, relative_to, relative_pt, xOfs, yOfs );
		
	end

	if frame.options then

		local label = frame.options.label;
		
		if label and label.enabled then
			
			anchor_pt   = label.anchor_pt or "CENTER";
			relative_to = label.relative_to or frame:GetName();
			relative_pt = label.relative_pt or anchor_pt;			
			xOfs        = (label.xOfs or 0) * frame.scale * nUI.hScale;
			yOfs        = (label.yOfs or 0) * frame.scale * nUI.vScale;
			
			if frame.text.xOfs ~= xOfs
			or frame.text.yOfs ~= yOfs
			or frame.text.anchor_pt ~= anchor_pt
			or frame.text.relative_to ~= relative_to
			or frame.text.relative_pt ~= relative_pt
			then
				
				frame.text.anchor_pt   = anchor_pt;
				frame.text.relative_to = relative_to;
				frame.text.relative_pt = relative_pt;
				frame.text.xOfs        = xOfs;
				frame.text.yOfs        = yOfs;
				
				frame.text:SetPoint( anchor_pt, relative_to, relative_pt, xOfs, yOfs );
				
			end			
		end		
	end

--	nUI_ProfileStop();
	
end

-------------------------------------------------------------------------------

frame.applyOptions = function( options )
	
--	nUI_ProfileStart( ProfileCounter, "applyOptions" );
	
	frame.options = options;
	
	if not options or not options.enabled then
		
		frame.enabled = false;
		background:Hide();
		
	else
		
		frame.enabled = true;
		background:Show();
		
		background:SetFrameStrata( options.strata or nUI_Dashboard:GetFrameStrata() );
		background:SetFrameLevel( options.level or nUI_Dashboard:GetFrameLevel()+2 );

		frame.alpha = nUI_Options.hud_alpha or options.alpha;
		
		if not options.label or not options.label.enabled then
			
			frame.text.enabled = false;
			frame.text.value   = nil;
			frame.text:SetAlpha( 0 );
			frame.text:SetText( "" );
			
		else
			
			frame.text.enabled = true;
			frame.text:SetAlpha( 1 );
			
			local color = options.label.color or {};
			
			frame.text:SetTextColor( color.r or 1, color.g or 0.83, color.b or 0, color.a or 1 );
			
		end
		
		if options.border then
			
			local backdrop_color = options.border.color.backdrop;
			local border_color   = options.border.color.border;
			
			frame:SetBackdrop( options.border.backdrop );
			frame:SetBackdropColor( backdrop_color.r, backdrop_color.g, backdrop_color.b, backdrop_color.a );
			frame:SetBackdropBorderColor( border_color.r, border_color.g, border_color.b, border_color.a );
			
		else
			
			frame:SetBackdrop( nil );
			
		end
		
		if options.background then
			
			local backdrop_color = options.background.color.backdrop;
			local border_color   = options.background.color.border;
			
			frame:SetBackdrop( options.background.backdrop );
			frame:SetBackdropColor( backdrop_color.r, backdrop_color.g, backdrop_color.b, backdrop_color.a );
			frame:SetBackdropBorderColor( border_color.r, border_color.g, border_color.b, border_color.a );
			
		end

		frame.applyScale( options.scale or frame.scale or 1 );
	
	end	

--	nUI_ProfileStop();
	
end

-------------------------------------------------------------------------------

frame.applySkin = function( skin )
	
--	nUI_ProfileStart( ProfileCounter, "applySkin" );
	
	-- we don't allow the skin developer to not include HUD layouts... if they
	-- don't specify them, we use the default
	
	local skin = skin.HUDLayoutSelector or nUI_DefaultConfig.HUDLayoutSelector;
	
	if not skin or not skin.options.enabled then
		
		frame.enabled = false;
		background:Hide();
		
	else
		
		local have_selection   = false;
		local rotation         = {};
		local buttonbag_states = nil;
		
		frame.enabled = true;
		background:Show();

		frame.applyOptions( skin.options );
		frame.applyAnchor( skin.anchor );

		-- parse the list of available panels.
		
		for layout_name in pairs( nUI_HUDLayouts ) do
	
			local layout_config = nUI_HUDLayouts[layout_name];
			local layout_info   = nUI_HUDLayoutSelector.Layouts[layout_name];
			
			-- if it the layout is diabled, then make sure it's not longer visible
			-- or in the rotation
			
			if not layout_config.enabled 
			then
				
				if layout_info then
						
					local hframe  = layout_info.frame;
					
					hframe.enabled = false;
					hframe:Hide();
					
					layout_info.enabled = false;
					
				end
				
			else

				if layout_name == nUI_Options.hud_layout then
					have_selection = layout_name;
				end
				
				-- create the  the HUD anchor frame for the new layout

				local hframe;
				
				if not layout_info then 
					
					hframe        = CreateFrame( "Frame", layout_name, nUI_Dashboard.Anchor, "SecureHandlerStateTemplate" );
					hframe.fader  = CreateFrame( "Frame", "$parentFader", hframe );
					hframe.left   = CreateFrame( "Frame", "$parentLeft", hframe );
					hframe.right  = CreateFrame( "Frame", "$parentRight", hframe );
					hframe.top    = CreateFrame( "Frame", "$parentTop", hframe );
					hframe.bottom = CreateFrame( "Frame", "$parentBottom", hframe );
					
					hframe:SetAttribute( "nUI_showstate", layout_name );
					
					hframe:SetAttribute( 
						"_onstate-selected",
						[[
							local showstate = self:GetAttribute( "nUI_showstate" );
							
							if newstate and showstate and showstate == newstate then
								self:Show();
							else
								self:Hide();
							end
						]]
					);
										
					hframe.enabled  = true;
					hframe.Elements = {};
					
					hframe.left:SetWidth( 2 );
					hframe.left:SetHeight( 2 );
					hframe.right:SetWidth( 2 );
					hframe.right:SetHeight( 2 );
					hframe.top:SetWidth( 2 );
					hframe.top:SetHeight( 2 );
					hframe.bottom:SetWidth( 2 );
					hframe.bottom:SetHeight( 2 );

					hframe.hGap  = (nUI_Options.hud_hGap or 400) * nUI.hScale;
					hframe.vOfs  = (nUI_Options.hud_vOfs and nUI_Options.hud_vOfs ~= 0 and nUI_Options.hud_vOfs or 0) * nUI.vScale;
					hframe.scale = nUI_Options.hud_scale or 1;
					
					hframe.fader:SetScale( hframe.scale );
					hframe:SetAlpha( frame.cur_alpha );
					hframe:SetPoint( "CENTER", WorldFrame, "CENTER", 0, hframe.vOfs );
					hframe.left:SetPoint( "CENTER",   hframe, "CENTER", -hframe.hGap, 0 );
					hframe.right:SetPoint( "CENTER",  hframe, "CENTER", hframe.hGap, 0 );
					hframe.top:SetPoint( "CENTER",    hframe, "CENTER", 0, layout_config.options.vGap/2 );
					hframe.bottom:SetPoint( "CENTER", hframe, "CENTER", 0, -layout_config.options.vGap/2 );

--					frame:SetAttribute( "addchild", hframe );
--					hframe:SetAttribute( "showstates", layout_name );				

					layout_info =
					{
						layout_name = layout_name,
						config      = layout_config,
						frame       = hframe,
					};

					nUI_HUDLayoutSelector.Layouts[layout_name] = layout_info;
					
				else

					layout_info.config = layout_config;
					hframe             = layout_info.frame;
				
					if not hframe.enabled then
						
						hframe.enabled = true;
						hframe:Show();
						
					end									
				end

				layout_info.enabled = true;

				-- set up the tooltip and selector button labeling and callback notification to the 
				-- underlying info panel addon to let it know when it's been selected and deselected
				
				hframe:SetFrameStrata( frame:GetFrameStrata() );
				hframe:SetFrameLevel( frame:GetFrameLevel()+1 );
				
				hframe:SetScript( "OnShow",
					function()
				
--						nUI_ProfileStart( FrameProfileCounter, "OnShow" );
	
--						nUI:debug( "nUI_HUD: Showing HUD layout ["..layout_name.."]", 1 );
												
						nUI_Options.hud_layout     = layout_name;
						nUI_HUDLayoutSelector.desc = layout_config.desc;
						nUI_HUDLayoutSelector.hud  = hframe;

						nUI_HUDLayoutSelector.text:SetText( layout_config.label );
						
						if (nUI_Options.hud_hGap or 400) * nUI.hScale ~= hframe.hGap then
							
							hframe.hGap = (nUI_Options.hud_hGap or 400) * nUI.hScale;
							
							hframe.left:ClearAllPoints();
							hframe.left:SetPoint( "CENTER", hframe, "CENTER", -hframe.hGap, 0 );
						
							hframe.right:ClearAllPoints();
							hframe.right:SetPoint( "CENTER", hframe, "CENTER", hframe.hGap, 0 );
						
						end
						
						if (nUI_Options.hud_vOfs and nUI_Options.hud_vOfs ~= 0 and nUI_Options.hud_vOfs or 0) * nUI.vScale ~= hframe.vOfs then
							
							hframe.vOfs = (nUI_Options.hud_vOfs and nUI_Options.hud_vOfs ~= 0 and nUI_Options.hud_vOfs or 0) * nUI.vScale;
							
							hframe:ClearAllPoints();
							hframe:SetPoint( "CENTER", WorldFrame, "CENTER", 0, hframe.vOfs );
						
						end
						
						hframe.fader:SetAlpha( frame.cur_alpha );
						
						if GameTooltip:IsOwned( nUI_HUDLayoutSelector.button ) then
							GameTooltip:SetText( layout_config.desc or nUI_L["Click to change HUD layouts"] );
						end
						
						for element_name in pairs( hframe.Elements ) do
							hframe.Elements[element_name].setEnabled( true );
						end

						if hframe.scale ~= nUI_Options.hud_scale then
							hframe:SetScale( nUI_Options.hud_scale or 1 );
							hframe.scale = nUI_Options.hud_scale or 1;
						end
						
						if hframe.health_race then 
							hframe.health_race.setEnabled( nUI_Options.hud_healthrace );
						end
						
						if hframe.cooldown then 
							hframe.cooldown.setEnabled( nUI_Options.hud_cooldown );
						end
						
--						nUI_ProfileStop();
						
					end
				);
				
				hframe:SetScript( "OnHide",
					function()
						
--						nUI_ProfileStart( FrameProfileCounter, "OnHide" );
	
--						nUI:debug( "nUI_HUD: Hiding HUD layout ["..layout_name.."]", 1 );
						
						for element_name in pairs( hframe.Elements ) do
							hframe.Elements[element_name].setEnabled( false );
						end
						
						if hframe.health_race then
							hframe.health_race.setEnabled( false );
						end						

						if hframe.cooldown then
							hframe.cooldown.setEnabled( false );
						end						

--						nUI_ProfileStop();
						
					end
				);
				
				-- create method for managing the visibility of the focus elements of the HUD
				
				hframe.setFocusVisibility = function()

					if hframe.focus_pairs then
					
						if hframe.focus_pairs["target"] then
						
							local normal = _G[hframe.focus_pairs["target"].normal];
							local focus  = _G[hframe.focus_pairs["target"].focus];

							if not normal or not focus then
								nUI:debug( "Could not create target focus pair for "..hframe:GetName() );
							elseif nUI_Options.hud_focus then							
								normal.setVisibility( "[target=focus, exists] hide; [target=target, exists] show; hide" );
								focus.setVisibility( "[target=focus, exists] show; hide" );
							else
								normal.setVisibility( "[target=target, exists] show; hide" );
								focus.setVisibility( "hide" );
							end
						end
						
						if hframe.focus_pairs["tot"] then
						
							local normal = _G[hframe.focus_pairs["tot"].normal];
							local focus  = _G[hframe.focus_pairs["tot"].focus];
							
							if not normal or not focus then
								nUI:debug( "Could not create ToT focus pair for "..hframe:GetName() );
							elseif nUI_Options.hud_focus then							
								normal.setVisibility( "[target=focustarget, exists] hide; [target=targettarget, exists] show; hide" );
								focus.setVisibility( "[target=focustarget, exists] show; hide" );
							else
								normal.setVisibility( "[target=targettarget, exists] show; hide" );
								focus.setVisibility( "hide" );
							end
						end
					end
				end

				-- add the new panel to the list of panels in the rotation
				
				local item =
				{
					desc     = layout_info.config.desc,
					rotation = layout_info.config.rotation,
					frame    = layout_info.frame,
					name     = layout_name,					
				};

				table.insert( rotation, item );
				
				-- add the elements to the frame...
				
				if layout_config.elements then
					
					-- create the unit frames
					
					if layout_config.elements.units then
							
						for unit_name in pairs( layout_config.elements.units ) do
							
							local options = layout_config.elements.units[unit_name].options;
		
							-- if the unit already exists and the option is not enabled, then
							-- disable the frame
							
							if not options.enabled then
								
--								nUI:debug( "nUI_HUD: unit [ "..unit_name.." ] is disabled", 1 );
								if hframe.Elements[unit_name] then
									hframe.Elements[unit_name].setEnabled( false );
								end
							
							-- otherwise, if the unit does not exist yet, create it
							
							elseif not hframe.Elements[unit_name] then
								
--								nUI:debug( "nUI_HUD: creating unit [ "..unit_name.." ]", 1 );
								hframe.Elements[unit_name] = nUI_Unit:createUnit( unit_name, options.fade and hframe.fader or hframe, options );
								
							-- and if it does exist, then update the skin and make sure
							-- the unit is enabled
							
							else
								hframe.Elements[unit_name].applyOptions( options );
								hframe.Elements[unit_name].setEnabled( true );
							end
						end
					end
					
					-- create the health race bar
					
					local health_race = layout_config.elements.health_race;
					
					if health_race and health_race.enabled then
						
						hframe.health_race = nUI_Bars:createHealthRaceBar( health_race.name, health_race.options.fade and hframe.fader or hframe, health_race.options );
						hframe.health_race.applyAnchor( health_race.anchor );
						hframe.health_race.setEnabled( nUI_Options.hud_healthrace );
						
						if not nUI_Options.hud_healthrace then
							UnregisterUnitWatch( hframe.health_race );
						end

					elseif hframe.health_race then
						
						hframe.health_race.deleteBar();
						hframe.health_race = nil;
						
					end
					
					-- create the cooldown bar
					
					local cooldown = layout_config.elements.cooldown_bar;
					
					if cooldown and cooldown.enabled then
						
						hframe.cooldown = nUI_Bars:createCooldownBar( cooldown.name, cooldown.options.fade and hframe.fader or hframe, cooldown.options );
						hframe.cooldown.applyAnchor( cooldown.anchor );
						hframe.cooldown.setEnabled( nUI_Options.hud_cooldown );

					elseif hframe.cooldown then
						
						hframe.cooldown.deleteBar();
						hframe.cooldown = nil;
						
					end
	
					-- if the user has enabled the HUD Focus ability, then modify the visibility rules for
					-- the target, focus, ToT and focus target accordingly
					
					hframe.focus_pairs = layout_config.options.focus_pairs;

					hframe.setFocusVisibility();
									
				-- if there are no elements to deal with at all... then disable everything
				
				else
					for unit_name in pairs( hframe.Elements ) do
						hframe.Elements[unit_name].setEnabled( false );
					end
				end
								
				hframe:Hide();
				
			end
		end
		
		-- create the rotation and select the correct panel
		
		local state_string = nil;
		
		nUI:TableSort( rotation, SortLayoutList );

		for item in pairs( rotation ) do		
			local name = rotation[item].name;
			frame.button:SetAttribute( "nUI_HUDPanel"..item, name );
			frame.button:SetFrameRef( name, rotation[item].frame );
		end
		
		-- if we have no selected unit panels (first time loaded) then default to
		-- the solo player unit panel, otherwise, select the last panel the user selected

		local selected    = have_selection or nUI_HUDLAYOUT_PLAYERTARGET;
		local layout_info = nUI_HUDLayoutSelector.Layouts[selected];
		
		if not layout_info or not layout_info.enabled then
			selected    = nUI_HUDLAYOUT_PLAYERTARGET;
			layout_info = nUI_HUDLayoutSelector.Layouts[selected];
		end
		
		if layout_info then
			
			for item in pairs( rotation ) do
				
				rotation[item].frame:SetAttribute( "state-selected", selected );
				
				if rotation[item].name == selected then
					frame.button:SetAttribute( "state", item );
				end
			end
			
			nUI_HUDLayoutSelector:SetAttribute( "state", selected );
			nUI_HUDLayoutSelector.text:SetText( layout_info.config.label );
			
			nUI_HUDLayoutSelector.desc = layout_info.config.desc;		
			nUI_Options.hud_layout     = selected;
			
		end
		
		frame.button:Execute(
			[[
				local i = 1;
				
				PanelList = newtable();
				
				while true do
					
					local panel_name = self:GetAttribute( "nUI_HUDPanel"..i );
					
					if not panel_name then 
						break;
					end
					
					PanelList[i] = panel_name;
					i = i+1;
					
				end
				
				CurrentPanel = self:GetAttribute( "state" ) or 1;
			]]
		);
	end

--	nUI_ProfileStop();
	
end

-------------------------------------------------------------------------------

local function onHUDLayoutEvent( who, event, arg1 )
	
--	nUI_ProfileStart( ProfileCounter, "onHUDLayoutEvent", event );

	if event == "ADDON_LOADED" and arg1 == "nUI" then

		_G["BINDING_HEADER_nUI_MISCKEYS"] = "nUI: "..nUI_L["Miscellaneous Bindings"];		
		_G["BINDING_NAME_CLICK "..frame.button:GetName()..":LeftButton"] = nUI_L["HUD Layout"];		

		nUI:registerSkinnedFrame( frame );
		nUI:registerScalableFrame( frame );

		if not nUI_Options.hud_alpha then 
			nUI_Options.hud_alpha = nUI_DefaultConfig.HUDLayoutSelector.options.alpha;
		end

		if not nUI_Options.hud_hGap then
			nUI_Options.hud_hGap = 400;
		end

		if not nUI_Options.hud_vOfs then
			nUI_Options.hud_vOfs = 0;
		end

		if not nUI_Options.hud_scale then
			nUI_Options.hud_scale = 1;
		end
		
		frame.alpha = nUI_Options.hud_alpha

		-- set up a slash command handler for dealing with setting the HUD scale
		
		local master = nUI_SlashCommands[nUI_SLASHCMD_HUD];
		local option = master.sub_menu[nUI_SLASHCMD_HUD_SCALE];
		
		nUI_SlashCommands:setSubHandler( master.command, option.command,
			
			function( msg, arg1 )
				
				local scale = tonumber( arg1 or "1" );
				
				if not scale or scale < 0.25 or scale > 1.75 then
			
					DEFAULT_CHAT_FRAME:AddMessage( nUI_L["nUI: The value [ %s ] is not a valid HUD scale. Please choose a number between 0.25 and 1.75"]:format( arg1 ), 1, 0.83, 0 );
					
				elseif nUI_Options.hud_scale ~= scale then
						
					nUI_Options.hud_scale = scale;
					
					DEFAULT_CHAT_FRAME:AddMessage( (option.message):format( scale ), 1, 0.83, 0 );
					
					if frame.hud then frame.hud:SetScale( scale ); end
					
				end				
			end
		);
		
		-- set up a slash command handler for dealing with setting the HUD's show_npc mode
		
		local master = nUI_SlashCommands[nUI_SLASHCMD_HUD];
		local option = master.sub_menu[nUI_SLASHCMD_HUD_SHOWNPC];
		
		nUI_SlashCommands:setSubHandler( master.command, option.command,
			
			function( msg )
				
				nUI_Options.show_npc = not nUI_Options.show_npc;
				
				DEFAULT_CHAT_FRAME:AddMessage( (option.message):format( nUI_Options.show_npc and nUI_L["|cFF00FF00ENABLED|r"] or nUI_L["|cFFFF0000DISABLED|r"] ), 1, 0.83, 0 );
				
				frame.newUnitInfo( "target", nUI_Unit.TargetInfo );
				
			end
		);
		
		-- set up a slash command handler for dealing with setting the HUD's show focus mode
		
		local master = nUI_SlashCommands[nUI_SLASHCMD_HUD];
		local option = master.sub_menu[nUI_SLASHCMD_HUD_FOCUS];
		
		nUI_SlashCommands:setSubHandler( master.command, option.command,
			
			function( msg )
				
				nUI_Options.hud_focus = not nUI_Options.hud_focus;
				
				DEFAULT_CHAT_FRAME:AddMessage( (option.message):format( nUI_Options.hud_focus and nUI_L["|cFF00FF00ENABLED|r"] or nUI_L["|cFFFF0000DISABLED|r"] ), 1, 0.83, 0 );
				
				for name in pairs( nUI_HUDLayoutSelector.Layouts ) do
					nUI_HUDLayoutSelector.Layouts[name].frame.setFocusVisibility();
				end
			end
		);
		
		-- set up a slash command handler for dealing with setting the HUD's health race bar toggle
		
		local master = nUI_SlashCommands[nUI_SLASHCMD_HUD];
		local option = master.sub_menu[nUI_SLASHCMD_HUD_HEALTHRACE];
		
		nUI_SlashCommands:setSubHandler( master.command, option.command,
			
			function( msg )
				
				nUI_Options.hud_healthrace = not nUI_Options.hud_healthrace;
				
				DEFAULT_CHAT_FRAME:AddMessage( (option.message):format( nUI_Options.hud_healthrace and nUI_L["|cFF00FF00ENABLED|r"] or nUI_L["|cFFFF0000DISABLED|r"] ), 1, 0.83, 0 );
				
				if frame.hud and frame.hud.health_race then 
					
					frame.hud.health_race.setEnabled( nUI_Options.hud_healthrace );
					
					if nUI_Options.hud_healthrace then
						RegisterUnitWatch( frame.hud.health_race );
						frame.hud.health_race.newUnitInfo( "player", nUI_Unit.PlayerInfo );
						frame.hud.health_race.newUnitInfo( "target", nUI_Unit.TargetInfo );
					else
						UnregisterUnitWatch( frame.hud.health_race );
					end
				end				
			end
		);
		
		-- set up a slash command handler for dealing with setting the HUD's cooldown bar toggle
		
		local master = nUI_SlashCommands[nUI_SLASHCMD_HUD];
		local option = master.sub_menu[nUI_SLASHCMD_HUD_COOLDOWN];
		
		nUI_SlashCommands:setSubHandler( master.command, option.command,
			
			function( msg )
				
				nUI_Options.hud_cooldown = not nUI_Options.hud_cooldown;
				
				DEFAULT_CHAT_FRAME:AddMessage( (option.message):format( nUI_Options.hud_cooldown and nUI_L["|cFF00FF00ENABLED|r"] or nUI_L["|cFFFF0000DISABLED|r"] ), 1, 0.83, 0 );
				
				if frame.hud and frame.hud.cooldown then 
					
					frame.hud.cooldown.setEnabled( nUI_Options.hud_cooldown );
					
				end				
			end
		);
		
		-- set up a slash command handler for dealing with setting the HUD's cooldown alert message toggle
		
		local master = nUI_SlashCommands[nUI_SLASHCMD_HUD];
		local option = master.sub_menu[nUI_SLASHCMD_HUD_CDALERT];
		
		nUI_SlashCommands:setSubHandler( master.command, option.command,
			
			function( msg )
				
				nUI_Options.hud_cdalert = not nUI_Options.hud_cdalert;
				
				DEFAULT_CHAT_FRAME:AddMessage( (option.message):format( nUI_Options.hud_cdalert and nUI_L["|cFF00FF00ENABLED|r"] or nUI_L["|cFFFF0000DISABLED|r"] ), 1, 0.83, 0 );
				
			end
		);
		
		-- set up a slash command handler for dealing with setting the HUD's cooldown alert sound toggle
		
		local master = nUI_SlashCommands[nUI_SLASHCMD_HUD];
		local option = master.sub_menu[nUI_SLASHCMD_HUD_CDSOUND];
		
		nUI_SlashCommands:setSubHandler( master.command, option.command,
			
			function( msg )
				
				nUI_Options.hud_cdsound = not nUI_Options.hud_cdsound;
				
				DEFAULT_CHAT_FRAME:AddMessage( (option.message):format( nUI_Options.hud_cdsound and nUI_L["|cFF00FF00ENABLED|r"] or nUI_L["|cFFFF0000DISABLED|r"] ), 1, 0.83, 0 );
				
			end
		);
		
		-- set up a slash command handler for dealing with setting the HUD's cooldown minimum time requirement for display
		
		local master = nUI_SlashCommands[nUI_SLASHCMD_HUD];
		local option = master.sub_menu[nUI_SLASHCMD_HUD_CDMIN];
		
		nUI_SlashCommands:setSubHandler( master.command, option.command,
			
			function( msg, arg1 )
				
				local minCooldown = tonumber( arg1 or "2" ) or "2";
				
				if nUI_Options.minCooldown ~= minCooldown then
				
					nUI_Options.minCooldown = minCooldown;
				
					DEFAULT_CHAT_FRAME:AddMessage( (option.message):format( minCooldown ), 1, 0.83, 0 );
				end		
			end
		);
		
		-- set up a slash command handler for dealing with setting the HUD's horizontal gap
		
		local master = nUI_SlashCommands[nUI_SLASHCMD_HUD];
		local option = master.sub_menu[nUI_SLASHCMD_HUD_HGAP];
		
		nUI_SlashCommands:setSubHandler( master.command, option.command,
			
			function( msg, arg1 )
				
				local hGap = tonumber( arg1 or "400" );
				
				if not hGap or hGap < 0 or hGap > 1200 then
					
					DEFAULT_CHAT_FRAME:AddMessage( nUI_L["nUI: [ %s ] is not a valid horizontal gap value... please choose a number between 1 and 1200 where 1 is very narrow and 1200 is very wide."]:format( arg1 ), 1, 0.83, 0 );
					
				elseif nUI_Options.hud_hGap ~= hGap then
					
					nUI_Options.hud_hGap = hGap;
					
					DEFAULT_CHAT_FRAME:AddMessage( (option.message):format( hGap ), 1, 0.83, 0 );
					
					frame.hud.hGap = hGap * nUI.hScale;
					
					frame.hud.left:ClearAllPoints();
					frame.hud.left:SetPoint( "CENTER", frame.hud, "CENTER", -frame.hud.hGap, 0 );
					
					frame.hud.right:ClearAllPoints();
					frame.hud.right:SetPoint( "CENTER", frame.hud, "CENTER", frame.hud.hGap, 0 );

				end
			end
		);		
		
		-- set up a slash command handler for dealing with setting the HUD's vertical offset
		
		local master = nUI_SlashCommands[nUI_SLASHCMD_HUD];
		local option = master.sub_menu[nUI_SLASHCMD_HUD_VOFS];
		
		nUI_SlashCommands:setSubHandler( master.command, option.command,
			
			function( msg, arg1 )
				
				local vOfs = tonumber( arg1 or "0" );
				
				if nUI_Options.hud_vOfs ~= vOfs then
					
					nUI_Options.hud_vOfs = vOfs;
					
					DEFAULT_CHAT_FRAME:AddMessage( (option.message):format( vOfs ), 1, 0.83, 0 );
					
					frame.hud.vOfs = vOfs * nUI.vScale;
					
					frame.hud:ClearAllPoints();
					frame.hud:SetPoint( "CENTER", WorldFrame, "CENTER", 0, frame.hud.vOfs );

				end
			end
		);		
		
		-- set up a slash command handler for dealing with setting the HUD's idlealpha command
		
		local master = nUI_SlashCommands[nUI_SLASHCMD_HUD];
		local option = master.sub_menu[nUI_SLASHCMD_HUD_IDLEALPHA];
		
		nUI_SlashCommands:setSubHandler( master.command, option.command,
			
			function( msg, arg1 )
				
				local alpha = tonumber( arg1 or "0" );
				
				if not alpha or alpha < 0 or alpha > 1 then
					
					DEFAULT_CHAT_FRAME:AddMessage( nUI_L["nUI: [ %s ] is not a valid alpha value... please choose a number between 0 and 1 where 0 is fully transparent and 1 is fully opaque."]:format( arg1 ), 1, 0.83, 0 );
					
				elseif nUI_Options.hud_alpha.idle ~= alpha then
					
					nUI_Options.hud_alpha.idle = alpha;
					
					DEFAULT_CHAT_FRAME:AddMessage( (option.message):format( alpha ), 1, 0.83, 0 );
					
					frame.newUnitInfo( "target", nUI_Unit.TargetInfo );

				end
			end
		);		
		
		-- set up a slash command handler for dealing with setting the HUD's idlealpha command
		
		local master = nUI_SlashCommands[nUI_SLASHCMD_HUD];
		local option = master.sub_menu[nUI_SLASHCMD_HUD_REGENALPHA];
		
		nUI_SlashCommands:setSubHandler( master.command, option.command,
			
			function( msg, arg1 )
				
				local alpha = tonumber( arg1 or "0.35" );
				
				if not alpha or alpha < 0 or alpha > 1 then
					
					DEFAULT_CHAT_FRAME:AddMessage( nUI_L["nUI: [ %s ] is not a valid alpha value... please  choose a number between 0 and 1 where 0 is fully transparent and 1 is fully opaque."]:format( arg1 ), 1, 0.83, 0 );
					
				elseif nUI_Options.hud_alpha.regen ~= alpha then
					
					nUI_Options.hud_alpha.regen = alpha;
					
					DEFAULT_CHAT_FRAME:AddMessage( (option.message):format( alpha ), 1, 0.83, 0 );
					
					frame.newUnitInfo( "target", nUI_Unit.TargetInfo );

				end
			end
		);		
		
		-- set up a slash command handler for dealing with setting the HUD's idlealpha command
		
		local master = nUI_SlashCommands[nUI_SLASHCMD_HUD];
		local option = master.sub_menu[nUI_SLASHCMD_HUD_TARGETALPHA];
		
		nUI_SlashCommands:setSubHandler( master.command, option.command,
			
			function( msg, arg1 )
				
				local alpha = tonumber( arg1 or "0.75" );
				
				if not alpha or alpha < 0 or alpha > 1 then
					
					DEFAULT_CHAT_FRAME:AddMessage( nUI_L["nUI: [ %s ] is not a valid alpha value... please choose a number between 0 and 1 where 0 is fully transparent and 1 is fully opaque."]:format( arg1 ), 1, 0.83, 0 );
					
				elseif nUI_Options.hud_alpha.target ~= alpha then
					
					nUI_Options.hud_alpha.target = alpha;
					
					DEFAULT_CHAT_FRAME:AddMessage( (option.message):format( alpha ), 1, 0.83, 0 );
					
					frame.newUnitInfo( "target", nUI_Unit.TargetInfo );

				end
			end
		);		
		
		-- set up a slash command handler for dealing with setting the HUD's idlealpha command
		
		local master = nUI_SlashCommands[nUI_SLASHCMD_HUD];
		local option = master.sub_menu[nUI_SLASHCMD_HUD_COMBATALPHA];
		
		nUI_SlashCommands:setSubHandler( master.command, option.command,
			
			function( msg, arg1 )
				
				local alpha = tonumber( arg1 or "1" );
				
				if not alpha or alpha < 0 or alpha > 1 then
					
					DEFAULT_CHAT_FRAME:AddMessage( nUI_L["nUI: [ %s ] is not a valid alpha value... please choose a number between 0 and 1 where 0 is fully transparent and 1 is fully opaque."]:format( arg1 ), 1, 0.83, 0 );
					
				elseif nUI_Options.hud_alpha.combat ~= alpha then
					
					nUI_Options.hud_alpha.combat = alpha;
					
					DEFAULT_CHAT_FRAME:AddMessage( (option.message):format( alpha ), 1, 0.83, 0 );
					
					frame.newUnitInfo( "target", nUI_Unit.TargetInfo );

				end
			end
		);		

	elseif event == "PLAYER_LOGIN" then
		
		nUI_Unit:registerUnitChangeCallback( "target", frame );
		nUI_Unit:registerReactionCallback( "target", frame );
		nUI_Unit:registerCombatCallback( "pet", frame );
		nUI_Unit:registerHealthCallback( "pet", frame );
		nUI_Unit:registerPowerCallback( "pet", frame );
		nUI_Unit:registerAuraCallback( "pet", frame );
		nUI_Unit:registerCombatCallback( "player", frame );
		nUI_Unit:registerHealthCallback( "player", frame );
		nUI_Unit:registerPowerCallback( "player", frame );
		nUI_Unit:registerAuraCallback( "player", frame );
		nUI_Unit:registerRunesCallback( "player", frame );

	end
	
--	nUI_ProfileStop();
	
end

nUI_HUDLayoutSelector:SetScript( "OnEvent", onHUDLayoutEvent );
nUI_HUDLayoutSelector:RegisterEvent( "ADDON_LOADED" );
nUI_HUDLayoutSelector:RegisterEvent( "PLAYER_LOGIN" );
