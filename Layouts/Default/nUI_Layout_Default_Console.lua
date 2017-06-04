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

nUI_DefaultConfig.AddOns["nUI_SysInfo"] =
{
	enabled = true;	
	
	Latency =
	{
		anchor =
		{
			anchor_pt   = "TOPRIGHT",
			relative_to = "nUI_MicroMenu",
			relative_pt = "TOPLEFT",
			xOfs        = 1,
			yOfs        = 2,
		},
		
		options =
		{
			enabled  = true,
			strata   = nil,
			level    = 4,
			width    = 65,
			height   = 14,
			
			label =
			{
				enabled     = true,
				fontsize    = 10,
				justifyH    = "CENTER",
				justifhV    = "MIDDLE",
				anchor_pt   = "TOPRIGHT",
				relative_pt = "BOTTOMRIGHT",
				xOfs        = 0,
				yOfs        = -2,
				color       = { r = 1, g = 0.83, b = 0, a = 1 },
			},				
		},
	},
	
	FrameRate =
	{
		anchor =
		{
			anchor_pt   = "TOPLEFT",
			relative_to = "nUI_MicroMenu",
			relative_pt = "TOPRIGHT",
			xOfs        = -1,
			yOfs        = 2,
		},
		
		options =
		{
			enabled  = true,
			strata   = nil,
			level    = 4,
			width    = 65,
			height   = 14,
			
			label =
			{
				enabled     = true,
				fontsize    = 10,
				justifyH    = "CENTER",
				justifhV    = "MIDDLE",
				anchor_pt   = "TOPLEFT",
				relative_pt = "BOTTOMLEFT",
				xOfs        = 0,
				yOfs        = -2,
				color       = { r = 1, g = 0.83, b = 0, a = 1 },
			},				
		},
	},
};

-------------------------------------------------------------------------------
-- basic miscro-menu layout

nUI_DefaultConfig.MicroMenu =
{
	anchor =
	{
		anchor_pt   = "BOTTOM",
		relative_to = "nUI_TopBars",
		relative_pt = "BOTTOM",
		xOfs        = 8,
		yOfs        = 26,
	},
	
	options =
	{
		enabled  = "yes",
		strata   = "HIGH",
		level    = 3,
		scale    = 1,
		btn_size = 34,
		btn_gap  = -3,
		
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
				backdrop = { r = 0, g = 0, b = 0, a = 0.35 },
			},
		},
	},
};

-------------------------------------------------------------------------------
-- selector button for the HUD mode

nUI_DefaultConfig.HUDLayoutSelector =
{
	anchor =
	{
		anchor_pt   = "BOTTOM",
		relative_to = "nUI_MicroMenu",
		relative_pt = "TOP",
		xOfs        = 0,
		yOfs        = 12.5,
	},
	options =
	{
		enabled = true,
		height  = 40,
		width   = 130,
		strata  = nil,
		level   = nil,

		label =
		{
			enabled = true,
			fontsize = 12,
			anchor_pt = "CENTER",
		},
	
		alpha =
		{
			idle    = 0,
			regen   = 0.35,
			target  = 0.75,
			combat  = 1,
		};

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

