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

local GetFactionInfo         = GetFactionInfo;
local GetNumFactions         = GetNumFactions;
local GetWatchedFactionInfo  = GetWatchedFactionInfo;
local SetWatchedFactionIndex = SetWatchedFactionIndex;

nUI_Profile.nUI_FactionBar = {};

local ProfileCounter = nUI_Profile.nUI_FactionBar;

-------------------------------------------------------------------------------

local FactionStandings =
{
	[0] = nUI_L["Unknown"],	
	[1] = nUI_L["Hated"],	
	[2] = nUI_L["Hostile"],	
	[3] = nUI_L["Unfriendly"],	
	[4] = nUI_L["Neutral"],	
	[5] = nUI_L["Friendly"],	
	[6] = nUI_L["Honored"],	
	[7] = nUI_L["Revered"],	
	[8] = nUI_L["Exalted"], 
};

-------------------------------------------------------------------------------

local background    = CreateFrame( "Frame", "nUI_FactionBarBackground", nUI_Dashboard.Anchor );
local frame         = nUI_Bars:createStatusBar( "nUI_FactionBar", nUI_Dashboard.Anchor );
frame.text          = frame:CreateFontString( "$parentLabel", "OVERLAY" );
frame.Super         = {};

frame.updateBar( nil, { 0, 0, 0, 0 } );
frame:EnableMouse( true );
background:SetAllPoints( frame );

-------------------------------------------------------------------------------

local function UpdateFaction( msg )

--	nUI_ProfileStart( ProfileCounter, "UpdateFaction" );
	
	local	track_faction;
	
	-- if we trapped a combat log chat message, then which faction was it talking about?
	
	if msg then

		-- make sure the message is both an update and and increase in
		-- faction (we ignore faction decreases as they usually immediately
		-- follow the increase that we really care about)
		
		if msg:match( nUI_L[nUI_FACTION_UPDATE_START_STRING] )
		and msg:find( nUI_L[nUI_FACTION_UPDATE_INCREASE_STRING] )
		then
			
			local start_idx = nUI_L[nUI_FACTION_UPDATE_START_STRING]:len() + 1;
			local end_idx   = msg:find( nUI_L[nUI_FACTION_UPDATE_END_STRING] );
			local faction   = end_idx and msg:sub( start_idx, end_idx-1 ) or nil;
				
--			nUI:debug( "nUI_FactionBar: seeking faction ["..(faction or "<nil>").."]", 1 );
			
			-- if we have a new faction to track, make it the watched faction
			
			if faction and frame.faction ~= faction then
				
				local firstFaction = IsInGuild() and 3 or 1;
				
				for i=firstFaction, GetNumFactions() do
					
					if faction == GetFactionInfo( i ) then
		
--						nUI:debug( "nUI_FactionBar: matched faction at i = "..i, 1 );
						frame.faction = faction;
						SetWatchedFactionIndex( i );
						
						break;
					end
				end
			end	
		end
	end

	-- who are we actually watching?
	
	local faction, standing, min, max, cur = GetWatchedFactionInfo();
	local pct = faction and ((cur - min) / (max - min)) or nil;
	
--	nUI:debug( "nUI_FactionBar: faction = ["..(faction or "<nil>").."], standing = "..(standing or "<nil>")..", min = "..(min or "<nil>")..", max = "..(max or "<nil>")..", cur = "..(cur or "<nil>")..", pct = "..(pct or "<nil>"), 1 );
	
	-- if we don't have a faction we're watching, then hide the bar
	
	if not faction then
		
		if frame.faction then
			
			frame.faction = nil;
			frame.showing = false;
			
			if frame.options and frame.options.bar then
				frame.updateBar( nil, frame.options.bar.color );
			end
		
			frame:SetScript( "OnEnter", nil );
			frame:SetScript( "OnLeave", nil );
			
		end
		
	else

		if not frame.showing then
			
			frame.showing = true;

			frame:SetScript( "OnEnter",
			
				function()
					
--					nUI_ProfileStart( ProfileCounter, "OnEnter" );
	
					GameTooltip:SetOwner( frame );
					GameTooltip:SetText( nUI_L["Faction: <faction name>"]:format( frame.faction ), 1, 0.83, 0 );
					GameTooltip:AddLine( nUI_L["Reputation: <rep level>"]:format( FactionStandings[frame.standing] ), 1, 0.83, 0 );
					GameTooltip:AddLine( nUI_L["Current Rep: <number>"]:format( frame.cur - frame.min ), 1, 0.83, 0 );
					GameTooltip:AddLine( nUI_L["Required Rep: <number>"]:format( frame.max - frame.min ), 1, 0.83, 0 );
					GameTooltip:AddLine( nUI_L["Remaining Rep: <number>"]:format( frame.max - frame.cur ), 1, 0.83, 0 );
					GameTooltip:AddLine( nUI_L["Percent Complete: <number>"]:format( frame.pct * 100 ), 1, 0.83, 0 );
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

		if frame.faction  ~= faction
		or frame.standing ~= standing
		or frame.cur      ~= cur
		or frame.max      ~= max
		or frame.min      ~= min
		then
				
			frame.faction  = faction;
			frame.standing = standing;
			frame.cur      = cur;
			frame.max      = max;
			frame.min      = min;
			
			if frame.enabled and frame.bar.enabled then
--				nUI:debug( "nUI_FactionBar: setting percent = "..pct, 1 );
				frame.updateBar( pct, frame.options.bar.color );
			end
			
			local label = nUI_L["<faction name> (<reputation>) <current rep> of <required rep> (<percent complete>)"]:format( faction, FactionStandings[standing], cur-min, max-min, pct * 100 );
			
			if frame.text.enabled
			and frame.text.value ~= label
			then
				
				frame.text.value = label;
				frame.text:SetText( label );
				
			elseif not frame.text.enabled
			and frame.text.value 
			then
				
				frame.text.value = nil;
				frame.text:SetText( "" );
				
			end
		end		
	end
	
--	nUI_ProfileStop();
	
end

-------------------------------------------------------------------------------

local function onFactionEvent( who, event, arg1 )
	
--	nUI_ProfileStart( ProfileCounter, "onFactionEvent", event );
	
	if event == "ADDON_LOADED" then
		
		if arg1 == "nUI" then		
			nUI:registerScalableFrame( frame );
			nUI:registerSkinnedFrame( frame );
		end
		
	elseif event == "PLAYER_ENTERING_WORLD" 
	or event == "UPDATE_FACTION"
	then 
	
		UpdateFaction();
		
	else
	
		UpdateFaction( arg1 );
		
	end
	
--	nUI_ProfileStop();
	
end

background:SetScript( "OnEvent", onFactionEvent );
background:RegisterEvent( "ADDON_LOADED" );
background:RegisterEvent( "PLAYER_ENTERING_WORLD" );
background:RegisterEvent( "UPDATE_FACTION" );
background:RegisterEvent( "CHAT_MSG_COMBAT_FACTION_CHANGE" );

-------------------------------------------------------------------------------

frame.applyScale = function( scale )
	
--	nUI_ProfileStart( ProfileCounter, "applyScale" );
	
	local anchor  = scale and frame.anchor or nil;
	local scale   = scale or frame.scale or 1;
	local options = frame.options;
	
	frame.scale = scale;
	
	if options then
		
		local width       = options.width * scale * nUI.hScale;
		local height      = options.height * scale * nUI.vScale;
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
			frame.updateBar( nil, { 0, 0, 0, 0 } );
			
		else
			
			frame.bar.enabled = true;
			
			frame.setBar( nil, 0, 1 );
			frame.setOverlay( options.bar.overlay );
			frame.setOrientation( options.bar.orient );
			
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
	
	local skin = skin and skin.FactionBar or nUI_DefaultConfig.FactionBar;
	
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
