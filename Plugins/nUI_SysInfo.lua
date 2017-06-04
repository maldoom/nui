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
if not nUI_Profile then nUI_Profile = {}; end;

nUI_Profile.nUI_SysInfo = {};
nUI_Profile.nUI_SysInfo.Latency = {};
nUI_Profile.nUI_SysInfo.Framerate = {};

local ProfileCounter          = nUI_Profile.nUI_SysInfo;
local LatencyProfileCounter   = nUI_Profile.nUI_SysInfo.Latency;
local FramerateProfileCounter = nUI_Profile.nUI_SysInfo.Framerate;

local maxMem  = 0;
local minRate = 100000;

-------------------------------------------------------------------------------
-- local cache

local CreateFrame  = CreateFrame;
local GetNetStats  = GetNetStats;
local GetFramerate = GetFramerate;

-------------------------------------------------------------------------------

local ratio;
local r, r1, r2, g, g1, g2;

local function colorSelect( value, max, up )
	
--	nUI_ProfileStart( ProfileCounter, "colorSelect" );
	
	ratio = min( value, max ) / max;

	if ratio > 0.5 then
		
		ratio = (ratio - 0.5) * 2;
		if up then
			r1 = 1;
			r2 = 0;
			g1 = 0.83;
			g2 = 1;
		else
			r1 = 1;
			r2 = 1;
			g1 = 0.83;
			g2 = 0;
		end
	else
		ratio = ratio * 2;
		if up then
			r1 = 1;
			r2 = 1;
			g1 = 0;
			g2 = 0.83;
		else
			r1 = 0;
			r2 = 1;
			g1 = 1;
			g2 = 0.83;
		end
	end
	
	r = (r2 - r1) * ratio + r1;
	g = (g2 - g1) * ratio + g1;
	
--	nUI_ProfileStop();
	
	return r, g;
	
end

local NUM_ADDONS_TO_DISPLAY = 10;	
local string;
local i; 
local j; 
local k;
local mem;
local topAddOns = {};

for i=1,NUM_ADDONS_TO_DISPLAY do
	topAddOns[i] = {};
end

local function SysInfo_Tooltip( frame )
	
--	nUI_ProfileStart( ProfileCounter, "SysInfo_Tooltip" );
	
	i = 0; 
	j = 0; 
	k = 0;
	
	for i=1, NUM_ADDONS_TO_DISPLAY do
		topAddOns[i].value = 0;
		topAddOns[i].name = "";
	end
	
	GameTooltip_SetDefaultAnchor( GameTooltip, frame );
	GameTooltip:SetText( nUI_L["System Performance Stats..."], 1, 1, 1 );
	
	-- latency
	
	string = format( MAINMENUBAR_LATENCY_LABEL, nUI.latency, nUI.worldLatency );

	GameTooltip:AddLine( "\n" );
	GameTooltip:AddLine( string, 1.0, 1.0, 1.0 );
	
	if SHOW_NEWBIE_TIPS == "1" then
		GameTooltip:AddLine( NEWBIE_TOOLTIP_LATENCY, NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b, 1 );
	end
	
	GameTooltip:AddLine( "\n" );

	-- framerate
	
	string = format( MAINMENUBAR_FPS_LABEL, nUI.framerate );
	
	GameTooltip:AddLine( string, 1.0, 1.0, 1.0 );
	
	if SHOW_NEWBIE_TIPS == "1" then
		GameTooltip:AddLine( NEWBIE_TOOLTIP_FRAMERATE, NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b, 1 );
	end

	-- AddOn mem usage
	
	local totalMem = 0;

	for i=1, NUM_ADDONS_TO_DISPLAY, 1 do
		topAddOns[i].value = 0;
	end

	UpdateAddOnMemoryUsage();
	
	for i=1, GetNumAddOns(), 1 do
		
		mem = GetAddOnMemoryUsage(i);
		totalMem  = totalMem + mem;
		
		for j=1, NUM_ADDONS_TO_DISPLAY, 1 do
			
			if mem > topAddOns[j].value then
				
				for k=NUM_ADDONS_TO_DISPLAY, 1, -1 do
					
					if k == j then
						
						topAddOns[k].value = mem;
						topAddOns[k].name = GetAddOnInfo(i);
						break;
						
					elseif k ~= 1 then
						
						topAddOns[k].value = topAddOns[k-1].value;
						topAddOns[k].name = topAddOns[k-1].name;
						
					end
				end
				break;
			end
		end
	end

	if totalMem > 0 then
		
		if totalMem > 1000 then
			totalMem = totalMem / 1000;
			string = format( TOTAL_MEM_MB_ABBR, totalMem );
		else
			string = format( TOTAL_MEM_KB_ABBR, totalMem );
		end

		GameTooltip:AddLine( "\n" );
		GameTooltip:AddLine( string, 1.0, 1.0, 1.0 );
		
		if SHOW_NEWBIE_TIPS == "1" then
			GameTooltip:AddLine( NEWBIE_TOOLTIP_MEMORY, NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b, 1 );
		end

		GameTooltip:AddLine( "\n" );
		
		for i=1, NUM_ADDONS_TO_DISPLAY, 1 do
			
			if topAddOns[i].value == 0 then
				break;
			end
			
			local size = topAddOns[i].value;
			
			if size > 1000 then
				size = size / 1000;
				string = format( ADDON_MEM_MB_ABBR, size, topAddOns[i].name );
			else
				string = format( ADDON_MEM_KB_ABBR, size, topAddOns[i].name );
			end
			
			GameTooltip:AddLine( string, 1.0, 1.0, 1.0 );
		end
	end

	GameTooltip:Show();
	
--	nUI_ProfileStop();
	
end

-------------------------------------------------------------------------------

local frame = CreateFrame( "Frame", "nUI_SysInfoEvents", WorldFrame );
local timer = 0;

frame.enabled = true;
nUI_SysInfo   = frame;

-------------------------------------------------------------------------------

local function onSysInfoEvent( who, event, arg1 )

--	nUI_ProfileStart( ProfileCounter, "onSysInfoEvent", event );
	
	if event == "ADDON_LOADED" and arg1 == "nUI" then
			
		nUI:registerSkinnedFrame( frame );
		nUI:registerScalableFrame( frame.latency );
		nUI:registerScalableFrame( frame.fps );

	elseif event == "PLAYER_LOGOUT" then

		if maxMem ~= 0 then nUI:debug( "Maxmimum memory usage (total system) = "..maxMem ); end
		if minRate ~= 100000 then nUI:debug( "Minimum frame rate = "..minRate ); end
		
	end
	
--	nUI_ProfileStop();
	
end

frame:SetScript( "OnEvent", onSysInfoEvent );
frame:RegisterEvent( "ADDON_LOADED" );
frame:RegisterEvent( "PLAYER_LOGOUT" );

-------------------------------------------------------------------------------

local startTime  = 0;
local recordData = false;
local v1, v2, latency;
local r, g, text;

local function onSysInfoUpdate( who, elapsed )
	
--	nUI_ProfileStart( ProfileCounter, "onSysInfoUpdate" );
	
	timer     = timer + elapsed;
	
	if startTime > 30 then recordData = true; 
	else startTime = startTime + elapsed;	
	end
	
	if timer >= 1 then
		
	local bandwidthIn, bandwidthOut, latencyHome, latencyWorld = GetNetStats();
	string = format(MAINMENUBAR_LATENCY_LABEL, latencyHome, latencyWorld);
		
		v1, v2, latencyHome, latencyWorld = GetNetStats();	
		
		nUI.latency      = latencyHome;
		nUI.worldLatency = latencyWorld;
		timer            = 0;
		
		if frame.enabled then
				
			if frame.hover then
				SysInfo_Tooltip( frame.hover );
			end
			
			-- update latency
				
			if frame.latency.active then
				
				r, g  = colorSelect( nUI.latency, 600, false );
				text  = ("%0.0f%s"):format( nUI.latency, nUI_L["MS"] );
				
				if frame.latency.r ~= r
				or frame.latency.g ~= g
				then
					
					frame.latency.r = r;
					frame.latency.g = g;
					
					frame.latency.texture:SetVertexColor( r, g, 0, 1 );
					
				end
				
				if frame.latency.text.enabled
				and frame.latency.text.value ~= text then
	
					frame.latency.text.value = text;
					frame.latency.text:SetText( text );
					
				end			
			end
			
			-- update frame rate
			
			if frame.fps.active then
				
				nUI.framerate  = GetFramerate();
				r, g     = colorSelect( nUI.framerate, 40, true );
				text     = ("%0.0f%s"):format( nUI.framerate, nUI_L["FPS"] )
		
				if frame.fps.r ~= r
				or frame.fps.g ~= g
				then
					
					frame.fps.texture:SetVertexColor( r, g, 0, 1 );
					
				end
				
				if frame.fps.text.enabled
				and frame.fps.text.value ~= text then
					
					frame.fps.text.value = text;
					frame.fps.text:SetText( text );
					
				end			
			end		
		end
	end
	
--	nUI_ProfileStop();
	
end

frame:SetScript( "OnUpdate", onSysInfoUpdate );

-------------------------------------------------------------------------------

frame.applySkin = function( skin )

--	nUI_ProfileStart( ProfileCounter, "applySkin" );
	
	local skin = skin and skin.AddOns["nUI_SysInfo"] or nUI_CurrentSkin.AddOns["SysInfo"];
	frame.skin = skin;
	
	if not skin or not skin.enabled then
		
		frame:Hide();
		frame.enabled        = false;
		frame.latency.active = false;
		frame.fps.active     = false;
		
	else
		
		frame:Show();
		frame.enabled = true;
		
		frame.latency.applyOptions( skin.Latency and skin.Latency.options or nil );
		frame.latency.applyAnchor( skin.Latency and skin.Latency.anchor or nil );
	
		frame.fps.applyOptions( skin.FrameRate and skin.FrameRate.options or nil );
		frame.fps.applyAnchor( skin.FrameRate and skin.FrameRate.anchor or nil );
		
	end
	
--	nUI_ProfileStop();
	
end

-------------------------------------------------------------------------------
-- network latency indicator

frame.latency_background = CreateFrame( "Frame", "nUI_SysInfo_Latency", nUI_TopBars.Anchor );
frame.latency            = CreateFrame( "Button", "$parentBar", frame.latency_background );
frame.latency.texture    = frame.latency:CreateTexture( "$parentTexture", "ARTWORK" );
frame.latency.text       = frame.latency:CreateFontString( "$parentLabel", "OVERLAY" );
frame.latency.enabled    = true;

frame.latency.texture:SetTexture( "Interface\\AddOns\\nUI\\Layouts\\Default\\Art\\nUI_SysInfoBar" );
frame.latency.texture:SetTexCoord( 0, 0, 0, 1, 1, 0, 1, 1 );
frame.latency.texture:SetAllPoints( frame.latency );
frame.latency_background:SetAllPoints( frame.latency );

frame.latency:SetScript( "OnEnter", 
	function()
	
--		nUI_ProfileStart( LatencyProfileCounter, "OnEnter" );
	
		frame.hover = frame.latency;
		SysInfo_Tooltip( frame.latency );
		
--		nUI_ProfileStop();
		
	end
);

frame.latency:SetScript( "OnLeave",
	function()
		
--		nUI_ProfileStart( LatencyProfileCounter, "OnLeave" );
	
		frame.hover = nil;
		GameTooltip:Hide();
		
--		nUI_ProfileStop();
		
	end
);

-------------------------------------------------------------------------------

frame.latency.applyScale = function( scale )

--	nUI_ProfileStart( LatencyProfileCounter, "applyScale" );
	
	local latency  = frame.latency;
	local options  = latency.options;
	
	if options then
			
		local anchor   = scale and latency.anchor or nil;
		local scale    = scale or latency.scale or 1;
		local width    = options.width * scale * nUI.hScale;
		local height   = options.height * scale * nUI.vScale;
		local fontsize = options.label.fontsize * scale * nUI.vScale;
		
		latency.scale = scale;
		
		if latency.width    ~= width
		or latency.height   ~= height
		then
			
			latency.width    = width;
			latency.height   = height;
			latency.fontsize = fontsize;
			
			latency:SetWidth( width );
			latency:SetHeight( height )
	
		end
		
		if latency.text.fontsize ~= fontsize then
			
			latency.text.fontsize = fontsize;
			latency.text:SetFont( nUI_L["font1"], fontsize * 1.75, "OUTLINE" );
			
		end

		if anchor then latency.applyAnchor( anchor ); end
		
	end
	
--	nUI_ProfileStop();
	
end

-------------------------------------------------------------------------------

frame.latency.applyAnchor = function( anchor )
	
--	nUI_ProfileStart( LatencyProfileCounter, "applyAnchor" );
	
	local latency     = frame.latency;
	local options     = latency.options;
	local anchor      = anchor or latency.anchor or {};
	local anchor_pt   = anchor.anchor_pt or "CENTER";
	local relative_to = anchor.relative_to or "nUI_TopBars";
	local relative_pt = anchor.relative_pt or anchor_pt;
	local xOfs        = (anchor.xOfs or 0) * nUI.hScale;
	local yOfs        = (anchor.yOfs or 0) * nUI.vScale;

	if latency.anchor_pt ~= anchor_pt
	or latency.relative_to ~= relative_to
	or latency.relative_pt ~= relative_pt
	or latency.xOfs        ~= xOfs
	or latency.yOfs        ~= yOfs
	then
		
		latency.anchor_pt   = anchor_pt;
		latency.relative_to = relative_to;
		latency.relative_pt = relative_pt;
		latency.xOfs        = xOfs;
		latency.yOfs        = yOfs;
		
		latency:ClearAllPoints();
		latency:SetPoint( anchor_pt, relative_to, relative_pt, xOfs, yOfs );
		
	end
	
	if options then
			
		local text  = latency.text;
		local label = latency.options.label;		
		local scale = latency.scale;
		anchor_pt   = label.anchor_pt or "CENTER";
		relative_to = label.relative_to or latency:GetName();
		relative_pt = label.relative_pt or anchor_pt;
		xOfs        = (label.xOfs or 0) * scale * nUI.hScale;
		yOfs        = (label.yOfs or 0) * scale * nUI.vScale;
	
		if text.anchor_pt   ~= anchor_pt
		or text.relative_to ~= relative_to
		or text.relative_pt ~= relative_pt
		or text.xOfs        ~= xOfs
		or text.yOfs        ~= yOfs
		then
			
			text.anchor_pt   = anchor_pt;
			text.relative_to = relative_to;
			text.relative_pt = relative_pt;
			text.xOfs        = xOfs;
			text.yOfs        = yOfs;
			
			text:ClearAllPoints();
			text:SetPoint( anchor_pt, relative_to, relative_pt, xOfs, yOfs );
			
		end
	end
	
--	nUI_ProfileStop();
	
end

-------------------------------------------------------------------------------

frame.latency.applyOptions = function( options )

--	nUI_ProfileStart( LatencyProfileCounter, "applyOptions" );
	
	local latency   = frame.latency;
	latency.options = options;
	
	if not options or not options.enabled then
		
		latency.active = false;
		
		if latency.enabled then
			latency.enabled = false;
			frame.latency_background:Hide();
		end
		
	else
		
		if not latency.enabled then
			latency.enabled = true;
			frame.latency_background:Show();
		end
		
		frame.latency_background:SetFrameStrata( options.strata or nUI_TopBars:GetFrameStrata() );
		frame.latency_background:SetFrameLevel( options.level or nUI_TopBars:GetFrameLevel()+1 );
		
		if not options.label or not options.label.enabled then
			
			if latency.text.enabled then 				
				latency.text.enabled = false;
				latency.text:Hide();
			end
		
		else
			
			if not latency.text.enabled then
				latency.text.enabled = true;
				latency.text:Show();
			end
										
			local color = options.label.color or {};
				
			latency.text:SetTextColor( color.r, color.g, color.b, color.a );
			latency.text:SetJustifyH( options.label.justifyH or "CENTER" );
			latency.text:SetJustifyV( options.label.justifyV or "MIDDLE" );

		end

		if options.border then
			
			local border_color   = options.border.color.border or {};
			local backdrop_color = options.border.color.backdrop or {};
			
			latency:SetBackdrop( options.border.backdrop );
			latency:SetBackdropColor( backdrop_color.r or 1, backdrop_color.g or 1, backdrop_color.b or 1, backdrop_color.a or 1 );
			latency:SetBackdropBorderColor( border_color.r or 1, border_color.g or 1, border_color.b or 1, border_color.a or 1 );
			
		else
			
			latency:SetBackdrop( nil );
			
		end

		if options.background then
			
			local border_color   = options.background.color.border or {};
			local backdrop_color = options.background.color.backdrop or {};
			
			frame.latency_background:SetBackdrop( options.background.backdrop );
			frame.latency_background:SetBackdropColor( backdrop_color.r or 1, backdrop_color.g or 1, backdrop_color.b or 1, backdrop_color.a or 1 );
			frame.latency_background:SetBackdropBorderColor( border_color.r or 1, border_color.g or 1, border_color.b or 1, border_color.a or 1 );
			
		else
			
			frame.latency_background:SetBackdrop( nil );
			
		end
		
		latency.applyScale( options.scale or latency.scale or 1 );

		latency.active = true;
	end		
	
--	nUI_ProfileStop();
	
end

-------------------------------------------------------------------------------
-- framerate indicator

frame.fps_background = CreateFrame( "Frame", "nUI_SysInfo_FrameRate", nUI_TopBars.Anchor );
frame.fps            = CreateFrame( "Button", "$parentBar", frame.fps_background );
frame.fps.texture    = frame.fps:CreateTexture( "$parentTexture", "ARTWORK" );
frame.fps.text       = frame.fps:CreateFontString( "$parentLabel", "OVERLAY" );
frame.fps.enabled    = true;

frame.fps.texture:SetTexture( "Interface\\AddOns\\nUI\\Layouts\\Default\\Art\\nUI_SysInfoBar" );
frame.fps.texture:SetTexCoord( 0, 0, 0, 1, 1, 0, 1, 1 );
frame.fps.texture:SetAllPoints( frame.fps );
frame.fps_background:SetAllPoints( frame.fps );

frame.fps:SetScript( "OnEnter", 
	function()

--		nUI_ProfileStart( FramerateProfileCounter, "OnEnter" );
	
		frame.hover = frame.fps;
		SysInfo_Tooltip( frame.fps );
		
--		nUI_ProfileStop();
		
	end
);

frame.fps:SetScript( "OnLeave",
	function()

--		nUI_ProfileStart( FramerateProfileCounter, "OnLeave" );
	
		frame.hover = nil;
		GameTooltip:Hide();
		
--		nUI_ProfileStop();
		
	end
);

-------------------------------------------------------------------------------

frame.fps.applyScale = function( scale )

--	nUI_ProfileStart( FramerateProfileCounter, "applyScale" );

	local fps     = frame.fps;
	local options = fps.options;
	
	if options then
			
		local anchor   = scale and fps.anchor or nil;
		local scale    = scale or fps.scale or 1;
		local width    = options.width * scale * nUI.hScale;
		local height   = options.height * scale * nUI.vScale;
		local fontsize = options.label.fontsize * scale * nUI.vScale;
		
		fps.scale = scale;
		
		if fps.width    ~= width
		or fps.height   ~= height
		then
			
			fps.width    = width;
			fps.height   = height;
			fps.fontsize = fontsize;
			
			fps:SetWidth( width );
			fps:SetHeight( height )
	
		end
		
		if fps.text.fontsize ~= fontsize then
			
			fps.text.fontsize = fontsize;
			fps.text:SetFont( nUI_L["font1"], fontsize * 1.75, "OUTLINE" );
			
		end

		if anchor then fps.applyAnchor( anchor ); end
		
	end
	
--	nUI_ProfileStop();
	
end

-------------------------------------------------------------------------------

frame.fps.applyAnchor = function( anchor )
	
--	nUI_ProfileStart( FramerateProfileCounter, "applyAnchor" );

	local fps         = frame.fps;
	local options     = fps.options;
	local anchor      = anchor or fps.anchor or {};
	local anchor_pt   = anchor.anchor_pt or "CENTER";
	local relative_to = anchor.relative_to or "nUI_TopBars";
	local relative_pt = anchor.relative_pt or anchor_pt;
	local xOfs        = (anchor.xOfs or 0) * nUI.hScale;
	local yOfs        = (anchor.yOfs or 0) * nUI.vScale;

	if fps.anchor_pt   ~= anchor_pt
	or fps.relative_to ~= relative_to
	or fps.relative_pt ~= relative_pt
	or fps.xOfs        ~= xOfs
	or fps.yOfs        ~= yOfs
	then
		
		fps.anchor_pt   = anchor_pt;
		fps.relative_to = relative_to;
		fps.relative_pt = relative_pt;
		fps.xOfs        = xOfs;
		fps.yOfs        = yOfs;
		
		fps:ClearAllPoints();
		fps:SetPoint( anchor_pt, relative_to, relative_pt, xOfs, yOfs );
		
	end

	if options then
			
		local text  = fps.text;
		local label = fps.options.label;		
		local scale = fps.scale;
		anchor_pt   = label.anchor_pt or "CENTER";
		relative_to = label.relative_to or fps:GetName();
		relative_pt = label.relative_pt or anchor_pt;
		xOfs        = (label.xOfs or 0) * scale * nUI.hScale;
		yOfs        = (label.yOfs or 0) * scale * nUI.vScale;
	
		if text.anchor_pt   ~= anchor_pt
		or text.relative_to ~= relative_to
		or text.relative_pt ~= relative_pt
		or text.xOfs        ~= xOfs
		or text.yOfs        ~= yOfs
		then
			
			text.anchor_pt   = anchor_pt;
			text.relative_to = relative_to;
			text.relative_pt = relative_pt;
			text.xOfs        = xOfs;
			text.yOfs        = yOfs;
			
			text:ClearAllPoints();
			text:SetPoint( anchor_pt, relative_to, relative_pt, xOfs, yOfs );
			
		end
	end
	
--	nUI_ProfileStop();
	
end

-------------------------------------------------------------------------------

frame.fps.applyOptions = function( options )

--	nUI_ProfileStart( FramerateProfileCounter, "applyOptions" );

	local fps   = frame.fps;
	fps.options = options;
	
	if not options or not options.enabled then

		ftp.active = false;
		
		if fps.enabled then
			fps.enabled = false;
			frame.fps_background:Hide();
		end
		
	else
		
		if not fps.enabled then
			fps.enabled = true;
			frame.fps_background:Show();
		end
		
		frame.fps_background:SetFrameStrata( options.strata or nUI_TopBars:GetFrameStrata() );
		frame.fps_background:SetFrameLevel( options.level or nUI_TopBars:GetFrameLevel()+1 );
		
		if not options.label or not options.label.enabled then
			
			if fps.text.enabled then 				
				fps.text.enabled = false;
				fps.text:Hide();
			end
		
		else
			
			if not fps.text.enabled then
				fps.text.enabled = true;
				fps.text:Show();
			end
										
			local color = options.label.color or {};
				
			fps.text:SetTextColor( color.r, color.g, color.b, color.a );
			fps.text:SetJustifyH( options.label.justifyH or "CENTER" );
			fps.text:SetJustifyV( options.label.justifyV or "MIDDLE" );

		end

		if options.border then
			
			local border_color   = options.border.color.border or {};
			local backdrop_color = options.border.color.backdrop or {};
			
			fps:SetBackdrop( options.border.backdrop );
			fps:SetBackdropColor( backdrop_color.r or 1, backdrop_color.g or 1, backdrop_color.b or 1, backdrop_color.a or 1 );
			fps:SetBackdropBorderColor( border_color.r or 1, border_color.g or 1, border_color.b or 1, border_color.a or 1 );
			
		else
			
			fps:SetBackdrop( nil );
			
		end

		if options.background then
			
			local border_color   = options.background.color.border or {};
			local backdrop_color = options.background.color.backdrop or {};
			
			frame.fps_background:SetBackdrop( options.background.backdrop );
			frame.fps_background:SetBackdropColor( backdrop_color.r or 1, backdrop_color.g or 1, backdrop_color.b or 1, backdrop_color.a or 1 );
			frame.fps_background:SetBackdropBorderColor( border_color.r or 1, border_color.g or 1, border_color.b or 1, border_color.a or 1 );
			
		else
		
			frame.fps_background:SetBackdrop( nil );
			
		end
		
		fps.applyScale( options.scale or fps.scale or 1 );
		
		fps.active = true;
		
	end		
	
--	nUI_ProfileStop();
	
end
