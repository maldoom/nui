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

if not nUI_UnitPanels then nUI_UnitPanels = {}; end

nUI_UnitPanels[nUI_UNITPANEL_PLAYER] =
{
	desc     = nUI_L[nUI_UNITPANEL_PLAYER],				-- player friendly name/description of the panel
	label    = nUI_L[nUI_UNITPANEL_PLAYER.."Label"],	-- label to use on the panel selection button face
	rotation = nUI_UNITMODE_PLAYER,						-- index or position this panel appears on/in when clicking the selector button
	enabled  = true,									-- whether or not the player has the panel enabled
	selected = false,									-- whether or not this is the currently selected panel
	automode = "solo",									-- selects to automatically show this panel when player is solo
	
	loadOrder =
	{
		[1]  = nUI_UNITFRAME_SOLOPLAYER,
		[2]  = nUI_UNITFRAME_SOLOPET,
		[3]  = nUI_UNITFRAME_SOLOPETT,
		[4]  = nUI_UNITFRAME_SOLOVEHICLE,
		[5]  = nUI_UNITFRAME_SOLOTARGET,
		[6]  = nUI_UNITFRAME_SOLOTARGETP,
		[7]  = nUI_UNITFRAME_SOLOTOT,
		[8]  = nUI_UNITFRAME_SOLOTOTP,
		[9]  = nUI_UNITFRAME_SOLOTOTT,
		[10] = nUI_UNITFRAME_SOLOFOCUS,
		[11] = nUI_UNITFRAME_SOLOFOCUSP,
		[12] = nUI_UNITFRAME_SOLOFOCUST,
		[13] = nUI_UNITFRAME_SOLOMOUSE,
		[14] = nUI_UNITFRAME_SOLOBOSS.."2",
		[15] = nUI_UNITFRAME_SOLOBOSS.."3",
		[16] = nUI_UNITFRAME_SOLOBOSS.."1",
		[17] = nUI_UNITFRAME_SOLOBOSS.."4",
	},
	
	units =
	{
		[nUI_UNITFRAME_SOLOPLAYER] = 
		{
			anchor = 
			{
				anchor_pt   = "TOPLEFT",
				relative_to = "$parent",
				relative_pt = "CENTER",
				xOfs        = -570,
				yOfs        = 53,
			},
			options = 
			{
				skinName  = nUI_UNITSKIN_SOLOPLAYER,
				enabled   = true,
				
				strata    = nil,
				level     = 3,
				
				unit_id   = "player",
				party_id  = nil,
				raid_id	  = nil,
				
				scale     = 1,
				clickable = true,
				
				popup =
				{
					anchor_pt = "BOTTOMRIGHT",
					relative_pt = "CENTER",
					xOfs = 0,
					yOfs = 0,
					
					color = { r = 0, g = 0, b = 0, a = 0.75 },
				};
				
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
						backdrop = { r = 0, g = 0, b = 0, a = 0.35 },
					},
				},
			},
		},
		[nUI_UNITFRAME_SOLOVEHICLE] = 
		{
			anchor = 
			{
				anchor_pt   = "TOP",
				relative_to = nUI_UNITFRAME_SOLOPLAYER.."_Feedback",
				relative_pt = "BOTTOM",
				xOfs        = 0,
				yOfs        = 0,
			},
			options = 
			{
				skinName  = nUI_UNITSKIN_SOLOVEHICLE,
				enabled   = true,
				
				strata    = nil,
				level     = 4,
				
				unit_id   = "vehicle",
				party_id  = nil,
				raid_id	  = nil,
				
				scale     = 1,
				clickable = true,
				
				popup =
				{
					anchor_pt = "BOTTOMRIGHT",
					relative_pt = "CENTER",
					xOfs = 0,
					yOfs = 0,
					
					color = { r = 0, g = 0, b = 0, a = 0.75 },
				};
			},
		},
		[nUI_UNITFRAME_SOLOPET] = 
		{
			anchor = 
			{
				anchor_pt   = "TOP",
				relative_to = nUI_UNITFRAME_SOLOPLAYER.."_Feedback",
				relative_pt = "BOTTOM",
				xOfs        = 0,
				yOfs        = 0,
			},
			options = 
			{
				skinName  = nUI_UNITSKIN_SOLOPET,
				enabled   = true,
				
				strata    = nil,
				level     = 4,
				
				unit_id   = "pet",
				party_id  = nil,
				raid_id	  = nil,
				
				visibility = "[target=pet, noexists] hide; [target=vehicle, exists] hide; show",
				scale     = 1,
				clickable = true,
				
				popup =
				{
					anchor_pt = "BOTTOMRIGHT",
					relative_pt = "CENTER",
					xOfs = 0,
					yOfs = 0,
					
					color = { r = 0, g = 0, b = 0, a = 0.75 },
				};
			},
		},
		[nUI_UNITFRAME_SOLOPETT] = 
		{
			anchor = 
			{
				anchor_pt   = "BOTTOMLEFT",
				relative_to = nUI_UNITFRAME_SOLOPET.."_Portrait",
				relative_pt = "BOTTOMRIGHT",
				xOfs        = 0,
				yOfs        = 13,
			},
			options = 
			{
				skinName  = nUI_UNITSKIN_SOLOTGTBUTTON,
				enabled   = true,
				
				strata    = nil,
				level     = 5,
				
				unit_id   = "pettarget",
				party_id  = nil,
				raid_id	  = nil,
				
				scale     = 1,
				clickable = true,
				
				popup =
				{
					anchor_pt = "BOTTOMRIGHT",
					relative_pt = "CENTER",
					xOfs = 0,
					yOfs = 0,
					
					color = { r = 0, g = 0, b = 0, a = 0.75 },
				};
			},
		},
		[nUI_UNITFRAME_SOLOTARGET] = 
		{
			anchor = 
			{
				anchor_pt   = "TOPRIGHT",
				relative_to = "$parent",
				relative_pt = "CENTER",
				xOfs        = 570,
				yOfs        = 53,
			},
			options = 
			{
				skinName  = nUI_UNITSKIN_SOLOTARGET,
				enabled   = true,
				
				strata    = nil,
				level     = 3,
				
				unit_id   = "target",
				party_id  = nil,
				raid_id	  = nil,
				
				scale     = 1,
				clickable = true,
				
				popup =
				{
					anchor_pt = "BOTTOMRIGHT",
					relative_pt = "CENTER",
					xOfs = 0,
					yOfs = 0,
					
					color = { r = 0, g = 0, b = 0, a = 0.75 },
				};
				
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
						backdrop = { r = 0, g = 0, b = 0, a = 0.35 },
					},
				},
			},
		},
--[[
		[nUI_UNITFRAME_SOLOTARGETP] = 
		{
			anchor = 
			{
				anchor_pt   = "BOTTOMRIGHT",
				relative_to = nUI_UNITFRAME_SOLOTARGET.."_Portrait",
				relative_pt = "BOTTOMLEFT",
				xOfs        = 0,
				yOfs        = 13,
			},
			options = 
			{
				skinName  = nUI_UNITSKIN_SOLOPETBUTTON,
				enabled   = true,
				
				strata    = nil,
				level     = 5,
				
				unit_id   = "targetpet",
				party_id  = nil,
				raid_id	  = nil,
				
				scale     = 1,
				clickable = true,
				
				popup =
				{
					anchor_pt = "BOTTOMRIGHT",
					relative_pt = "CENTER",
					xOfs = 0,
					yOfs = 0,
					
					color = { r = 0, g = 0, b = 0, a = 0.75 },
				};
			},
		},
]]--
		[nUI_UNITFRAME_SOLOTOT] = 
		{
			anchor = 
			{
				anchor_pt   = "TOP",
				relative_to = nUI_UNITFRAME_SOLOTARGET.."_Feedback",
				relative_pt = "BOTTOM",
				xOfs        = 0,
				yOfs        = 0,
			},
			options = 
			{
				skinName  = nUI_UNITSKIN_SOLOTOT,
				enabled   = true,
				
				strata    = nil,
				level     = 4,
				
				unit_id   = "targettarget",
				party_id  = nil,
				raid_id	  = nil,
				
				scale     = 1,
				clickable = true,
				
				popup =
				{
					anchor_pt = "BOTTOMRIGHT",
					relative_pt = "CENTER",
					xOfs = 0,
					yOfs = 0,
					
					color = { r = 0, g = 0, b = 0, a = 0.75 },
				};
			},
		},
--[[		
		[nUI_UNITFRAME_SOLOTOTP] = 
		{
			anchor = 
			{
				anchor_pt   = "BOTTOMRIGHT",
				relative_to = nUI_UNITFRAME_SOLOTOT.."_Portrait",
				relative_pt = "BOTTOMLEFT",
				xOfs        = 0,
				yOfs        = 13,
			},
			options = 
			{
				skinName  = nUI_UNITSKIN_SOLOPETBUTTON,
				enabled   = true,
				
				strata    = nil,
				level     = 5,
				
				unit_id   = "targettargetpet",
				party_id  = nil,
				raid_id	  = nil,
				
				scale     = 1,
				clickable = true,
				
				popup =
				{
					anchor_pt = "BOTTOMRIGHT",
					relative_pt = "CENTER",
					xOfs = 0,
					yOfs = 0,
					
					color = { r = 0, g = 0, b = 0, a = 0.75 },
				};
			},
		},
]]--		
		[nUI_UNITFRAME_SOLOFOCUS] = 
		{
			anchor = 
			{
				anchor_pt   = "TOP",
				relative_to = "$parent",
				relative_pt = "CENTER",
				xOfs        = 0,
				yOfs        = 53,
			},
			options = 
			{
				skinName  = nUI_UNITSKIN_SOLOFOCUS,
				enabled   = true,
				
				strata    = nil,
				level     = 3,
				
				unit_id   = "focus",
				party_id  = nil,
				raid_id	  = nil,
				
				scale     = 1,
				clickable = true,
				
				popup =
				{
					anchor_pt = "BOTTOMRIGHT",
					relative_pt = "CENTER",
					xOfs = 0,
					yOfs = 0,
					
					color = { r = 0, g = 0, b = 0, a = 0.75 },
				};
				
				border =
				{
					backdrop =
					{
						bgFile   = "Interface\\Tooltips\\UI-Tooltip-Background", 
						edgeFile = "Interface\\AddOns\\nUI\\Layouts\\Default\\Art\\nUI_BevelboxBorder", 
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
		},
--[[		
		[nUI_UNITFRAME_SOLOFOCUSP] = 
		{
			anchor = 
			{
				anchor_pt   = "TOPLEFT",
				relative_to = nUI_UNITFRAME_SOLOFOCUS.."_Label",
				relative_pt = "BOTTOMLEFT",
				xOfs        = 5,
				yOfs        = 0,
			},
			options = 
			{
				skinName  = nUI_UNITSKIN_SOLOPETBUTTON,
				enabled   = true,
				
				strata    = nil,
				level     = 8,
				
				unit_id   = "focuspet",
				party_id  = nil,
				raid_id	  = nil,
				
				scale     = 0.85,
				clickable = true,
				
				popup =
				{
					anchor_pt = "BOTTOMRIGHT",
					relative_pt = "CENTER",
					xOfs = 0,
					yOfs = 0,
					
					color = { r = 0, g = 0, b = 0, a = 0.75 },
				};
			},
		},
]]--		
		[nUI_UNITFRAME_SOLOFOCUST] = 
		{
			anchor = 
			{
				anchor_pt   = "TOPRIGHT",
				relative_to = nUI_UNITFRAME_SOLOFOCUS.."_Label",
				relative_pt = "BOTTOMRIGHT",
				xOfs        = -5,
				yOfs        = 0,
			},
			options = 
			{
				skinName  = nUI_UNITSKIN_SOLOTGTBUTTON,
				enabled   = true,
				
				strata    = nil,
				level     = 8,
				
				unit_id   = "focustarget",
				party_id  = nil,
				raid_id	  = nil,
				
				scale     = 0.85,
				clickable = true,
				
				popup =
				{
					anchor_pt = "BOTTOMRIGHT",
					relative_pt = "CENTER",
					xOfs = 0,
					yOfs = 0,
					
					color = { r = 0, g = 0, b = 0, a = 0.75 },
				};
			},
		},
		[nUI_UNITFRAME_SOLOMOUSE] = 
		{
			anchor = 
			{
				anchor_pt   = "TOP",
				relative_to = nUI_UNITFRAME_SOLOFOCUS,
				relative_pt = "BOTTOM",
				xOfs        = 0,
				yOfs        = -7,
			},
			options = 
			{
				skinName  = nUI_UNITSKIN_SOLOMOUSE,
				enabled   = true,
				
				strata    = nil,
				level     = 8,
				
				unit_id   = "mouseover",
				party_id  = nil,
				raid_id	  = nil,
				
				scale      = 1,
				clickable  = true,
				
				popup =
				{
					anchor_pt = "BOTTOMRIGHT",
					relative_pt = "CENTER",
					xOfs = 0,
					yOfs = 0,
					
					color = { r = 0, g = 0, b = 0, a = 0.75 },
				};
				
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
						backdrop = { r = 0, g = 0, b = 0, a = 0.35 },
					},
				},
			},
		},
		[nUI_UNITFRAME_SOLOBOSS.."2"] = 
		{
			anchor = 
			{
				anchor_pt   = "TOPRIGHT",
				relative_to = "nUI_TopBars",
				relative_pt = "BOTTOM",
				xOfs        = -2.5,
				yOfs        = 7.5,
			},
			options = 
			{
				skinName  = nUI_UNITSKIN_BOSSFRAME,
				enabled   = true,
				
				strata    = nil,
				level     = 8,
				
				unit_id   = "boss2",
				party_id  = nil,
				raid_id	  = nil,
				
				scale      = 1,
				clickable  = true,
				
				popup =
				{
					anchor_pt = "TOPRIGHT",
					relative_pt = "BOTTOM",
					xOfs = 0,
					yOfs = 0,
					
					color = { r = 0, g = 0, b = 0, a = 0.75 },
				};
			},
		},
		[nUI_UNITFRAME_SOLOBOSS.."3"] = 
		{
			anchor = 
			{
				anchor_pt   = "TOPLEFT",
				relative_to = "nUI_TopBars",
				relative_pt = "BOTTOM",
				xOfs        = 2.5,
				yOfs        = 7.5,
			},
			options = 
			{
				skinName  = nUI_UNITSKIN_BOSSFRAME,
				enabled   = true,
				
				strata    = nil,
				level     = 8,
				
				unit_id   = "boss3",
				party_id  = nil,
				raid_id	  = nil,
				
				scale      = 1,
				clickable  = true,
				
				popup =
				{
					anchor_pt = "TOPRIGHT",
					relative_pt = "BOTTOM",
					xOfs = 0,
					yOfs = 0,
					
					color = { r = 0, g = 0, b = 0, a = 0.75 },
				};
			},
		},
		[nUI_UNITFRAME_SOLOBOSS.."1"] = 
		{
			anchor = 
			{
				anchor_pt   = "RIGHT",
				relative_to = nUI_UNITFRAME_SOLOBOSS.."2",
				relative_pt = "LEFT",
				xOfs        = -5,
				yOfs        = 0,
			},
			options = 
			{
				skinName  = nUI_UNITSKIN_BOSSFRAME,
				enabled   = true,
				
				strata    = nil,
				level     = 8,
				
				unit_id   = "boss1",
				party_id  = nil,
				raid_id	  = nil,
				
				scale      = 1,
				clickable  = true,
				
				popup =
				{
					anchor_pt = "TOPRIGHT",
					relative_pt = "BOTTOM",
					xOfs = 0,
					yOfs = 0,
					
					color = { r = 0, g = 0, b = 0, a = 0.75 },
				};
			},
		},
		[nUI_UNITFRAME_SOLOBOSS.."4"] = 
		{
			anchor = 
			{
				anchor_pt   = "LEFT",
				relative_to = nUI_UNITFRAME_SOLOBOSS.."3",
				relative_pt = "RIGHT",
				xOfs        = 5,
				yOfs        = 0,
			},
			options = 
			{
				skinName  = nUI_UNITSKIN_BOSSFRAME,
				enabled   = true,
				
				strata    = nil,
				level     = 8,
				
				unit_id   = "boss4",
				party_id  = nil,
				raid_id	  = nil,
				
				scale      = 1,
				clickable  = true,
				
				popup =
				{
					anchor_pt = "TOPRIGHT",
					relative_pt = "BOTTOM",
					xOfs = 0,
					yOfs = 0,
					
					color = { r = 0, g = 0, b = 0, a = 0.75 },
				};
			},
		},
	},
};
