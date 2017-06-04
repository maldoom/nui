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
if not nUI.SpellStatus then nUI.SpellStatus = {}; end
if not nUI.Cooldowns then nUI.Cooldowns = {}; end
if not nUI_ButtonColors then nUI_ButtonColors = {}; end
if not nUI_DefaultConfig then nUI_DefaultConfig = {}; end
if not nUI_Profile then nUI_Profile = {}; end;

local ActionHasRange     = ActionHasRange;
local CreateFrame        = CreateFrame;
local GetBindingKey      = GetBindingKey;
local GetActionInfo      = GetActionInfo;
local IsActionInRange    = IsActionInRange;
local IsUsableAction     = IsUsableAction;
local IsConsumableAction = IsConsumableAction;
local GetActionCount     = GetActionCount;
local UnitExists         = UnitExists;
local UnitIsUnit         = UnitIsUnit;
local GetTime            = GetTime;
local GetActionInfo      = GetActionInfo;
local UIFrameFlash       = UIFrameFlash;
local floor              = math.floor;
local nUI                = nUI;
local SpellStatus        = nUI.SpellStatus;
local Cooldowns          = nUI.Cooldowns;

nUI_Profile.nUI_Button = {};

local ProfileCounter = nUI_Profile.nUI_Button;

-------------------------------------------------------------------------------

nUI_DefaultConfig.ButtonColors =
{
	["OOR"]     = { r = 1, g = 0.5, b = 0.5 },
	["OOM"]     = { r = 0.35, g = 0.5, b = 1 },
	["UNUSABLE"]= { r = 0.45, g = 0.45, b = 0.45 },
	["CDC1"]    = { r = 1, g = 1, b = 0 },
	["CDC2"]    = { r = 1, g = 0.6, b = 0.6 },
}

-------------------------------------------------------------------------------
-- spells we know to be valid for checking the global cooldown (GCD)

local nUI_GCDSpells    = {};
local nUI_CandidateGCD = {};

local frame = CreateFrame( "Frame", "nUI_ButtonEvents", WorldFrame );

-------------------------------------------------------------------------------

local function onFeedbackEvent( who, event, arg1 )
	
--	nUI_ProfileStart( ProfileCounter, "onFeedbackEvent", event );

-- WoW 4.3 change by Belechannas to make cooldown timers work
	if event == "ACTIONBAR_UPDATE_COOLDOWN" then
		if nUI_ButtonMap then
			for button, overlay in pairs(nUI_ButtonMap) do
				if (button.action) then
					local start, duration, enable = GetActionCooldown(button.action);
					if start and duration then 
						overlay.abCooldown( button, start, duration, enable ); 
					end
				end
			end
		end
-- end WoW 4.3 change
	elseif event == "ADDON_LOADED" and arg1 == "nUI" then
		
		nUI:patchConfig();
		nUI:configButtons();		
	end		
	
--	nUI_ProfileStop();
	
end

frame:SetScript( "OnEvent", onFeedbackEvent );
frame:RegisterEvent( "ADDON_LOADED" );
frame:RegisterEvent("ACTIONBAR_UPDATE_COOLDOWN"); -- 4.3 change to handle cooldown timers

local actionName;
local btnName;
local key1, key2;
local action;
local update_vertex;
local is_usable;
local is_oor;
local is_oom;
local can_use, oom;
local count;
local in_range;
local color;
local spellType, id;
local cooldown;
local cdc;
local cdc2;
local spell_info;
local start;
local duration;
local now;
local remain;
local name;
local do_action_update;
local visible;
local unit_info;
local aura_info;
local aura;
local proc_time;
local text;
local overlay;

-------------------------------------------------------------------------------
-- initialize configuration for the action button color indicators
-- 
-- this method is called when the mod's saved variables have been loaded by Bliz and
-- may be called again whenever the button color configuration has been changed
-- by the player or programmatically. Passing true or a non-nil value for "use_default"
-- will cause the player's current feedback color configuration to be replaced with
-- the default settings defined at the top of this file (which cannot be undone!)

function nUI:configButtons( use_default )
	
--	nUI_ProfileStart( ProfileCounter, "configButtons" );
	
	if not nUI_ButtonColors then nUI_ButtonColors = {}; end
	
	for color in pairs( nUI_DefaultConfig.ButtonColors ) do
		nUI:configButtonColor( color, use_default );
	end

--	nUI_ProfileStop();
	
end

function nUI:configButtonColor( color, use_default )
	
--	nUI_ProfileStart( ProfileCounter, "configButtonColor" );
	
	local config  = nUI_ButtonColors[color] or {};
	local default = nUI_DefaultConfig.ButtonColors[color] or {};
	
	if use_default then
			
		config.r = default.r;
		config.g = default.g;
		config.b = default.b;

	else
			
		config.r = tonumber( config.r or default.r );
		config.g = tonumber( config.g or default.g );
		config.b = tonumber( config.b or default.b );

	end
	
	nUI_ButtonColors[color] = config;
	
--	nUI_ProfileStop();
	
end

-------------------------------------------------------------------------------
-- support method to convert time remaining into a countdown text string

function nUI_DurationText( remain )

--	nUI_ProfileStart( ProfileCounter, "nUI_DurationText" );
	
	if remain > 3600 then -- over an hour remaining
		
		text = ("%0.0f"):format( remain / 3600 ).."h";
		
	elseif remain > 60 then -- over one minute remaining
	
		text = ("%0.0f"):format( remain / 60 ).."m";
		
	elseif remain > 1 then -- more than a second to go
	
		text = ("%0.0f"):format( remain ).."s";
		
	else -- less than two seconds
	
		text = ("%0.1f"):format( remain );
		
	end
	
--	nUI_ProfileStop();
		
	return text;
	
end

-------------------------------------------------------------------------------
-- hook the action button update function because Blizzard insists on constantly
-- resetting the button normal texture even when we try to get rid of it, so
-- we get rid of it again if they put it back. Pushy bastages!

hooksecurefunc( "ActionButton_Update",

	function( self )
	
		if self and nUI_ButtonMap[self] then
			
			if self:GetNormalTexture() ~= "" 
			then self:SetNormalTexture( "" ); 
			end
						
			-- there is no built in mechanism I am aware of to check and see if a spell ID
			-- is usable or not... that is, you can test an action to see if it is usable
			-- or oom and you can check both actions and spells for range, but you cannot
			-- check a spell for usable or oom without an attached action. This hack creates
			-- a cache of spell states by spell ID as we update them on the action buttons.
			-- It isn't perfect, but it's usable. One place this is used is in range 
			-- checking since IsSpellInRange() can return 1 if the spell is unusable but
			-- the target is valid (i.e... hunter Kill Command will return "in range" any
			-- time the command is unusable even if the mob is out of range at the time.
			
			overlay  = nUI_ButtonMap[self];			
			action   = ActionButton_CalculateAction( self );
			spellType, id = GetActionInfo( action );
			
			if id 
			and spellType == BOOKTYPE_SPELL 
			and id > 0
			then
				
				if not SpellStatus[id] then SpellStatus[id] = {}; end;

				overlay.spellID        = id;
				overlay.spellStatus    = SpellStatus[id];						
				SpellStatus[id].name,
				SpellStatus[id].rank   = GetSpellInfo( id );

			else
			
				if overlay.spellStatus then
				
					if overlay.spellStatus.remains then
					
						overlay.spellStatus.remains = nil;
						overlay.layers.cdc.value    = nil;
						overlay.layers.cdc:SetText( "" );
					end
						
					if overlay.is_flashing then
						color = nUI_ButtonColors["CDC2"] or nUI_DefaultConfig.ButtonColors["CDC2"];
					elseif overlay.is_cdc then
						color = nUI_ButtonColors["CDC1"] or nUI_DefaultConfig.ButtonColors["CDC1"];
					else
						color = nil;
					end
					
					if color then							
						if overlay.layers.cdc.r ~= color.r
						or overlay.layers.cdc.g ~= color.g
						or overlay.layers.cdc.b ~= color.b
						then
							overlay.layers.cdc.r = color.r;
							overlay.layers.cdc.g = color.g;
							overlay.layers.cdc.b = color.b;
							overlay.layers.cdc:SetTextColor( color.r, color.g, color.b );
						end
					end
					
					overlay.spellStatus = nil;
				end					
			end
		end
	end
);

-------------------------------------------------------------------------------
-- hook action button updates

hooksecurefunc( "ActionButton_OnUpdate",

	function( self, elapsed )

--		nUI_ProfileStart( ProfileCounter, "ActionButton_OnUpdate" );
	
		if self and nUI_ButtonMap[self] then
			if nUI_ButtonMap[self].onUpdate( self, elapsed ) then
				nUI_ButtonMap[self].updateUsable( self );
			end
		end	

--		nUI_ProfileStop();
		
	end	
);

-------------------------------------------------------------------------------
-- hook cooldown timer setups
-- commented out by Belechannas
-- Does not work as of 4.3; handle ACTIONBAR_UPDATE_COOLDOWN above instead
--[[
hooksecurefunc( "CooldownFrame_SetTimer",

	function( cooldown, start, duration, enable )

--		nUI_ProfileStart( ProfileCounter, "CooldownFrame_SetTimer" );
		if cooldown and start and duration and nUI_ButtonMap[cooldown] then 
			nUI_ButtonMap[cooldown].abCooldown( cooldown, start, duration, enable ); 
		end
		
--		nUI_ProfileStop();
		
	end	
);
--]]

-------------------------------------------------------------------------------
-- hook hotkey updates

hooksecurefunc( "ActionButton_UpdateHotkeys",

	function( self, buttonType )

--		nUI_ProfileStart( ProfileCounter, "ActionButton_UpdateHotkeys" );
	
		if self and not nUI.logout then 
		
		    if nUI_ButtonMap[self] then 
    		
			    nUI_ButtonMap[self].updateHotkeys( self ); 
    			
	        elseif not InCombatLockdown() then
    	    
	            local id;
	            local button;
	            local actionName;
    	        
                if ( not buttonType ) then
                    buttonType = "ACTIONBUTTON";
		            id = self:GetID();
	            else
		            if ( actionButtonType == "MULTICASTACTIONBUTTON" ) then
			            id = self.buttonIndex;
		            else
			            id = self:GetID();
		            end
                end

                actionName = buttonType..id;
                button     = nUI_ButtonTypeMap[actionName];

	            if button then
    	        
			        local key1, key2 = GetBindingKey( actionName );
	                local btnName    = button:GetName();
    	            
			        if key1 then 
				        SetBinding( key1, "CLICK "..btnName..":LeftButton" );
			        end
			        if key2 then 
				        SetBinding( key2, "CLICK "..btnName..":LeftButton" );
			        end	            
                end            
		    end
        end
        
--		nUI_ProfileStop();
		
	end	
);

-------------------------------------------------------------------------------
-- hook usability updates

hooksecurefunc( "ActionButton_UpdateUsable",

	function( self )

--		nUI_ProfileStart( ProfileCounter, "ActionButton_UpdateUsable" );
	
		if self and nUI_ButtonMap[self] then 
			nUI_ButtonMap[self].updateUsable( self ); 
		end
		
--		nUI_ProfileStop();
		
	end
	
);

-------------------------------------------------------------------------------
-- setup hooks and support methods in the SecureActionButton class to manage
-- nUI features

function nUI:initActionButton( button )

--	nUI_ProfileStart( ProfileCounter, "initActionButton" );
	
	-- initialization when button is first created
	
	local overlay  = nUI_ButtonMap[button];
	
	if not overlay then
		overlay               = CreateFrame( "Frame", "$parent_ActionOverlay", button );
		nUI_ButtonMap[button] = overlay;
		
		overlay:SetAttribute( "nUI_ActionButtonOverlay", true );
	end
	
	if not overlay.nUI_init then
				
		local btn_name = button:GetName();
	
		overlay:SetAllPoints( button );
		
		overlay:SetFrameStrata( button:GetFrameStrata() );
		overlay:SetFrameLevel( button:GetFrameLevel()+1 );
		
		overlay.button            = button;
		overlay.nUI_init          = true;
		overlay.elapsed           = 0;
		overlay.layers            = {};	
		overlay.Timers            = {};
		overlay.Timers.range      = 0;
		overlay.Timers.cdc        = 0;
		overlay.Timers.cdc_expire = nil;
		overlay.Timers.spellCheck = 1 / nUI_DEFAULT_FRAME_RATE;
		overlay.Timers.visibility = 0;	
		overlay.Timers.scale      = 0;
		
		overlay.is_usable         = true;
		overlay.is_oom            = false;
		overlay.is_oor            = false;
		overlay.is_cdc            = false;
	
		-- cache references to all of the relevant frames
	
		overlay.layers.flash     = _G[btn_name.."Flash"];
		overlay.layers.count     = _G[btn_name.."Count"];
		overlay.layers.name      = _G[btn_name.."Name"];
		overlay.layers.border    = _G[btn_name.."Border"];
		overlay.layers.cooldown  = _G[btn_name.."Cooldown"];
		overlay.layers.normal    = _G[btn_name.."NormalTexture"];
		overlay.layers.normal2   = _G[btn_name.."NormalTexture2"];
		overlay.layers.castable  = _G[btn_name.."AutoCastable"];
		overlay.layers.autocast  = _G[btn_name.."AutoCast"];
		overlay.layers.icon      = _G[btn_name.."Icon"];
		overlay.layers.hotkey    = _G[btn_name.."HotKey"];
		overlay.layers.pushed    = button:GetPushedTexture();
		overlay.layers.highlight = button:GetHighlightTexture();

		overlay.nUI_CachedClearAllPoints = button.ClearAllPoints;
		overlay.nUI_CachedSetAllPoints   = button.SetAllPoints;
		overlay.nUI_CachedSetPoint       = button.SetPoint;

		if overlay.layers.cooldown then nUI_ButtonMap[overlay.layers.cooldown] = overlay; end
		
		---------------------------------------------------------------------------
		-- dispose of the Blizz background textures
		
		button:SetNormalTexture( "" ); 		

		---------------------------------------------------------------------------
		-- create a frame to hold the cooldown counter text
	
		overlay.layers.cdcFrame = CreateFrame( "Frame", btn_name.."_CDC", button );
		overlay.layers.cdc      = overlay.layers.cdcFrame:CreateFontString( "$parentLabel", nil );

		overlay.layers.cdcFrame:ClearAllPoints();
		overlay.layers.cdcFrame:SetAllPoints( button );
		
		overlay.layers.cdc:ClearAllPoints();
		overlay.layers.cdc:SetAllPoints( overlay.layers.cdcFrame );
		overlay.layers.cdc:SetJustifyH( "CENTER" );
		overlay.layers.cdc:SetJustifyV( "MIDDLE" );
		overlay.layers.cdc:SetTextColor( 1, 1, 0, 1 );
			
		---------------------------------------------------------------------------
		-- create a grid to display when dragging actions
	
		overlay.layers.grid    = CreateFrame( "Frame", btn_name.."_Grid", button:GetParent() );
		overlay.layers.grid:SetAttribute( "nUI_ActionButtonOverlay", true );
		
		overlay.layers.grid:SetBackdrop(
			{
				bgFile   = "Interface\\AddOns\\nUI\\Layouts\\Default\\Art\\nUI_BevelboxBg.blp", 
				edgeFile = "Interface\\AddOns\\nUI\\Layouts\\Default\\Art\\nUI_BevelboxBorder.blp", 
				tile     = true, 
				tileSize = 1, 
				edgeSize = 5, 
				insets   = {left = 0, right = 0, top = 0, bottom = 0},
			}
		);
	
		overlay.layers.grid:SetScript( "OnEvent",
		
			function( who, event )
				
--				nUI_ProfileStart( ProfileCounter, "OnEvent", event );
	
				if event == "ACTIONBAR_SHOWGRID" then overlay.layers.grid:SetAlpha( 1 );
				elseif event == "ACTIONBAR_HIDEGRID" then overlay.layers.grid:SetAlpha( 0 );
				elseif event == "PLAYER_TARGET_CHANGED" then overlay.updateUsable( button );
				elseif event == "UPDATE_BINDINGS" then overlay.updateHotkeys( button );
				end

--				nUI_ProfileStop();
				
			end
		);
		
		overlay.layers.grid:SetAlpha( 0 );
		overlay.layers.grid:SetAllPoints( button );
		overlay.layers.grid:SetFrameStrata( button:GetFrameStrata() );
		overlay.layers.grid:SetFrameLevel( button:GetFrameLevel() );
		overlay.layers.grid:SetBackdropColor( 0, 0, 0, 0.25 );
		overlay.layers.grid:RegisterEvent( "ACTIONBAR_SHOWGRID" );
		overlay.layers.grid:RegisterEvent( "ACTIONBAR_HIDEGRID" );
		overlay.layers.grid:RegisterEvent( "PLAYER_TARGET_CHANGED" );
		overlay.layers.grid:RegisterEvent( "UPDATE_BINDINGS" );
		
		---------------------------------------------------------------------------
		-- tweak the macro name label 
		
		if overlay.layers.name then
			overlay.layers.name:ClearAllPoints();
			overlay.layers.name:SetPoint( "TOP", button, "TOP", 1, 0 );
			overlay.layers.name:SetPoint( "BOTTOM", button, "BOTTOM", 1, 1 );
			overlay.layers.name:SetPoint( "LEFT", button, "LEFT", 1, 0 );
			overlay.layers.name:SetPoint( "RIGHT", button, "RIGHT", 1, 0 );
			overlay.layers.name:SetJustifyH( "CENTER" );
			overlay.layers.name:SetJustifyV( "BOTTOM" );
			overlay.layers.name:SetTextColor( 1, 1, 1, 1 );
		end

		---------------------------------------------------------------------------
		-- tone down the autocast animation if present
		
		if overlay.layers.autocast then		
			overlay.layers.autocast:SetAlpha( 0.05 );		
		end

		---------------------------------------------------------------------------
		-- extra border on pet frame buttons
		
		if overlay.layers.normal2 then 
			overlay.layers.normal2:SetAlpha( 0 ); 
		end			

		---------------------------------------------------------------------------
		-- Blizz stomps on the hotkey text mercilessly, so take control of it
		
		if overlay.layers.hotkey then 
			overlay.layers.hotkey:SetAlpha( 0 );
			overlay.layers.hotkey = button:CreateFontString( "$parent_nUIHotkey", nil );
		else
			overlay.layers.hotkeyFrame = CreateFrame( "Frame", "$parent_nUIHotkeyFrame", button );
			overlay.layers.hotkey = overlay.layers.hotkeyFrame:CreateFontString( "$parentLabel", nil );				
		end
		
		overlay.layers.hotkey:ClearAllPoints();
		overlay.layers.hotkey:SetPoint( "TOP", button, "TOP", 1, 0 );
		overlay.layers.hotkey:SetPoint( "BOTTOM", button, "BOTTOM", 1, 1 );
		overlay.layers.hotkey:SetPoint( "LEFT", button, "LEFT", 1, 0 );
		overlay.layers.hotkey:SetPoint( "RIGHT", button, "RIGHT", 1, 0 );			
		overlay.layers.hotkey:SetJustifyH( "LEFT" );
		overlay.layers.hotkey:SetJustifyV( "TOP" );
		overlay.layers.hotkey:SetTextColor( 1, 1, 1, 1 );
				
		---------------------------------------------------------------------------
		-- just to manage position and font size
		
		if overlay.layers.count then
			overlay.layers.count:ClearAllPoints();
			overlay.layers.count:SetPoint( "TOP", button, "TOP", 0, 0 );
			overlay.layers.count:SetPoint( "BOTTOM", button, "BOTTOM", 0, 1 );
			overlay.layers.count:SetPoint( "LEFT", button, "LEFT", 1, 0 );
			overlay.layers.count:SetPoint( "RIGHT", button, "RIGHT", 1, 0 );
			overlay.layers.count:SetJustifyH( "RIGHT" );
			overlay.layers.count:SetJustifyV( "BOTTOM" );
			overlay.layers.count:SetTextColor( 1, 1, 1, 1 );
		end
		
		---------------------------------------------------------------------------
		-- start a new cooldown count
		
		overlay.abCooldown = function( self, start, duration, enable )
		
--			nUI_ProfileStart( ProfileCounter, "abCooldown" );
			-- start a counter
			
			if start > 0 and duration > 0 and enable > 0 then
				
				overlay.cdc_start    = start;
				overlay.cdc_duration = duration;
				
				overlay:updateCooldown();
				
			-- otherwise, if we're not enabling and we have an active cooldown, cancel it
			
			elseif overlay.is_cdc then
	
				overlay.cdc_start    = GetTime();
				overlay.cdc_duration = -1;
				
				overlay:updateCooldown();
			
			end

--			nUI_ProfileStop();
	
		end	

		-------------------------------------------------------------------------------
		-- set the key binding text
		
		overlay.updateHotkeys = function()
						
--			nUI_ProfileStart( ProfileCounter, "updateHotkeys" );

		    key1, key2 = GetBindingKey( "CLICK "..button:GetName()..":LeftButton");
	        text       = strupper( key1 or key2 or "" );
    			
            if overlay.text ~= text then
                
		        if ( text == "" ) then
			        overlay.layers.hotkey:SetText( "" );
			        overlay.layers.hotkey:SetAlpha( 0 );
    				
		        else

			        text = text:gsub( "NUMPAD", "|c00FF9966np|r" );
			        text = text:gsub( "NUMLOCK", "|c00FF9966nl|r" );
			        text = text:gsub( "MOUSEBUTTON ", "|c0000FFFFM|r" );
			        text = text:gsub( "MIDDLEMOUSE", "|c0000FFFFMM|r" );
			        text = text:gsub( "MOUSEWHEELUP", "|c0000FFFFWU|r" );
			        text = text:gsub( "MOUSEWHEELDOWN", "|c0000FFFFWD|r" );
			        text = text:gsub( "BACKSPACE", "|c00FF9966Bs|r" );
			        text = text:gsub( "SPACEBAR", "|c00FF9966Sp|r" );
			        text = text:gsub( "ESCAPE", "|c00FF9966Esc|r" );
			        text = text:gsub( "DELETE", "|c00FF9966De|r" );
			        text = text:gsub( "HOME", "|c00FF9966Ho|r" );
			        text = text:gsub( "CAPSLOCK", "|c00FF9966Caps|r" );
			        text = text:gsub( "END", "|c00FF9966En|r" );
			        text = text:gsub( "TAB", "|c00FF9966Tab|r" );
			        text = text:gsub( "ENTER", "|c00FF9966Ent|r" );
			        text = text:gsub( "INSERT", "|c00FF9966Ins|r" );
			        text = text:gsub( "PAGEUP", "|c00FF9966Pu|r" );
			        text = text:gsub( "PAGEDOWN", "|c00FF9966Pd|r" );
			        text = text:gsub( "DOWN", "|c00FF9966D|r" );
			        text = text:gsub( "UP", "|c00FF9966U|r" );
			        text = text:gsub( "LEFT", "|c00FF9966L|r" );
			        text = text:gsub( "RIGHT", "|c00FF9966R|r" );
			        text = text:gsub( "DIVIDE", "/" );
			        text = text:gsub( "MINUS", "-" );
			        text = text:gsub( "PLUS", "+" );
			        text = text:gsub( "MULTIPLY", "*" );

			        text = text:gsub( "CTRL--", "|c00FF9966c|r")
			        text = text:gsub( "ALT--", "|c00FF9966a|r")
			        text = text:gsub( "SHIFT--", "|c00FF9966s|r")
			        text = text:gsub( "STRG--", "|c00FF9966s|r" );
			        text = text:gsub( "MAJ--", "|c00FF9966s|r" );
    			
			        overlay.layers.hotkey:SetText( text );
			        overlay.layers.hotkey:SetAlpha( nUI_Options.barKeyBindings and 1 or 0 );
    				
		        end
            end
                            
--			nUI_ProfileStop();
	
		end
		
		-------------------------------------------------------------------------------
		-- called when ActionButton_UpdateUsable is called on a button we have hooked
		
		overlay.updateUsable = function()
			
--			nUI_ProfileStart( ProfileCounter, "updateUsable" );

			-- there's nothing to do if there's no visible icon

			overlay.layers.icon = _G[btn_name.."Icon"];

			if overlay.layers.icon and overlay.layers.icon:IsVisible() and overlay.layers.icon:GetAlpha() > 0 then
			
				action = ActionButton_CalculateAction( button );
				
				overlay.action = action;


				if action then
					
					update_vertex = false;
					is_usable     = false;
					is_oor        = false;
					is_oom        = false;
				
					can_use, oom = IsUsableAction( action );

					-- if the spell is usable then we leave the oom flag cleared
					
					if can_use or not UnitExists( "Target" ) then

						is_usable = true;
						
					-- if the spell is not usable because of oom, be sure both flags are set
							
					elseif oom then 
						
						is_usable = true;
						is_oom    = true;
				
					end
					
					-- if this is a consumable action and there's none left to consume, it's unusable
					
					if is_usable and IsConsumableAction( action ) then
						
						count = GetActionCount( action );
						
						if count <= 0 then 
							is_usable = false; 
						end
						
					end
					
					-- if the action has a range component, then we do oor checks on it
					
					if ActionHasRange( action ) then
								
						in_range = IsActionInRange( action );

						if in_range == false then
							
							is_oor = true;

						end
					end
					
					-- if we changed any of the three states, save the state change
					
					if is_usable ~= overlay.is_usable 
					or is_oor ~= overlay.is_oor 
					or is_oom ~= overlay.is_oom 
					then
						overlay.is_usable = is_usable;
						overlay.is_oor    = is_oor;
						overlay.is_oom    = is_oom;
						
						if overlay.spellStatus then

							overlay.spellStatus.usable = is_usable;
							overlay.spellStatus.oor    = is_oor;
							overlay.spellStatus.oom    = is_oom;
						
						end
					end				

					-- color the icon based on the state we last calculated for it
					-- I'd like to only do this when the state changes, but WoW's code
					-- steps on our coloring if we don't do it every time
					if not is_usable then 
						color = nUI_ButtonColors["UNUSABLE"] or nUI_DefaultConfig.ButtonColors["UNUSABLE"];
					elseif is_oor then
						color = nUI_ButtonColors["OOR"] or nUI_DefaultConfig.ButtonColors["OOR"];
					elseif is_oom then
						color = nUI_ButtonColors["OOM"] or nUI_DefaultConfig.ButtonColors["OOM"];
					else
						colorName = "normal";
						color = { r=1, g=1, b=1 };
					end

					overlay.r = color.r;
					overlay.g = color.g;
					overlay.b = color.b;
				end
			end	

--			nUI_ProfileStop();

		end
		
		-------------------------------------------------------------------------------
		-- called when ActionButton_OnUpdate is called on a button we have hooked
				
		overlay.onUpdate = function( self, elapsed )
		
--			nUI_ProfileStart( ProfileCounter, "onUpdate" );

			do_action_update = false;
			visible = true;
		
			-- check the button for visibility. If there's no icon for the button 
			-- or the icon is not shown, then we need to hide the cooldown count
			-- and hotkey. Likewise, there's no reason to do any other work if
			-- there's no visible buttons
			
			overlay.layers.icon = _G[btn_name.."Icon"];
			
			if not overlay.layers.icon or not overlay.layers.icon:IsVisible() then
				visible = false;
			end
			if not visible then
			
				-- if we're not visible, then hide our custom layers, too
				
				if not overlay.hidden then
					overlay.layers.hotkey:SetAlpha( 0 );
					overlay.layers.cdc:SetAlpha( 0 );
					overlay.hidden = true;
				end
				
			else
				
				-- otherwise, if the layers are hidden, show them
				
				if overlay.hidden then	
					overlay.layers.hotkey:SetAlpha( 1 );
					overlay.layers.cdc:SetAlpha( 1 );
					overlay.hidden = nil;					
				end
			
				-- check for updates to the out of range and out of mana status
				
				overlay.Timers.range = overlay.Timers.range + elapsed;
				
				if overlay.Timers.range >= 0.08 then -- update at 12.5fps
				
					overlay.Timers.range = 0;
					do_action_update  = true;
								
				end
		
				-- check for update to cooldown counter
		
				if overlay.Timers.cdc_expire then
					
					overlay.Timers.cdc = overlay.Timers.cdc + elapsed;
					if overlay.Timers.cdc >= overlay.Timers.cdc_expire then -- rate varies by time remaining
						
						overlay.Timers.cdc = 0;
					
						overlay.updateCooldown( button );
						
					end
				end
			end

--			nUI_ProfileStop();
	
			return do_action_update;
		
		end

		-------------------------------------------------------------------------------
		-- keep a cooldown counter on the face of applicable buttons
		
		overlay.updateCooldown = function()
			
--			nUI_ProfileStart( ProfileCounter, "updateCooldown" );

			action     = ActionButton_CalculateAction( button );
			spellType, id   = GetActionInfo( action );
			cooldown   = id and Cooldowns[id] or nil;
			cdc        = cooldown and cooldown.text or nil;
			cdc2       = overlay.layers.cdc;
			start      = overlay.cdc_start;
			duration   = overlay.cdc_duration;
			spell_info = overlay.spellStatus and overlay.spellStatus.remains;
			now        = GetTime();
		
			overlay.action = action;
			
			if not (start > 0) 
			and not (duration > 0) 
			and overlay.is_cdc 
			then
					
				overlay.is_cdc            = false;
				overlay.is_flashing       = false;
				overlay.Timers.cdc_expire = nil;
		
				if cdc then cdc:SetText( "" ); end;
				
				if not spell_info then 
				
					if cdc2.value and not spell_info then
						cdc2.value = nil;
						cdc2:SetText( "" ); 
					end
				end
				
				if cooldown then 					
					cooldown.done = true;
					if nUI.hud then nUI.hud:updateCooldowns(); end
				end

			-- we only process the cooldown after the current time has hit the start time
			
			elseif now < start then
				
				overlay.Timers.cdc_expire = start - now;
				
			-- otherwise we'll get to work
			
			elseif id and type( id ) == "number" and id > 0 then
		
				remain     = duration - ( now - start );
				text       = "";
		
				-- again... we only have work to do if there's still time remaining
				
				if remain <= 0 then
				
--					nUI:debug( button:GetName()..": remain < 0" );
					
					-- if we have an active cooldown counter we need to expire it
					-- and we'll return to looking for cooldowns at 12.5fps
					
					if overlay.is_cdc then
					
						overlay.is_cdc            = false;
						overlay.is_flashing       = false;
						overlay.Timers.cdc_expire = nil;
		
						if cdc then cdc:SetText( "" ); end
		
						if cdc2.value and not spell_info then
							cdc2.value = nil;
							cdc2:SetText( "" ); 
						end
						
						if cooldown then 
							overlay.done = true;
							if nUI.hud then nUI.hud:updateCooldowns(); end
						end				
					end
					
				else

					if not overlay.is_cdc then

						color = nUI_ButtonColors["CDC1"] or nUI_DefaultConfig.ButtonColors["CDC1"];
						
						if spellType == "spell" and id  and id > 0 then

							name = GetSpellInfo( id );
			
							-- if this is a spell that we know to be on the global cooldown counter
							-- then we can set the current value of the GCD accordingly. Note that
							-- is a value that can potentially change over time w/spellhaste and 
							-- the like.
							
							if nUI_GCDSpells[name] then nUI.GCD = duration; end
							
						end

						-- do not show counters on buttons that are just spinning the global cooldown

						if duration <= (nUI.GCD or 2) then 
--							nUI:debug( button:GetName()..": Initiating global cooldown in HUD" );
							if nUI_Unit then nUI_Unit:startGCD( duration ); end
--							nUI_ProfileStop();
							return; 
						end

						-- this duration is not GCD, so run it...
						
						overlay.is_cdc      = true;
						overlay.is_flashing = false;
		
						if not cooldown then
							
							Cooldowns[id] = {};
							
							cooldown = Cooldowns[id];
						end
						
						overlay.action   = action;
						overlay.id       = id;
						overlay.start    = start;
						overlay.duration = duration;
						overlay.done     = false;
						overlay.icon     = overlay.layers.icon;
		
						if nUI.hud then nUI.hud:updateCooldowns(); end
						
						cdc = cooldown.text;
						
						if not spell_info then 
						
							if cdc2.r ~= color.r
							or cdc2.g ~= color.g
							or cdc2.b ~= color.b
							then
								cdc2.r = color.r;
								cdc2.g = color.g;
								cdc2.b = color.b;
								cdc2:SetTextColor( color.r, color.g, color.b, 1 ); 
							end
						end
						
					elseif not overlay.is_flashing and remain < 10 then

--						nUI:debug( button:GetName()..": starting flash sequence" );
						
						color = nUI_ButtonColors["CDC2"] or nUI_DefaultConfig.ButtonColors["CDC2"];
						overlay.is_flashing = true;
						
						if cdc then
							cdc:SetTextColor( color.r, color.g, color.b, 1 );
						end
		
						if not spell_info then 
						
							if cdc2.r ~= color.r
							or cdc2.g ~= color.g
							or cdc2.b ~= color.b
							then
								cdc2.r = color.r;
								cdc2.g = color.g;
								cdc2.b = color.b;
								cdc2:SetTextColor( color.r, color.g, color.b, 1 ); 
							end
						end
		
						-- flag the item as flashing in the cooldown table so the hud
						-- can modify the cooldown display
						
						if cooldown then 
							cooldown.flashing = true; 
							if nUI.hud then nUI.hud:updateCooldowns(); end
						end				
					end
					
					-- in the interest of efficiency, we set our time to expire for
					-- the next cooldown count check based on how much time is left.
		
					text = nUI_DurationText( remain );
					-- over an hour remaining

					if remain > 3600 then 
						
						overlay.Timers.cdc_expire = remain % 3600;
						
					-- over one minute remaining
		
					elseif remain > 60 then 
					
						overlay.Timers.cdc_expire = remain % 60;
						
					-- more than a second to go
		
					elseif remain > 1 then 
					
						overlay.Timers.cdc_expire = remain % 1;
						
					-- less than a second
		
					else 
					
						overlay.Timers.cdc_expire = remain - math.floor( remain * 10 ) / 10;
						
					end

					-- if we have a text object, update it, otherwise we'll recheck at 12.5fps

					if cdc then 
						cdc:SetText( text ); 
						if cdc2.value and not spell_info then
							cdc2.value = nil;
							cdc2:SetText( "" );
						end
					elseif not cooldown then 
					
						overlay.Timers.cdc_expire = 0.08;
						
					elseif not spell_info then 

						if not nUI_Options.barCooldowns then
							text = nil;
						end
						
						if cdc2.value ~= text then
							cdc2.value = text;
							cdc2:SetText( text );
						end
					end
				end
			end

--			nUI_ProfileStop();
	
		end		
	end	
	
	-- track spell time remaining on the target
	
	overlay:SetScript( "OnUpdate",
	
		function( who, elapsed )
		
			-- check to see if this button's spell is currently active on the target
			
			overlay.Timers.spellCheck = overlay.Timers.spellCheck - elapsed;
			
			if overlay.Timers.spellCheck <= 0 then

				text                      = nil;			
				unit_info                 = nUI_Unit.TargetInfo;
				overlay.Timers.spellCheck = nUI_Unit.frame_rate or (1 / nUI_DEFAULT_FRAME_RATE);
				
				if not unit_info 
				or not overlay.spellStatus
				then
	
					if overlay.spellStatus
					and overlay.spellStatus.remains
					then
					
						overlay.spellStatus.remains = nil;
						overlay.layers.cdc.value    = nil;
						overlay.layers.cdc:SetText( "" );
						
					end
					
				else

					-- deal with remaining spell duration if it is enabled on the action bar
					
					if nUI_Options.barDurations then
						
						proc_time = GetTime();
						aura_info = unit_info.aura_info and unit_info.aura_info.buff_list or nil;
						overlay.spellStatus.remains = nil;
						
						if aura_info then 
							for i=1,#aura_info do
								
								aura = aura_info[i];
								
								if  aura.end_time
								and aura.caster
								and aura.end_time > proc_time
								and aura.name == overlay.spellStatus.name
	--							and aura.rank == overlay.spellStatus.rank					
								and aura.caster == "player"
								then
									overlay.spellStatus.remains = aura.end_time - proc_time;
									overlay.spellStatus.color   = overlay.is_cdc and { r=0.75, g=0.05, b=1 } or { r=0, g=1, b=1 };
									break;
								end
							end
						end
						
						if not overlay.spellStatus.remains then
						
							aura_info = unit_info.aura_info and unit_info.aura_info.debuff_list or nil;
							
							if aura_info then 
								for i=1,#aura_info do
								
									aura = aura_info[i];
								
									if  aura.end_time
									and aura.end_time > proc_time
									and aura.name == overlay.spellStatus.name
	--								and aura.rank == overlay.spellStatus.rank					
									and aura.caster == "player"
									then 
										overlay.spellStatus.remains = aura.end_time - proc_time;
										overlay.spellStatus.color   = overlay.is_cdc and { r=0.75, g=0.05, b=1 } or { r=0, g=1, b=1 };
										break;
									end
								end
							end
						end

						if overlay.spellStatus.remains then					
							text = nUI_SecondsLeftToString( overlay.spellStatus.remains );
						end
					
						if text 
						and overlay.layers.cdc.value ~= text 
						then
						
							overlay.layers.cdc.value = text;
							overlay.layers.cdc:SetText( text or "" );
							
							if overlay.layers.cdc.r ~= overlay.spellStatus.color.r
							or overlay.layers.cdc.g ~= overlay.spellStatus.color.g
							or overlay.layers.cdc.b ~= overlay.spellStatus.color.b
							then
								overlay.layers.cdc.r = overlay.spellStatus.color.r; 
								overlay.layers.cdc.g = overlay.spellStatus.color.g; 
								overlay.layers.cdc.b = overlay.spellStatus.color.b; 
								overlay.layers.cdc:SetTextColor( overlay.spellStatus.color.r, overlay.spellStatus.color.g, overlay.spellStatus.color.b );
							end
						end												
					end									
				end
				
				if not text 
				or not nUI_Options.barDurations
				or not overlay.spellStatus
				or not overlay.spellStatus.remains
				then
																
					if overlay.is_flashing then
						color = nUI_ButtonColors["CDC2"] or nUI_DefaultConfig.ButtonColors["CDC2"];
					elseif overlay.is_cdc then
						color = nUI_ButtonColors["CDC1"] or nUI_DefaultConfig.ButtonColors["CDC1"];
					else
						if overlay.layers.cdc.value then
							overlay.layers.cdc.value = nil;
							overlay.layers.cdc:SetText( "" );
						end
						color = nil;
					end
					
					if color then							
						if overlay.layers.cdc.r ~= color.r
						or overlay.layers.cdc.g ~= color.g
						or overlay.layers.cdc.b ~= color.b
						then
							overlay.layers.cdc.r = color.r;
							overlay.layers.cdc.g = color.g;
							overlay.layers.cdc.b = color.b;
							overlay.layers.cdc:SetTextColor( color.r, color.g, color.b );
						end
					end
				end
				
				if (not InCombatLockdown() and not nUI_Unit.TargetInfo)
				or not nUI_Options.barDimming
				then

			        overlay.layers.icon:SetAlpha( 1 );
					overlay.layers.cooldown:SetAlpha( 1 );
				    
				elseif overlay.layers.cdc.value
				or overlay.is_cdc
				or not overlay.is_usable
				then

			        overlay.layers.icon:SetAlpha( nUI_Options.dimmingAlpha or 0.3 );
					overlay.layers.cooldown:SetAlpha( nUI_Options.dimmingAlpha or 0.3 );

			    else

			        overlay.layers.icon:SetAlpha( 1 );
					overlay.layers.cooldown:SetAlpha( 1 );
			        
				end				

				overlay.layers.icon:SetVertexColor( overlay.r, overlay.g, overlay.b, 1 );

			end
		end
	);
			
	-- these steps are performed when the button is first initialized and any 
	-- time the display size changes or anything may alter scaling of the button

	local scale   = button:GetEffectiveScale();
	local height  = button:GetHeight();
	local width   = button:GetWidth();
	
	overlay.layers.cdcFrame:SetScale( 1.0 / scale );
	overlay.layers.cdc:SetFont( nUI_L["font1"], height * scale * 0.45, "OUTLINE" );
	overlay.layers.hotkey:SetFont( nUI_L["font1"], height / 2.5, "OUTLINE" );
	overlay.layers.count:SetFont( nUI_L["font1"], height / 2.5, "OUTLINE" );
	overlay.layers.name:SetFont( nUI_L["font1"], height / 3, "OUTLINE" );

	-- tweak some of the layer scales to make them "fit" better
	
	if overlay.layers.border then
		
		local layer = overlay.layers.border;
		local hInset = width * nUI.hScale * 0.95;
		local vInset = height * nUI.vScale * 0.95;
		
		layer:ClearAllPoints();
		layer:SetPoint( "TOPLEFT", button, "TOPLEFT", -hInset, vInset );
		layer:SetPoint( "TOPRIGHT", button, "TOPRIGHT", hInset, vInset );
		layer:SetPoint( "BOTTOMLEFT", button, "BOTTOMLEFT", -hInset, -vInset );
		layer:SetPoint( "BOTTOMRIGHT", button, "BOTTOMRIGHT", hInset, -vInset );
	end	
	
	-- initialize the button state
	
	overlay.updateHotkeys( button );
	overlay.updateUsable( button );
	
	if overlay.action then
		
		local start, duration, enable = GetActionCooldown( overlay.action );
		overlay.abCooldown( button, start, duration, enable );
		
	end	
	
--	nUI_ProfileStop();
	
end
