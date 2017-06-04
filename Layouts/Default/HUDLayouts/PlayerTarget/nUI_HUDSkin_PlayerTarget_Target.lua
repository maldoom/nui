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

nUI_UnitSkins[nUI_HUDSKIN_PLAYERTARGET_TARGET] =
{
	height   = 2,
	width    = 2,
	desc     = nUI_L[nUI_HUDSKIN_PLAYERTARGET_TARGET],
	
	elements =
	{
		["Label"] =
		{
			anchor =
			{
				anchor_pt   = "TOPLEFT",
				relative_to = "$parent_Power",
				relative_pt = "TOP",
				xOfs        = 45,
				yOfs        = 0,
			},		
			options =
			{
				enabled = true,
				height  = 15,
				width   = 2,
				inset   = 0,
				strata  = nil,
				level   = nil,

				text          = nil,
				show_reaction = false,
				class_colors  = true,
				
				label =
				{
					enabled     = true,
					fontsize    = 16,
					justifyH    = "LEFT",
					justifyV    = "MIDDLE",
					anchor_pt   = "LEFT",
					color       = { r = 1, g = 0.83, b = 0, a = 1 },
				},
			},
		},
		["Spec"] =
		{
			anchor =
			{
				anchor_pt   = "BOTTOMLEFT",
				relative_to = "$parent_Label",
				relative_pt = "TOPLEFT",
				xOfs = 0,
				yOfs = 10,
			},		
			options =
			{
				enabled = true,
				width   = 120,
				height  = 30,
				inset   = 0,
				strata  = nil,
				level   = 2,
				
				show_name   = true,
				show_points = true,
				show_type   = true,
				
				icon =
				{
					enabled         = true,
					height          = 256,
					width           = 64,
					anchor_pt       = "CENTER",
					relative_to     = "$parent_Health",
					relative_pt     = "CENTER",
					xOfs            = 87,
					yOfs            = 20,
					elite_icon      = "Interface\\AddOns\\nUI\\Layouts\\Default\\Art\\nUI_HUD_EliteRight",
					rare_icon       = "Interface\\AddOns\\nUI\\Layouts\\Default\\Art\\nUI_HUD_RareRight",
					rare_elite_icon = "Interface\\AddOns\\nUI\\Layouts\\Default\\Art\\nUI_HUD_RareRight",
					world_boss_icon = "Interface\\AddOns\\nUI\\Layouts\\Default\\Art\\nUI_HUD_WorldBossRight",
				},
				label =
				{
					enabled     = true,
					fontsize    = 12,
					justifyH    = "LEFT",
					justifyV    = "MIDDLE",
					anchor_pt   = "LEFT",
					relative_to = "$parent_LabelText",
					relative_pt = "RIGHT",
					xOfs        = 0,
					yOfs        = 0,
					color       = { r = 0, g = 1, b = 1, a = 1 },
				},
			},
		},
		["Range"] =
		{
			anchor =
			{
				anchor_pt   = "CENTER",
				relative_to = "$parent_Label",
				relative_pt = "TOP",
				xOfs = 0,
				yOfs = -2,
			},		
			options =
			{
				enabled         = true,
				size            = 2,
				inset           = 0,
				strata          = nil,
				level           = 2,
				inrange_icon    = false,
				outofrange_icon = false,
				
				label =
				{
					enabled     = true,
					fontsize    = 17,
					justifyH    = "CENTER",
					justifyV    = "MIDDLE",
					anchor_pt   = "BOTTOM",
					relative_to = nUI_HUDLAYOUT_PLAYERTARGET.."Bottom",
					relative_pt = "CENTER",
					xOfs        = 0,
					yOfs        = -45,
				},
			},
		},
		["ComboPoints"] =
		{
			anchor =
			{
				anchor_pt   = "BOTTOM",
				relative_to = nUI_HUDLAYOUT_PLAYERTARGET.."Bottom",
				relative_pt = "TOP",
				xOfs        = 0,
				yOfs        = 130,
			},		
			options =
			{
				enabled = true,
				size    = 30,
				strata  = nil,
				level   = nil,
				orient  = "CENTER",
			},
		},	
		["RaidTarget"] =
		{
			anchor =
			{
				anchor_pt   = "BOTTOM",
				relative_to = "$parent_Health",
				relative_pt = "TOP",
				xOfs = 0,
				yOfs = 0,
			},		
			options =
			{
				enabled = true,
				size    = 35,
				inset   = 0,
				strata  = nil,
				level   = nil,
			},
		},	
		["Health"] =
		{
			anchor =
			{
				anchor_pt   = "CENTER",
				relative_to = nUI_HUDLAYOUT_PLAYERTARGET.."Right",
				relative_pt = "CENTER",
				xOfs = 0,
				yOfs = 0,
			},		
			options =
			{
				enabled  = true,
				height   = 600,
				width    = 300,
				inset    = 0,
				strata   = nil,
				level    = nil,
				
				bar = 
				{
					enabled    = true;
					orient     = "BOTTOM",
					min_offset = 0.01171875,
					max_offset = 0.990234375,
					texture    = "Interface\\AddOns\\nUI\\Layouts\\Default\\Art\\nUI_HUD_rhb1",
					overlay    = "Interface\\AddOns\\nUI\\Layouts\\Default\\Art\\nUI_HUD_rhf1",
				},
				
				max_health =
				{
					enabled     = true,
					maxcolor    = true,
					fontsize    = 16,
					justifyH    = "LEFT",
					justifyV    = "MIDDLE",
					anchor_pt   = "TOPLEFT",
					relative_to = "$parent_Power",
					relative_pt = "TOP",
					xOfs        = 65,
					yOfs        = -30,
					color       = { r = 0.5, g = 1, b = 0.5, a = 1 },
				},
				
				cur_health =
				{
					enabled     = true,
					barcolor    = true,
					fontsize    = 17,
					justifyH    = "LEFT",
					justifyV    = "MIDDLE",
					anchor_pt   = "BOTTOMLEFT",
					relative_to = "$parent_Power",
					relative_pt = "BOTTOM",
					xOfs        = 60,
					yOfs        = 30,
				},
				
				pct_health =
				{
					enabled     = true,
					barcolor    = true,
					fontsize    = 17,
					justifyH    = "RIGHT",
					justifyV    = "MIDDLE",
					anchor_pt   = "BOTTOMRIGHT",
					relative_to = "$parent_Power",
					relative_pt = "BOTTOM",
					xOfs        = -90,
					yOfs        = 30,
				},
			},
		},
		["Power"] =
		{
			anchor =
			{
				anchor_pt   = "CENTER",
				relative_to = "$parent_Health",
				xOfs = 0,
				yOfs = 0,
			},		
			options =
			{
				enabled  = true,
				height   = 600,
				width    = 300,
				inset    = 0,
				strata   = nil,
				level    = nil,
				
				bar = 
				{
					enabled    = true;
					orient     = "BOTTOM",
					min_offset = 0.01171875,
					max_offset = 0.990234375,
					texture    = "Interface\\AddOns\\nUI\\Layouts\\Default\\Art\\nUI_HUD_rhb2",
					overlay    = "Interface\\AddOns\\nUI\\Layouts\\Default\\Art\\nUI_HUD_rhf2",
				},
				
				max_power =
				{
					enabled     = true,
					maxcolor    = true,
					fontsize    = 15,
					justifyH    = "LEFT",
					justifyV    = "MIDDLE",
					anchor_pt   = "TOPLEFT",
					relative_to = "$parent_Power",
					relative_pt = "TOP",
					xOfs        = 75,
					yOfs        = -60,
					color       = { r = 0.5, g = 1, b = 0.5, a = 1 },
				},
				
				cur_power =
				{
					enabled     = true,
					barcolor    = true,
					fontsize    = 15,
					justifyH    = "LEFT",
					justifyV    = "MIDDLE",
					anchor_pt   = "BOTTOMLEFT",
					relative_to = "$parent_Power",
					relative_pt = "BOTTOM",
					xOfs        = 45,
					yOfs        = 0,
				},
				
				pct_power =
				{
					enabled     = true,
					barcolor    = true,
					fontsize    = 15,
					justifyH    = "RIGHT",
					justifyV    = "MIDDLE",
					anchor_pt   = "BOTTOMRIGHT",
					relative_to = "$parent_Power",
					relative_pt = "BOTTOM",
					xOfs        = -105,
					yOfs        = 0,
				},
			},
		},	
		["Casting"] =
		{
			anchor =
			{
				anchor_pt   = "TOP",
				relative_to = nUI_HUDLAYOUT_PLAYERTARGET.."Top",
				xOfs        = 0,
				yOfs        = -20,
			},		
			options =
			{
				enabled = true,
				height  = 40,
				width   = 400,
				inset   = 0,
				strata  = nil,
				level   = 4,
				
				orient       = "LEFT",
				persist      = false,
				show_bar     = true,
				show_gcd     = false,
				show_latency = false,	
				overlay     = "Interface\\AddOns\\nUI\\Layouts\\Default\\Art\\nUI_BarOverlay1",
				
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
						edgeFile = nil, 
						tile     = true, 
						tileSize = 1, 
						edgeSize = 5, 
						insets   = { left = 0, right = 0, top = 0, bottom = 0 },
					},					
					color =
					{
						border   = { r = 0, g = 0, b = 0, a = 0 },
						backdrop = { r = 0, g = 0, b = 0, a = 0.75 },
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
					anchor_pt   = "TOPLEFT",
					relative_to = "$parent_Health",
					relative_pt = "TOPRIGHT",
					xOfs        = -40,
					yOfs        = -100,
				},		
				options =
				{
					enabled = true,
					size    = 45,
					strata  = nil,
					level   = 1,
					
					aura_type        = "harm",
					origin           = "TOPLEFT",
					player_auras     = false,
					dispellable      = false,
					horizontal       = false,
					highlight_player = false,
					aura_types       = true,
					cooldown_anim    = false,
					flash_expire     = true,
					clickable        = true,
					rows             = 3,
					cols             = 4,
					expire_time      = 10,
					hGap             = 5,
					vGap             = 20,

					timer =
					{
						enabled     = true,
						fontsize    = 10,
						justifyH    = "CENTER",
						justifyV    = "TOP",
						anchor_pt   = "TOP",
						relative_pt = "BOTTOM",
						xOfs        = 0,
						yOfs        = 1,
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
				},		
			},
			[2] =	-- debuffs
			{
				anchor =
				{
					anchor_pt   = "BOTTOM",
					relative_to = nUI_HUDLAYOUT_PLAYERTARGET.."Bottom",
					relative_pt = "TOP",
					xOfs        = 0,
					yOfs        = 80,
				},		
				options =
				{
					enabled = true,
					size    = 40,
					strata  = nil,
					level   = 1,
					
					aura_type        = "help",
					origin           = "TOPLEFT",
					player_auras     = true,
					dispellable      = false,
					horizontal       = true,
					dynamic_size     = true,
					highlight_player = false,
					aura_types       = false,
					cooldown_anim    = false,
					flash_expire     = true,
					clickable        = false,
					rows             = 1,
					cols             = 10,
					expire_time      = 10,
					hGap             = 5,
					vGap             = 20,

					timer =
					{
						enabled     = true,
						fontsize    = 12,
						justifyH    = "CENTER",
						justifyV    = "TOP",
						anchor_pt   = "TOP",
						relative_pt = "BOTTOM",
						xOfs        = 0,
						yOfs        = 1,
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
				},		
			},
		},
	},
};
