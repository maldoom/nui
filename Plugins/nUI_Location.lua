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

local CreateFrame            = CreateFrame;
local date                   = date;
local GetCurrentMapContinent = GetCurrentMapContinent;
local GetCurrentMapZone      = GetCurrentMapZone;
local GetGameTime            = GetGameTime;
local GetMapZones            = GetMapZones;
local GetPlayerMapPosition   = GetPlayerMapPosition;
local SetMapToCurrentZone    = SetMapToCurrentZone;

nUI_Profile.nUI_Location = {};
nUI_Options.clock        = nUI_L[nUI_SLASHCMD_OPTIONS( nUI_SLASHCMD_CLOCK, "server" )];
nUI_Options.map_coords   = true;

local ProfileCounter = nUI_Profile.nUI_Location;

-------------------------------------------------------------------------------

local background  = CreateFrame( "Frame", "nUI_LocationBackground", nUI_Dashboard.Anchor );
local frame       = CreateFrame( "Button", "nUI_Location", nUI_Dashboard.Anchor, "SecureFrameTemplate" );
frame.text_anchor = frame:CreateTexture( "$parent_Anchor", "BACKGROUND" );
frame.location    = frame:CreateFontString( "$parent_Label", "ARTWORK" );
frame.coords      = frame:CreateFontString( "$parent_Coords", "ARTWORK" );
frame.clock       = frame:CreateFontString( "$parent_Clock", "ARTWORK" );

background:SetAllPoints( frame );
frame.text_anchor:SetPoint( "CENTER", frame, "CENTER", 0, 0 );
frame.text_anchor:SetWidth( 2 );

frame.location:SetFontObject( SystemFont_Outline_Small );
frame.location:SetJustifyH( "CENTER" );
frame.location:SetJustifyV( "MIDDLE" );
frame.location:SetPoint( "TOP", frame.text_anchor, "TOP", 0, 0 );

frame.coords:SetJustifyH( "CENTER" );
frame.coords:SetJustifyV( "MIDDLE" );
frame.coords:SetPoint( "TOP", frame.location, "BOTTOM", 0, 0 );

frame.clock:SetJustifyH ("CENTER" );
frame.clock:SetJustifyV( "MIDDLE" );
frame.clock:SetPoint( "TOP", frame.coords, "BOTTOM", 0, 0 );

RegisterStateDriver( frame, "visibility", "[target=mouseover, exists] hide; show" );

MiniMapInstanceDifficulty:SetParent( frame );
MiniMapInstanceDifficulty:ClearAllPoints();
MiniMapInstanceDifficulty:SetPoint( "BOTTOMLEFT", frame, "BOTTOMLEFT", 2, -2 );

GuildInstanceDifficulty:SetParent( frame );
GuildInstanceDifficulty:ClearAllPoints();
GuildInstanceDifficulty:SetPoint( "BOTTOMLEFT", frame, "BOTTOMLEFT", 2, -2 );

-------------------------------------------------------------------------------

nUI_MapLocation = CreateFrame( "Frame", "nUI_MapLocation", WorldMapPositioningGuide );
nUI_MapLocation.label = nUI_MapLocation:CreateFontString( nil, "OVERLAY" );
nUI_MapLocation.label:SetJustifyH( "CENTER" );
nUI_MapLocation.label:SetJustifyV( "BOTTOM" );
nUI_MapLocation.label:SetFontObject( SystemFont_Outline_Small );

local function SetLocationAnchor()

	nUI_MapLocation.label:ClearAllPoints();
	
	if ( WORLDMAP_SETTINGS.size == WORLDMAP_WINDOWED_SIZE ) then
		nUI_MapLocation.label:SetPoint( "BOTTOM", WorldMapPositioningGuide, "BOTTOM", 0, 35 );
	else	
		nUI_MapLocation.label:SetPoint( "BOTTOM", WorldMapPositioningGuide, "BOTTOM", 0, 11 );
	end
	
end

--hooksecurefunc( "WorldMapQuestShowObjectives_AdjustPosition", SetLocationAnchor );
nUI_MapLocation:SetScript( "OnShow", SetLocationAnchor );

local player_x, player_y;
local cursor_x, cursor_y;
local map_scale;
local map_width;
local map_height;
local center_x, center_y;

local function nUI_MapCoordUpdate( who, elapsed )

	player_x, player_y = GetPlayerMapPosition( "player" );
	cursor_x, cursor_y = GetCursorPosition();
	map_scale          = WorldMapDetailFrame:GetEffectiveScale();
	map_width          = WorldMapDetailFrame:GetWidth();
	map_height         = WorldMapDetailFrame:GetHeight();
	center_x, center_y = WorldMapDetailFrame:GetCenter();
	
	cursor_x = cursor_x / map_scale;
	cursor_y = cursor_y / map_scale;
	
	cursor_x = (cursor_x - (center_x - (map_width / 2))) / map_width;	
	cursor_y = (center_y + (map_height / 2) - cursor_y) / map_height;
	
	cursor_x = max( 0, min( 100, cursor_x * 100 ) );
	cursor_y = max( 0, min( 100, cursor_y * 100 ) );
			
	nUI_MapLocation.label:SetText( 
		nUI_L["Cursor: <cursor_x,cursor_y>  /  Player: <player_x,player_y>"]:format( cursor_x, cursor_y, player_x * 100, player_y * 100 ) 
	);
	
end

-------------------------------------------------------------------------------

local timer = 0;
local mapX, mapY;
local inInstance;
local coords;
local location;
local server_hour, server_minute;
local local_hour, local_minute;
local time_str;
local clock;
local mode;
local local_suffix;
local server_suffix;
local height;

local function onLocationUpdate( who, elapsed )

--	nUI_ProfileStart( ProfileCounter, "onLocationUpdate" );
	
	local emptyVar -- 5.0.4 Doesn't like us using _ variables
	
	timer = timer + elapsed;
	
	if timer >= 0.1 then -- 10fps update

		timer = 0;
		
		if not WorldMapFrame:IsVisible() then

			-- map coordinates
			
			mapX, mapY   = GetPlayerMapPosition( "player" );
			-- 5.0.4 Start
			-- inInstance,_ = IsInInstance();
			inInstance,emptyVar = IsInInstance();
			-- 5.0.4 End
			coords       = ("%0.1f - %0.1f"):format( mapX * 100, mapY * 100 );
			
			if frame.coords.value ~= coords
			then

				frame.coords.value = coords;				
				frame.coords:SetText( coords );
			
			end
			
			-- map location
			
			location = GetMinimapZoneText();
			
			if frame.location.value ~= location then
				
				frame.location.value = location;				
				frame.location:SetText( location );
				
			end
			
			-- clock
			
			server_hour, server_minute = GetGameTime();
			local_hour, local_minute = tonumber( date( "%H" ) ), tonumber( date( "%M" ) );
			time_str = "";
			clock    = TimeManagerMilitaryTimeCheck and TimeManagerMilitaryTimeCheck:GetChecked() and 24 or 12;
			mode     = nUI_Options.clock or nUI_L[nUI_SLASHCMD_OPTIONS( nUI_SLASHCMD_CLOCK, "server" )];
			
			if clock == 12 then
		
				local_suffix  = nUI_L["am"];
				server_suffix = local_suffix;
					
				if local_hour >= 12 then
					local_hour   = local_hour - 12;
					local_suffix = nUI_L["pm"];
				end
				
				if local_hour == 0 then
					local_hour = 12;
				end
			
				if server_hour >= 12 then
					server_hour   = server_hour - 12;
					server_suffix = nUI_L["pm"];
				end
				
				if server_hour == 0 then
					server_hour = 12;
				end
			
				if mode == nUI_L[nUI_SLASHCMD_OPTIONS( nUI_SLASHCMD_CLOCK, "both" )] then
					time_str = nUI_L["(S) <hour>:<minute><suffix> - <hour>:<minute><suffix> (L)"]:format( server_hour, server_minute, server_suffix, local_hour, local_minute, local_suffix );
				elseif mode == nUI_L[nUI_SLASHCMD_OPTIONS( nUI_SLASHCMD_CLOCK, "local" )] then
					time_str = nUI_L["<hour>:<minute><suffix>"]:format( local_hour, local_minute, local_suffix );
				else
					time_str = nUI_L["<hour>:<minute><suffix>"]:format( server_hour, server_minute, server_suffix );
				end
		
			else
			
				if mode == nUI_L[nUI_SLASHCMD_OPTIONS( nUI_SLASHCMD_CLOCK, "both" )] then
					time_str = nUI_L["(S) <hour>:<minute> - <hour>:<minute> (L)"]:format( server_hour, server_minute, local_hour, local_minute );
				elseif mode == nUI_L[nUI_SLASHCMD_OPTIONS( nUI_SLASHCMD_CLOCK, "local" )] then
					time_str = nUI_L["<hour>:<minute>"]:format( local_hour, local_minute );
				else
					time_str = nUI_L["<hour>:<minute>"]:format( server_hour, server_minute );
				end
				
			end

			if frame.clock.value ~= time_str then
				
				frame.clock.value = time_str;
				frame.clock:SetText( time_str );
				
			end			
			
			-- and size the anchor if required
			
			height = frame.location:GetHeight() + frame.coords:GetHeight() + frame.clock:GetHeight();
			
			if frame.text_anchor.height ~= height then
				frame.text_anchor.height = height;
				frame.text_anchor:SetHeight( height );
			end
		end	
	end
	
--	nUI_ProfileStop();
	
end

-------------------------------------------------------------------------------

local function onLocationEvent( who, event, arg1 )
	
--	nUI_ProfileStart( ProfileCounter, "onLocationEvent", event );
	
	if event == "ADDON_LOADED" and arg1 == "nUI" then
		
		LoadAddOn( "Blizzard_TimeManager" );
		
		nUI:registerSkinnedFrame( frame );
		nUI:registerScalableFrame( frame );
	
		-- set up a slash command handler for choosing a 12 or 24 hour clock
		
		local option = nUI_SlashCommands[nUI_SLASHCMD_CLOCK];
		
		nUI_SlashCommands:setHandler( option.command,
			
			function( msg, arg1 )
				
				local clock = arg1 or nUI_L[nUI_SLASHCMD_OPTIONS( nUI_SLASHCMD_CLOCK, "server" )];
				
				if not  clock == nUI_L[nUI_SLASHCMD_OPTIONS( nUI_SLASHCMD_CLOCK, "server" )]
				and not clock == nUI_L[nUI_SLASHCMD_OPTIONS( nUI_SLASHCMD_CLOCK, "local" )]
				and not clock == nUI_L[nUI_SLASHCMD_OPTIONS( nUI_SLASHCMD_CLOCK, "both" )]
				then
					
					DEFAULT_CHAT_FRAME:AddMessage( nUI_L["nUI: [ %s ] is not a valid clock option... please choose either 'local' to display the local time, 'server' to display the server time or 'both' to display both times."]:format( arg1 ), 1, 0.83, 0 );
					
				elseif nUI_Options.clock ~= clock then
					
					nUI_Options.clock = clock;
					
					DEFAULT_CHAT_FRAME:AddMessage( (option.message):format( clock ), 1, 0.83, 0 );

				end
			end
		);	
		
		-- set up a slash command handler for dealing with setting the onebag toggle
		
		local option = nUI_SlashCommands[nUI_SLASHCMD_MAPCOORDS];
		
		nUI_SlashCommands:setHandler( option.command,
			
			function( msg )

				nUI_Options.map_coords = not nUI_Options.map_coords;
				
				DEFAULT_CHAT_FRAME:AddMessage( (option.message):format( nUI_Options.map_coords and nUI_L["|cFF00FF00ENABLED|r"] or nUI_L["|cFFFF0000DISABLED|r"] ), 1, 0.83, 0 );
				
				nUI_MapLocation:SetScript( "OnUpdate", nUI_Options.map_coords and nUI_MapCoordUpdate or nil );
				
				if not nUI_Options.map_coords then
					nUI_MapLocation.label:SetText( "" );
				end
				
			end
		);		
				
	elseif event == "PLAYER_LOGIN" then

		nUI_MapLocation:SetScript( "OnUpdate", nUI_Options.map_coords and nUI_MapCoordUpdate or nil );
		
		if TimeManagerClockButton_OnEnter then
			
			hooksecurefunc( "TimeManagerMilitaryTimeCheck_OnClick", function() onLocationUpdate( nil, 5 ); end );
			
			nUI.HideDefaultFrame( TimeManagerClockButton );
			
			frame:SetScript( "OnEnter", 
				function() 
					GameTooltip:SetOwner( frame, "ANCHOR_LEFT");
					frame:SetScript( "OnUpdate", 
						function( who, elapsed ) 
							TimeManagerClockButton_OnUpdateWithTooltip( who, elapsed ); 
							onLocationUpdate( who, elapsed ); 
						end 
					);
				end 
			);
			frame:SetScript( "OnLeave", 
				function() 
					GameTooltip:Hide();
					frame:SetScript( "OnUpdate", onLocationUpdate );
				end 
			);
			frame:SetScript( "OnClick", function() TimeManagerClockButton_OnClick( frame ); end );
		
		end
	end
	
--	nUI_ProfileStop();
	
end

frame:SetScript( "OnEvent", onLocationEvent );
frame:RegisterEvent( "ADDON_LOADED" );
frame:RegisterEvent( "PLAYER_LOGIN" );

-------------------------------------------------------------------------------

frame.applyScale = function( scale )
	
--	nUI_ProfileStart( ProfileCounter, "applyScale" );
	
	local anchor   = scale and frame.anchor or nil;
	local scale    = scale or frame.scale or 1;
	local options  = frame.options;
	
	if options then
	
		local height   = options.height * scale * nUI.vScale;
		local width    = options.width * scale * nUI.hScale;
		local fontsize = (options.fontsize or 12) * scale * nUI.vScale * 1.75;
		
		if frame.width    ~= width
		or frame.height   ~= height
		or frame.fontsize ~= fontsize 
		then
			
			frame.height   = height;
			frame.width    = width;
			frame.fontsize = fontsize;
			
			frame:SetHeight( height );
			frame:SetWidth( width );
			
			frame.location:SetFont( nUI_L["font2"], fontsize, "OUTLINE" );
			frame.coords:SetFont( nUI_L["font1"], fontsize * 0.9, "OUTLINE" );
			frame.clock:SetFont( nUI_L["font1"], fontsize * 0.9, "OUTLINE" );
	
			frame.text_anchor:SetHeight( frame.location:GetHeight() + frame.coords:GetHeight() + frame.clock:GetHeight() );

			MiniMapInstanceDifficulty:SetScale( height * 0.7 / MiniMapInstanceDifficulty:GetHeight() );
						
		end
	end
	
--	nUI_ProfileStop();
	
end

-------------------------------------------------------------------------------

frame.applyAnchor = function( anchor )
	
--	nUI_ProfileStart( ProfileCounter, "applyAnchor" );
	
	local anchor = anchor or frame.anchor or {};
	local anchor_pt   = anchor.anchor_pt or "CENTER";
	local relative_to = anchor.relative_to or frame:GetParent():GetName();
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
	
--	nUI_ProfileStop();
	
end

-------------------------------------------------------------------------------

frame.applyOptions = function( options )
	
--	nUI_ProfileStart( ProfileCounter, "applyOptions" );
	
	frame.options = options;
	
	if not options or not options.enabled then
		
--		nUI:debug( "nUI_Location: player location is disabled", 1 );
		
		frame:SetAlpha( 0 );
		frame:SetScript( "OnUpdate", nil );
		
	else
	
--		nUI:debug( "nUI_Location: player location is enabled", 1 );
		
		background:SetFrameStrata( options.strata or frame:GetParent():GetFrameStrata() );
		background:SetFrameLevel( frame:GetParent():GetFrameLevel() + (options.level or 1) );
		
		frame:SetFrameStrata( background:GetFrameStrata() );
		frame:SetFrameLevel( background:GetFrameLevel()+1 );
		
		MiniMapMailFrame:SetFrameStrata( frame:GetFrameStrata() );
		MiniMapMailFrame:SetFrameLevel( frame:GetFrameLevel()+1 );
		
		-- 5.0.1 Change Start
		--MiniMapBattlefieldFrame:SetFrameStrata( frame:GetFrameStrata() );
		--MiniMapBattlefieldFrame:SetFrameLevel( frame:GetFrameLevel()+1 );
		-- 5.0.1 Change End
		
		frame:SetAlpha( 1 );
		frame:SetScript( "OnUpdate", onLocationUpdate );
		
		local color = options.color or { r = 1, g = 0.83, b = 0 };
		
		frame.location:SetTextColor( color.r, color.g, color.b, 1 );
		frame.coords:SetTextColor( color.r, color.g, color.b, 1 );
		frame.clock:SetTextColor( color.r, color.g, color.b, 1 );
		
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
			
			background:SetBackdrop( options.background.backdrop );
			background:SetBackdropBorderColor( border_color.r, border_color.g, border_color.b, border_color.a );
			background:SetBackdropColor( backdrop_color.r, backdrop_color.g, backdrop_color.b, backdrop_color.a );
	
		else 
			
			background:SetBackdrop( nil );
			
		end
		
		frame.applyScale( options.scale or frame.scale or 1 );
		
	end
	
--	nUI_ProfileStop();
	
end

-------------------------------------------------------------------------------

frame.applySkin = function( skin )
	
--	nUI_ProfileStart( ProfileCounter, "applySkin" );
	
	local skin = skin and skin.Location or nUI_DefaultConfig.Location;
	
	if skin and skin.enabled then
		
--		nUI:debug( "nUI_Location: setting skin", 1 );
		
		frame.applyOptions( skin.options );
		frame.applyAnchor( skin.anchor );
	
	else
		
		frame:SetScript( "OnUpdate", nil );
		frame:SetAlpha( 0 );
		
	end
	
--	nUI_ProfileStop();
	
end