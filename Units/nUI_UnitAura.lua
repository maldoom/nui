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
if not nUI_Unit then nUI_Unit = {}; end
if not nUI_UnitOptions then nUI_UnitOptions = {}; end
if not nUI_DefaultConfig then nUI_DefaultConfig = {}; end
if not nUI_Profile then nUI_Profile = {}; end;

local CancelItemTempEnchantment = CancelItemTempEnchantment;
local CancelUnitBuff            = CancelUnitBuff;
local CreateFrame               = CreateFrame;
local GetInventoryItemTexture   = GetInventoryItemTexture;
local GetPlayerBuff             = GetPlayerBuff;
local GetPlayerBuffApplications = GetPlayerBuffApplications;
local GetPlayerBuffTimeLeft     = GetPlayerBuffTimeLeft;
local GetPlayerBuffName         = GetPlayerBuffName;
local GetTime                   = GetTime;
local GetWeaponEnchantInfo      = GetWeaponEnchantInfo;
local UnitBuff                  = UnitBuff;
local UnitDebuff                = UnitDebuff;
local UnitIsDeadOrGhost         = UnitIsDeadOrGhost;

-------------------------------------------------------------------------------
-- default options for the unit aura colors

nUI_DefaultConfig.AuraColors =
{
	["none"]          = nil,
	["Magic"]         = DebuffTypeColor["Magic"],
	["Curse"]         = DebuffTypeColor["Curse"],
	["Disease"]       = DebuffTypeColor["Disease"],
	["Poison"]        = DebuffTypeColor["Poison"],
	["label"]         = { r = 1, g = 0.83, b = 1, a = 1 },
	["count"]         = { r = 1, g = 1, b = 1, a = 1 },
	["remains"]       = { r = 1, g = 1, b = 1, a = 1 },
	["expiring"]      = { r = 1, g = 0.5, b = 0.5, a = 1 },
	["player_buff"]   = { r = 0, g = 1, b = 0, a = 0.25 },
	["player_debuff"] = { r = 1, g = 0, b = 0, a = 0.25 },
};

-------------------------------------------------------------------------------

local AuraCallbacks     = {};
local AuraUnits         = {};
local FlashAuras        = {};
local TimerAuras        = {};
local NewUnitInfo       = {};
local UpdateQueue       = {};
local flash_alpha       = 1;
local flash_timer       = 1 / nUI_DEFAULT_FRAME_RATE;
local queue_timer       = 1 / nUI_DEFAULT_FRAME_RATE;
local count_timer       = 0;
local aura_timer        = 0;
local new_weapon_buff   = false;
local PlayerWeaponBuffs;

-------------------------------------------------------------------------------
-- simple utility method to convert a time value to a string

function nUI_SecondsLeftToString( value )

	local fmt;

	if value >= 3600 then
		fmt   = nUI_L["TimeLeftInHours"];
		value = value / 3600;
	elseif value >= 60 then
		fmt   = nUI_L["TimeLeftInMinutes"];
		value = value / 60;
	elseif value >= 2 then
		fmt = nUI_L["TimeLeftInSeconds"];
	else
		fmt = nUI_L["TimeLeftInTenths"];
	end

	return fmt:format( value );

end

-------------------------------------------------------------------------------

local function SetContainerFrameSize( frame )

	local hGap       = frame.hGap or 0;
	local vGap       = frame.vGap or 0;
	local hSize      = frame.hSize or 0;
	local vSize      = frame.vSize or 0;
	local changed    = false;
	local cols       = frame.options.cols or 1;
	local rows       = frame.options.rows or 1;
	local horizontal = frame.options.horizontal;
	local height     = horizontal and frame.defaultHeight or rows * vSize + (rows-1) * vGap;
	local width      = not horizontal and frame.defaultWidth or cols * hSize + (cols-1) * hGap;
	local living;

	if not frame.options.clickable or not InCombatLockdown() then
		
		if frame.options.dynamic_size then
			
			living = frame.unit_info and not frame.unit_info.is_dead and not frame.unit_info.is_ghost;
			cols   = living and frame.num_cols or 0;
			rows   = living and frame.num_rows or 0;
			height = horizontal and (frame.defaultHeight or height) or max( 1, min( height, (rows * vSize + (rows-1) * vGap) ) );
			width  = not horizontal and (frame.defaultWidth or width) or max( 1, min( width, (cols * hSize + (cols-1) * hGap) ) );
			
		end
		
		if frame.dynamic_width  ~= width
		then
			changed = true;
			frame.dynamic_width  = width;
			frame:SetWidth( width );
		end

		if frame.dynamic_height ~= height
		then
			changed = true;
			frame.dynamic_height = height;
			frame:SetHeight( height );
		end
	
		-- if we changed the frame size and we're not doing dynamic frame sizing,
		-- then the player has changed the max_auras setting and we need to hide
		-- frames that are no longer in use
		
		if not frame.options.clickable or not InCombatLockdown() then
			
			if changed and not frame.options.dynamic_size then
			
				for i=1,#frame.ButtonList do
					if i > (nUI_Options.max_auras or 40) then
						frame.ButtonList[i]:Hide();
					else
						frame.ButtonList[i]:Show();
					end
				end
				
			end
		end
	end
			
	-- if the frame is only one pixel high or wide, then it contains no
	-- auras and the sizer should be invisible. Otherwise, if the sizer
	-- isn't visible, it needs to be made so.

	local alpha = nil;

	if height == 1 and width == 1 and frame.alpha ~= 0 then alpha = 0;
	elseif height ~= 1 and width ~= 1 and frame.alpha ~= 1 then alpha = 1;
	end

	if alpha and frame.alpha ~= alpha then
		frame.alpha = alpha;
		frame:SetAlpha( alpha );
	end
end

-------------------------------------------------------------------------------
-- apply the current set of aura frame options to a button

local function ApplyAuraFrameOptions( frame, button )

--	nUI_ProfileStart( ProfileCounter, "ApplyAuraFrameOptions" );

	button:SetHeight( frame.vSize );
	button:SetWidth( frame.hSize );
	button:SetFrameStrata( frame:GetFrameStrata() );
	button:SetFrameLevel( frame:GetFrameLevel()+1 );

	button.label.color = frame.options.label and frame.options.label.color or nUI_UnitOptions.AuraColors["label"];
	button.label.enabled = frame.options.label and true or false;
	button.label:SetFont( nUI_L["font1"], frame.label.fontsize * frame.vScale * 1.75, "OUTLINE" );
	button.label:SetJustifyH( frame.label.justifyH );
	button.label:SetJustifyV( frame.label.justifyV );
	button.label:SetPoint( frame.label.anchor_pt, button, frame.label.relative_pt, frame.label.xOfs * frame.hScale, frame.label.yOfs * frame.vScale );
	button.label:SetTextColor( button.label.color.r or 1, button.label.color.g or 1, button.label.color.b or 1, button.label.color.a or 1 );

	if frame.options.label and frame.options.label.width then
		button.label:SetWidth( frame.options.label.width * frame.hScale );
	end

	if frame.options.label and frame.options.label.height then
		button.label:SetHeight( frame.options.label.height * frame.vScale );
	end

	button.remains.color = frame.options.timer and frame.options.timer.color or nUI_UnitOptions.AuraColors["remains"];
	button.remains.enabled = frame.options.timer and true or false;
	button.remains:SetFont( nUI_L["font1"], frame.timer.fontsize * frame.vScale * 1.75, "OUTLINE" );
	button.remains:SetJustifyH( frame.timer.justifyH );
	button.remains:SetJustifyV( frame.timer.justifyV );
	button.remains:SetPoint( frame.timer.anchor_pt, button, frame.timer.relative_pt, frame.timer.xOfs * frame.hScale, frame.timer.yOfs * frame.vScale );
	button.remains:SetTextColor( button.remains.color.r or 1, button.remains.color.g or 1, button.remains.color.b or 1, button.remains.color.a or 1 );

	if button.remains.enabled then
		nUI:TableInsertByValue( TimerAuras, button );
	else
		nUI:TableRemoveByValue( TimerAuras, button );
	end

	button.count.color = frame.options.count and frame.options.count.color or nUI_UnitOptions.AuraColors["count"];
	button.count.enabled = frame.options.count and true or false;
	button.count:SetFont( nUI_L["font1"], frame.count.fontsize * frame.vScale * 1.75, "OUTLINE" );
	button.count:SetJustifyH( frame.count.justifyH );
	button.count:SetJustifyV( frame.count.justifyV );
	button.count:SetPoint( frame.count.anchor_pt, button, frame.count.relative_pt, frame.count.xOfs * frame.hScale, frame.count.yOfs * frame.vScale );
	button.count:SetTextColor( button.count.color.r or 1, button.count.color.g or 1, button.count.color.b or 1, button.count.color.a or 1 );

	if frame.options.flash_expire then
		nUI:TableInsertByValue( FlashAuras, button );
	else
		nUI:TableRemoveByValue( FlashAuras, button );
		button.highlight:SetAlpha( 1 );
		button.icon:SetAlpha( 1 );
		button.icon.alpha = 1;
	end

--	nUI_ProfileStop();

end

-------------------------------------------------------------------------------
-- attach tooltip handlers to avoid calling EnableMouse in combat

local function AuraTooltipEnter( self )

	local owner = self.hitBox and self or self:GetParent();
	
	local tooltipUpdate = function( self )
		if GameTooltip:IsOwned( owner ) then
			if owner.aura.is_weapon then GameTooltip:SetInventoryItem( owner.unit_id, owner.aura.id );
			else GameTooltip:SetUnitAura( owner.unit_id, owner.aura.id, owner.aura.filter );
			end
		end
	end

	if owner.aura and owner.active then

		--self:SetID( owner.aura.id );

		GameTooltip:SetOwner( owner );
		tooltipUpdate( owner );
		GameTooltip:Show();

--		self:SetScript( "OnUpdate", tooltipUpdate );

	end
end

local function AuraTooltipLeave( self )

	GameTooltip:Hide();
--	self:SetScript( "OnUpdate", nil );
	
end

local function AttachAuraTooltipHandlers( button )

	if not button.clickable then
--		button:SetScript( "OnEnter", AuraTooltipEnter );
--		button:SetScript( "OnLeave", AuraTooltipLeave );
	else
		button.hitBox:SetScript( "OnEnter", AuraTooltipEnter );
		button.hitBox:SetScript( "OnLeave", AuraTooltipLeave );
	end

end

-------------------------------------------------------------------------------
-- construct a single buff/debuff aura button

local function CreateAuraButton( frame, i )

--	nUI_ProfileStart( ProfileCounter, "CreateAuraButton" );

	local options = frame.options;

--	nUI:debug( "nUI_UnitAura: creating new button for "..frame:GetName().." and index "..i, 1 );

	local clickable     = options and options.clickable and true or false;
	local button        = CreateFrame( "Frame", "$parent_Button"..i, frame );

	button.remains      = button:CreateFontString( "$parentRemains", "OVERLAY" );
	button.count        = button:CreateFontString( "$parentCount", "OVERLAY" );
	button.label        = button:CreateFontString( "$parentLabel", "OVERLAY" );
	button.icon         = button:CreateTexture( "$parentIcon", "BACKGROUND" );
	button.class        = button:CreateTexture( "$parentBorder", "ARTWORK" );
	button.highlight    = button:CreateTexture( "$parentHighight", "BORDER" );
	button.cooldown     = button:CreateTexture( "$parentCooldown", "ARTWORK" );
	button.clickable    = clickable;
	button.unit_id      = frame.unit;
	button.parent       = frame;
	button.active       = true;
	button.class.active = true;

	button.icon:SetAllPoints( button );
	button.class:SetAllPoints( button );
	button.cooldown:SetAllPoints( button );
	button.highlight:SetAllPoints( button );

	button.highlight:SetAlpha( 1 );
	button.icon:SetAlpha( 1 );
	button.icon.alpha = 1;

	button.class:SetAlpha( 0 );
	button.class:SetTexture( "Interface\\AddOns\\nUI\\Layouts\\Default\\Art\\nUI_BuffBorder" );
	button.class:SetTexCoord( 0, 0, 0, 1, 1, 0, 1, 1 );

	button.highlight:SetColorTexture( 0, 0, 0, 0 );

	if button.clickable then
		
		local hitBox  = CreateFrame( "Button", "$parent_HitBox", button, "SecureActionButtonTemplate" );
		button.hitBox = hitBox;
		
		hitBox:EnableMouse( true );
		hitBox:RegisterForClicks( "RightButtonUp" );
		hitBox:SetAllPoints( button );
		
		hitBox:SetAttribute( "type2", "cancelaura" );	
		hitBox:SetAttribute( "unit", button.unit_id );
		hitBox:SetAttribute( "index", i );
		hitBox:SetAttribute( "filter", "HELPFUL" );
		
	end
			
	ApplyAuraFrameOptions( frame, button );

	AttachAuraTooltipHandlers( button );

--	nUI_ProfileStop();

	return button;

end

-------------------------------------------------------------------------------
-- disable all mouseover and click abilities for a button and hide it

local function DisableAuraButton( button )

--	nUI_ProfileStart( ProfileCounter, "DisableAuraButton" );

--	nUI:debug( "nUI_UnitAura: disabling button: "..button:GetName(), 1 );

	if button.active then

		button.active = false;

		button:SetAlpha( 0 );

		if not button.clickable then
			button:Hide();
		end
		
		--[[
		if button.clickable then
			button:EnableMouse( false );
			button:RegisterForClicks();
		end
		--]]
		
		if button.clickable then
			-- hide the tooltip if it is shown for a button that's going away
			if GameTooltip and GameTooltip:IsOwned( button ) then
				GameTooltip:Hide();
				--button:SetScript( "OnUpdate" , nil);
			end
			-- detach handlers
			--button:SetScript( "OnEnter" , nil );
			--button:SetScript( "OnLeave" , nil );
		end

		if button.count.value then
			button.count.value = nil;
			button.count:SetText( "" );
		end

		if button.remains.value then
			button.remains.value = nil;
			button.remains:SetText( "" );
		end

		if button.label.value then
			button.label.value = nil;
			button.label:SetText( "" );
			button.label.length = 0;
		end
	end

--	nUI_ProfileStop();

end

-------------------------------------------------------------------------------
-- configure a button for a given aura

local function SetButtonAura( frame, button, aura, proc_time )

--	nUI_ProfileStart( ProfileCounter, "SetButtonAura" );

	if button then

		button.aura = aura;

		if button.clickable and aura and not InCombatLockdown() then
			if aura.is_weapon then
				button.hitBox:SetAttribute("target-slot", aura.id );
			else
				button.hitBox:SetAttribute("index", aura.id );
			end
		end	

	--	nUI:debug( "enabling aura button "..button:GetName().." for "..aura.name );

		-- do we need to update the icon for this button (basically, a new button at this point)

		if button.icon.path ~= aura.icon then

			button.icon.path = aura.icon;
			button.icon:SetTexture( aura.icon );

		end

		-- do we need to update the spell name label for this button

		if button.label.enabled then

			local label = frame.label.enabled and (aura.name..(aura.rank and aura.rank ~= "" and " ("..aura.rank..")" or "")) or "";

			if button.label.value ~= label
			then

				button.label.value = label;
				button.label:SetText( label );
				button.label.length = button.label:GetStringWidth();
			end
		end

		-- do we need to update the count for this button

		if button.count.enabled
		then

			if button.count.value ~= aura.count
			then

				button.count.value = aura.count;
				button.count:SetText( aura.count and aura.count > 0 and aura.count or "" );

			end

			local count_color = button.count.color;

			if button.count.r ~= count_color.r
			or button.count.g ~= count_color.g
			or button.count.b ~= count_color.b
			then

				button.count.r = count_color.r;
				button.count.g = count_color.g;
				button.count.b = count_color.b;

				button.count:SetTextColor( count_color.r, count_color.g, count_color.b );

			end
		end

		-- highlight the aura icon's button face if this is a player cast
		-- and player highlighting is enabled

		if aura.caster and frame.options.highlight_player and UnitIsUnit( aura.caster, "player" ) then

			local color = nUI_UnitOptions.AuraColors[(aura.filter == "HELPFUL" and "player_buff" or "player_debuff")] or {};

			if new_aura
			or button.highlight.r ~= color.r
			or button.highlight.g ~= color.g
			or button.highlight.b ~= color.b
			or button.highlight.a ~= color.a
			then

				button.highlight.r = color.r;
				button.highlight.g = color.g;
				button.highlight.b = color.b;
				button.highlight.a = color.a;

				button.highlight:SetColorTexture( color.r, color.g, color.b, color.a );

			end

		elseif button.highlight.r
		or button.highlight.g
		or button.highlight.b
		or button.highlight.a
		then

			button.highlight.r = nil;
			button.highlight.g = nil;
			button.highlight.b = nil;
			button.highlight.a = nil;

			button.highlight:SetColorTexture( 0, 0, 0, 0 );

		end

		-- highlight the aura's border if aura type highlights are enabled

		if frame.options.aura_types then

			local color = aura.buff_color or aura.debuff_color;

			if not color or not aura.type then

				if button.class.r
				or button.class.g
				or button.class.b
				then

					button.class.r = nil;
					button.class.g = nil;
					button.class.b = nil;
					button.class:SetAlpha( 0 );

				end

			elseif new_aura
			or button.class.r ~= color.r
			or button.class.g ~= color.g
			or button.class.b ~= color.b
			then

				button.class.r = color.r;
				button.class.g = color.g;
				button.class.b = color.b;
				button.class:SetAlpha( 1 );
				button.class:SetVertexColor( color.r, color.g, color.b );
					
			end

		elseif button.class.r
		or button.class.g
		or button.class.b
		then
			button.class.r = nil;
			button.class.g = nil;
			button.class.b = nil;
			button.class:SetAlpha( 0 );
		end

		-- when would we consider this aura to be expiring?

		if frame.options.expire_time
		and frame.options.expire_time > 0
		and aura.end_time then
			aura.expires_at = aura.end_time - frame.options.expire_time;
		else
			aura.expires_at = nil;
		end

		-- do we need to enable the button?

		if not button.active then

			button.active = true;

			button:SetAlpha( 1 );
					
			if not button.clickable then
				button:Show();
			end

			--[[
			if button.clickable then
				button:EnableMouse( true );
				button:RegisterForClicks( "RightButtonUp" );
			end
			--]]
			-- reattach handlers rather than calling EnableMouse
			--if button.clickable then
			--	AttachAuraTooltipHandlers( button );
			--end
		end
	end

--	nUI_ProfileStop();

end

-------------------------------------------------------------------------------
-- compare two auras, return true if the do not match

local function CompareAuras( aura1, aura2 )

	return	aura1.name         ~= aura2.name
	or		aura1.rank         ~= aura2.rank
	or		aura1.count        ~= aura2.count
	or		aura1.max_time     ~= aura2.max_time
	or		aura1.end_time     ~= aura2.end_time
	or		aura1.start_time   ~= aura2.start_time
	or		aura1.caster       ~= aura2.caster
	or		aura1.is_stealable ~= aura2.is_stealable
	or		aura1.icon         ~= aura2.icon
	or		aura1.type         ~= aura2.type;

end

-------------------------------------------------------------------------------
-- this method scans the unit for all buffs present and builds a list accordingly

local function GetAuraList( unit_id, is_self, filter )

--	nUI_ProfileStart( ProfileCounter, "GetAuraList" );

	local aura_list = {};

	-- spin the list of possible buffs and see what's there

	for i=1,40 do

		-- check for a buff on this index

		local aura = {};

		aura.name, aura.rank, aura.icon, aura.count, aura.type,
		aura.max_time, aura.end_time, aura.caster, aura.is_stealable = UnitAura( unit_id, i, filter );

		if aura.name then

			aura.id          = i;
			aura.filter      = filter;
			aura.can_dispell = filter == "HARMFUL" and UnitDebuff( unit_id, i, 1 ) ~= nil;
			aura.buff_color  = nUI_UnitOptions and nUI_UnitOptions.AuraColors and nUI_UnitOptions.AuraColors[aura.type or "none"] or nUI_DefaultConfig.AuraColors[aura.type or "none"];
			aura.count       = aura.count and aura.count > 0 and aura.count or nil;

			if aura.max_time and aura.max_time > 0 then

				aura.start_time = aura.end_time - aura.max_time;

			elseif aura.end_time and aura.end_time > 0 then

				aura.start_time = GetTime();
				aura.max_time   = aura.end_time - aura.start_time;

			else

				aura.max_time   = nil;
				aura.start_time = nil;
				aura.end_time   = nil;

			end

			table.insert( aura_list, aura );

		end
	end

	-- return the result

--	nUI_ProfileStop();

	return #aura_list > 0 and aura_list or nil;

end

-------------------------------------------------------------------------------

local function SortAuras( left, right )

	if left.end_time and not right.end_time then
		return true;
	elseif right.end_time and not left.end_time then
		return false;
	elseif left.end_time then

		if left.end_time < right.end_time then
			return true;
		elseif left.end_time > right.end_time then
			return false;
		end
	end

	if left.name > right.name then
		return true;
	end

	return false;
end

-------------------------------------------------------------------------------
-- unit aura event management

if not nUI_Unit.Drivers then
	nUI_Unit.Drivers = CreateFrame( "Frame", "nUI_UnitDrivers", WorldFrame );
end

nUI_Profile.nUI_UnitAura       = {};
nUI_Profile.nUI_UnitAura.Frame = {};

local ProfileCounter      = nUI_Profile.nUI_UnitAura;
local FrameProfileCounter = nUI_Profile.nUI_UnitAura.Frame;

local frame = CreateFrame( "Frame", "$parent_Aura", nUI_Unit.Drivers )

nUI_Unit.Drivers.Aura   = frame;

-------------------------------------------------------------------------------
-- variables used in methods within this module are declared here to eliminate
-- the use of dynamic memory and the garbage collector

local unit_id;
local unit_info;
local list;
local has_mainhand, mainhand_exp, mainhand_count, mainhand_enchantId, has_offhand, offhand_exp, offhand_count, offhand_enchantId;

-------------------------------------------------------------------------------

local function onAuraEvent( who, event, arg1 )

--	nUI_ProfileStart( ProfileCounter, "onEvent", event );

	if event == "ADDON_LOADED" then

		if arg1 == "nUI" then

			nUI:patchConfig();
			nUI_Unit:configAura();

			-- set up a slash command handler for dealing with setting the maximum number of auras

			local option = nUI_SlashCommands[nUI_SLASHCMD_MAXAURAS];

			nUI_SlashCommands:setHandler( option.command,

				function( msg )

					local command, count = strsplit( " ", msg );

					if InCombatLockdown() then
					
						DEFAULT_CHAT_FRAME:AddMessage( "nUI: Cannot change maxauras while in combat", 1, 0.83, 0 );
						
					else
						
						count = max( 0, min( 40, tonumber( ("%0.0f"):format( count or "40" ) )));

						if count ~= nUI_Options.max_auras then

							DEFAULT_CHAT_FRAME:AddMessage( (option.message):format( count ), 1, 0.83, 0 );						
							nUI_Options.max_auras = count < 40 and count or nil;
							nUI_Unit:refreshAuraCallbacks();

						end
					end
				end
			);
		end

	-- for these events, we don't know which units are affected, so
	-- we span the list of all known interested units to see who is watching

	elseif event == "PLAYER_ENTERING_WORLD" then

		nUI_Unit:refreshAuraCallbacks();

	-- aura changes on a single unit

	elseif nUI_UnitOptions.AuraColors
	then

		if not arg1
		or event == "SPELLS_CHANGED"
		or event == "PLAYER_AURAS_CHANGED"
		then arg1 = "player";
		end

		if AuraCallbacks[arg1] and #AuraCallbacks[arg1] > 0 then
			UpdateQueue[arg1] = true;
			NewUnitInfo[arg1] = nUI_Unit:getUnitInfo( arg1 );
		end

	end

--	nUI_ProfileStop();

end

frame:SetScript( "OnEvent", onAuraEvent );
frame:RegisterEvent( "ADDON_LOADED" );
frame:RegisterEvent( "PLAYER_ENTERING_WORLD" );
frame:RegisterEvent( "UNIT_AURA" );
frame:RegisterEvent( "UNIT_AURA_STATE" );
frame:RegisterEvent( "SPELLS_CHANGED" );
frame:RegisterEvent( "PLAYER_AURAS_CHANGED" );

-------------------------------------------------------------------------------
-- aura update event management

local flash_rate     = 0;
local WeaponBuffs    = nil;
local NewWeaponBuffs = false;

local function onAuraUpdate( who, elapsed )

--	nUI_ProfileStart( ProfileCounter, "onAuraUpdate" );

	queue_timer = queue_timer - elapsed;
	flash_rate  = (flash_rate + elapsed) % 2;

	if queue_timer <= 0 then

		local proc_time = GetTime();

		queue_timer = nUI_Unit.frame_rate;

		-- check player's temporary weapon enchants... I'd love to know why
		-- Bliz doesn't create and fire and event for this... seems mighty
		-- expensive to me to be hammering it in the frame update loop, but
		-- that's where they do it, so I follow suit

		has_mainhand, mainhand_exp, mainhand_count, mainhand_enchantId,
 		has_offhand,  offhand_exp,  offhand_count, offhand_enchantId = GetWeaponEnchantInfo();

		WeaponBuffs    = {};
		NewWeaponBuffs = false;

		if has_mainhand then

			--local link = GetInventoryItemLink( "player", 16 );
			--local id   = link and nUI_GetItemIdFromLink( link ) or nil;
			local text = mainhand_enchantId and GetItemInfo( mainhand_enchantId ) or "";

			WeaponBuffs[1] =
			{
				id         = 16,
				is_weapon  = true,
				count      = mainhand_count and mainhand_count > 0 and mainhand_count or nil,
				max_time   = mainhand_exp / 1000,
				end_time   = proc_time + (mainhand_exp / 1000),
				name       = nUI_L["Main Hand Weapon:"].." "..text,
				icon       = GetInventoryItemTexture( "player", 16 ),
			};

		end

		if has_offhand then

			--local link = GetInventoryItemLink( "player", 17 );
			--local id   = link and nUI_GetItemIdFromLink( link ) or nil;
			local text = offhand_enchantId and GetItemInfo( offhand_enchantId ) or "";

			WeaponBuffs[2] =
			{
				id         = 17,
				is_weapon  = true,
				count      = offhand_count and offhand_count ~= 0 and offhand_count or nil,
				max_time   = offhand_exp / 1000,
				end_time   = proc_time + (offhand_exp / 1000),
				name       = nUI_L["Off Hand Weapon:"].." "..text,
				icon       = GetInventoryItemTexture( "player", 17 ),
			};

		end

		if not WeaponBuffs[1] and not WeaponBuffs[2] then
			WeaponBuffs = nil;
		end

		-- we'll only test to see if the weapon enchants have changed if the player
		-- is not already in the update list

		if not UpdateQueue[ "player" ] then

			local aura_info = nUI_Unit.PlayerInfo and nUI_Unit.PlayerInfo.aura_info or nil;

			-- if we don't have weapon buffs, the checking is very simple...
			-- update in the last time we looked the player had buffs

			if not WeaponBuffs then

				if aura_info
				and aura_info.weapon_buffs
				then
					UpdateQueue["player"] = true;
					NewUnitInfo["player"] = nUI_Unit.PlayerInfo;
					NewWeaponBuffs        = true;
				end

			-- otherwise, we now have weapon buffs, so we update if we didn't have them before
			-- or we've gained or lost a weapon buff

			elseif not aura_info
			or not aura_info.weapon_buffs
			or (aura_info.weapon_buffs[1] and not WeaponBuffs[1])
			or (WeaponBuffs[1] and not aura_info.weapon_buffs[1])
			or (aura_info.weapon_buffs[2] and not WeaponBuffs[2])
			or (WeaponBuffs[2] and not aura_info.weapon_buffs[2])
			then

				UpdateQueue["player"] = true;
				NewUnitInfo["player"] = nUI_Unit.PlayerInfo;
				NewWeaponBuffs        = true;

			-- otherwise the testing is more expensive /sigh

			elseif WeaponBuffs[1]
			and CompareAuras( WeaponBuffs[1], aura_info.weapon_buffs[1] )
			then

				UpdateQueue["player"] = true;
				NewUnitInfo["player"] = nUI_Unit.PlayerInfo;
				NewWeaponBuffs        = true;

			elseif WeaponBuffs[2]
			and CompareAuras( WeaponBuffs[2], aura_info.weapon_buffs[2] )
			then

				UpdateQueue["player"] = true;
				NewUnitInfo["player"] = nUI_Unit.PlayerInfo;
				NewWeaponBuffs        = true;

			end
		end

		-- update any units that have flagged a change since the last iteration

		for unit_id in pairs( UpdateQueue ) do

			if UpdateQueue[unit_id] then

				UpdateQueue[unit_id] = false;
				unit_info = NewUnitInfo[unit_id];

				if AuraCallbacks[unit_id] and #AuraCallbacks[unit_id] > 0 then
					nUI_Unit:notifyCallbacks(
						nUI_L["unit aura"], AuraCallbacks, AuraUnits,
						unit_info, unit_id, nUI_Unit:updateAuraInfo( unit_id, unit_info )
					);
				end
			end
		end

		-- update any auras that have timers

		for i=1,#TimerAuras do

			local button = TimerAuras[i];
			local aura   = button.aura;
			local text   = nil;

			if button.active
			and aura
			then

				if aura.end_time then

					local remains = aura.end_time - GetTime();

					if remains <= 0 then

						aura.expired = true;
						UpdateQueue[button.unit_id] = true;

					else

						text = nUI_SecondsLeftToString( remains );

						-- if the aura has a time remaining, at what point do we consider it
						-- to be expiring?

						local timer_color = button.remains.color;

						if aura.expires_at and aura.expires_at <= proc_time then
							timer_color = nUI_UnitOptions.AuraColors["expiring"];
						end

						if button.remains.r ~= timer_color.r
						or button.remains.g ~= timer_color.g
						or button.remains.b ~= timer_color.b
						then

							button.remains.r = timer_color.r;
							button.remains.g = timer_color.g;
							button.remains.b = timer_color.b;

							button.remains:SetTextColor( timer_color.r, timer_color.g, timer_color.b );

						end
					end
				end

				if button.remains.value ~= text then
					button.remains.value = text;
					button.remains:SetText( text or "" );
				end

			end
		end

		-- update any auras that are flashing on expire

		if #FlashAuras > 0 then

			-- for the first 1/2 second, we fade out

			if flash_rate < 0.5 then

				flash_alpha = 1 - (flash_rate * 2);

			-- for the next 1/4 second we hold the button invisible

			elseif flash_rate < 0.75 then

				flash_alpha = 0;

			-- for the next 1/2 second we fade in

			elseif flash_rate < 1.25 then

				flash_alpha = (flash_rate - 0.75) * 2;

			-- and for the last 3/4 of a second, we hold the button at full alpha

			else

				flash_alpha = 1;

			end

			-- update alpha on the visible auras

			for i=1,#FlashAuras do

				local button = FlashAuras[i];
				local aura   = button.aura;

				if button.active and aura then

					local alpha = 1;

					if aura.expires_at and aura.expires_at <= proc_time then
						alpha = flash_alpha;
					end

					if button.icon.alpha ~= alpha then

						button.icon.alpha = alpha;
						button.highlight:SetAlpha( alpha );
						button.icon:SetAlpha( alpha );
					end
				end
			end
		end
	end

--	nUI_ProfileStop();

end

frame:SetScript( "OnUpdate", onAuraUpdate );

-------------------------------------------------------------------------------
-- this callback method is called when one of the unit IDs we are monitoring
-- for unit aura changes GUID

frame.newUnitInfo = function( unit_id, unit_info )

--	nUI_ProfileStart( ProfileCounter, "newUnitInfo" );

	UpdateQueue[unit_id] = true;
	NewUnitInfo[unit_id] = unit_info;

--	nUI_ProfileStop();

end

-------------------------------------------------------------------------------
-- initialize configuration for the unit aura color indicators
--
-- this method is called when the mod's saved variables have been loaded by Bliz and
-- may be called again whenever the unit aura configuration has been changed
-- by the player or programmatically. Passing true or a non-nil value for "use_default"
-- will cause the player's current aura color configuration to be replaced with
-- the default settings defined at the top of this file (which cannot be undone!)

function nUI_Unit:configAura( use_default )

--	nUI_ProfileStart( ProfileCounter, "configAuras" );

	if not nUI_UnitOptions then nUI_UnitOptions = {}; end
	if not nUI_UnitOptions.AuraColors then nUI_UnitOptions.AuraColors = {}; end

	for aura in pairs( nUI_DefaultConfig.AuraColors ) do
		nUI_Unit:configAuraColor( aura, use_default );
	end

--	nUI_ProfileStop();

end

function nUI_Unit:configAuraColor( aura, use_default )

--	nUI_ProfileStart( ProfileCounter, "configAuraColor" );

	local config  = nUI_UnitOptions.AuraColors[aura] or {};
	local default = nUI_DefaultConfig.AuraColors[aura] or {};

	if use_default then

		config.r = default.r;
		config.g = default.g;
		config.b = default.b;
		config.a = default.a or 1;

	else

		config.r = tonumber( config.r or default.r );
		config.g = tonumber( config.g or default.g );
		config.b = tonumber( config.b or default.b );
		config.a = tonumber( config.a or default.a or 1 );

	end

	nUI_UnitOptions.AuraColors[aura] = config;
	nUI_Unit:refreshAuraCallbacks();

--	nUI_ProfileStop();

end

-------------------------------------------------------------------------------
-- add and remove callbacks from the list of unit aura listeners we manage
--
-- calling this method will return the current unit_info structure for this
-- unit if it exists or nil if the unit does not exist at this time
--
-- Note: these callbacks will be notified both when the underlying GUID for the
--		 unit changes or when the aura info of the underlying GUID to the
--		 player changes. If the underlying unit does not exist, the callback
--		 will be passed a nil unit_info structure

function nUI_Unit:registerAuraCallback( unit_id, callback )

--	nUI_ProfileStart( ProfileCounter, "registerAuraCallback" );

	local unit_info = nil;

	if unit_id and callback then

		-- get the list of callbacks for this unit id and add this callback

		local list = AuraCallbacks[unit_id] or {};

		nUI:TableInsertByValue( list, callback );

		-- if this is a new unit id, add it to the callback list

		if not AuraCallbacks[unit_id] then
			AuraCallbacks[unit_id] = list;
		end

		-- if this is the first callback for the unit id, then register our
		-- event driver to receive notice when the GUID changes on this id

		if #list == 1 then
			nUI_Unit:registerStatusCallback( unit_id, nUI_Unit.Drivers.Aura );
		end

		-- collect aura information for this unit as we know it at this time

		unit_info = nUI_Unit:getUnitInfo( unit_id );

		if unit_info then
			nUI_Unit:updateAuraInfo( unit_id, unit_info );
		end
	end

--	nUI_ProfileStop();

	return unit_info;

end

function nUI_Unit:unregisterAuraCallback( unit_id, callback )

--	nUI_ProfileStart( ProfileCounter, "unregisterAuraCallback" );

	if unit_id and callback then

		-- get the list of current callbacks for this unit ud and remove this callback

		local list = AuraCallbacks[unit_id] or {};

		nUI:TableRemoveByValue( list, callback );

		-- if that's the last callback in the list, then remove our event handler of
		-- the list of unit change callbacks for that unit it

		if #list == 0 then
			nUI_Unit:unregisterStatusCallback( unit_id, nUI_Unit.Drivers.Aura );
		end
	end

--	nUI_ProfileStop();

end

-------------------------------------------------------------------------------
-- update the aura information for this unit
--
-- note: it is the caller's responsibility to ensure that the unit_info being
--       passed belongs to the unit_id that is passed. Generally third party
--       consumers of unit_info should not call this method, rather they
--       should use the callback registration system to get change notices
--       and let the nUI unit driver engine do the updating. If you MUST call
--       this method, you should first test that the following condition
--       evaluates as true: UnitGUID( unit_id ) == unit_info.guid
--
-- returns the updated unit information structure for the current GUID
-- if the data has changed, otherwise returns nil if nothing changed

function nUI_Unit:updateAuraInfo( unit_id, unit_info )

--	nUI_ProfileStart( ProfileCounter, "updateAuraInfo" );

	local modified  = false;

	if unit_info then

		local aura_info   = nil;
		local status_info = unit_info.status_info;
		local alive       = status_info and (not status_info.is_dead and not status_info.is_ghost and true or false) or UnitIsDeadOrGhost( unit_id );

		-- a dead unit never has auras

		if not alive then

			modified = true;

		-- otherwise, see what auras we do have

		else

			local is_self      = unit_info.is_self;
			local cached       = unit_info.aura_info or {};
			local weapon_buffs = unit_id == "player" and WeaponBuffs or nil;
			local buff_list    = GetAuraList( unit_id, is_self, "HELPFUL" );
			local debuff_list  = GetAuraList( unit_id, is_self, "HARMFUL" );
			local have_auras   = (weapon_buffs or buff_list or debuff_list) and true or false;

			-- has anything changed?

			if NewWeaponBuffs
			and unit_id == "player"
			then

				aura_info =
				{
					weapon_buffs = weapon_buffs,
					buff_list    = buff_list,
					debuff_list  = debuff_list,
				};

				modified = true;

			-- unit has no auras now...

			elseif not have_auras then

				-- but unit had auras on the last update

				if unit_info.aura_info then
					modified  = true;
				end

			-- unit has aura now but didn't have auras on the last update

			elseif not unit_info.aura_info then

					aura_info =
					{
						weapon_buffs = weapon_buffs,
						buff_list    = buff_list,
						debuff_list  = debuff_list,
					};

					modified = true;

			else

				local unit_weapons = unit_info.aura_info.weapon_buffs;
				local unit_buffs   = unit_info.aura_info.buff_list;
				local unit_debuffs = unit_info.aura_info.debuff_list;

				aura_info =
				{
					weapon_buffs = weapon_buffs,
					buff_list    = buff_list,
					debuff_list  = debuff_list,
				};

				-- the type and/or number of auras has changed

		-- if the number of maximum auras has changed, we need to update
		
				if (unit_debuffs and not debuff_list)
				or (debuff_list and not unit_debuffs)
				or (unit_debuffs and #unit_debuffs ~= #debuff_list)
				or (unit_buffs and not buff_list)
				or (buff_list and not unit_buffs)
				or (unit_buffs and #unit_buffs ~= #buff_list)
				or (unit_weapons and not weapon_buffs)
				or (weapon_buffs and not unit_weapons)
				or (unit_weapons and #unit_weapons ~= #weapon_buffs)
				or (unit_info.aura_info and unit_info.aura_info.maxAuras ~= nUI_Options.max_auras)
				then

					modified = true;

				-- the type and number of auras has not changed, so now we have to
				-- do the more expensive test to see if any of the aura detail changed

				else

					if debuff_list then
						for i in pairs( debuff_list ) do
							if CompareAuras( unit_debuffs[i], debuff_list[i] ) then
								modified = true;
								break;
							end
						end
					end

					if not modified and buff_list then
						for i in pairs( buff_list ) do
							if CompareAuras( unit_buffs[i], buff_list[i] ) then
								modified = true;
								break;
							end
						end
					end
				end
			end
		end

		-- if we've found something new in the unit auras, update the cache

		if modified then

			unit_info.modified    = true;
			unit_info.last_change = GetTime();
			unit_info.aura_info   = aura_info;

			if unit_info.aura_info then
				unit_info.aura_info.maxAuras = nUI_Options.max_auras;
			end
			
		end
	end

--	nUI_ProfileStop();

	return modified and unit_info or nil;

end


-------------------------------------------------------------------------------
-- update all of the registered unit aura listeners, even if there's no
-- change in data... typically used when the aura color options change
-- or entering the world

function nUI_Unit:refreshAuraCallbacks()

--	nUI_ProfileStart( ProfileCounter, "refreshAuraCallbacks" );

	for unit_id in pairs( AuraCallbacks ) do
		if AuraCallbacks[unit_id] and #AuraCallbacks[unit_id] > 0 then
			UpdateQueue[unit_id] = true;
			NewUnitInfo[unit_id] = nUI_Unit:getUnitInfo( unit_id );
		end
	end

--	nUI_ProfileStop();

end

-------------------------------------------------------------------------------
-- create a new unit aura frame

function nUI_Unit:createAuraFrame( parent, unit_id, id, options )

--	nUI_ProfileStart( ProfileCounter, "createAuraFrame" );

	local frame = nUI_Unit:createFrame( "$parent_Aura"..(id or ""), parent, unit_id, false );
	frame.Super = {};

	frame:SetScript( "OnEnter", nil );
	frame:SetScript( "OnLeave", nil );
	frame:EnableMouse( false );
	
	-- create the aura buttons for this frame

	frame.ButtonList = {};

	-- called when the underlying GUID for the unit changes or when the
	-- content of the GUID is updated

	frame.Super.newUnitInfo = frame.newUnitInfo;
	frame.newUnitInfo       = function( list_unit, unit_info )

--		nUI_ProfileStart( FrameProfileCounter, "newUnitInfo" );

		frame.Super.newUnitInfo( list_unit, unit_info );

		if frame.enabled then
			nUI_Unit:updateAuraFrame( frame );
		end

--		nUI_ProfileStop();

	end;

	-- setting enabled to false will prevent the frame from updating when new
	-- unit information is received (saves framerate). Setting enabled true will
	-- call the frame to immediately update if its content has changed since it
	-- was disabled

	frame.Super.setEnabled = frame.setEnabled;
	frame.setEnabled       = function( enabled )

--		nUI_ProfileStart( FrameProfileCounter, "setEnabled" );

		local prior_state = frame.enabled;

		frame.Super.setEnabled( enabled );

		if frame.enabled ~= prior_state then

			if frame.enabled then
				frame.unit_info = nUI_Unit:registerAuraCallback( frame.unit, frame );
				nUI_Unit:updateAuraFrame( frame );
			else
				SetContainerFrameSize( frame );
				nUI_Unit:unregisterAuraCallback( frame.unit, frame );
			end
		end

--		nUI_ProfileStop();

	end

	-- used to change the scale of the frame... rather than the Bliz widget frame:SetScale()
	-- this method actually recalculates the size of the frame and uses frame:SetHeight()
	-- and frame:SetWidth() to reflect the actual size of the frame.

	frame.Super.applyScale = frame.applyScale;
	frame.applyScale       = function( scale )

--		nUI_ProfileStart( FrameProfileCounter, "applyScale" );

		frame.Super.applyScale( scale );

		if frame.options then

			frame.defaultHeight = frame.options.height and frame.options.height * frame.vScale or nil;
			frame.defaultWidth  = frame.options.width and frame.options.width * frame.hScale or nil;
			
			frame.vGap = (frame.options.vGap or 0) * frame.vScale;
			frame.hGap = (frame.options.hGap or 0) * frame.hScale;

			if #frame.ButtonList > 0 then

				if frame.hSize  ~= frame.ButtonList[1].hSize
				or frame.vSize  ~= frame.ButtonList[1].vSize
				or frame.height ~= frame.ButtonList[1].height
				or frame.width  ~= frame.ButtonList[1].width
				or frame.hGap   ~= frame.ButtonList[1].hGap
				or frame.vGap   ~= frame.ButtonList[1].vGap
				then

					local vGap = frame.vGap;
					local hGap = frame.hGap;

					frame.ButtonList[1].height = frame.height;
					frame.ButtonList[1].width  = frame.width;
					frame.ButtonList[1].hSize  = frame.hSize;
					frame.ButtonList[1].vSize  = frame.vSize;
					frame.ButtonList[1].hGap   = frame.hGap;
					frame.ButtonList[1].vGap   = frame.vGap;

					SetContainerFrameSize( frame );

					for i=1,#frame.ButtonList do

						local button = frame.ButtonList[i];
						local anchor_pt, relative_to, relative_pt, xOfs, yOfs = button:GetPoint( 1 );

						ApplyAuraFrameOptions( frame, button );

						if anchor_pt then

							if xOfs < 0 then xOfs = -hGap;
							elseif xOfs > 0 then xOfs = hGap;
							end

							if yOfs < 0 then yOfs = -vGap;
							elseif yOfs > 0 then yOfs = vGap;
							end

							button:ClearAllPoints();
							button:SetPoint( anchor_pt, relative_to, relative_pt, xOfs, yOfs );

						end
					end

				end

				if anchor then frame.applyAnchor(); end

			end
		end

--		nUI_ProfileStop();

	end

	-- this method applies the anchor point of the frame. As with all else, the
	-- frame's anchor is only moved if the point defined is different than the
	-- point that is already known

	frame.Super.applyAnchor = frame.applyAnchor;
	frame.applyAnchor       = function( anchor )

--		nUI_ProfileStart( FrameProfileCounter, "applyAnchor" );

		local anchor      = anchor or frame.anchor or {};
		local anchor_pt   = anchor.anchor_pt or "CENTER";
		local relative_to = anchor.relative_to or frame.parent:GetName();
		local relative_pt = anchor.relative_pt or anchor_pt;
		local xOfs        = (anchor.xOfs or 0) * (frame.hScale or 1);
		local yOfs        = (anchor.yOfs or 0) * (frame.vScale or 1);

		frame.anchor = anchor;

		if frame.anchor_pt   ~= anchor_pt
		or frame.relative_to ~= relative_to
		or frame.relative_pt ~= relative_pt
		or frame.xOfs        ~= xOfs
		or frame.yOfs        ~= yOfs
		then

			frame.anchor_pt   = anchor_pt;
			frame.relative_to = relative_to;
			frame.relative_pt = relative_pt;
			frame.xOfs        = xOfs;
			frame.yOfs        = yOfs;

			frame:ClearAllPoints();
			frame:SetPoint( anchor_pt, relative_to:gsub( "$parent", frame.parent:GetName() ), relative_pt, xOfs, yOfs );

		end

		-- and anchor the text

		for text in pairs( frame.Labels ) do

			local config      = frame.Labels[text].config;
			local hScale      = frame.Labels[text].hScale;
			local vScale      = frame.Labels[text].vScale;

			anchor_pt   = (config and config.anchor_pt or "CENTER");
			relative_to = (config and config.relative_to or frame:GetName());
			relative_pt = (config and config.relative_pt or anchor_pt);
			xOfs        = (config and config.xOfs or 0) * hScale;
			yOfs        = (config and config.yOfs or 0) * vScale;

			if text.hScale      ~= hScale
			or text.vScale      ~= vScale
			or text.xOfs        ~= xOfs
			or text.yOfs        ~= yOfs
			or text.anchor_pt   ~= anchor_pt
			or text.relative_to ~= relative_to
			or text.relative_pt ~= relative_pt
			then

				text.hScale      = hScale;
				text.vScale      = vScale;
				text.xOfs        = xOfs;
				text.yOfs        = yOfs;
				text.anchor_pt   = (config and config.anchor_pt or "CENTER");
				text.relative_to = (config and config.relative_to or frame:GetName());
				text.relative_pt = (config and config.relative_pt or "CENTER");

				text:ClearAllPoints();
				text:SetPoint( anchor_pt, relative_to:gsub( "$parent", frame.parent:GetName() ), relative_pt, xOfs, yOfs );

			end
		end

		if frame.options then
			for i=1,#frame.ButtonList do
				ApplyAuraFrameOptions( frame, frame.ButtonList[i] );
			end
		end

--		nUI_ProfileStop();

	end

	-- applies the set of frame options to this frame. Typically called when the frame
	-- is first created or when the user changes options via config.

	frame.Super.applyOptions = frame.applyOptions;
	frame.applyOptions       = function( options )

--		nUI_ProfileStart( FrameProfileCounter, "applyOptions" );

		frame.Super.applyOptions( options );

		-- set up the spell name label;

		local name_label = options.label or {};

		name_label.enabled     = options.label ~= nil;
		name_label.anchor_pt   = name_label.anchor_pt or "CENTER";
		name_label.relative_to = name_label.relative_to or "CENTER";
		name_label.xOfs        = name_label.xOfs or 0;
		name_label.yOfs        = name_label.yOfs or 0;
		name_label.justifyH    = name_label.justifyH or "CENTER";
		name_label.justifyV    = name_label.justifyV or "MIDDLE";
		name_label.fontsize    = name_label.fontsize or 12;

		-- set up the countdown timer label;

		local timer_label = options.timer or {};

		timer_label.enabled     = options.timer ~= nil;
		timer_label.anchor_pt   = timer_label.anchor_pt or "CENTER";
		timer_label.relative_to = timer_label.relative_to or "CENTER";
		timer_label.xOfs        = timer_label.xOfs or 0;
		timer_label.yOfs        = timer_label.yOfs or 0;
		timer_label.justifyH    = timer_label.justifyH or "CENTER";
		timer_label.justifyV    = timer_label.justifyV or "MIDDLE";
		timer_label.fontsize    = timer_label.fontsize or 12;

		-- set up the application count label;

		local count_label = options.count or {};

		count_label.enabled     = options.count ~= nil;
		count_label.anchor_pt   = count_label.anchor_pt or "CENTER";
		count_label.relative_to = count_label.relative_to or "CENTER";
		count_label.xOfs        = count_label.xOfs or 0;
		count_label.yOfs        = count_label.yOfs or 0;
		count_label.justifyH    = count_label.justifyH or "CENTER";
		count_label.justifyV    = count_label.justifyV or "MIDDLE";
		count_label.fontsize    = count_label.fontsize or 12;

		-- if we're changing options after having already created buttons,
		-- then update the buttons that already exist

		if frame.label then

			frame.label = name_label;
			frame.timer = timer_label;
			frame.count = count_label;

			for i=1,#frame.ButtonList do
				ApplyAuraFrameOptions( frame, frame.ButtonList[i] );
			end

		else

			frame.label = name_label;
			frame.timer = timer_label;
			frame.count = count_label;

		end

		-- if there's a frame border, set it (frame border hides when the frame hides

		if options.border then

			local border_color = options.border.color.border;
			local backdrop_color = options.border.color.backdrop;

			frame:SetBackdrop( options.border.backdrop );
			frame:SetBackdropBorderColor( border_color.r, border_color.g, border_color.b, border_color.a );
			frame:SetBackdropColor( backdrop_color.r, backdrop_color.g, backdrop_color.b, backdrop_color.a );

		else

			frame:SetBackdrop( nil );

		end

		-- update the buttons

		frame.last_id = min( 40, (options.rows or 1) * (options.cols or 1) );

		for i=1, frame.last_id do
			if frame.ButtonList[i] then ApplyAuraFrameOptions( frame, frame.ButtonList[i] );
			else frame.ButtonList[i] = CreateAuraButton( frame, i );
			end
		end

		-- anchor all active aura buttons

		local origin     = options.origin or "TOPLEFT";
		local left       = origin == "TOPLEFT" or origin == "BOTTOMLEFT";
		local top        = origin == "TOPLEFT" or origin == "TOPRIGHT";
		local horizontal = options.horizontal;
		local rows       = horizontal and options.rows or options.cols;
		local cols       = horizontal and options.cols or options.rows;
		local row        = 0;
		local col        = 0;
		local hGap       = frame.hGap;
		local vGap       = frame.vGap;
		local last_button;
		local row_start;
		local next_button;
		local next_line;

		-- builing auras starting from the top left

		if top and left then

			if horizontal then
				next_button = { pt1 = "LEFT", pt2 = "RIGHT", xOfs = hGap, yOfs = 0 };
				next_line = { pt1 = "TOPLEFT", pt2 = "BOTTOMLEFT", xOfs = 0, yOfs = -vGap };
			else
				next_button = { pt1 = "TOP", pt2 = "BOTTOM", xOfs = 0, yOfs = -vGap };
				next_line = { pt1 = "TOPLEFT", pt2 = "TOPRIGHT", xOfs = hGap, yOfs = 0 };
			end

		-- building auras starting from the top right

		elseif top then

			if horizontal then
				next_button = { pt1 = "RIGHT", pt2 = "LEFT", xOfs = -hGap, yOfs = 0 };
				next_line = { pt1 = "TOPRIGHT", pt2 = "BOTTOMRIGHT", xOfs = 0, yOfs = -vGap };
			else
				next_button = { pt1 = "TOP", pt2 = "BOTTOM", xOfs = 0, yOfs = -vGap };
				next_line = { pt1 = "TOPRIGHT", pt2 = "TOPLEFT", xOfs = -hGap, yOfs = 0 };
			end

		-- building auras starting from the bottom left

		elseif left then

			if horizontal then
				next_button = { pt1 = "LEFT", pt2 = "RIGHT", xOfs = hGap, yOfs = 0 };
				next_line = { pt1 = "BOTTOMLEFT", pt2 = "TOPLEFT", xOfs = 0, yOfs = vGap };
			else
				next_button = { pt1 = "BOTTOM", pt2 = "TOP", xOfs = 0, yOfs = vGap };
				next_line = { pt1 = "BOTTOMLEFT", pt2 = "BOTTOMRIGHT", xOfs = hGap, yOfs = 0 };
			end

		-- building auras starting from the bottom right

		else

			if horizontal then
				next_button = { pt1 = "RIGHT", pt2 = "LEFT", xOfs = -hGap, yOfs = 0 };
				next_line = { pt1 = "BOTTOMRIGHT", pt2 = "TOPRIGHT", xOfs = 0, yOfs = vGap };
			else
				next_button = { pt1 = "BOTTOM", pt2 = "TOP", xOfs = 0, yOfs = vGap };
				next_line = { pt1 = "BOTTOMRIGHT", pt2 = "BOTTOMLEFT", xOfs = -hGap, yOfs = 0 };
			end

		end

		-- span the list of active aura buttons and anchor them

		for i=1, frame.last_id do

			local button = frame.ButtonList[i];
			local anchor;
			local anchor_frame;

			col = col+1;

			-- first button on the frame

			if i == 1 then

				button:ClearAllPoints();
				button:SetPoint( origin, frame, origin, 0, 0 );

				row         = 1;
				row_start   = button;

			-- start a new line of aura buttons

			elseif col > cols then

				anchor_frame = row_start;
				anchor       = next_line;
				row_start    = button;
				row          = row+1;
				col          = 1;

				button:ClearAllPoints();
				button:SetPoint( anchor.pt1, anchor_frame, anchor.pt2, anchor.xOfs, anchor.yOfs );

			-- otherwise, just place this button after the last one on the line

			else

				anchor_frame = last_button;
				anchor       = next_button;

				button:ClearAllPoints();
				button:SetPoint( anchor.pt1, anchor_frame, anchor.pt2, anchor.xOfs, anchor.yOfs );

			end

			last_button = button;

		end

		-- refresh the frame

		nUI_Unit:updateAuraFrame( frame );

--		nUI_ProfileStop();

	end

	-- register the frame for scaling

	nUI:registerScalableFrame( frame );

	-- initiate the frame

	frame.unit_info = nUI_Unit:registerAuraCallback( frame.unit, frame );

	frame.applyOptions( options );

--	nUI_ProfileStop();

	return frame;

end

-------------------------------------------------------------------------------
-- remove a unit aura frame

function nUI_Unit:deleteAuraFrame( frame )

--	nUI_ProfileStart( ProfileCounter, "deleteAuraFrame" );

	nUI:unregisterScalableFrame( frame );
	nUI_Unit:unregisterAuraCallback( frame.unit, frame );
	nUI_Unit:deleteFrame( frame );

--	nUI_ProfileStop();

end

-------------------------------------------------------------------------------
-- display the appropriate icons for the unit's auras
--
-- note: this method expends extra energy in state management... as in knowing
--       exactly what state it is currently in and only updating the frame text,
--       content, colors, alphas, etc. when a change in state occurs. The extra
--       effort is spent on state management in order to reduce impact to the
--       graphis engine so as to preserve frame rate. It costs far less to check
--		 a memory value that and burn through the graphics geometry. It does not
--       matter how many times the unit changes GUID or how many times this
--       method will call, it will only alter the graphics elements when its
--       relative state changes.

function nUI_Unit:updateAuraFrame( frame )

--	nUI_ProfileStart( ProfileCounter, "updateAuraFrame" );

	local proc_time    = GetTime();
	local aura_type    = frame.options.aura_type;
	local unit_info    = frame.unit_info;
	local aura_info    = unit_info and unit_info.aura_info;
	local aura_count   = 0;
	local aura_list    = nil;
	local weapon_buffs = aura_info and aura_info.weapon_buffs;
	local clickable    = frame.options.clickable;

	-- otherwise determine the type of auras to show and where or not there are any

	if aura_info then

		if aura_type == "help" then
			aura_type = unit_info.attackable and "debuff" or "buff";
		elseif aura_type == "harm" then
			aura_type = unit_info.attackable and "buff" or "debuff";
		end

		if aura_type == "buff" then
			aura_list = aura_info.buff_list;
		else
			aura_list = aura_info.debuff_list;
		end

		if aura_list then
			aura_count = #aura_list;
		end

		if aura_type == "buff" and aura_info.weapon_buffs then
			if aura_info.weapon_buffs[1] then aura_count = aura_count+1; end
			if aura_info.weapon_buffs[2] then aura_count = aura_count+1; end
		end

	end

	-- if there's no unit or no auras, hide the frame and disable
	-- all of its buttons so there's no mouseover, etc.

	if aura_count == 0
	or nUI_Options.max_auras == 0 then

		if frame.active then

			for i=1,#frame.ButtonList do

				local button = frame.ButtonList[i];

				if button and button.active then
					DisableAuraButton( button );
				else
					break;
				end
			end

			frame.num_rows = 0;
			frame.num_cols = 0;

			SetContainerFrameSize( frame );

			frame.active = false;
			frame:SetAlpha( 0 );
		end

	-- otherwise we have work to do

	else

--		nUI:debug( "nUI_UnitAura: processing aura update for "..frame:GetName(), 1 );

		-- make sure the frame is visible

		if not frame.active then
			frame.active = true;
			frame:SetAlpha( 1 );
		end

		-- build a list of the auras that will be displayed

		local player_auras = frame.options.player_auras;
		local dispellable  = frame.options.dispellable;
		local timedauras   = frame.options.timed_auras or false;
		local showAuras    = {};

		if aura_list then
			for i = 1,#aura_list do

				local aura = aura_list[i];

				aura.expired = aura.end_time and aura.end_time <= proc_time or false;

				if not aura.expired
				and (not timedauras or aura.end_time)
				then

					-- if the we only want to see auras the player cast, ignore all else

					if player_auras and (not aura.caster or not UnitIsUnit( aura.caster, "player" ))
					then aura = nil;

					-- if we only want to see auras the player can dispell, ignore all else

					elseif dispellable and not aura.can_dispell
					then aura = nil;

					end

					if aura then
						table.insert( showAuras, aura );
					end
				end
			end
		end

		-- if we have more than one aura to show, sort them

		if #showAuras > 1 and (not clickable or not InCombatLockdown()) then 
			nUI:TableSort( showAuras, SortAuras ); 
		end

		-- if we have temporary weapon enchants then add them to the head
		-- of the sorted list (we always show main hand weapon first, then
		-- offhand weapon regardless of time remaining if the player has
		-- any active temporary weapon enchants

		if weapon_buffs
		and aura_type == "buff"
		then

			-- if there's an offhand buff, stuff it at the head of the
			-- aura table first

			if weapon_buffs[2] then
				table.insert( showAuras, 1, weapon_buffs[2] );
			end

			-- if there's a main hand buff, stuff it at the head of the
			-- the table... this pushes the offhand buff, if there is one,
			-- into the second aura position, otherwise it pushes the
			-- first aura down to the second position.

			if weapon_buffs[1] then
				table.insert( showAuras, 1, weapon_buffs[1] );
			end
		end

		-- hide any aura buttons not in use

		local num_auras = min( min( (nUI_Options.max_auras or 40), #showAuras ), (frame.options.cols * frame.options.rows) );

		for i=num_auras+1,#frame.ButtonList do

			local button = frame.ButtonList[i];

			if button and button.active then
				DisableAuraButton( button );
			else
				break;
			end
		end

		-- set up the active buttons

		for i=1,num_auras do
			SetButtonAura( frame, frame.ButtonList[i], showAuras[i], proc_time );
		end

		-- if we're dynamically sizing the frame, then calculate and set its
		-- size accordingly

		if frame.options.dynamic_size or (nUI_Options.max_auras and nUI_Options.max_auras > 0) then

			local rows, cols;
			local aura_count = frame.options.dynamic_size and num_auras or min( frame.options.cols * frame.options.rows, nUI_Options.max_auras );				

			if frame.options.horizontal then
				cols = min( frame.options.cols, aura_count );
				rows = math.ceil( aura_count / frame.options.cols );
			else
				cols = math.ceil( aura_count / frame.options.rows );
				rows = min( frame.options.rows, aura_count );
			end

			frame.num_cols = cols;
			frame.num_rows = rows;

		else
		
			frame.num_cols = frame.options.cols;
			frame.num_rows = frame.options.rows;

		end

		SetContainerFrameSize( frame );
		
	end

--	nUI_ProfileStop();

end
