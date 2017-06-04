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

nUI_UnitSkins[nUI_UNITSKIN_RAID15PLAYER] =
{
	height   = 225,
	width    = 194,
	desc     = nUI_L[nUI_UNITSKIN_RAID15PLAYER],
	
	elements =
	{
		["Label"] =
		{
			[1] =
			{
				anchor =
				{
					anchor_pt   = "TOP",
					xOfs        = 0,
					yOfs        = 0,
				},		
				options =
				{
					enabled = true,
					height  = 35,
					width   = 194,
					inset   = 7,
					strata  = nil,
					level   = 1,
	
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
						xOfs        = -10,
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
			[2] =
			{
				anchor =
				{
					anchor_pt        = "BOTTOMLEFT",
					relative_to      = "nUI_Dashboard",
					relative_pt      = "TOPLEFT",
					xOfs             = 20,
					yOfs             = -80,
				},		
				options =
				{
					enabled = true,
					height  = 35,
					width   = 350,
					inset   = 7,
					strata  = nil,
					level   = nil,
	
					text          = nil,
					show_reaction = true,
					class_colors  = true,
					clickable     = false,
					
					label =
					{
						enabled     = true,
						fontsize    = 12,
						justifyH    = "CENTER",
						justifyV    = "MIDDLE",
						xOfs        = 0,
						yOfs        = 0,					
						color       = { r = 1, g = 1, b = 1, a = 1 },
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
							border   = { r = 1, g = 1, b = 1, a = 0.5 },
							backdrop = { r = 0.25, g = 0.25, b = 0.25, a = 0.5 },
						},
					},
				},
			},
		},
		["Spec"] =
		{
			anchor =
			{
				anchor_pt   = "TOP",
				relative_to = "$parent_Label1",
				relative_pt = "BOTTOM",
				xOfs = 0,
				yOfs = 5,
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
					justifyV    = "TOP",
					anchor_pt   = "CENTER",
					xOfs        = 0,
					yOfs        = 0,
					color       = { r = 0, g = 1, b = 1, a = 1 },
				},
			},
		},
		["Class"] =
		{
			anchor =
			{
				anchor_pt   = "RIGHT",
				relative_to = "$parent_Portrait",
				relative_pt = "BOTTOMRIGHT",
				xOfs        = -15,
				yOfs        = 30,
			},		
			options =
			{
				enabled = true,
				size    = 30,
				inset   = 6,
				strata  = nil,
				level   = 2,

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
		["Level"] =
		{
			anchor =
			{
				anchor_pt   = "LEFT",
				relative_to = "$parent_Portrait",
				relative_pt = "BOTTOMLEFT",
				xOfs        = 15,
				yOfs        = 30,
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
					justifyH    = "CENTER",
					justifyV    = "MIDDLE",
					anchor_pt   = "CENTER",
					xOfs        = 0,
					yOfs        = 1,					
					color       = { r = 1, g = 0.83, b = 0, a = 1 },
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
				},			},
		},
		["Portrait"] =
		{
			anchor =
			{
				anchor_pt   = "CENTER",
				relative_to = "$parent_Feedback",
				xOfs        = 0,
				yOfs        = 0,
			},		
			options =
			{
				enabled = true,
				height  = 120,
				width   = 110,
				inset   = 30,
				strata  = nil,
				level   = nil,

				show_anim = true,
				model     = false,
				outline   = true,
			},
		},
		["Runes"] =
		{
			anchor =
			{
				anchor_pt   = "CENTER",
				relative_to = "$parent_Label1",
				relative_pt = "BOTTOM",
				xOfs        = 0,
				yOfs        = 0,
			},		
			options =
			{
				enabled = true,
				size    = 15,
				hgap    = 8,
				strata  = nil,
				level   = nil,
				orient  = "CENTER",
			},
		},	
		["Resting"] =
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
		["Combat"] =
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
		["RaidTarget"] =
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
		["PvP"] =
		{
			anchor =
			{
				anchor_pt   = "CENTER",
				relative_to = "$parent_Health",
				relative_pt = "BOTTOM",
				xOfs        = 0,
				yOfs        = 1,
			},		
			options =
			{
				enabled = true,
				size    = 35,
				strata  = nil,
				level   = 4,

				timer =
				{
					enabled     = true,
					fontsize    = 13.5,
					justifyH    = "LEFT",
					justifyV    = "MIDDLE",
					anchor_pt   = "LEFT",
					relative_pt = "RIGHT",
					xOfs        = 0,
					yOfs        = 1.5,					
					color       = { r = 1, g = 1, b = 1, a = 1 },
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
				height    = 225,
				width     = 194,
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
		["Health"] =
		{
			anchor =
			{
				anchor_pt   = "BOTTOM",
				relative_to = "$parent_Stats",
				relative_pt = "CENTER",
				xOfs = 0,
				yOfs = 0,
			},		
			options =
			{
				enabled  = true,
				height   = 15,
				width    = 180,
				inset    = 5,
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
					barcolor    = true,
					fontsize    = 11.5,
					justifyH    = "CENTER",
					justifyV    = "MIDDLE",
					anchor_pt   = "CENTER",
					relative_to = "$parent_Stats",
					relative_pt = "TOP",
					xOfs        = 0,
					yOfs        = 14,
				},
				
				pct_health =
				{
					enabled     = true,
					maxcolor    = true,
					fontsize    = 9.5,
					justifyH    = "LEFT",
					justifyV    = "MIDDLE",
					anchor_pt   = "BOTTOMLEFT",
					relative_to = "$parent_Stats",
					relative_pt = "TOPLEFT",
					xOfs        = 0,
					yOfs        = 2,
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
				relative_to = "$parent_Stats",
				relative_pt = "CENTER",
				xOfs = 0,
				yOfs = 3,
			},		
			options =
			{
				enabled  = true,
				height   = 15,
				width    = 180,
				inset    = 5,
				strata   = nil,
				level    = 2,
				
				pct_power =
				{
					enabled     = true,
					fontsize    = 9.5,
					justifyH    = "RIGHT",
					justifyV    = "MIDDLE",
					anchor_pt   = "BOTTOMRIGHT",
					relative_to = "$parent_Stats",
					relative_pt = "TOPRIGHT",
					xOfs        = 0,
					yOfs        = 2,
					color       = { r = 1, g = 1, b = 1, a = 1 },
				},
				
				bar = 
				{
					enabled  = true;
					orient   = "LEFT",
					overlay  = "Interface\\AddOns\\nUI\\Layouts\\Default\\Art\\nUI_BarOverlay2",
				},				
			},
		},	
		["Status"] =
		{
			anchor =
			{
				anchor_pt   = "TOPLEFT",
				relative_to = "$parent_Stats",
				xOfs        = 0,
				yOfs        = 0,
			},		
			options =
			{
				enabled = true,
				height  = 35,
				width   = 190,
				strata  = nil,
				level   = 5,

				fade_unit = 0.6,
				
				label =
				{
					enabled   = true,
					fontsize  = 15,
					justifyH  = "CENTER",
					justifyV  = "MIDDLE",
					anchor_pt = "CENTER",
					xOfs      = 0,
					yOfs      = 1,
					
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
		["Role"] =
		{
			anchor =
			{
				anchor_pt   = "LEFT",
				relative_to = "$parent_Label1",
				relative_pt = "LEFT",
				xOfs        = 5,
				yOfs        = 0,
			},		
			options =
			{
				enabled = true,
				size    = 30,
				strata  = nil,
				level   = 2,

				icon_size = 30,
				orient    = "LEFT",				
			},
		},
		["GCD"] =
		{
			anchor =
			{
				anchor_pt   = "CENTER",
				relative_to = "$parent",
				relative_pt = "TOP",
				xOfs = 0,
				yOfs = 0,
			},		
			options =
			{
				enabled    = true,
				height     = 15,
				width      = 184,
				inset      = 0,
				strata     = nil,
				level      = 8,
				barColor   = { r = 0.75, g = 0.75, b = 0.75 },
				sparkColor = { r = 1, g = 0.5, b = 0.5 },
			},
		},
		["Casting"] =
		{
			anchor =
			{
				anchor_pt   = "CENTER",
				relative_to = "$parent_Label1",
				xOfs        = 0,
				yOfs        = -1,
			},		
			options =
			{
				enabled = true,
				height  = 30,
				width   = 194,
				inset   = 0,
				strata  = nil,
				level   = 4,
				
				orient       = "LEFT",
				persist      = false,
				show_gcd     = false,
				show_bar     = true;
				show_latency = true;
				overlay      = "Interface\\AddOns\\nUI\\Layouts\\Default\\Art\\nUI_BarOverlay1",

				cur_time =
				{
					enabled     = true,
					fonsize     = 11,
					justifyH    = "RIGHT",
					justifyV    = "MIDDLE",
					anchor_pt   = "RIGHT",
					xOfs        = -5,
					yOfs        = 1,
					
					color = { r = 1, g = 1, b = 1, a = 1 },
				},
				
				spell_name =
				{
					enabled     = true,
					fonsize     = 11,
					justifyH    = "LEFT",
					justifyV    = "MIDDLE",
					anchor_pt   = "LEFT",
					xOfs        = 5,
					yOfs        = 1,
					
					color = { r = 1, g = 1, b = 1, a = 1 },
				},
				
				msg_label =
				{
					enabled   = true,
					fonsize     = 13,
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
					anchor_pt   = "BOTTOM",
					relative_to = "$parent_Feedback",
					relative_pt = "BOTTOM",
					xOfs        = 0,
					yOfs        = 1,
				},		
				options =
				{
					name    = "$parent_Stats",
					enabled = true,
					height  = 35,
					width   = 190,
					inset   = 0,
					strata  = nil,
					level   = nil,
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
		["Aura"] =
		{
			[1] =	-- debuffs
			{
				anchor =
				{
					anchor_pt   = "TOPRIGHT",
					relative_to = "$parent_Casting",
					relative_pt = "BOTTOMRIGHT",
					xOfs        = -7.5,
					yOfs        = -5,
				},		
				options =
				{
					enabled = true,
					size    = 30,
					strata  = nil,
					level   = 2,
					
					aura_type        = "harm",
					origin           = "BOTTOMRIGHT",
					player_auras     = false,
					dispellable      = false,
					horizontal       = false,
					highlight_player = false,
					aura_types       = true,
					cooldown_anim    = false,
					flash_expire     = true,
					clickable        = false,
					rows             = 4,
					cols             = 3,
					expire_time      = 10,
					hGap             = 0,
					vGap             = 0,

					count =
					{
						enabled     = true,
						fontsize    = 10,
						justifyH    = "LEFT",
						justifyV    = "TOP",
						anchor_pt   = "TOPLEFT",
						relative_pt = "TOPLEFT",
						xOfs        = 1,
						yOfs        = -1,
					},
				},		
			},
			[2] =
			{
				anchor =
				{
					anchor_pt   = "BOTTOMLEFT",
					relative_to = "$parent_Label2",
					relative_pt = "TOPLEFT",
					xOfs        = 0,
					yOfs        = 0,
				},		
				options =
				{
					enabled          = true,
					width            = 350,
					size             = 28.5,
					strata           = nil,
					level            = 1,
					
					aura_type        = "help",
					origin           = "BOTTOMLEFT",
					player_auras     = false,
					dispellable      = false,
					horizontal       = false,
					highlight_player = true,
					aura_types       = false,
					cooldown_anim    = false,
					flash_expire     = true,
					clickable        = true,
					dynamic_size     = false,
					rows             = 40,
					cols             = 1,
					expire_time      = 10,
					hGap             = 0,
					vGap             = 2,
				
					count =
					{
						enabled     = true,
						fontsize    = 11.5,
						justifyH    = "LEFT",
						justifyV    = "MIDDLE",
						anchor_pt   = "LEFT",
						relative_pt = "RIGHT",
						xOfs        = 10,
						yOfs        = 1,
						color       = { r = 0.5, g = 1, b = 0.5, a = 1 },
					},

					timer =
					{
						enabled     = true,
						fontsize    = 11.5,
						justifyH    = "RIGHT",
						justifyV    = "MIDDLE",
						anchor_pt   = "RIGHT",
						relative_pt = "RIGHT",
						xOfs        = 315,
						yOfs        = 1,
						color       = { r = 0, g = 1, b = 1, a = 1 },
					},

					label =
					{
						enabled     = true,
						fontsize    = 11.5,
						justifyH    = "LEFT",
						justifyV    = "MIDDLE",
						anchor_pt   = "LEFT",
						relative_pt = "RIGHT",
						width       = 240,
						height      = 28.5,
						xOfs        = 35,
						yOfs        = 1,
						color       = { r = 1, g = 0.83, b = 0, a = 1 },
					},
				},	
			},
		},		
	},
};
