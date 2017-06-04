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

nUI_UnitSkins[nUI_HUDSKIN_PLAYERTARGET_PET] =
{
	height   = 2,
	width    = 2,
	desc     = nUI_L[nUI_HUDSKIN_PLAYERTARGET_PET],
	
	elements =
	{
		["Label"] =
		{
			anchor =
			{
				anchor_pt   = "TOPRIGHT",
				relative_to = "$parent_Power",
				relative_pt = "LEFT",
				xOfs        = 0,
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
					justifyH    = "RIGHT",
					justifyV    = "MIDDLE",
					anchor_pt   = "TOPRIGHT",
					relative_to = "$parent_Power",
					relative_pt = "CENTER",
					xOfs        = -115,
					yOfs        = 0,
					color       = { r = 1, g = 0.83, b = 0, a = 1 },
				},
			},
		},
		["RaidTarget"] =
		{
			anchor =
			{
				anchor_pt   = "BOTTOM",
				relative_to = "$parent_Health",
				relative_pt = "CENTER",
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
				relative_to = nUI_HUDLAYOUT_PLAYERTARGET.."Left",
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
					max_offset = 0.48828125,
					texture    = "Interface\\AddOns\\nUI\\Layouts\\Default\\Art\\nUI_HUD_lhb4",
					overlay    = "Interface\\AddOns\\nUI\\Layouts\\Default\\Art\\nUI_HUD_lhf4",
				},
				
				max_health =
				{
					enabled     = true,
					maxcolor    = true,
					fontsize    = 14,
					justifyH    = "RIGHT",
					justifyV    = "MIDDLE",
					anchor_pt   = "TOPRIGHT",
					relative_to = "$parent_Power",
					relative_pt = "CENTER",
					xOfs        = -115,
					yOfs        = -30,
					color       = { r = 0.5, g = 1, b = 0.5, a = 1 },
				},
				
				cur_health =
				{
					enabled     = true,
					barcolor    = true,
					fontsize    = 13,
					justifyH    = "LEFT",
					justifyV    = "MIDDLE",
					anchor_pt   = "BOTTOMLEFT",
					relative_to = "$parent_Power",
					relative_pt = "BOTTOM",
					xOfs        = 40,
					yOfs        = -45,
				},
				
				pct_health =
				{
					enabled     = true,
					barcolor    = true,
					fontsize    = 13,
					justifyH    = "LEFT",
					justifyV    = "MIDDLE",
					anchor_pt   = "BOTTOMLEFT",
					relative_to = "$parent_Power",
					relative_pt = "BOTTOM",
					xOfs        = 40,
					yOfs        = -25,
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
					max_offset = 0.48828125,
					texture    = "Interface\\AddOns\\nUI\\Layouts\\Default\\Art\\nUI_HUD_lhb3",
					overlay    = "Interface\\AddOns\\nUI\\Layouts\\Default\\Art\\nUI_HUD_lhf3",
				},
				
				max_power =
				{
					enabled     = true,
					maxcolor    = true,
					fontsize    = 13,
					justifyH    = "RIGHT",
					justifyV    = "MIDDLE",
					anchor_pt   = "TOPRIGHT",
					relative_to = "$parent_Power",
					relative_pt = "CENTER",
					xOfs        = -110,
					yOfs        = -60,
					color       = { r = 0.5, g = 1, b = 0.5, a = 1 },
				},
				
				cur_power =
				{
					enabled     = true,
					barcolor    = true,
					fontsize    = 12,
					justifyH    = "RIGHT",
					justifyV    = "MIDDLE",
					anchor_pt   = "BOTTOMRIGHT",
					relative_to = "$parent_Power",
					relative_pt = "BOTTOM",
					xOfs        = 30,
					yOfs        = -45,
				},
				
				pct_power =
				{
					enabled     = true,
					barcolor    = true,
					fontsize    = 12,
					justifyH    = "RIGHT",
					justifyV    = "MIDDLE",
					anchor_pt   = "BOTTOMRIGHT",
					relative_to = "$parent_Power",
					relative_pt = "BOTTOM",
					xOfs        = 30,
					yOfs        = -25,
				},
			},
		},	
		["Casting"] =
		{
			anchor =
			{
				anchor_pt   = "BOTTOM",
				relative_to = nUI_HUDLAYOUT_PLAYERTARGET.."Bottom",
				relative_pt = "TOP",
				xOfs        = 0,
				yOfs        = 122,
			},		
			options =
			{
				enabled = true,
				height  = 8,
				width   = 375,
				inset   = 0,
				strata  = nil,
				level   = 4,
				
				orient       = "LEFT",
				persist      = false,
				show_bar     = true,
				show_gcd     = false,
				show_latency = false,	
				overlay      = "Interface\\AddOns\\nUI\\Layouts\\Default\\Art\\nUI_BarOverlay1",
			
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
					anchor_pt   = "TOPRIGHT",
					relative_to = "$parent_Health",
					relative_pt = "LEFT",
					xOfs        = 35,
					yOfs        = -90,
				},		
				options =
				{
					enabled = true,
					size    = 35,
					strata  = nil,
					level   = 1,
					
					aura_type        = "harm",
					origin           = "TOPRIGHT",
					player_auras     = false,
					dispellable      = false,
					horizontal       = false,
					highlight_player = false,
					aura_types       = true,
					cooldown_anim    = false,
					flash_expire     = true,
					clickable        = false,
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
		},
	},
};
