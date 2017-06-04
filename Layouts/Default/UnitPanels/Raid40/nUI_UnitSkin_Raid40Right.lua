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

if not nUI_UnitSkins then nUI_UnitSkins = {}; end

nUI_UnitSkins[nUI_UNITSKIN_RAID40RIGHT] =
{
	height   = 225,
	width    = 460,
	desc     = nUI_L[nUI_UNITSKIN_RAID40RIGHT],
	
	elements =
	{
		["Label"] =
		{
			anchor =
			{
				anchor_pt   = "TOP",
				relative_to = "$parent_Feedback",
				xOfs        = 0,
				yOfs        = 0,
			},		
			options =
			{
				enabled = true,
				height  = 30,
				width   = 92,
				inset   = 7,
				strata  = nil,
				level   = nil,

				text          = nil,
				show_reaction = false,
				class_colors  = true,
				
				label =
				{
					enabled     = true,
					fontsize    = 11,
					justifyH    = "LEFT",
					justifyV    = "MIDDLE",
					anchor_pt   = "LEFT",
					xOfs        = 0,
					yOfs        = 0,					
					color       = { r = 1, g = 0.83, b = 0, a = 1 },
				},
			},
		},
		["Health"] =
		{
			anchor =
			{
				anchor_pt   = "BOTTOM",
				relative_to = "$parent_Power",
				relative_pt = "TOP",
				xOfs = 0,
				yOfs = 1,
			},		
			options =
			{
				enabled  = true,
				height   = 19,
				width    = 82,
				inset    = 0,
				strata   = nil,
				level    = 3,
				
				bar = 
				{
					enabled  = true;
					orient   = "LEFT",
					overlay  = "Interface\\AddOns\\nUI\\Layouts\\Default\\Art\\nUI_BarOverlay1",
				},
				
				cur_health =
				{
					enabled     = true,
					fontsize    = 10,
					justifyH    = "RIGHT",
					justifyV    = "MIDDLE",
					anchor_pt   = "RIGHT",
					xOfs        = -0.5,
					yOfs        = 1.5,
					color       = { r = 1, g = 1, b = 1, a = 1 },
				},
			},
		},
		["Power"] =
		{
			anchor =
			{
				anchor_pt   = "BOTTOMLEFT",
				relative_to = "$parent_Feedback",
				relative_pt = "BOTTOMLEFT",
				xOfs = 5,
				yOfs = 2,
			},		
			options =
			{
				enabled  = true,
				height   = 6.5,
				width    = 82,
				inset    = 0,
				strata   = nil,
				level    = 3,
				
				bar = 
				{
					enabled  = true;
					orient   = "LEFT",
					overlay  = "Interface\\AddOns\\nUI\\Layouts\\Default\\Art\\nUI_BarOverlay2",
				},				
			},
		},	
		["RaidTarget"] =
		{
			anchor =
			{
				anchor_pt   = "CENTER",
				relative_to = "$parent_Label",
				relative_pt = "CENTER",
				xOfs = 0,
				yOfs = 0,
			},		
			options =
			{
				enabled = true,
				size    = 25,
				inset   = 0,
				strata  = nil,
				level   = 3,
			},
		},
		["RaidGroup"] =
		{
			anchor =
			{
				anchor_pt   = "TOPRIGHT",
				relative_to = "$parent_Label",
				xOfs = 0,
				yOfs = 0,
			},		
			options =
			{
				enabled = true,
				size    = 30,
				inset   = 0,
				strata  = nil,
				level   = 2,
				
				label =
				{
					enabled     = true,
					fontsize    = 11,
					justifyH    = "CENTER",
					justifyV    = "MIDDLE",
					anchor_pt   = "CENTER",
					xOfs        = 0,
					yOfs        = 2,
					color       = { r = 0, g = 1, b = 1, a = 1 },
				},
			
				border =
				{
					backdrop =
					{
						bgFile   = "Interface\\Tooltips\\UI-Tooltip-Background", 
						edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border", 
						tile     = true, 
						tileSize = 1, 
						edgeSize = 8, 
						insets   = { left = 0, right = 0, top = 0, bottom = 0 },
					},					
					color =
					{
						border   = { r = 1, g = 1, b = 1, a = 0.5 },
						backdrop = { r = 0, g = 0, b = 0, a = 1 },
					},
				},
			},
		},
		["Feedback"] =
		{
			anchor =
			{
				anchor_pt   = "TOPRIGHT",
				relative_to = "$parent",
				relative_pt = "TOPRIGHT",
				xOfs        = 0,
				yOfs        = 0,
			},		
			options =
			{
				enabled   = true,
				height    = 56.25,
				width     = 92,
				inset     = 0,
				strata    = nil,
				level     = nil,
				clickable = true,
						
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
						backdrop = { r = 0, g = 0, b = 0, a = 0.35 },
					},
				},
			},
		},
		["ReadyCheck"] =
		{
			anchor =
			{
				anchor_pt   = "RIGHT",
				relative_to = "$parent_Feedback",
				xOfs        = 0,
				yOfs        = 0,
			},		
			options =
			{
				enabled = true,
				size    = 50,
				strata  = nil,
				level   = 9,
			},
		},
		["Status"] =
		{
			anchor =
			{
				anchor_pt   = "BOTTOM",
				relative_to = "$parent_Feedback",
				xOfs        = 0,
				yOfs        = 1,
			},		
			options =
			{
				enabled = true,
				height  = 30,
				width   = 82,
				strata  = nil,
				level   = 6,
				
				fade_unit = 0.6,
				
				label =
				{
					enabled   = true,
					fontsize  = 14,
					justifyH  = "CENTER",
					justifyV  = "MIDDLE",
					anchor_pt = "CENTER",
					xOfs      = 0,
					yOfs      = 0,
					
					color = { r = 1, g = 0.8, b = 0.8, a = 1 },
				},
			
				border =
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
						border   = { r = 1, g = 1, b = 1, a = 0.5 },
						backdrop = { r = 0, g = 0, b = 0, a = 1 },
					},
				},
			},
		},
		["Aura"] =
		{
			[1] =	-- debuffs
			{
				anchor =
				{
					anchor_pt   = "BOTTOMRIGHT",
					relative_to = "$parent_Power",
					relative_pt = "RIGHT",
					xOfs        = 0,
					yOfs        = 0,
				},		
				options =
				{
					enabled = true,
					size    = 21,
					strata  = nil,
					level   = 4,
					
					aura_type        = "harm",
					origin           = "BOTTOMRIGHT",
					player_auras     = false,
					dispellable      = true,
					horizontal       = true,
					highlight_player = false,
					aura_types       = false,
					cooldown_anim    = false,
					flash_expire     = true,
					timed_auras      = true,
					clickable        = false,
					rows             = 1,
					cols             = 5,
					expire_time      = 10,
					hGap             = 0,
					vGap             = 0,

					count =
					{
						enabled     = true,
						fontsize    = 9,
						justifyH    = "CENTER",
						justifyV    = "MIDDLE",
						anchor_pt   = "CENTER",
						relative_pt = "CENTER",
						xOfs        = 0,
						yOfs        = 0.5,
					},
				},		
			},
		},		
		["Role"] =
		{
			anchor =
			{
				anchor_pt   = "CENTER",
				relative_to = "$parent_Feedback",
				relative_pt = "RIGHT",
				xOfs        = 0,
				yOfs        = 0,
			},		
			options =
			{
				enabled = true,
				size    = 25,
				strata  = nil,
				level   = 3,

				icon_size = 25,
				orient    = "TOP",				
			},
		},
	},
};
