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

nUI_UnitPanels[nUI_UNITPANEL_RAID15] =
{
	desc     = nUI_L[nUI_UNITPANEL_RAID15],			 	-- player friendly name/description of the panel
	label    = nUI_L[nUI_UNITPANEL_RAID15.."Label"],	-- label to use on the panel selection button face
	rotation = nUI_UNITMODE_RAID15,						-- index or position this panel appears on/in when clicking the selector button
	enabled  = true,									-- whether or not the player has the panel enabled
	selected = true,									-- whether or not this is the currently selected panel
	automode = "raid15",								-- selects to automatically display this frame when player is in a raid of eleven to fifteen members
	
	loadOrder =
	{
		[1]  = nUI_UNITFRAME_RAID15.."1",
		[2]  = nUI_UNITFRAME_RAID15P.."1",
		[3]  = nUI_UNITFRAME_RAID15T.."1",
		[4]  = nUI_UNITFRAME_RAID15.."2",
		[5]  = nUI_UNITFRAME_RAID15P.."2",
		[6]  = nUI_UNITFRAME_RAID15T.."2",
		[7]  = nUI_UNITFRAME_RAID15.."3",
		[8]  = nUI_UNITFRAME_RAID15P.."3",
		[9]  = nUI_UNITFRAME_RAID15T.."3",
		[10] = nUI_UNITFRAME_RAID15.."4",
		[11] = nUI_UNITFRAME_RAID15P.."4",
		[12] = nUI_UNITFRAME_RAID15T.."4",
		[13] = nUI_UNITFRAME_RAID15.."5",
		[14] = nUI_UNITFRAME_RAID15P.."5",
		[15] = nUI_UNITFRAME_RAID15T.."5",
		[16] = nUI_UNITFRAME_RAID15.."6",
		[17] = nUI_UNITFRAME_RAID15P.."6",
		[18] = nUI_UNITFRAME_RAID15T.."6",
		[19] = nUI_UNITFRAME_RAID15.."7",
		[20] = nUI_UNITFRAME_RAID15P.."7",
		[21] = nUI_UNITFRAME_RAID15T.."7",
		[22] = nUI_UNITFRAME_RAID15.."8",
		[23] = nUI_UNITFRAME_RAID15P.."8",
		[24] = nUI_UNITFRAME_RAID15T.."8",
		[25] = nUI_UNITFRAME_RAID15.."9",
		[26] = nUI_UNITFRAME_RAID15P.."9",
		[27] = nUI_UNITFRAME_RAID15T.."9",
		[28] = nUI_UNITFRAME_RAID15.."10",
		[29] = nUI_UNITFRAME_RAID15P.."10",
		[30] = nUI_UNITFRAME_RAID15T.."10",
		[31] = nUI_UNITFRAME_RAID15.."11",
		[32] = nUI_UNITFRAME_RAID15P.."11",
		[33] = nUI_UNITFRAME_RAID15T.."11",
		[34] = nUI_UNITFRAME_RAID15.."12",
		[35] = nUI_UNITFRAME_RAID15P.."12",
		[36] = nUI_UNITFRAME_RAID15T.."12",
		[37] = nUI_UNITFRAME_RAID15.."13",
		[38] = nUI_UNITFRAME_RAID15P.."13",
		[39] = nUI_UNITFRAME_RAID15T.."13",
		[40] = nUI_UNITFRAME_RAID15.."14",
		[41] = nUI_UNITFRAME_RAID15P.."14",
		[42] = nUI_UNITFRAME_RAID15T.."14",
		[43] = nUI_UNITFRAME_RAID15.."15",
		[44] = nUI_UNITFRAME_RAID15P.."15",
		[45] = nUI_UNITFRAME_RAID15T.."15",
		[46] = nUI_UNITFRAME_RAID15PLAYER,
		[47] = nUI_UNITFRAME_RAID15PET,
		[48] = nUI_UNITFRAME_RAID15PETT,
		[49] = nUI_UNITFRAME_RAID15VEHICLE,
		[50] = nUI_UNITFRAME_RAID15TARGET,
		[51] = nUI_UNITFRAME_RAID15TARGETP,
		[52] = nUI_UNITFRAME_RAID15TOT,
		[53] = nUI_UNITFRAME_RAID15TOTT,
		[54] = nUI_UNITFRAME_RAID15FOCUS,
		[55] = nUI_UNITFRAME_RAID15FOCUSP,
		[56] = nUI_UNITFRAME_RAID15FOCUST,
		[57] = nUI_UNITFRAME_RAID15MOUSE,
		[58] = nUI_UNITFRAME_RAID15BOSS.."2",
		[59] = nUI_UNITFRAME_RAID15BOSS.."3",
		[60] = nUI_UNITFRAME_RAID15BOSS.."1",
		[61] = nUI_UNITFRAME_RAID15BOSS.."4",
	},
	
	units =
	{
		[nUI_UNITFRAME_RAID15.."1"] = 
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
				skinName  = nUI_UNITSKIN_RAID15LEFT,
				enabled   = true,
				
				strata    = nil,
				level     = 4,
				
				unit_id   = "raid1",
				party_id  = nil,
				raid_id	  = 1,
				
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
		},
		[nUI_UNITFRAME_RAID15.."2"] = 
		{
			anchor = 
			{
				anchor_pt   = "TOPLEFT",
				relative_to = nUI_UNITFRAME_RAID15.."1_Feedback",
				relative_pt = "TOPRIGHT",
				xOfs        = 0,
				yOfs        = 0,
			},
			options = 
			{
				skinName  = nUI_UNITSKIN_RAID15LEFT,
				enabled   = true,
				
				strata    = nil,
				level     = 4,
				
				unit_id   = "raid2",
				party_id  = nil,
				raid_id	  = 2,
				
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
		[nUI_UNITFRAME_RAID15.."3"] = 
		{
			anchor = 
			{
				anchor_pt   = "TOPLEFT",
				relative_to = nUI_UNITFRAME_RAID15.."1_Feedback",
				relative_pt = "BOTTOMLEFT",
				xOfs        = 0,
				yOfs        = 0,
			},
			options = 
			{
				skinName  = nUI_UNITSKIN_RAID15LEFT,
				enabled   = true,
				
				strata    = nil,
				level     = 4,
				
				unit_id   = "raid3",
				party_id  = nil,
				raid_id	  = 3,
				
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
		[nUI_UNITFRAME_RAID15.."4"] = 
		{
			anchor = 
			{
				anchor_pt   = "TOPLEFT",
				relative_to = nUI_UNITFRAME_RAID15.."2_Feedback",
				relative_pt = "BOTTOMLEFT",
				xOfs        = 0,
				yOfs        = 0,
			},
			options = 
			{
				skinName  = nUI_UNITSKIN_RAID15LEFT,
				enabled   = true,
				
				strata    = nil,
				level     = 4,
				
				unit_id   = "raid4",
				party_id  = nil,
				raid_id	  = 4,
				
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
		[nUI_UNITFRAME_RAID15.."5"] = 
		{
			anchor = 
			{
				anchor_pt   = "TOPLEFT",
				relative_to = nUI_UNITFRAME_RAID15.."3_Feedback",
				relative_pt = "BOTTOMLEFT",
				xOfs        = 0,
				yOfs        = 0,
			},
			options = 
			{
				skinName  = nUI_UNITSKIN_RAID15LEFT,
				enabled   = true,
				
				strata    = nil,
				level     = 4,
				
				unit_id   = "raid5",
				party_id  = nil,
				raid_id	  = 5,
				
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
		[nUI_UNITFRAME_RAID15.."6"] = 
		{
			anchor = 
			{
				anchor_pt   = "TOPLEFT",
				relative_to = nUI_UNITFRAME_RAID15.."4_Feedback",
				relative_pt = "BOTTOMLEFT",
				xOfs        = 0,
				yOfs        = 0,
			},
			options = 
			{
				skinName  = nUI_UNITSKIN_RAID15LEFT,
				enabled   = true,
				
				strata    = nil,
				level     = 4,
				
				unit_id   = "raid6",
				party_id  = nil,
				raid_id	  = 6,
				
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
		[nUI_UNITFRAME_RAID15.."7"] = 
		{
			anchor = 
			{
				anchor_pt   = "TOPLEFT",
				relative_to = nUI_UNITFRAME_RAID15.."5_Feedback",
				relative_pt = "BOTTOMLEFT",
				xOfs        = 0,
				yOfs        = 0,
			},
			options = 
			{
				skinName  = nUI_UNITSKIN_RAID15LEFT,
				enabled   = true,
				
				strata    = nil,
				level     = 4,
				
				unit_id   = "raid7",
				party_id  = nil,
				raid_id	  = 7,
				
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
		[nUI_UNITFRAME_RAID15PLAYER] = 
		{
			anchor = 
			{
				anchor_pt   = "TOPRIGHT",
				relative_to = nUI_UNITFRAME_RAID15FOCUS,
				relative_pt = "TOPLEFT",
				xOfs        = -7,
				yOfs        = 0,
			},
			options = 
			{
				skinName  = nUI_UNITSKIN_RAID15PLAYER,
				enabled   = true,
				
				strata    = nil,
				level     = 4,
				
				unit_id = "player",
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
		},
		[nUI_UNITFRAME_RAID15VEHICLE] = 
		{
			anchor = 
			{
				anchor_pt   = "RIGHT",
				relative_to = nUI_UNITFRAME_RAID15MOUSE,
				relative_pt = "LEFT",
				xOfs        = -7,
				yOfs        = 0,
			},
			options = 
			{
				skinName  = nUI_UNITSKIN_RAID15VEHICLE,
				enabled   = true,
				
				strata    = nil,
				level     = 8,
				
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
		},
		[nUI_UNITFRAME_RAID15PET] = 
		{
			anchor = 
			{
				anchor_pt   = "RIGHT",
				relative_to = nUI_UNITFRAME_RAID15MOUSE,
				relative_pt = "LEFT",
				xOfs        = -7,
				yOfs        = 0,
			},
			options = 
			{
				skinName  = nUI_UNITSKIN_RAID15PET,
				enabled   = true,
				
				strata    = nil,
				level     = 8,
				
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
		},
		[nUI_UNITFRAME_RAID15TARGET] = 
		{
			anchor = 
			{
				anchor_pt   = "TOPLEFT",
				relative_to = nUI_UNITFRAME_RAID15FOCUS,
				relative_pt = "TOPRIGHT",
				xOfs        = 7,
				yOfs        = 0,
			},
			options = 
			{
				skinName  = nUI_UNITSKIN_RAID15TARGET,
				enabled   = true,
				
				strata    = nil,
				level     = 4,
				
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
		},
--[[		
		[nUI_UNITFRAME_RAID15TARGETP] = 
		{
			anchor = 
			{
				anchor_pt   = "TOPLEFT",
				relative_to = nUI_UNITFRAME_RAID15TARGET.."_Label",
				relative_pt = "BOTTOMLEFT",
				xOfs        = 5,
				yOfs        = -1,
			},
			options = 
			{
				skinName  = nUI_UNITSKIN_RAID15PETBUTTON,
				enabled   = true,
				
				strata    = nil,
				level     = 6,
				
				unit_id   = "targetpet",
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
		[nUI_UNITFRAME_RAID15TOT] = 
		{
			anchor = 
			{
				anchor_pt   = "LEFT",
				relative_to = nUI_UNITFRAME_RAID15MOUSE,
				relative_pt = "RIGHT",
				xOfs        = 7,
				yOfs        = 0,
			},
			options = 
			{
				skinName  = nUI_UNITSKIN_RAID15TOT,
				enabled   = true,
				
				strata    = nil,
				level     = 8,
				
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
		},
		[nUI_UNITFRAME_RAID15FOCUS] = 
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
				skinName  = nUI_UNITSKIN_RAID15FOCUS,
				enabled   = true,
				
				strata    = nil,
				level     = 4,
				
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
		[nUI_UNITFRAME_RAID15FOCUSP] = 
		{
			anchor = 
			{
				anchor_pt   = "TOPLEFT",
				relative_to = nUI_UNITFRAME_RAID15FOCUS.."_Label",
				relative_pt = "BOTTOMLEFT",
				xOfs        = 5,
				yOfs        = -1,
			},
			options = 
			{
				skinName  = nUI_UNITSKIN_RAID15PETBUTTON,
				enabled   = true,
				
				strata    = nil,
				level     = 6,
				
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
		[nUI_UNITFRAME_RAID15FOCUST] = 
		{
			anchor = 
			{
				anchor_pt   = "TOPRIGHT",
				relative_to = nUI_UNITFRAME_RAID15FOCUS.."_Label",
				relative_pt = "BOTTOMRIGHT",
				xOfs        = -5,
				yOfs        = -1,
			},
			options = 
			{
				skinName  = nUI_UNITSKIN_RAID15TGTBUTTON,
				enabled   = true,
				
				strata    = nil,
				level     = 6,
				
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
		[nUI_UNITFRAME_RAID15.."8"] = 
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
				skinName  = nUI_UNITSKIN_RAID15RIGHT,
				enabled   = true,
				
				strata    = nil,
				level     = 4,
				
				unit_id   = "raid8",
				party_id  = nil,
				raid_id	  = 8,
				
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
		},
		[nUI_UNITFRAME_RAID15.."9"] = 
		{
			anchor = 
			{
				anchor_pt   = "TOPRIGHT",
				relative_to = nUI_UNITFRAME_RAID15.."8_Feedback",
				relative_pt = "TOPLEFT",
				xOfs        = 0,
				yOfs        = 0,
			},
			options = 
			{
				skinName  = nUI_UNITSKIN_RAID15RIGHT,
				enabled   = true,
				
				strata    = nil,
				level     = 4,
				
				unit_id   = "raid9",
				party_id  = nil,
				raid_id	  = 9,
				
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
		[nUI_UNITFRAME_RAID15.."10"] = 
		{
			anchor = 
			{
				anchor_pt   = "TOPRIGHT",
				relative_to = nUI_UNITFRAME_RAID15.."8_Feedback",
				relative_pt = "BOTTOMRIGHT",
				xOfs        = 0,
				yOfs        = 0,
			},
			options = 
			{
				skinName  = nUI_UNITSKIN_RAID15RIGHT,
				enabled   = true,
				
				strata    = nil,
				level     = 4,
				
				unit_id   = "raid10",
				party_id  = nil,
				raid_id	  = 10,
				
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
		[nUI_UNITFRAME_RAID15.."11"] = 
		{
			anchor = 
			{
				anchor_pt   = "TOPRIGHT",
				relative_to = nUI_UNITFRAME_RAID15.."9_Feedback",
				relative_pt = "BOTTOMRIGHT",
				xOfs        = 0,
				yOfs        = 0,
			},
			options = 
			{
				skinName  = nUI_UNITSKIN_RAID15RIGHT,
				enabled   = true,
				
				strata    = nil,
				level     = 4,
				
				unit_id   = "raid11",
				party_id  = nil,
				raid_id	  = 11,
				
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
		[nUI_UNITFRAME_RAID15.."12"] = 
		{
			anchor = 
			{
				anchor_pt   = "TOPRIGHT",
				relative_to = nUI_UNITFRAME_RAID15.."10_Feedback",
				relative_pt = "BOTTOMRIGHT",
				xOfs        = 0,
				yOfs        = 0,
			},
			options = 
			{
				skinName  = nUI_UNITSKIN_RAID15RIGHT,
				enabled   = true,
				
				strata    = nil,
				level     = 4,
				
				unit_id   = "raid12",
				party_id  = nil,
				raid_id	  = 12,
				
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
		[nUI_UNITFRAME_RAID15.."13"] = 
		{
			anchor = 
			{
				anchor_pt   = "TOPRIGHT",
				relative_to = nUI_UNITFRAME_RAID15.."11_Feedback",
				relative_pt = "BOTTOMRIGHT",
				xOfs        = 0,
				yOfs        = 0,
			},
			options = 
			{
				skinName  = nUI_UNITSKIN_RAID15RIGHT,
				enabled   = true,
				
				strata    = nil,
				level     = 4,
				
				unit_id   = "raid13",
				party_id  = nil,
				raid_id	  = 13,
				
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
		[nUI_UNITFRAME_RAID15.."14"] = 
		{
			anchor = 
			{
				anchor_pt   = "TOPRIGHT",
				relative_to = nUI_UNITFRAME_RAID15.."12_Feedback",
				relative_pt = "BOTTOMRIGHT",
				xOfs        = 0,
				yOfs        = 0,
			},
			options = 
			{
				skinName  = nUI_UNITSKIN_RAID15RIGHT,
				enabled   = true,
				
				strata    = nil,
				level     = 4,
				
				unit_id   = "raid14",
				party_id  = nil,
				raid_id	  = 14,
				
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
		[nUI_UNITFRAME_RAID15.."15"] = 
		{
			anchor = 
			{
				anchor_pt   = "TOPRIGHT",
				relative_to = nUI_UNITFRAME_RAID15.."13_Feedback",
				relative_pt = "BOTTOMRIGHT",
				xOfs        = 0,
				yOfs        = 0,
			},
			options = 
			{
				skinName  = nUI_UNITSKIN_RAID15RIGHT,
				enabled   = true,
				
				strata    = nil,
				level     = 4,
				
				unit_id   = "raid15",
				party_id  = nil,
				raid_id	  = 15,
				
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
		[nUI_UNITFRAME_RAID15MOUSE] = 
		{
			anchor = 
			{
				anchor_pt   = "TOP",
				relative_to = nUI_UNITFRAME_RAID15FOCUS,
				relative_pt = "BOTTOM",
				xOfs        = 0,
				yOfs        = -7,
			},
			options = 
			{
				skinName  = nUI_UNITSKIN_RAID15MOUSE,
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
		[nUI_UNITFRAME_RAID15BOSS.."2"] = 
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
		[nUI_UNITFRAME_RAID15BOSS.."3"] = 
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
		[nUI_UNITFRAME_RAID15BOSS.."1"] = 
		{
			anchor = 
			{
				anchor_pt   = "RIGHT",
				relative_to = nUI_UNITFRAME_RAID15BOSS.."2",
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
		[nUI_UNITFRAME_RAID15BOSS.."4"] = 
		{
			anchor = 
			{
				anchor_pt   = "LEFT",
				relative_to = nUI_UNITFRAME_RAID15BOSS.."3",
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
