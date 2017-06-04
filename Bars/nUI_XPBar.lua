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

if not nUI_DefaultConfig then nUI_DefaultConfig = {}; end
if not nUI_Profile then nUI_Profile = {}; end;

local GetRestState    = GetRestState;
local GetXPExhaustion = GetXPExhaustion;
local IsResting       = IsResting;
local UnitLevel       = UnitLevel;
local UnitXP          = UnitXP;
local UnitXPMax       = UnitXPMax;

nUI_Profile.nUI_XPBar = {};

local ProfileCounter = nUI_Profile.nUI_XPBar;

-------------------------------------------------------------------------------

local XpPerLevel = 
{
	   400,    900,   1400,   2100,   2800,   3600,   4500,   5400,   6500,   6700,		--  1 to 10
	  7000,   7700,   8700,   9700,  10800,  11900,  13100,  14200,  15400,  16600,		-- 11 to 20
	 17900,  19200,  20400,  21800,  23100,  24400,  25800,  27100,  29000,  31000,		-- 21 to 30
	 33300,  35700,  38400,  41100,  44000,  47000,  49900,  53000,  56200,  74300,		-- 31 to 40
	 78500,  82800,  87100,  91600,  96300, 101000, 105800, 110700, 115700, 120900,		-- 41 to 50
	126100, 131500, 137000, 142500, 148200, 154000, 159900, 165800, 172000, 254000, 	-- 51 to 60
	275000, 301000, 328000, 359000, 367000, 374000, 381000, 388000, 395000, 405000,		-- 61 to 70
	415000, 422000, 427000, 432000, 438000, 445000, 455000, 462000, 474000, 482000,		-- 71 to 80
	487000, 492000, 497000, 506000, 517000, 545000, 550000, 556000, 562000, 774800,		-- 81 to 90
	783900, 790400, 798200, 807300, 815100, 821600, 830700, 838500, 846300, 854100,		-- 91 to 100
	     0,      0,      0,      0,      0,      0,      0,      0,      0,      0,     -- 101 to 110
};

-------------------------------------------------------------------------------

local background    = CreateFrame( "Frame", "nUI_XPBarBackground", nUI_Dashboard.Anchor );
local frame         = nUI_Bars:createStatusBar( "nUI_XPBar", nUI_Dashboard.Anchor );
frame.text          = frame:CreateFontString( "$parentLabel", "OVERLAY" );
frame.rest          = frame:CreateTexture( "$parentRested", "BORDER" );
frame.tick          = frame:CreateTexture( "$parentRestedTick", "ARTWORK" );
frame.rest.active = true;
frame.tick.active   = true;
frame.Super         = {};

frame.rest:SetColorTexture( 1, 1, 1, 1 );
frame.updateBar( nil, { 0, 0, 0, 0 } );
background:SetAllPoints( frame );

-------------------------------------------------------------------------------

local function UpdateXP( player_lvl )
	
--	nUI_ProfileStart( ProfileCounter, "UpdateXP" );
	
	local is_rested, name, mult  = GetRestState();
	local resting    = IsResting();
	local rested_xp  = GetXPExhaustion();
	local xp         = UnitXP( "player" );
	local xp_max     = UnitXPMax( "player" );
	local label      = frame.text;
	local xp_pct     = xp / xp_max;
	local txt_color;

	if frame.xp        ~= xp
	or frame.xp_max    ~= xp_max
	or frame.xp_pct    ~= xp_pct
	or frame.rested_xp ~= rested_xp
	or frame.level     ~= player_lvl
	then
		
		frame.xp        = xp;
		frame.xp_max    = xp_max;
		frame.xp_pct    = xp_pct;
		frame.rested_xp = rested_xp;
		frame.level     = player_lvl;
			
		if not frame.showing then
			
			frame.showing = true;
			frame.bar:SetAlpha( 1 ); 
			frame.rest:SetAlpha( 1 );
			frame.tick:SetAlpha( 1 );
			frame:EnableMouse( true );
			
			frame:SetScript( "OnEnter", 
			
				function()
					
--					nUI_ProfileStart( ProfileCounter, "OnEnter" );
	
					GameTooltip:SetOwner( frame );
					GameTooltip:SetText( nUI_L["Current level: <level>"]:format( frame.level ), 1, 0.83, 0 );
					
					if frame.xp then
						GameTooltip:AddLine( nUI_L["Current XP: <experience points>"]:format( frame.xp ), 1, 0.83, 0 );
					end
					
					if frame.xp_max then
						GameTooltip:AddLine( nUI_L["Required XP: <XP required to reach next level>"]:format( frame.xp_max ), 1, 0.83, 0 );
					end
					
					if frame.xp and frame.xp_max then
						GameTooltip:AddLine( nUI_L["Remaining XP: <XP remaining to level>"]:format( frame.xp_max - frame.xp ), 1, 0.83, 0 );
					end
					
					if frame.xp_pct then
						GameTooltip:AddLine( nUI_L["Percent complete: <current XP / required XP>"]:format( frame.xp_pct * 100 ), 1, 0.83, 0 );
					end
					
					if frame.rested_xp and frame.xp_max then
						GameTooltip:AddLine( nUI_L["Rested XP: <total rested experience> (percent)"]:format( frame.rested_xp, frame.rested_xp / frame.xp_max * 100 ), 1, 0.83, 0 );
					end

					if frame.levels and frame.levels > 0 then
						GameTooltip:AddLine( nUI_L["Rested Levels: <levels>"]:format( frame.levels ), 1, 0.83, 0 );
					end
					
					GameTooltip:Show();
					
--					nUI_ProfileStop();
					
				end
			);
			
			frame:SetScript( "OnLeave", 
			
				function() 
--					nUI_ProfileStart( ProfileCounter, "OnLeave" );	
					GameTooltip:Hide(); 
--					nUI_ProfileStop();					
				end 
			);
			
		end
		
		if frame.options then 
		
			frame.updateBar( xp_pct, frame.options.bar.colors.xp );
		
			-- if we have some rested XP, then place a marker in the appropriate place
			
			if rested_xp and rested_xp > 0 then

				txt_color = frame.text.enabled and frame.options.label.color.rested;

				local offset        = xp + rested_xp;
				local level         = player_lvl;
				local dX            = offset / xp_max;
				local XpToLevel     = XpPerLevel[level] or 0;
				local XpAtNextLevel = XpPerLevel[level+1];

				if not xp_max == XpToLevel then
					print( "Please tell kscottpiel@gmail.com that the XP at level ".. level .." is " .. xp_max .. " not " .. XpToLevel  );
					nUI_XpErrata[level] = xp_max;
					XpPerLevel[level]   = xp_max;
					XpToLevel           = xp_max;
				end
				
				while level <= MAX_PLAYER_LEVEL and offset > XpToLevel do
					offset = offset - XpToLevel; 
					dX     = offset / (XpAtNextLevel or XpToLevel); -- need this in case player hits MAX_PLAYER_LEVEL with more than one rested level remaining
					level  = level+1; 
				end

				frame.levels = level - player_lvl + (level < MAX_PLAYER_LEVEL and (offset / XpToLevel) or 0);
				
				-- we only display the rested XP end marker if the marker is on the 
				-- current level as the player or the player is less than max level-1. Otherwise,
				-- there is no such thing as wraparound rested XP for a max level-1 player.
				
				if not (level > player_lvl and player_lvl+1 == MAX_PLAYER_LEVEL) then
						
					local orient = frame.options.bar.orient;
								
					if not frame.tick.active then 
						frame.tick.active = true;
						frame.tick:SetAlpha( 1 );
					end
					
					frame.tick:ClearAllPoints();
					
					if orient == "RIGHT" then
						frame.tick:SetPoint( "CENTER", frame, "RIGHT", -dX * frame:GetWidth(), -1.5 );
					elseif orient == "TOP" then				
						frame.tick:SetPoint( "CENTER", frame, "TOP", 0, -dX * frame:GetHeight() );
					elseif orient == "BOTTOM" then
						frame.tick:SetPoint( "CENTER", frame, "BOTTOM", 0, dX * frame:GetWidth() );
					else
						frame.tick:SetPoint( "CENTER", frame, "LEFT", dX * frame:GetWidth(), -1.5 );
					end
					
				elseif frame.tick.active then

					frame.tick.active = false;
					frame.tick:SetAlpha( 0 );
					
				end
				
				-- draw a rested XP bar behind the XP bar
				
				if xp + rested_xp > xp_max then
					
					if frame.options.bar.orient == "TOP" or frame.options.bar.orient == "BOTTOM" then
						local size = frame.height * (1 - xp_pct );					
						frame.rest:SetHeight( size );
					else
						local size = frame.width * (1 - xp_pct );					
						frame.rest:SetWidth( size );
					end
					
				-- draw a partial bar from the end of the current XP to 
				-- XP + rested XP
				
				else

					local rested_pct = rested_xp / xp_max;
									
					if frame.options.bar.orient == "TOP" or frame.options.bar.orient == "BOTTOM" then
						local size = frame.height * rested_pct;
						frame.rest:SetHeight( size );
					else
						local size = frame.width * rested_pct;
						frame.rest:SetWidth( size );
					end
				end
			else
				
--				text_color = frame.text.enabled and frame.options.label.color.normal;
				
				if frame.tick.active then
				
					frame.tick.active = false;
					frame.tick:SetAlpha( 0 );
					
				end
				
				if frame.rest.active then
				
					frame.rest.active = false;
					frame.rest:SetAlpha( 0 );
					
				end
			end
			
			if label.enabled then
				
				label:SetText( nUI_L["Level <player level>: <experience> of <max experience> (<percent of total>), <rested xp> rested XP"]:format( player_lvl, xp, xp_max, xp_pct * 100, rested_xp or 0 ) );
				label:SetTextColor( txt_color.r, txt_color.g, txt_color.b, 1 );
			
			end
		end
	end
	
--	nUI_ProfileStop();
	
end

-------------------------------------------------------------------------------

local function onXPBarEvent( who, event, arg1 )
	
--	nUI_ProfileStart( ProfileCounter, "onXPBarEvent", event );
	
	if event == "ADDON_LOADED" then
		
		if arg1 == "nUI" then
			nUI:registerScalableFrame( frame );
			nUI:registerSkinnedFrame( frame );
		end
		
	elseif event == "PLAYER_ENTERING_WORLD" then 
		
		if UnitLevel( "player" ) == MAX_PLAYER_LEVEL then
			frame:Hide();
		else	
			UpdateXP( nUI_Unit.PlayerInfo and nUI_Unit.PlayerInfo.level or UnitLevel( "player" ) );
		end
		
	elseif event == "PLAYER_LEVEL_UP" then 
	
		if arg1 == MAX_PLAYER_LEVEL then
			frame:Hide();
		else	
			UpdateXP( tonumber( arg1 ) );
		end
		
	else

		-- 5.0.1 Change start - Make sure PlayerInfo exists	
		-- UpdateXP( nUI_Unit.PlayerInfo.level or UnitLevel( "player" ) );
		UpdateXP( nUI_Unit.PlayerInfo and nUI_Unit.PlayerInfo.level or UnitLevel( "player" ) );
		-- 5.0.1 Change End
		
	end
	
--	nUI_ProfileStop();
	
end

background:SetScript( "OnEvent", onXPBarEvent );
background:RegisterEvent( "ADDON_LOADED" );
background:RegisterEvent( "PLAYER_ENTERING_WORLD" );
background:RegisterEvent( "PLAYER_XP_UPDATE" );
background:RegisterEvent( "UPDATE_EXHAUSTION" );
background:RegisterEvent( "PLAYER_LEVEL_UP" );
background:RegisterEvent( "PLAYER_UPDATE_RESTING" );
background:RegisterEvent( "PLAYER_ENTERING_WORLD" );

-------------------------------------------------------------------------------

frame.Super.onSizeChanged = frame.onSizeChanged;
frame.onSizeChanged       = function()

--	nUI_ProfileStart( ProfileCounter, "onSizeChanged" );
	
	frame.Super.onSizeChanged();
	
	if not frame.horizontal then
		frame.rest:SetWidth( frame.bar:GetWidth() );
	else
		frame.rest:SetHeight( frame.bar:GetHeight() );
	end
	
--	nUI_ProfileStop();
	
end

-------------------------------------------------------------------------------

frame.Super.setOrientation = frame.setOrientation;
frame.setOrientation       = function( orient )

--	nUI_ProfileStart( ProfileCounter, "setOrientation" );
	
	frame.Super.setOrientation( orient );
	frame.rest:ClearAllPoints();
	
	if orient == "RIGHT" then
		frame.rest:SetPoint( "TOPRIGHT", frame.bar, "TOPLEFT", 0, 0 );
		frame.rest:SetPoint( "BOTTOMRIGHT", frame.bar, "BOTTOMLEFT", 0, 0 );
	elseif orient == "TOP" then
		frame.rest:SetPoint( "TOPLEFT", frame.bar, "BOTTOMLEFT", 0, 0 );
		frame.rest:SetPoint( "TOPRIGHT", frame.bar, "BOTTOMRIGHT", 0, 0 );
	elseif orient == "BOTTOM" then
		frame.rest:SetPoint( "BOTTOMLEFT", frame.bar, "TOPLEFT", 0, 0 );
		frame.rest:SetPoint( "BOTTOMRIGHT", frame.bar, "TOPRIGHT", 0, 0 );
	else
		frame.rest:SetPoint( "TOPLEFT", frame.bar, "TOPRIGHT", 0, 0 );
		frame.rest:SetPoint( "BOTTOMLEFT", frame.bar, "BOTTOMRIGHT", 0, 0 );
	end
	
--	nUI_ProfileStop();
	
end
		
-------------------------------------------------------------------------------

frame.applyScale = function( scale )
	
--	nUI_ProfileStart( ProfileCounter, "appplyScale" );
	
	local anchor  = scale and frame.anchor or nil;
	local scale   = scale or frame.scale or 1;
	local options = frame.options;
	
	frame.scale = scale;
	
	if options then
		
		local width       = options.width * scale * nUI.hScale;
		local height      = options.height * scale * nUI.vScale;
		local tick_width  = (options.bar and options.bar.tick_width or 0) * scale * nUI.hScale;
		local tick_height = (options.bar and options.bar.tick_height or 0) * scale * nUI.vScale;
		local text        = frame.text;
		local font_size   = (options.label and options.label.fontsize or 12) * scale * 1.75 * nUI.vScale;
		local justifyH    = options.label  and options.label.justifyH or "CENTER";
		local justifyV    = options.label  and options.label.justifyV or "MIDDLE";
	
		-- set the bar size
		
		if frame.width  ~= width
		or frame.height ~= height
		then
			
			frame.width  = width;
			frame.height = height;
			
			frame:SetHeight( height );
			frame:SetWidth( width );

			frame.onSizeChanged();
			
		end
		
		if frame.tick.width ~= tick_width
		or frame.tick.height ~= tick_height
		then
			
			frame.tick.width  = tick_width;
			frame.tick.height = tick_height;
			
			frame.tick:SetWidth( tick_width );
			frame.tick:SetHeight( tick_height );
		
		end
		
		-- set the text font size
					
		if text.font_size ~= font_size
		then
			
			-- first time here?
			
			if not text.font_size then 
				text.active  = true;
			end
	
			text.font_size = font_size;
			text:SetFont( nUI_L["font1"], font_size, "OUTLINE" );

		end
		
		-- show or hide the text based on whether or not there is a config for it
		
		text.enabled = options.label and options.label.enabled or false;
		
		if not text.enabled and text.active then

			text.active = false;
			text.value  = nil;				
			text:SetAlpha( 0 );
			text:SetText( "" );				
			
		elseif text.enabled then

			text.active = true;
			text:SetAlpha( 1 );
			
		end
		
		-- set text justification
		
		if text.justifyH ~= justifyH then
			text.justifyH = justifyH;
			text:SetJustifyH( justifyH );
		end
		
		if text.justigyV ~= justifyV then
			text.justifyV = justifyV;
			text:SetJustifyV( justifyV );
		end
	end
	
	if anchor then frame.applyAnchor( anchor ); end
	
--	nUI_ProfileStop();
	
end

-------------------------------------------------------------------------------

frame.applyAnchor = function( anchor )
	
--	nUI_ProfileStart( ProfileCounter, "applyAnchor" );
	
	local anchor      = anchor or frame.anchor or {};
	local anchor_pt   = anchor.anchor_pt or "CENTER";
	local relative_to = anchor.relative_to or frame:GetParent():GetName();
	local relative_pt = anchor.relative_pt or anchor_pt;
	local xOfs        = (anchor.xOfs or 0) * nUI.hScale;
	local yOfs        = (anchor.yOfs or 0) * nUI.vScale;
	
	if frame.anchor_pt   ~= anchor_pt
	or frame.relative_to ~= relative_to
	or frame.relative_pt ~= relative_pt
	or frame.xOfs        ~= xOfs
	or frame.yOfs        ~= yOfs
	then
		
		frame.anchor_pt = anchor_pt;
		frame.relative_to = relative_to;
		frame.relative_pt = relative_pt;
		frame.xOfs        = xOfs;
		frame.yOfs        = yOfs;
		
		frame:ClearAllPoints();
		frame:SetPoint( anchor_pt, relative_to, relative_pt, xOfs, yOfs );
		
	end
	
	if frame.options and frame.text.enabled then
		
		local text  = frame.text;
		local label = frame.options.label;

		anchor_pt   = label.anchor_pt or "CENTER";
		relative_to = label.relative_to or frame:GetName();
		relative_pt = label.relative_pt or anchor_pt;
		xOfs        = (label.xOfs or 0) * frame.scale * nUI.hScale;
		yOfs        = (label.yOfs or 0) * frame.scale * nUI.vScale;
		
		if text.anchor_pt ~= anchor_pt
		or text.relative_to ~= relative_to
		or text.relative_pt ~= relative_pt
		or text.xOfs        ~= xOfs
		or text.yOfs        ~= yOfs
		then
			
			text.anchor_pt = anchor_pt;
			text.relative_to = relative_to;
			text.relative_pt = relative_pt;
			text.xOfs        = xOfs;
			text.yOfs        = yOfs;
			
			text:SetPoint( anchor_pt, relative_to, relative_pt, xOfs, yOfs );
			
		end
	end
	
--	nUI_ProfileStop();
	
end

-------------------------------------------------------------------------------

frame.applyOptions = function( options )
	
--	nUI_ProfileStart( ProfileCounter, "applyOptions" );
	
	frame.options = options;
	
	if not options or not options.enabled then

		frame.setEnabled( false );
		frame:Hide();
		
	else
		
		frame.setEnabled( true );
		frame:Show();
	
		background:SetFrameStrata( options.strata or background:GetParent():GetFrameStrata() );
		background:SetFrameLevel( background:GetFrameLevel() + (options.level or 1) );
		
		frame:SetFrameStrata( background:GetFrameStrata() );
		frame:SetFrameLevel( background:GetFrameLevel()+1 );
		
		-- set up the bar
		
		if not options.bar or not options.bar.enabled then
			
			frame.bar.enabled = false;
			frame.bar:SetAlpha( 0 );
			frame.rest:SetAlpha( 0 );
			frame.tick:SetAlpha( 0 );
			
		else
			
			frame.bar.enabled = true;
			frame.bar:SetAlpha( 1 );
			frame.rest:SetAlpha( 1 );
			frame.tick:SetAlpha( 1 );
			
			frame.tick:SetTexture( options.bar.rested_tick );
			frame.tick:SetTexCoord( 0, 0, 0, 1, 1, 0, 1, 1 );
			frame.setOverlay( options.bar.overlay );
			frame.setBar( nil, 0, 1 );
			frame.setOrientation( options.bar.orient );

			frame.rest:SetVertexColor( options.bar.colors.rested.r, options.bar.colors.rested.g, options.bar.colors.rested.b, 1 );
			
		end
		
		-- if there's a border, set it
		
		if options.border then
				
			local border_color = options.border.color.border;
			local backdrop_color = options.border.color.backdrop;
			
			frame:SetBackdrop( options.border.backdrop );
			frame:SetBackdropBorderColor( border_color.r, border_color.g, border_color.b, border_color.a );
			frame:SetBackdropColor( backdrop_color.r, backdrop_color.g, backdrop_color.b, backdrop_color.a );
	
		else 
			
			frame:SetBackdrop( nil );
			
		end
		
		-- if there's a background, set it
		
		if options.background then
				
			local border_color = options.background.color.border;
			local backdrop_color = options.background.color.backdrop;
			
			background:SetAlpha( 1 );
			background:SetBackdrop( options.background.backdrop );
			background:SetBackdropBorderColor( border_color.r, border_color.g, border_color.b, border_color.a );
			background:SetBackdropColor( backdrop_color.r, backdrop_color.g, backdrop_color.b, backdrop_color.a );
	
		else 
			
			background:SetAlpha( 0 );
			background:SetBackdrop( nil );
			
		end
		
		frame.applyScale( options.scale or frame.scale or 1 );
		
	end
	
--	nUI_ProfileStop();
	
end

-------------------------------------------------------------------------------

frame.applySkin = function( skin )
	
--	nUI_ProfileStart( ProfileCounter, "applySkin" );
	
	local skin = skin and skin.XPBar or nUI_DefaultConfig.XPBar;
	
	if not skin or not skin.enabled then
		
		frame.setEnabled( false );
		frame:Hide();
		background:Hide();
		
	else
		
		frame.setEnabled( true );
		frame:Show();
		background:Show();
		
		frame.applyOptions( skin.options );
		frame.applyAnchor( skin.anchor );
		
	end
	
--	nUI_ProfileStop();
	
end
