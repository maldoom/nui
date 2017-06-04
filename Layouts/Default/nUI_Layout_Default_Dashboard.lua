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
if not nUI_DefaultConfig.AddOns then nUI_DefaultConfig.AddOns = {}; end
if not nUI_DefaultConfig.Misc then nUI_DefaultConfig.Misc = {}; end

-------------------------------------------------------------------------------
-- default configuration for the chat frames

nUI_DefaultConfig.ChatFrame =
{	
	anchor =
	{
		anchor_pt   = "BOTTOMRIGHT",
		relative_to = "nUI_Dashboard",
		relative_pt = "CENTER",
		xOfs        = -685,
		yOfs        = -174,
	},
	
	options = 
	{
		strata   = "BACKGROUND",
		level    = 3,
		scale    = 1,
		height   = 290,
		width    = 585,
		fontsize = 11,
		btn_size = 45,
		btn_gap  = -8,

		background =
		{
			backdrop =
			{
				bgFile   = "Interface\\AddOns\\nUI\\Layouts\\Default\\Art\\nUI_BevelboxBg.blp", 
				edgeFile = "Interface\\AddOns\\nUI\\Layouts\\Default\\Art\\nUI_BevelboxBorder.blp", 
				tile     = true, 
				tileSize = 1, 
				edgeSize = 12, 
				insets   = { left = 0, right = 0, top = 0, bottom = 0 },
			},
			
			color =
			{
				border = { r = 1, g = 1, b = 1, a = 1 },
				backdrop = { r = 0, g = 0, b = 0, a = 0.85 },
			},
		},
	},	
};

-------------------------------------------------------------------------------
-- the information panel selector button

nUI_DefaultConfig.InfoPanelSelector =
{
	anchor =
	{
		anchor_pt   = "TOPRIGHT",
		relative_to = "nUI_BottomRightBar",
		relative_pt = "TOPLEFT",
		xOfs        = -10,
		yOfs        = 0,
	},
	options =
	{
		enabled = true,
		height  = 40,
		width   = 93,
		strata  = nil,
		level   = nil,
			
		label =
		{
			enabled = true,
			fontsize = 12,
			anchor_pt = "CENTER",
		},
		
		background =
		{
			backdrop =
			{
				bgFile   = "Interface\\Tooltips\\UI-Tooltip-Background", 
				edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border", 
				tile     = true, 
				tileSize = 1, 
				edgeSize = 5, 
				insets   = { left = 0, right = 0, top = 0, bottom = 0 },
			},
			
			color =
			{
				border = { r = 1, g = 1, b = 1, a = 1 },
				backdrop = { r = 0.75, g = 0, b = 0, a = 0.75 },
			},
		},		
	},
};

-------------------------------------------------------------------------------
-- default configuration for the actual information frame backdrop

nUI_DefaultConfig.InfoPanel =
{	
	anchor =
	{
		anchor_pt   = "BOTTOMLEFT",
		relative_to = "nUI_Dashboard",
		relative_pt = "CENTER",
		xOfs        = 685,
		yOfs        = -174,
	},	
	
	options = 
	{
		enabled  = true;
		strata   = "BACKGROUND",
		level    = 3,
		scale    = 1,
		height   = 290,
		width    = 585,
		inset    = 6,

		background =
		{
			backdrop =
			{
				bgFile   = "Interface\\AddOns\\nUI\\Layouts\\Default\\Art\\nUI_BevelboxBg", 
				edgeFile = "Interface\\AddOns\\nUI\\Layouts\\Default\\Art\\nUI_BevelboxBorder", 
				tile     = true, 
				tileSize = 1, 
				edgeSize = 12, 
				insets   = { left = 0, right = 0, top = 0, bottom = 0 },
			},
			
			color =
			{
				border = { r = 1, g = 1, b = 1, a = 1 },
				backdrop = { r = 0, g = 0, b = 0, a = 0.85 },
			},
		},
	},	
};

-------------------------------------------------------------------------------

nUI_DefaultConfig.UnitPanelSelector =
{
	anchor =
	{
		anchor_pt   = "TOPLEFT",
		relative_to = "nUI_BottomLeftBar",
		relative_pt = "TOPRIGHT",
		xOfs        = 7,
		yOfs        = 0,
	},
	options =
	{
		enabled = true,
		height  = 40,
		width   = 93,
		strata  = nil,
		level   = nil,
			
		label =
		{
			enabled = true,
			fontsize = 12,
			anchor_pt = "CENTER",
		},
		
		background =
		{
			backdrop =
			{
				bgFile   = "Interface\\Tooltips\\UI-Tooltip-Background", 
				edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border", 
				tile     = true, 
				tileSize = 1, 
				edgeSize = 5, 
				insets   = { left = 0, right = 0, top = 0, bottom = 0 },
			},
			
			color =
			{
				border = { r = 1, g = 1, b = 1, a = 1 },
				backdrop = { r = 0.75, g = 0, b = 0, a = 0.75 },
			},
		},		
	},
};

-------------------------------------------------------------------------------
-- minimap location

nUI_DefaultConfig.Minimap =
{
	enabled = true,
	
	anchor = 
	{
		anchor_pt   = "CENTER",
		relative_to = nUI_Dashboard,
		relative_pt = "CENTER",
		xOfs        = 3,
		yOfs        = -60,
	},
	
	options =
	{
		enabled     = true;
		height      = 235;
		width       = 235;
		strata      = nil,
		level       = 2,
		round_mask  = "Interface\\AddOns\\nUI\\Layouts\\Default\\Art\\nUI_RoundMinimapMask",
		square_mask = "Interface\\AddOns\\nUI\\Layouts\\Default\\Art\\nUI_SquareMinimapMask",
	},
};

-------------------------------------------------------------------------------

nUI_DefaultConfig.Location =
{
	enabled = true;
	
	anchor = 
	{
		anchor_pt   = "BOTTOM",
		relative_to = "nUI_Dashboard",
		relative_pt = "BOTTOM",
		xOfs        = 0,
		yOfs        = 8,
	},
	options =
	{
		enabled  = true,
		strata   = nil,
		level    = 2,
		height   = 70,
		width    = 286,
		fontsize = 12,
		color    = { r = 1, g = 0.83, b = 0 },
						
		border =
		{
			backdrop =
			{
				bgFile   = "Interface\\Tooltips\\UI-Tooltip-Background", 
				edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border", 
				tile     = true, 
				tileSize = 1, 
				edgeSize = 6, 
				insets   = { left = 0, right = 0, top = 0, bottom = 0 },
			},					
			color =
			{
				border   = { r = 1, g = 1, b = 1, a = 1 },
				backdrop = { r = 0, g = 0, b = 0, a = 0.75 },
			},
		},
	},
};

-------------------------------------------------------------------------------
-- basic bagbar layout

nUI_DefaultConfig.BagBar =
{
	btn_size = 50,
	gap      = 2,
	anchor   = "BOTTOMRIGHT",
	xOfs     = 1260,
	yOfs     = 150,
};

-------------------------------------------------------------------------------
-- default button bar configurations

nUI_DefaultConfig.ButtonBars =
{
	["nUI_ActionBar"] =
	{
		btn_size = 53.5,
		gap      = 2,
		anchor   = "BOTTOM",
		xOfs     = 0,
		yOfs     = 123,
		rows     = 1,
		cols     = 12,
		page     = 1,
		nuibind  = "nUI_ACTIONBAR",
		binding  = "ACTIONBUTTON",
		label    = nUI_L["nUI_ActionBar"],
	},

	-- the Bliz "bottom left" bar

	["nUI_TopLeftBar"] =
	{		
		btn_size = 53.5,
		gap      = 2,
		anchor   = "TOPRIGHT",
		yOfs     = 122,
		xOfs     = 0,
		rows     = 1,
		cols     = 12,
		page     = 6,
		nuibind  = "nUI_TOPLEFTBAR",
		binding  = "MULTIACTIONBAR1BUTTON",
		label    = nUI_L["nUI_TopLeftBar"],
	},
	
	-- the Bliz "bottom right" bar

	["nUI_TopRightBar"] =
	{		
		btn_size = 53.5,
		gap      = 2,
		anchor   = "TOPLEFT",
		yOfs     = 122,
		xOfs     = 0,
		rows     = 1,
		cols     = 12,
		page     = 5,
		nuibind  = "nUI_TOPRIGHTBAR",
		binding  = "MULTIACTIONBAR2BUTTON",
		label    = nUI_L["nUI_TopRightBar"],
	},
	
	-- the Bliz "right 1" bar (aka "left" bar in the Bliz code)

	["nUI_LeftUnitBar"] =
	{		
		btn_size = 48,
		gap      = 2,
		anchor   = "BOTTOMLEFT",		
		yOfs     = -250,
		xOfs     = -680,
		rows     = 6,
		cols     = 2,
		page     = 3,
		nuibind  = "nUI_LEFTUNITBAR",
		binding  = "MULTIACTIONBAR3BUTTON",
		label    = nUI_L["nUI_LeftUnitBar"],
	},
		
	-- the Bliz "right 2" bar (aka "right" bar in the Bliz code)
	
	["nUI_RightUnitBar"] =
	{		
		btn_size = 48,
		gap      = 2,
		anchor   = "BOTTOMRIGHT",
		yOfs     = -250,
		xOfs     = 680,
		rows     = 6,
		cols     = 2,
		page     = 4,
		nuibind  = "nUI_RIGHTUNITBAR",
		binding  = "MULTIACTIONBAR4BUTTON",
		label    = nUI_L["nUI_RightUnitBar"],
	},

	-- bonus bar 1

	["nUI_BottomLeftBar"] =
	{		
		btn_size = 38,
		gap      = 2,
		anchor   = "BOTTOMLEFT",
		yOfs     = -223,
		xOfs     = -1270,
		rows     = 1,
		cols     = 12,
		page     = 2,
		nuibind  = "nUI_BOTTOMLEFTBAR",
		binding  = nil,
		label    = nUI_L["nUI_BottomLeftBar"],
	},
		
	-- bonus bar 2
	
	["nUI_BottomRightBar"] =
	{		
		btn_size = 38,
		gap      = 2,
		anchor   = "BOTTOMRIGHT",
		yOfs     = -223,
		xOfs     = 1270,
		rows     = 1,
		cols     = 12,
		base_id  = 108,
		nuibind  = "nUI_BOTTOMRIGHTBAR",
		binding  = nil,
		label    = nUI_L["nUI_BottomRightBar"],
	},	
};
	
-------------------------------------------------------------------------------
-- pet bar, stance bar, shapeshift bar, aura bar, possession bar

nUI_DefaultConfig.SpecialBars =
{
	enabled = true;
	
	anchor =
	{
		anchor_pt   = "BOTTOM",
		relative_to = "nUI_Dashboard",
		relative_pt = "CENTER",
		xOfs        = 0,
		yOfs        = 183,
	},
	options =
	{
		enabled   = true,
		strata    = nil,
		level     = 2,
		btn_size  = 36,
		block_gap = 10,
		btn_gap   = 1,
		inset     = 3,
--[[		
		border =
		{
			backdrop =
			{
				bgFile   = "Interface\\AddOns\\nUI\\Layouts\\Default\\Art\\nUI_BevelboxBg.blp", 
				edgeFile = "Interface\\AddOns\\nUI\\Layouts\\Default\\Art\\nUI_BevelboxBorder.blp", 
				tile     = true, 
				tileSize = 1, 
				edgeSize = 12, 
				insets   = {left = 0, right = 0, top = 0, bottom = 0},
			},
			border_color = { r = 1, g = 1, b = 1, a = 1 },
			backdrop_color = { r = 0, g = 0, b = 0, a = 0.35 },
		}
]]--		
	},
};

-------------------------------------------------------------------------------
-- experience bar

nUI_DefaultConfig.XPBar =
{
	enabled = true;
	
	anchor =
	{
		anchor_pt   = "TOPLEFT",
		relative_to = "nUI_BottomLeftBar",
		relative_pt = "BOTTOMLEFT",
		xOfs        = 0,
		yOfs        = -7,
	},
	
	options =
	{
		enabled  = true;
		strata   = nil,
		level    = 3,
		height   = 15,
		width    = 585,
		inset    = 0,
--[[		
		label =
		{
			enabled     = true;
			font_size   = 12,
			anchor_pt   = "CENTER",
			relative_to = "$parent",
			relative_pt = "CENTER",
			xOfs        = 0,
			yOfs        = 0,
			color =
			{
				normal = { r=1, g=1, b=0 },
				rested = { r=1, g=0.83, b=1 },
			},
		},
]]--		
		bar =
		{
			enabled     = true,
			orient      = "LEFT",
			tick_height = 35,
			tick_width  = 40,
			overlay     = "Interface\\AddOns\\nUI\\Layouts\\Default\\Art\\nUI_XPRepOverlay",
			rested_tick = "Interface\\AddOns\\nUI\\Layouts\\Default\\Art\\nUI_XPRestedTick",
			
			colors =
			{
				rested = { r = 0.25, g = 1, b = 0.25 },
				xp     = { r = 0.25, g = 0.5, b = 1 },
			},
		},
	},
};

-------------------------------------------------------------------------------
-- faction/reputation bar

nUI_DefaultConfig.FactionBar =
{
	enabled = true;
	
	anchor =
	{
		anchor_pt   = "TOPRIGHT",
		relative_to = "nUI_BottomRightBar",
		relative_pt = "BOTTOMRIGHT",
		xOfs        = 0,
		yOfs        = -7,
	},
	
	options =
	{
		enabled  = true;
		strata   = nil,
		level    = 3,
		height   = 15,
		width    = 585,
		inset    = 0,
--[[
		label =
		{
			enabled     = true;
			font_size   = 12,
			anchor_pt   = "CENTER",
			relative_to = "$parent",
			relative_pt = "CENTER",
			xOfs        = 0,
			yOfs        = 0,
		},
]]--				
		bar =
		{
			enabled     = true,
			orient      = "LEFT",
			overlay     = "Interface\\AddOns\\nUI\\Layouts\\Default\\Art\\nUI_XPRepOverlay",			
			color       = { r = 0.25, g = 0.5, b = 1 },
		},
	},
};

