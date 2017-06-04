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

nUI_UnitSkins[nUI_UNITSKIN_RAID20MOUSE] =
{
	height   = 70,
	width    = 286,
	desc     = nUI_L[nUI_UNITSKIN_RAID20MOUSE],
	
	elements =
	{
		["Label"] =
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
				height  = 70,
				width   = 286,
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
					justifyH    = "CENTER",
					justifyV    = "MIDDLE",
					anchor_pt   = "TOP",
					xOfs        = 0,
					yOfs        = -8,					
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
		["RaidTarget"] =
		{
			anchor =
			{
				anchor_pt   = "CENTER",
				relative_to = "$parent_Class",
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
				level   = 5,
			},
		},
		["Class"] =
		{
			anchor =
			{
				anchor_pt   = "BOTTOMRIGHT",
				relative_to = "$parent_Label",
				xOfs        = -2.5,
				yOfs        = 0,
			},		
			options =
			{
				enabled = true,
				size    = 35,
				inset   = 6,
				strata  = nil,
				level   = 4,
						
				border =
				{
					backdrop =
					{
						bgFile   = "Interface\\Tooltips\\UI-Tooltip-Background", 
						edgeFile = nil, 
						tile     = true, 
						tileSize = 1, 
						edgeSize = 6, 
						insets   = { left = 0, right = 0, top = 0, bottom = 0 },
					},					
					color =
					{
						border   = { r = 0, g = 0, b = 0, a = 0 },
						backdrop = { r = 0, g = 0, b = 0, a = 0.6 },
					},
				},
			},
		},
		["Level"] =
		{
			anchor =
			{
				anchor_pt   = "BOTTOMLEFT",
				relative_to = "$parent_Label",
				xOfs        = 2.5,
				yOfs        = 0,
			},		
			options =
			{
				enabled = true,
				size    = 35,
				inset   = 0,
				strata  = nil,
				level   = 6,
				
				label =
				{
					enabled     = true,
					fontsize    = 13,
					justifyH    = "CENTER",
					justifyV    = "MIDDLE",
					anchor_pt   = "CENTER",
					xOfs        = -0.5,
					yOfs        = 1.5,					
					color       = { r = 1, g = 0.83, b = 0, a = 1 },
				},
						
				border =
				{
					backdrop =
					{
						bgFile   = "Interface\\Tooltips\\UI-Tooltip-Background", 
						edgeFile = nil, 
						tile     = true, 
						tileSize = 1, 
						edgeSize = 6, 
						insets   = { left = 0, right = 0, top = 0, bottom = 0 },
					},					
					color =
					{
						border   = { r = 0, g = 0, b = 0, a = 0 },
						backdrop = { r = 0, g = 0, b = 0, a = 0.6 },
					},
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
				yOfs = 0,
			},		
			options =
			{
				enabled  = true,
				height   = 17.5,
				width    = 216,
				inset    = 4,
				strata   = nil,
				level    = 2,
				
				bar = 
				{
					enabled  = true;
					orient   = "LEFT",
					overlay  = "Interface\\AddOns\\nUI\\Layouts\\Default\\Art\\nUI_BarOverlay2",
				},				
				
				pct_health =
				{
					enabled     = true,
					justifyH    = "CENTER",
					justifyV    = "MIDDLE",
					anchor_pt   = "CENTER",
					relative_to = "$parent_Health",
					relative_pt = "BOTTOM",
					xOfs        = 0,
					yOfs        = 2,
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
		["Power"] =
		{
			anchor =
			{
				anchor_pt   = "BOTTOM",
				relative_to = "$parent_Stats",
				xOfs = 0,
				yOfs = 0,
			},		
			options =
			{
				enabled  = true,
				height   = 17.5,
				width    = 216,
				inset    = 4,
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
				height  = 40,
				width   = 216,
				strata  = nil,
				level   = 5,

				fade_unit = 0.6,
				
				label =
				{
					enabled   = true,
					fontsize  = 18,
					justifyH  = "CENTER",
					justifyV  = "MIDDLE",
					anchor_pt = "CENTER",
					xOfs      = 0,
					yOfs      = -1,
					
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
		["Spec"] = -- this spec inclusion does not display anything on the unit frame, but it enabled the rare spotting for mouseover targets
		{
			anchor =
			{
				anchor_pt   = "BOTTOM",
				relative_to = "$parent",
				xOfs = 0,
				yOfs = 0,
			},		
			options =
			{
				enabled = true,
				width   = 1,
				height  = 1,
				inset   = 0,
				strata  = nil,
				level   = 2,
				
				show_name = true,
				show_type = true,
				
				icon =
				{
					enabled         = false,
				},
				
				label =
				{
					enabled     = false,
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
					relative_to = "$parent_Label",
					relative_pt = "BOTTOM",
					xOfs        = 0,
					yOfs        = 0,
				},		
				options =
				{
					name    = "$parent_Stats",
					enabled = true,
					height  = 40,
					width   = 216,
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
					relative_to = "$parent_Label",
					relative_pt = "TOPRIGHT",
					xOfs        = -5,
					yOfs        = -3,
				},		
				options =
				{
					enabled = true,
					size    = 30,
					strata  = nil,
					level   = 3,
					
					aura_type        = "harm",
					origin           = "TOPRIGHT",
					player_auras     = false,
					dispellable      = true,
					horizontal       = true,
					highlight_player = false,
					aura_types       = true,
					cooldown_anim    = false,
					flash_expire     = true,
					timed_auras      = true,
					rows             = 1,
					cols             = 4,
					expire_time      = 10,
					hGap             = 0,
					vGap             = 0,
				},		
			},
			[2] =	-- debuffs
			{
				anchor =
				{
					anchor_pt   = "TOPLEFT",
					relative_to = "$parent_Label",
					relative_pt = "TOPLEFT",
					xOfs        = 5,
					yOfs        = -3,
				},		
				options =
				{
					enabled = true,
					size    = 30,
					strata  = nil,
					level   = 3,
					
					aura_type        = "help",
					origin           = "TOPLEFT",
					player_auras     = true,
					dispellable      = false,
					horizontal       = true,
					highlight_player = false,
					aura_types       = false,
					cooldown_anim    = false,
					flash_expire     = true,
					timed_auras      = true,
					rows             = 1,
					cols             = 3,
					expire_time      = 10,
					hGap             = 0,
					vGap             = 0,

					timer =
					{
						enabled     = true,
						fontsize    = 8,
						justifyH    = "CENTER",
						justifyV    = "MIDDLE",
						anchor_pt   = "BOTTOM",
						relative_pt = "TOP",
						xOfs        = 0,
						yOfs        = 0,
					},
				},		
			},
		},		
	},
};
