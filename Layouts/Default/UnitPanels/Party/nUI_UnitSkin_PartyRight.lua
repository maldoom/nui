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

nUI_UnitSkins[nUI_UNITSKIN_PARTYRIGHT] =
{
	height   = 302,
	width    = 250,
	desc     = nUI_L[nUI_UNITSKIN_PARTYRIGHT],
	
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
				width   = 250,
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
				xOfs        = -8,
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
				width   = 90,
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
					fontsize    = 11,
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
		["Health"] =
		{
			anchor =
			{
				anchor_pt   = "TOPLEFT",
				relative_to = "$parent_Stats",
				relative_pt = "TOPLEFT",
				xOfs = 0,
				yOfs = 0,
			},		
			options =
			{
				enabled  = true,
				height   = 14,
				width    = 145,
				inset    = 1.5,
				strata   = nil,
				level    = 2,
				
				bar = 
				{
					enabled  = true;
					orient   = "LEFT",
					overlay  = "Interface\\AddOns\\nUI\\Layouts\\Default\\Art\\nUI_BarOverlay2",
				},				
				
				cur_health =
				{
					enabled     = true,
					justifyH    = "LEFT",
					justifyV    = "MIDDLE",
					anchor_pt   = "LEFT",
					relative_to = "$parent_CurHealth",
					xOfs        = 0,
					yOfs        = 1,
					color       = { r = 0.5, g = 1, b = 0.5, a = 1 },
				},
				
				pct_health =
				{
					enabled     = true,
					justifyH    = "CENTER",
					justifyV    = "MIDDLE",
					anchor_pt   = "CENTER",
					relative_to = "$parent_Stats",
					xOfs        = 0,
					yOfs        = 1,
					color       = { r = 1, g = 1, b = 1, a = 1 },
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
				yOfs = -2,
			},		
			options =
			{
				enabled  = true,
				height   = 10,
				width    = 145,
				inset    = 1.5,
				strata   = nil,
				level    = 2,
				
				bar = 
				{
					enabled  = true;
					orient   = "LEFT",
					overlay  = "Interface\\AddOns\\nUI\\Layouts\\Default\\Art\\nUI_BarOverlay2",
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
				height  = 30,
				width   = 245,
				inset   = 0,
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
					fonsize     = 11,
					justifyH    = "RIGHT",
					justifyV    = "MIDDLE",
					anchor_pt   = "RIGHT",
					xOfs        = -10,
					yOfs        = 0.5,
					
					color = { r = 1, g = 1, b = 1, a = 1 },
				},
				
				spell_name =
				{
					enabled     = true,
					fonsize     = 11,
					justifyH    = "LEFT",
					justifyV    = "MIDDLE",
					anchor_pt   = "LEFT",
					xOfs        = 10,
					yOfs        = 0.5,
					
					color = { r = 1, g = 1, b = 1, a = 1 },
				},
				
				msg_label =
				{
					enabled   = true,
					fontsize    = 13,
					justifyH  = "CENTER",
					justifyV  = "MIDDLE",
					anchor_pt = "CENTER",
					xOfs      = 0,
					yOfs      = 0,
					
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
				anchor_pt   = "TOPLEFT",
				relative_to = "$parent",
				relative_pt = "TOPLEFT",
				xOfs        = 0,
				yOfs        = 0,
			},		
			options =
			{
				enabled   = true,
				height    = 151,
				width     = 250,
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
		["PvP"] =
		{
			anchor =
			{
				anchor_pt   = "CENTER",
				relative_to = "$parent_Label",
				relative_pt = "RIGHT",
				xOfs        = -2,
				yOfs        = 0,
			},		
			options =
			{
				enabled = true,
				size    = 35,
				strata  = nil,
				level   = 4,
			},
		},
		["Role"] =
		{
			anchor =
			{
				anchor_pt   = "TOPRIGHT",
				relative_to = "$parent_Health",
				relative_pt = "TOPLEFT",
				xOfs        = 0,
				yOfs        = 0,
			},		
			options =
			{
				enabled = true,
				size    = 26,
				strata  = nil,
				level   = 2,

				icon_size = 26,
				orient    = "TOP",				
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
				anchor_pt   = "TOPLEFT",
				relative_to = "$parent_Health",
				xOfs        = 0,
				yOfs        = 0,
			},		
			options =
			{
				enabled = true,
				height  = 52.5,
				width   = 145,
				strata  = nil,
				level   = 5,
				
				fade_unit = 0.6,
				
				label =
				{
					enabled   = true,
					fontsize  = 22,
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
					anchor_pt   = "BOTTOMLEFT",
					relative_to = "$parent_Feedback",
					relative_pt = "BOTTOMLEFT",
					xOfs        = 0,
					yOfs        = 16,
				},		
				options =
				{
					enabled = true,
					size    = 30,
					strata  = nil,
					level   = 3,
					
					aura_type        = "harm",
					origin           = "BOTTOMLEFT",
					player_auras     = false,
					dispellable      = true,
					horizontal       = true,
					highlight_player = false,
					aura_types       = true,
					cooldown_anim    = false,
					flash_expire     = true,
					timed_auras      = true,
					rows             = 1,
					cols             = 8,
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
			[2] =
			{
				anchor =
				{
					anchor_pt   = "BOTTOMRIGHT",
					relative_to = "$parent_Feedback",
					relative_pt = "BOTTOMRIGHT",
					xOfs        = 0,
					yOfs        = 16,
				},		
				options =
				{
					enabled = true,
					size    = 30,
					strata  = nil,
					level   = 3,
					
					aura_type        = "help",
					origin           = "BOTTOMRIGHT",
					player_auras     = true,
					dispellable      = false,
					horizontal       = true,
					highlight_player = false,
					aura_types       = false,
					cooldown_anim    = false,
					flash_expire     = true,
					timed_auras      = true,
					rows             = 1,
					cols             = 8,
					expire_time      = 10,
					hGap             = 0,
					vGap             = 0,

					timer =
					{
						enabled     = true,
						fontsize    = 8,
						justifyH    = "CENTER",
						justifyV    = "MIDDLE",
						anchor_pt   = "TOP",
						relative_pt = "BOTTOM",
						xOfs        = 0,
						yOfs        = 0.5,
					},

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
					anchor_pt   = "TOPRIGHT",
					relative_to = "$parent_Portrait",
					relative_pt = "TOPLEFT",
					xOfs        = 0,
					yOfs        = -13,
				},		
				options =
				{
					name    = "$parent_Stats",
					enabled = true,
					height  = 26,
					width   = 145,
					inset   = 0,
					strata  = nil,
					level   = nil,
				},
			},
		},
	},
};
