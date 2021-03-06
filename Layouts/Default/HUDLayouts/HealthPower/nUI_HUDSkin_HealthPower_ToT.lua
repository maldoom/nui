﻿--[[---------------------------------------------------------------------------

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

nUI_UnitSkins[nUI_HUDSKIN_HEALTHPOWER_TOT] =
{
	height   = 2,
	width    = 2,
	desc     = nUI_L[nUI_HUDSKIN_HEALTHPOWER_TOT],
	
	elements =
	{
		["Label"] =
		{
			[1] =
			{
				anchor =
				{
					anchor_pt   = "TOPRIGHT",
					relative_to = "$parent_Health",
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
						justifyH    = "LEFT",
						justifyV    = "MIDDLE",
						anchor_pt   = "TOPLEFT",
						relative_to = "$parent_Health",
						relative_pt = "CENTER",
						xOfs        = -15,
						yOfs        = 0,
						color       = { r = 1, g = 0.83, b = 0, a = 1 },
					},
				},
			},
			[2] =
			{
				anchor =
				{
					anchor_pt   = "TOPLEFT",
					relative_to = "$parent_Power",
					relative_pt = "RIGHT",
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
						xOfs        = 10,
						yOfs        = 0,
						color       = { r = 1, g = 0.83, b = 0, a = 1 },
					},
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
					texture    = "Interface\\AddOns\\nUI\\Layouts\\Default\\Art\\nUI_HUD_lhb3",
					overlay    = "Interface\\AddOns\\nUI\\Layouts\\Default\\Art\\nUI_HUD_lhf3",
				},
				
				max_health =
				{
					enabled     = true,
					maxcolor    = true,
					fontsize    = 13,
					justifyH    = "LEFT",
					justifyV    = "MIDDLE",
					anchor_pt   = "TOPLEFT",
					relative_to = "$parent_Health",
					relative_pt = "CENTER",
					xOfs        = -10,
					yOfs        = -30,
				},
				
				cur_health =
				{
					enabled     = true,
					barcolor    = true,
					fontsize    = 12,
					justifyH    = "LEFT",
					justifyV    = "MIDDLE",
					anchor_pt   = "BOTTOMLEFT",
					relative_to = "$parent_Health",
					relative_pt = "BOTTOM",
					xOfs        = 30,
					yOfs        = -45,
				},
				
				pct_health =
				{
					enabled     = true,
					barcolor    = true,
					fontsize    = 12,
					justifyH    = "LEFT",
					justifyV    = "MIDDLE",
					anchor_pt   = "BOTTOMLEFT",
					relative_to = "$parent_Health",
					relative_pt = "BOTTOM",
					xOfs        = 30,
					yOfs        = -25,
				},
			},
		},
		["Power"] =
		{
			anchor =
			{
				anchor_pt   = "CENTER",
				relative_to = nUI_HUDLAYOUT_PLAYERTARGET.."Right",
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
					texture    = "Interface\\AddOns\\nUI\\Layouts\\Default\\Art\\nUI_HUD_rhb3",
					overlay    = "Interface\\AddOns\\nUI\\Layouts\\Default\\Art\\nUI_HUD_rhf3",
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
					xOfs        = 10,
					yOfs        = -30,
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
					xOfs        = -30,
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
					xOfs        = -30,
					yOfs        = -25,
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
					relative_pt = "CENTER",
					xOfs        = 45,
					yOfs        = -70,
				},		
				options =
				{
					enabled = true,
					size    = 35,
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
					clickable        = false,
					rows             = 3,
					cols             = 4,
					expire_time      = 10,
					hGap             = 15,
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
