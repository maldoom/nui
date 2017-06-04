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

nUI_UnitSkins[nUI_UNITSKIN_SOLOTOT] =
{
	height   = 151,
	width    = 420,
	desc     = nUI_L[nUI_UNITSKIN_SOLOTOT],
	
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
				height  = 35,
				width   = 420,
				inset   = 7,
				strata  = nil,
				level   = nil,

				text          = nil,
				show_reaction = true,
				class_colors  = true,
				
				label =
				{
					enabled     = true,
					fontsize    = 11,
					justifyH    = "RIGHT",
					justifyV    = "MIDDLE",
					anchor_pt   = "RIGHT",
					relative_to = "$parent_Level",
					relative_pt = "LEFT",
					xOfs        = 0,
					yOfs        = 0,					
					color       = { r = 1, g = 0.83, b = 0, a = 1 },
				},
			
				border =
				{
					backdrop =
					{
						bgFile   = nil, 
						edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border", 
						tile     = true, 
						tileSize = 1, 
						edgeSize = 5, 
						insets   = { left = 0, right = 0, top = 0, bottom = 0 },
					},					
					color =
					{
						border   = { r = 1, g = 1, b = 1, a = 0.5 },
						backdrop = { r = 0, g = 0, b = 0, a = 0 },
					},
				},
			},
		},
		["Class"] =
		{
			anchor =
			{
				anchor_pt   = "TOPLEFT",
				relative_to = "$parent_Feedback",
				xOfs        = 0,
				yOfs        = 0,
			},		
			options =
			{
				enabled = true,
				size    = 35,
				inset   = 6,
				strata  = nil,
				level   = 2,
			},
		},
		["Level"] =
		{
			anchor =
			{
				anchor_pt   = "TOPRIGHT",
				relative_to = "$parent_Feedback",
				xOfs        = 0,
				yOfs        = 0,
			},		
			options =
			{
				enabled = true,
				size    = 35,
				inset   = 0,
				strata  = nil,
				level   = 2,
				
				label =
				{
					enabled     = true,
					fontsize    = 11,
					justifyH    = "LEFT",
					justifyV    = "MIDDLE",
					anchor_pt   = "LEFT",
					xOfs        = 0,
					yOfs        = 1,					
					color       = { r = 1, g = 0.83, b = 0, a = 1 },
				},
			},
		},
		["Portrait"] =
		{
			anchor =
			{
				anchor_pt   = "BOTTOMRIGHT",
				relative_to = "$parent_Feedback",
				xOfs        = 0,
				yOfs        = 0,
			},		
			options =
			{
				enabled = true,
				height  = 120,
				width   = 120,
				inset   = 30,
				strata  = nil,
				level   = nil,

				show_anim = true,
				model     = false,
				outline   = true,
			},
		},
		["Resting"] =
		{
			anchor =
			{
				anchor_pt   = "TOPLEFT",
				relative_to = "$parent_Portrait",
				xOfs = 0,
				yOfs = -2.5,
			},		
			options =
			{
				enabled = true,
				size    = 35,
				inset   = 0,
				strata  = nil,
				level   = 2,
			},
		},
		["Combat"] =
		{
			anchor =
			{
				anchor_pt   = "TOPLEFT",
				relative_to = "$parent_Portrait",
				xOfs = 0,
				yOfs = -2.5,
			},		
			options =
			{
				enabled = true,
				size    = 35,
				inset   = 0,
				strata  = nil,
				level   = 2,
			},
		},
		["RaidTarget"] =
		{
			anchor =
			{
				anchor_pt   = "TOPRIGHT",
				relative_to = "$parent_Portrait",
				xOfs = 0,
				yOfs = -2.5,
			},		
			options =
			{
				enabled = true,
				size    = 35,
				inset   = 0,
				strata  = nil,
				level   = 2,
			},
		},
		["RaidGroup"] =
		{
			anchor =
			{
				anchor_pt   = "TOP",
				relative_to = "$parent_Portrait",
				xOfs = 0,
				yOfs = -5,
			},		
			options =
			{
				enabled = true,
				size    = 25,
				inset   = 0,
				strata  = nil,
				level   = 2,
				
				label =
				{
					enabled     = true,
					justifyH    = "CENTER",
					justifyV    = "MIDDLE",
					anchor_pt   = "CENTER",
					xOfs        = 0,
					yOfs        = 1.5,
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
						edgeSize = 4, 
						insets   = { left = 0, right = 0, top = 0, bottom = 0 },
					},					
					color =
					{
						border   = { r = 1, g = 1, b = 1, a = 0.75 },
						backdrop = { r = 0, g = 0, b = 0, a = 1 },
					},
				},
			},
		},
		["Spec"] =
		{
			anchor =
			{
				anchor_pt   = "BOTTOM",
				relative_to = "$parent_Portrait",
				xOfs = 0,
				yOfs = 0,
			},		
			options =
			{
				enabled = true,
				width   = 120,
				height  = 30,
				inset   = 0,
				strata  = nil,
				level   = 2,
				
				show_name = true,
				show_type = true,
				
				label =
				{
					enabled     = true,
					fontsize    = 10,
					justifyH    = "CENTER",
					justifyV    = "MIDDLE",
					anchor_pt   = "CENTER",
					xOfs        = 0,
					yOfs        = 5,
					color       = { r = 0, g = 1, b = 1, a = 1 },
				},
			},
		},
		["Health"] =
		{
			anchor =
			{
				anchor_pt   = "TOPRIGHT",
				relative_to = "$parent_Portrait",
				relative_pt = "TOPLEFT",
				xOfs = 0,
				yOfs = -13,
			},		
			options =
			{
				enabled  = true,
				height   = 25,
				width    = 225,
				inset    = 10,
				strata   = nil,
				level    = 2,
				
				bar = 
				{
					enabled  = true;
					orient   = "LEFT",
					overlay  = "Interface\\AddOns\\nUI\\Layouts\\Default\\Art\\nUI_BarOverlay1",
				},
				
				mix_health =
				{
					enabled     = true,
					fontsize    = 11,
					justifyH    = "LEFT",
					justifyV    = "MIDDLE",
					anchor_pt   = "LEFT",
					relative_to = "$parent_CurHealth",
					xOfs        = 0,
					yOfs        = 0,
					color       = { r = 0.5, g = 1, b = 0.5, a = 1 },
				},
				
				pct_health =
				{
					enabled     = true,
					fontsize    = 11,
					justifyH    = "CENTER",
					justifyV    = "MIDDLE",
					anchor_pt   = "CENTER",
					relative_to = "$parent_PctHealth",
					xOfs        = 0,
					yOfs        = 1,
					color       = { r = 0.5, g = 1, b = 0.5, a = 1 },
				},

				border =
				{
					backdrop =
					{
						bgFile   = nil, 
						edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border", 
						tile     = true, 
						tileSize = 1, 
						edgeSize = 5, 
						insets   = { left = 0, right = 0, top = 0, bottom = 0 },
					},					
					color =
					{
						border   = { r = 1, g = 1, b = 1, a = 0.5 },
						backdrop = { r = 0, g = 0, b = 0, a = 0 },
					},
				},
			},
		},
		["Power"] =
		{
			anchor =
			{
				anchor_pt   = "TOP",
				relative_to = "$parent_Health",
				relative_pt = "BOTTOM",
				xOfs = 0,
				yOfs = -2.5,
			},		
			options =
			{
				enabled  = true,
				height   = 25,
				width    = 225,
				inset    = 10,
				strata   = nil,
				level    = 2,
				
				bar = 
				{
					enabled  = true;
					orient   = "LEFT",
					overlay  = "Interface\\AddOns\\nUI\\Layouts\\Default\\Art\\nUI_BarOverlay1",
				},
		
				pct_power =
				{
					enabled     = true,
					fontsize    = 11,
					justifyH    = "CENTER",
					justifyV    = "MIDDLE",
					anchor_pt   = "CENTER",
					relative_to = "$parent_PctPower",
					xOfs        = 0,
					yOfs        = 1,
					color       = { r = 1, g = 1, b = 1, a = 1 },
				},
			
				border =
				{
					backdrop =
					{
						bgFile   = nil, 
						edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border", 
						tile     = true, 
						tileSize = 1, 
						edgeSize = 5, 
						insets   = { left = 0, right = 0, top = 0, bottom = 0 },
					},					
					color =
					{
						border   = { r = 1, g = 1, b = 1, a = 0.5 },
						backdrop = { r = 0, g = 0, b = 0, a = 0 },
					},
				},
			},
		},	
		["Casting"] =
		{
			anchor =
			{
				anchor_pt   = "CENTER",
				relative_to = "$parent_Label",
				relative_pt = "CENTER",
				xOfs        = 0,
				yOfs        = 0,
			},		
			options =
			{
				enabled = true,
				height  = 35,
				width   = 420,
				inset   = 10,
				strata  = nil,
				level   = 3,
				
				orient       = "LEFT",
				persist      = false,
				show_bar     = true,
				show_gcd     = false,
				show_latency = false,	
				overlay     = "Interface\\AddOns\\nUI\\Layouts\\Default\\Art\\nUI_BarOverlay1",
				
				pct_time =
				{
					enabled     = true,
					justifyH    = "LEFT",
					justifyV    = "MIDDLE",
					anchor_pt   = "LEFT",
					xOfs        = 10,
					yOfs        = 1,
					
					color = { r = 1, g = 1, b = 1, a = 1 },
				},
				
				spell_name =
				{
					enabled     = true,
					justifyH    = "RIGHT",
					justifyV    = "MIDDLE",
					anchor_pt   = "RIGHT",
					xOfs        = -10,
					yOfs        = 1,
					
					color = { r = 1, g = 1, b = 1, a = 1 },
				},
				
				msg_label =
				{
					enabled   = true,
					fontsize  = 14,
					justifyH  = "CENTER",
					justifyV  = "MIDDLE",
					anchor_pt = "CENTER",
					xOfs      = 0,
					yOfs      = 1,
					
					color = { r = 1, g = 0, b = 0, a = 1 },
				},
				
				border =
				{
					backdrop =
					{
						bgFile   = "Interface\\Tooltips\\UI-Tooltip-Background", 
						edgeFile = nil, 
						tile     = true, 
						tileSize = 1, 
						edgeSize = 7, 
						insets   = {left = 0, right = 0, top = 0, bottom = 0},
					},
					
					color =
					{
						border = { r = 0, g = 0, b = 0, a = 0 },
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
				height    = 151,
				width     = 420,
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
		["Aura"] =
		{
			[1] =	-- debuffs
			{
				anchor =
				{
					anchor_pt   = "BOTTOMRIGHT",
					relative_to = "$parent_Portrait",
					relative_pt = "BOTTOMLEFT",
					xOfs        = -10,
					yOfs        = 16,
				},		
				options =
				{
					enabled = true,
					size    = 35,
					strata  = nil,
					level   = 1,
					
					aura_type        = "harm",
					origin           = "BOTTOMLEFT",
					player_auras     = false,
					dispellable      = true,
					horizontal       = false,
					highlight_player = false,
					aura_types       = true,
					cooldown_anim    = false,
					flash_expire     = true,
					clickable        = false,
					rows             = 1,
					cols             = 8,
					expire_time      = 10,
					hGap             = 0,
					vGap             = 0,

					timer =
					{
						enabled     = true,
						fontsize    = 9,
						justifyH    = "CENTER",
						justifyV    = "TOP",
						anchor_pt   = "TOP",
						relative_pt = "BOTTOM",
						xOfs        = 0,
						yOfs        = 2,
					},

					count =
					{
						enabled     = true,
						justifyH    = "CENTER",
						justifyV    = "MIDDLE",
						anchor_pt   = "CENTER",
						relative_pt = "CENTER",
						xOfs        = 0,
						yOfs        = 0.5,
					},
					
					border = nil,				-- sets the frame's border and background or nil for no border/background at all
				},		
			},
		},
		["PvP"] =
		{
			anchor =
			{
				anchor_pt   = "TOP",
				relative_to = "$parent_Health",
				relative_pt = "TOP",
				xOfs        = 0,
				yOfs        = 0,
			},		
			options =
			{
				enabled = true,
				size    = 52.5,
				strata  = nil,
				level   = 4,
			},
		},
		["Role"] =
		{
			anchor =
			{
				anchor_pt   = "CENTER",
				relative_to = "$parent_Label",
				relative_pt = "CENTER",
				xOfs        = 0,
				yOfs        = 0,
			},		
			options =
			{
				enabled = true,
				size    = 30,
				strata  = nil,
				level   = 1,

				icon_size = 30,
				orient    = "RIGHT",
			},
		},
		["ReadyCheck"] =
		{
			anchor =
			{
				anchor_pt   = "CENTER",
				relative_to = "$parent_Portrait",
				xOfs        = 0,
				yOfs        = 0,
			},		
			options =
			{
				enabled = true,
				size    = 90,
				strata  = nil,
				level   = 9,
			},
		},
		["Status"] =
		{
			anchor =
			{
				anchor_pt   = "TOPRIGHT",
				relative_to = "$parent_Health",
				xOfs        = 0,
				yOfs        = -2,
			},		
			options =
			{
				enabled = true,
				height  = 52.5,
				width   = 225,
				strata  = nil,
				level   = 5,
				
				fade_unit = 0.6,
				
				label =
				{
					enabled   = true,
					fontsize  = 26,
					justifyH  = "CENTER",
					justifyV  = "MIDDLE",
					anchor_pt = "CENTER",
					xOfs      = 0,
					yOfs      = 2,
					
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
		["Frame"] =
		{
			[1] =
			{
				anchor =
				{
					anchor_pt   = "LEFT",
					relative_to = "$parent_Class",
					relative_pt = "RIGHT",
					xOfs        = 0,
					yOfs        = 0,
				},		
				options =
				{
					name    = "$parent_CurHealth",
					enabled = true,
					height  = 25,
					width   = 60,
					inset   = 0,
					strata  = nil,
					level   = nil,
				},
			},
			[2] =
			{
				anchor =
				{
					anchor_pt   = "RIGHT",
					relative_to = "$parent_Health",
					relative_pt = "LEFT",
					xOfs        = -5,
					yOfs        = 0,
				},		
				options =
				{
					name    = "$parent_PctHealth",
					enabled = true,
					height  = 25,
					width   = 60,
					inset   = 0,
					strata  = nil,
					level   = nil,
				},
			},
			[3] =
			{
				anchor =
				{
					anchor_pt   = "RIGHT",
					relative_to = "$parent_Power",
					relative_pt = "LEFT",
					xOfs        = -5,
					yOfs        = 0,
				},		
				options =
				{
					name    = "$parent_PctPower",
					enabled = true,
					height  = 25,
					width   = 60,
					inset   = 0,
					strata  = nil,
					level   = nil,
				},
			},
		},
	},
};
