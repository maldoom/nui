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

if not nUI_InfoPanels then nUI_InfoPanels = {}; end

local CreateFrame = CreateFrame;
local GetTime     = GetTime;

-------------------------------------------------------------------------------
-- default configuration for the battlefield minimap info panel

nUI_InfoPanels[nUI_INFOPANEL_BMM] =
{	
	enabled   = true,
	desc      = nUI_L[nUI_INFOPANEL_BMM],			-- player friendly name/description of the panel
	label     = nUI_L[nUI_INFOPANEL_BMM.."Label"],	-- label to use on the panel selection button face
	rotation  = nUI_INFOMODE_BMM,					-- index or position this panel appears on/in when clicking the selector button
	full_size = false;								-- this plugin requires the entire info panel port without the button bag
	
	options  =
	{
		enabled  = true,
	},
};

-------------------------------------------------------------------------------

local refresh = 0.1;
local coords  = nil;

local function nUI_BmmCoordUpdate( who, elapsed )
	
	refresh = refresh - elapsed;
	
	if refresh <= 0 then
		
		refresh = 0.1;
		
		if MouseIsOver( BattlefieldMinimap ) and BattlefieldMinimap:IsVisible() then
				
			local cursor_x, cursor_y = GetCursorPosition();
			local map_scale          = BattlefieldMinimap:GetEffectiveScale();
			local map_left           = BattlefieldMinimap:GetLeft() * map_scale;
			local map_top            = BattlefieldMinimap:GetTop() * map_scale;
			local map_width          = BattlefieldMinimap:GetWidth() * 0.98;
			local map_height         = BattlefieldMinimap:GetHeight() * 0.98;
			
			cursor_x = (cursor_x - map_left) / map_scale;
			cursor_y = (map_top - cursor_y) / map_scale;
			
			cursor_x = max( 0, min( (cursor_x / map_width * 100), 100 ) );	
			cursor_y = max( 0, min( (cursor_y / map_height * 100), 100 ) );
			
			coords = ("|cFF00FFFF<%0.0f, %0.0f>|r>"):format( cursor_x, cursor_y );
			
			nUI_BmmLocation.label:SetText( coords );
			
		elseif coords then
			
			coords = nil;
			nUI_BmmLocation.label:SetText( "" );
			
		end
	end
end

-------------------------------------------------------------------------------
-- master frame for the plugin

local CombatHit = {};
local UnitInfo  = {};
local POIList   = {};
local plugin    = CreateFrame( "Frame", nUI_INFOPANEL_BMM, nUI_Dashboard.Anchor );
plugin.active   = true;

-------------------------------------------------------------------------------

local timer = 0;

local function onBattlefieldMinimapUpdate( who, elapsed )
	
	timer = timer + elapsed;
	
	if timer >= 0.08 then -- about 12.5fps update
	
		local now          = GetTime();

		timer = 0;
		
		for unit_id in pairs( CombatHit ) do
			
			local end_time = CombatHit[unit_id];
			
			if end_time and end_time <= now then
				
				local poi = POIList[unit_id];
			
				poi.icon:cachedSetVertexColor( 1, 1, 1, 1 );
				poi.icon.colored = false;
				
				if poi.text then poi.text:SetTextColor( 1, 1, 1, 1 ); end
				
				CombatHit[unit_id] = nil;
				
			end
		end
	end
end

-------------------------------------------------------------------------------

plugin.initPanel = function( container, options )

	plugin.container = container;
	plugin.options   = options;

	if options and options.enabled then
			
		plugin.setEnabled( true );
		
	end
end

-------------------------------------------------------------------------------

plugin.sizeChanged = function( scale, height, width )
	
	local options  = plugin.options;
	
	plugin.scale = scale;
			
	BattlefieldMinimap:SetScale( height / BattlefieldMinimap:GetHeight() );
	
end	

-------------------------------------------------------------------------------

plugin.setEnabled = function( enabled )

	if not IsAddOnLoaded( "Blizzard_BattlefieldMinimap" ) then 
		local loaded, reason = LoadAddOn( "Blizzard_BattlefieldMinimap" ); if not loaded then print( "load failed: "..(reason or "unknown reason") ); end
	end
	
	plugin.active = IsAddOnLoaded( "Blizzard_BattlefieldMinimap" );
	
	enabled = plugin.active and enabled;
	
	if plugin.enabled ~= enabled then
		
		plugin.enabled = enabled;
		
		if not enabled then

			if plugin.saved_parent then
				
				BattlefieldMinimap:SetParent( plugin.saved_parent );				
				BattlefieldMinimapCloseButton:Show();
				BattlefieldMinimapCorner:Show();
				BattlefieldMinimapBackground:Show();
				
				BattlefieldMinimapTab.Show = BattlefieldMinimapTab.cachedShow;
				BattlefieldMinimapTab:Show();
				
				plugin.saved_parent = nil;
--[[				
				for unit_id in pairs( POIList ) do
					if poi.text then poi.text:SetText( "" ); end
					poi.icon.SetVertexColor = poi.icon.cachedSetVertexColor;
					poi.icon:SetVertexColor( 1, 1, 1, 1 );
				end
]]--				
			end
		
		else

			if not plugin.saved_parent then				
				plugin.saved_parent = BattlefieldMinimap:GetParent();
			end
			
			nUI_BmmLocation = CreateFrame( "Frame", "nUI_BmmLocation", BattlefieldMinimap );
			nUI_BmmLocation.label = nUI_BmmLocation:CreateFontString( nil, "OVERLAY" );
			nUI_BmmLocation.label:SetPoint( "BOTTOM", BattlefieldMinimap, "BOTTOM", 0, 10 );
			nUI_BmmLocation.label:SetJustifyH( "CENTER" );
			nUI_BmmLocation.label:SetJustifyV( "BOTTOM" );
			nUI_BmmLocation.label:SetFontObject( SystemFont_Outline_Small );
			
			nUI_BmmLocation:SetScript( "OnUpdate", nUI_BmmCoordUpdate );
			
			BattlefieldMinimapTab:Hide();
			
			BattlefieldMinimapTab.cachedShow = BattlefieldMinimapTab.Show;
			BattlefieldMinimapTab.Show       = function() end;
			
			BattlefieldMinimap:SetParent( plugin.container );
			BattlefieldMinimap:SetFrameStrata( plugin.container:GetFrameStrata() );
			BattlefieldMinimap:SetFrameLevel( plugin.container:GetFrameLevel()+1 );
			
			BattlefieldMinimap:ClearAllPoints();
			BattlefieldMinimap:SetPoint( "TOPLEFT", plugin.container, "TOPLEFT", 0, 0 );
			
			BattlefieldMinimapCloseButton:Hide();
			BattlefieldMinimapCorner:Hide();
			BattlefieldMinimapBackground:Hide();
			BattlefieldMinimap_UpdateOpacity( 0 );
			
			BattlefieldMinimap:Show();
			
--[[			
			for i=1, MAX_PARTY_MEMBERS do
				
				local poi = getglobal( "BattlefieldMinimapParty"..i );
				poi.icon  = getglobal( poi:GetName().."Icon" );
				poi.icon.cachedSetVertexColor = poi.icon.SetVertexColor;
				poi.icon.SetVertexColor = function() end;
				POIList["party"..i] = poi;
				
			end
			
			for i=1, MAX_RAID_MEMBERS do
				
				local poi = getglobal( "BattlefieldMinimapRaid"..i )
				poi.text  = poi:CreateFontString( "$parentGroupID" );
				poi.icon  = getglobal( poi:GetName().."Icon" );
				
				poi.text:SetFont( nUI_L["font1"], poi:GetHeight() * 0.85, "OUTLINE" );
				poi.text:SetJustifyH( "CENTER" );
				poi.text:SetJustifyV( "MIDDLE" );
				poi.text:SetPoint( "CENTER", poi, "CENTER", 0, 0.5 );
				poi.text:SetTextColor( 1, 1, 1, 1 );

				poi.icon.cachedSetVertexColor = poi.icon.SetVertexColor;
				poi.icon.SetVertexColor = function() end;
				
				POIList["raid"..i]  = poi;
				
			end
]]--			
		end				
	end			
end

-------------------------------------------------------------------------------

plugin.setSelected = function( selected )

	if selected ~= plugin.selected then

		plugin.selected = selected;

		-- register for updates on combat affected and who is in what raid group
		
		if selected then
--[[			
			for i=1, MAX_PARTY_MEMBERS do
				
				POIList["party"..i]  = getglobal( "BattlefieldMinimapParty"..i );
				UnitInfo["party"..i] = nUI_Unit:registerFeedbackCallback( "party"..i, plugin );
				
			end
			
			for i=1, MAX_RAID_MEMBERS do
				
				POIList["raid"..i]  = getglobal("BattlefieldMinimapRaid"..i)
				UnitInfo["raid"..i] = nUI_Unit:registerFeedbackCallback( "raid"..i, plugin );
			
				nUI_Unit:registerRaidGroupCallback( "raid"..i, plugin );
				
			end
			
			plugin:SetScript( "OnUpdate", onBattlefieldMinimapUpdate );
]]--			
		else
--[[			
			plugin:SetScript( "OnUpdate", nil );
			
			for i=1, MAX_PARTY_MEMBERS do
				
				nUI_Unit:unregisterFeedbackCallback( "party"..i, plugin );
				
				UnitInfo["party"..i] = nil;
				
			end
			
			for i=1, MAX_RAID_MEMBERS do
				
				nUI_Unit:unregisterRaidGroupCallback( "raid"..i, plugin );
				nUI_Unit:unregisterFeedbackCallback( "raid"..i, plugin );

				UnitInfo["raid"..i] = nil;
				
			end
]]--			
		end
	end
end

-------------------------------------------------------------------------------

plugin.newUnitInfo = function( unit_id, unit_info )

	local poi         = POIList[unit_id];
	UnitInfo[unit_id] = unit_info;
	
	if poi then

		-- if the unit no longer exists, just clean up the poi
		
		if not unit_info then
			
			if poi.text then
				if poi.text.value then
					poi.text.value = nil;
					poi.text:SetText( "" );
					poi.text:SetTextColor( 1, 1, 1, 1 );
				end
			end
			
			if poi.icon and poi.icon.colored then
				poi.icon.colored = false;
				poi.icon:cachedSetVertexColor( 1, 1, 1, 1 );
			end
		
		-- otherwise the unit does exist and we need to
		-- do something with it
		
		else
		
			-- if the unit is in our raid, add a raid group number to to poi
			-- so the player can see which group members are where
			
			if unit_info.in_raid 
			and poi.text 
			and unit_info.raid_info 
			and unit_info.raid_info.subGroup ~= poi.text.value 
			then
				
				poi.text.value = unit_info.raid_info.subGroup;
				poi.text:SetText( poi.text.value );

			end
			
			-- if the unit is incurring unit combat info, set highlights on the
			-- poi to indicate combat to the player
			
			local now = GetTime();
			
			if unit_info.feedback
			and unit_info.feedback.start_time
			and unit_info.feedback.start_time <= now
			and unit_info.feedback.end_time > now
			and not CombatHit[unit_id] 
			then
			
				poi.icon.colored   = true;
				CombatHit[unit_id] = unit_info.feedback.end_time;
				
				if unit_info.feedback.action == "HEAL" then
					
					poi.icon:cachedSetVertexColor( 0, 1, 0, 1 );
					
					if poi.text then poi.text:SetTextColor( 0, 1, 0, 1 ); end
					
				else
					
					poi.icon:cachedSetVertexColor( 1, 0, 0, 1 );
					
					if poi.text then poi.text:SetTextColor( 1, 0, 0, 1 ); end
					
				end
			end
		end
	end
end
