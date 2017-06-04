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

nUI_UnitPanels[nUI_UNITPANEL_RAID25] =
{
	desc     = nUI_L[nUI_UNITPANEL_RAID25],			 	-- player friendly name/description of the panel
	label    = nUI_L[nUI_UNITPANEL_RAID25.."Label"],	-- label to use on the panel selection button face
	rotation = nUI_UNITMODE_RAID25,						-- index or position this panel appears on/in when clicking the selector button
	enabled  = true,									-- whether or not the player has the panel enabled
	selected = true,									-- whether or not this is the currently selected panel
	automode = "raid25",								-- selects to automatically display this frame when player is in a raid of 16 to 20 members
	
	loadOrder =
	{
		[1]  = nUI_UNITFRAME_RAID25.."1",
		[2]  = nUI_UNITFRAME_RAID25P.."1",
		[3]  = nUI_UNITFRAME_RAID25T.."1",
		[4]  = nUI_UNITFRAME_RAID25.."2",
		[5]  = nUI_UNITFRAME_RAID25P.."2",
		[6]  = nUI_UNITFRAME_RAID25T.."2",
		[7]  = nUI_UNITFRAME_RAID25.."3",
		[8]  = nUI_UNITFRAME_RAID25P.."3",
		[9]  = nUI_UNITFRAME_RAID25T.."3",
		[10] = nUI_UNITFRAME_RAID25.."4",
		[11] = nUI_UNITFRAME_RAID25P.."4",
		[12] = nUI_UNITFRAME_RAID25T.."4",
		[13] = nUI_UNITFRAME_RAID25.."5",
		[14] = nUI_UNITFRAME_RAID25P.."5",
		[15] = nUI_UNITFRAME_RAID25T.."5",
		[16] = nUI_UNITFRAME_RAID25.."6",
		[17] = nUI_UNITFRAME_RAID25P.."6",
		[18] = nUI_UNITFRAME_RAID25T.."6",
		[19] = nUI_UNITFRAME_RAID25.."7",
		[20] = nUI_UNITFRAME_RAID25P.."7",
		[21] = nUI_UNITFRAME_RAID25T.."7",
		[22] = nUI_UNITFRAME_RAID25.."8",
		[23] = nUI_UNITFRAME_RAID25P.."8",
		[24] = nUI_UNITFRAME_RAID25T.."8",
		[25] = nUI_UNITFRAME_RAID25.."9",
		[26] = nUI_UNITFRAME_RAID25P.."9",
		[27] = nUI_UNITFRAME_RAID25T.."9",
		[28] = nUI_UNITFRAME_RAID25.."10",
		[29] = nUI_UNITFRAME_RAID25P.."10",
		[30] = nUI_UNITFRAME_RAID25T.."10",
		[31] = nUI_UNITFRAME_RAID25.."11",
		[32] = nUI_UNITFRAME_RAID25P.."11",
		[33] = nUI_UNITFRAME_RAID25T.."11",
		[34] = nUI_UNITFRAME_RAID25.."12",
		[35] = nUI_UNITFRAME_RAID25P.."12",
		[36] = nUI_UNITFRAME_RAID25T.."12",
		[37] = nUI_UNITFRAME_RAID25.."13",
		[38] = nUI_UNITFRAME_RAID25P.."13",
		[39] = nUI_UNITFRAME_RAID25T.."13",
		[40] = nUI_UNITFRAME_RAID25.."14",
		[41] = nUI_UNITFRAME_RAID25P.."14",
		[42] = nUI_UNITFRAME_RAID25T.."14",
		[43] = nUI_UNITFRAME_RAID25.."15",
		[44] = nUI_UNITFRAME_RAID25P.."15",
		[45] = nUI_UNITFRAME_RAID25T.."15",
		[46] = nUI_UNITFRAME_RAID25.."16",
		[47] = nUI_UNITFRAME_RAID25P.."16",
		[48] = nUI_UNITFRAME_RAID25T.."16",
		[49] = nUI_UNITFRAME_RAID25.."17",
		[50] = nUI_UNITFRAME_RAID25P.."17",
		[51] = nUI_UNITFRAME_RAID25T.."17",
		[52] = nUI_UNITFRAME_RAID25.."18",
		[53] = nUI_UNITFRAME_RAID25P.."18",
		[54] = nUI_UNITFRAME_RAID25T.."18",
		[55] = nUI_UNITFRAME_RAID25.."19",
		[56] = nUI_UNITFRAME_RAID25P.."19",
		[57] = nUI_UNITFRAME_RAID25T.."19",
		[58] = nUI_UNITFRAME_RAID25.."20",
		[59] = nUI_UNITFRAME_RAID25P.."20",
		[60] = nUI_UNITFRAME_RAID25T.."20",
		[61] = nUI_UNITFRAME_RAID25.."21",
		[62] = nUI_UNITFRAME_RAID25P.."21",
		[63] = nUI_UNITFRAME_RAID25T.."21",
		[64] = nUI_UNITFRAME_RAID25.."22",
		[65] = nUI_UNITFRAME_RAID25P.."22",
		[66] = nUI_UNITFRAME_RAID25T.."22",
		[67] = nUI_UNITFRAME_RAID25.."23",
		[68] = nUI_UNITFRAME_RAID25P.."23",
		[69] = nUI_UNITFRAME_RAID25T.."23",
		[70] = nUI_UNITFRAME_RAID25.."24",
		[71] = nUI_UNITFRAME_RAID25P.."24",
		[72] = nUI_UNITFRAME_RAID25T.."24",
		[73] = nUI_UNITFRAME_RAID25.."25",
		[74] = nUI_UNITFRAME_RAID25P.."25",
		[75] = nUI_UNITFRAME_RAID25T.."25",
		[76] = nUI_UNITFRAME_RAID25PLAYER,
		[77] = nUI_UNITFRAME_RAID25PET,
		[78] = nUI_UNITFRAME_RAID25PETT,
		[79] = nUI_UNITFRAME_RAID25VEHICLE,
		[80] = nUI_UNITFRAME_RAID25TARGET,
		[81] = nUI_UNITFRAME_RAID25TARGETP,
		[82] = nUI_UNITFRAME_RAID25TOT,
		[83] = nUI_UNITFRAME_RAID25TOTT,
		[84] = nUI_UNITFRAME_RAID25FOCUS,
		[85] = nUI_UNITFRAME_RAID25FOCUSP,
		[86] = nUI_UNITFRAME_RAID25FOCUST,
		[87] = nUI_UNITFRAME_RAID25MOUSE,
		[88] = nUI_UNITFRAME_RAID25BOSS.."2",
		[89] = nUI_UNITFRAME_RAID25BOSS.."3",
		[90] = nUI_UNITFRAME_RAID25BOSS.."1",
		[91] = nUI_UNITFRAME_RAID25BOSS.."4",
	},
	
	units =
	{
		[nUI_UNITFRAME_RAID25.."1"] = 
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
				skinName  = nUI_UNITSKIN_RAID25LEFT,
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
		[nUI_UNITFRAME_RAID25.."2"] = 
		{
			anchor = 
			{
				anchor_pt   = "TOPLEFT",
				relative_to = nUI_UNITFRAME_RAID25.."1_Feedback",
				relative_pt = "TOPRIGHT",
				xOfs        = 0,
				yOfs        = 0,
			},
			options = 
			{
				skinName  = nUI_UNITSKIN_RAID25LEFT,
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
		[nUI_UNITFRAME_RAID25.."3"] = 
		{
			anchor = 
			{
				anchor_pt   = "TOPLEFT",
				relative_to = nUI_UNITFRAME_RAID25.."2_Feedback",
				relative_pt = "TOPRIGHT",
				xOfs        = 0,
				yOfs        = 0,
			},
			options = 
			{
				skinName  = nUI_UNITSKIN_RAID25LEFT,
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
		[nUI_UNITFRAME_RAID25.."4"] = 
		{
			anchor = 
			{
				anchor_pt   = "TOPLEFT",
				relative_to = nUI_UNITFRAME_RAID25.."3_Feedback",
				relative_pt = "TOPRIGHT",
				xOfs        = 0,
				yOfs        = 0,
			},
			options = 
			{
				skinName  = nUI_UNITSKIN_RAID25LEFT,
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
		[nUI_UNITFRAME_RAID25.."5"] = 
		{
			anchor = 
			{
				anchor_pt   = "TOPLEFT",
				relative_to = nUI_UNITFRAME_RAID25.."1_Feedback",
				relative_pt = "BOTTOMLEFT",
				xOfs        = 0,
				yOfs        = 0,
			},
			options = 
			{
				skinName  = nUI_UNITSKIN_RAID25LEFT,
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
		[nUI_UNITFRAME_RAID25.."6"] = 
		{
			anchor = 
			{
				anchor_pt   = "TOPLEFT",
				relative_to = nUI_UNITFRAME_RAID25.."2_Feedback",
				relative_pt = "BOTTOMLEFT",
				xOfs        = 0,
				yOfs        = 0,
			},
			options = 
			{
				skinName  = nUI_UNITSKIN_RAID25LEFT,
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
		[nUI_UNITFRAME_RAID25.."7"] = 
		{
			anchor = 
			{
				anchor_pt   = "TOPLEFT",
				relative_to = nUI_UNITFRAME_RAID25.."3_Feedback",
				relative_pt = "BOTTOMLEFT",
				xOfs        = 0,
				yOfs        = 0,
			},
			options = 
			{
				skinName  = nUI_UNITSKIN_RAID25LEFT,
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
		[nUI_UNITFRAME_RAID25.."8"] = 
		{
			anchor = 
			{
				anchor_pt   = "TOPLEFT",
				relative_to = nUI_UNITFRAME_RAID25.."4_Feedback",
				relative_pt = "BOTTOMLEFT",
				xOfs        = 0,
				yOfs        = 0,
			},
			options = 
			{
				skinName  = nUI_UNITSKIN_RAID25LEFT,
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
			},
		},
		[nUI_UNITFRAME_RAID25.."9"] = 
		{
			anchor = 
			{
				anchor_pt   = "TOPLEFT",
				relative_to = nUI_UNITFRAME_RAID25.."5_Feedback",
				relative_pt = "BOTTOMLEFT",
				xOfs        = 0,
				yOfs        = 0,
			},
			options = 
			{
				skinName  = nUI_UNITSKIN_RAID25LEFT,
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
		[nUI_UNITFRAME_RAID25.."10"] = 
		{
			anchor = 
			{
				anchor_pt   = "TOPLEFT",
				relative_to = nUI_UNITFRAME_RAID25.."6_Feedback",
				relative_pt = "BOTTOMLEFT",
				xOfs        = 0,
				yOfs        = 0,
			},
			options = 
			{
				skinName  = nUI_UNITSKIN_RAID25LEFT,
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
		[nUI_UNITFRAME_RAID25.."11"] = 
		{
			anchor = 
			{
				anchor_pt   = "TOPLEFT",
				relative_to = nUI_UNITFRAME_RAID25.."7_Feedback",
				relative_pt = "BOTTOMLEFT",
				xOfs        = 0,
				yOfs        = 0,
			},
			options = 
			{
				skinName  = nUI_UNITSKIN_RAID25LEFT,
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
		[nUI_UNITFRAME_RAID25.."12"] = 
		{
			anchor = 
			{
				anchor_pt   = "TOPLEFT",
				relative_to = nUI_UNITFRAME_RAID25.."8_Feedback",
				relative_pt = "BOTTOMLEFT",
				xOfs        = 0,
				yOfs        = 0,
			},
			options = 
			{
				skinName  = nUI_UNITSKIN_RAID25LEFT,
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
		[nUI_UNITFRAME_RAID25PLAYER] = 
		{
			anchor = 
			{
				anchor_pt   = "TOPRIGHT",
				relative_to = nUI_UNITFRAME_RAID25MOUSE,
				relative_pt = "TOPLEFT",
				xOfs        = -7,
				yOfs        = 0,
			},
			options = 
			{
				skinName  = nUI_UNITSKIN_RAID25PLAYER,
				enabled   = true,
				
				strata    = nil,
				level     = 4,
				
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
		[nUI_UNITFRAME_RAID25VEHICLE] = 
		{
			anchor = 
			{
				anchor_pt   = "TOPRIGHT",
				relative_to = nUI_UNITFRAME_RAID25PLAYER,
				relative_pt = "TOPLEFT",
				xOfs        = -7,
				yOfs        = 0,
			},
			options = 
			{
				skinName  = nUI_UNITSKIN_RAID25VEHICLE,
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
		[nUI_UNITFRAME_RAID25PET] = 
		{
			anchor = 
			{
				anchor_pt   = "TOPRIGHT",
				relative_to = nUI_UNITFRAME_RAID25PLAYER,
				relative_pt = "TOPLEFT",
				xOfs        = -7,
				yOfs        = 0,
			},
			options = 
			{
				skinName  = nUI_UNITSKIN_RAID25PET,
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
		[nUI_UNITFRAME_RAID25TARGET] = 
		{
			anchor = 
			{
				anchor_pt   = "TOPLEFT",
				relative_to = nUI_UNITFRAME_RAID25MOUSE,
				relative_pt = "TOPRIGHT",
				xOfs        = 7,
				yOfs        = 0,
			},
			options = 
			{
				skinName  = nUI_UNITSKIN_RAID25TARGET,
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
		[nUI_UNITFRAME_RAID25TOT] = 
		{
			anchor = 
			{
				anchor_pt   = "TOPLEFT",
				relative_to = nUI_UNITFRAME_RAID25TARGET,
				relative_pt = "TOPRIGHT",
				xOfs        = 7,
				yOfs        = 0,
			},
			options = 
			{
				skinName  = nUI_UNITSKIN_RAID25TOT,
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
		[nUI_UNITFRAME_RAID25FOCUS] = 
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
				skinName  = nUI_UNITSKIN_RAID25FOCUS,
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
		[nUI_UNITFRAME_RAID25FOCUST] = 
		{
			anchor = 
			{
				anchor_pt   = "TOPRIGHT",
				relative_to = nUI_UNITFRAME_RAID25FOCUS.."_Label",
				relative_pt = "BOTTOMRIGHT",
				xOfs        = -5,
				yOfs        = -1,
			},
			options = 
			{
				skinName  = nUI_UNITSKIN_RAID25TGTBUTTON,
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
		[nUI_UNITFRAME_RAID25.."13"] = 
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
				skinName  = nUI_UNITSKIN_RAID25RIGHT,
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
		[nUI_UNITFRAME_RAID25.."14"] = 
		{
			anchor = 
			{
				anchor_pt   = "TOPRIGHT",
				relative_to = nUI_UNITFRAME_RAID25.."13_Feedback",
				relative_pt = "TOPLEFT",
				xOfs        = 0,
				yOfs        = 0,
			},
			options = 
			{
				skinName  = nUI_UNITSKIN_RAID25RIGHT,
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
		[nUI_UNITFRAME_RAID25.."15"] = 
		{
			anchor = 
			{
				anchor_pt   = "TOPRIGHT",
				relative_to = nUI_UNITFRAME_RAID25.."14_Feedback",
				relative_pt = "TOPLEFT",
				xOfs        = 0,
				yOfs        = 0,
			},
			options = 
			{
				skinName  = nUI_UNITSKIN_RAID25RIGHT,
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
		[nUI_UNITFRAME_RAID25.."16"] = 
		{
			anchor = 
			{
				anchor_pt   = "TOPRIGHT",
				relative_to = nUI_UNITFRAME_RAID25.."15_Feedback",
				relative_pt = "TOPLEFT",
				xOfs        = 0,
				yOfs        = 0,
			},
			options = 
			{
				skinName  = nUI_UNITSKIN_RAID25RIGHT,
				enabled   = true,
				
				strata    = nil,
				level     = 4,
				
				unit_id   = "raid16",
				party_id  = nil,
				raid_id	  = 16,
				
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
		[nUI_UNITFRAME_RAID25.."17"] = 
		{
			anchor = 
			{
				anchor_pt   = "TOPRIGHT",
				relative_to = nUI_UNITFRAME_RAID25.."13_Feedback",
				relative_pt = "BOTTOMRIGHT",
				xOfs        = 0,
				yOfs        = 0,
			},
			options = 
			{
				skinName  = nUI_UNITSKIN_RAID25RIGHT,
				enabled   = true,
				
				strata    = nil,
				level     = 4,
				
				unit_id   = "raid17",
				party_id  = nil,
				raid_id	  = 17,
				
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
		[nUI_UNITFRAME_RAID25.."18"] = 
		{
			anchor = 
			{
				anchor_pt   = "TOPRIGHT",
				relative_to = nUI_UNITFRAME_RAID25.."14_Feedback",
				relative_pt = "BOTTOMRIGHT",
				xOfs        = 0,
				yOfs        = 0,
			},
			options = 
			{
				skinName  = nUI_UNITSKIN_RAID25RIGHT,
				enabled   = true,
				
				strata    = nil,
				level     = 4,
				
				unit_id   = "raid18",
				party_id  = nil,
				raid_id	  = 18,
				
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
		[nUI_UNITFRAME_RAID25.."19"] = 
		{
			anchor = 
			{
				anchor_pt   = "TOPRIGHT",
				relative_to = nUI_UNITFRAME_RAID25.."15_Feedback",
				relative_pt = "BOTTOMRIGHT",
				xOfs        = 0,
				yOfs        = 0,
			},
			options = 
			{
				skinName  = nUI_UNITSKIN_RAID25RIGHT,
				enabled   = true,
				
				strata    = nil,
				level     = 4,
				
				unit_id   = "raid19",
				party_id  = nil,
				raid_id	  = 19,
				
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
		[nUI_UNITFRAME_RAID25.."20"] = 
		{
			anchor = 
			{
				anchor_pt   = "TOPRIGHT",
				relative_to = nUI_UNITFRAME_RAID25.."16_Feedback",
				relative_pt = "BOTTOMRIGHT",
				xOfs        = 0,
				yOfs        = 0,
			},
			options = 
			{
				skinName  = nUI_UNITSKIN_RAID25RIGHT,
				enabled   = true,
				
				strata    = nil,
				level     = 4,
				
				unit_id   = "raid20",
				party_id  = nil,
				raid_id	  = 20,
				
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
		[nUI_UNITFRAME_RAID25.."21"] = 
		{
			anchor = 
			{
				anchor_pt   = "TOPRIGHT",
				relative_to = nUI_UNITFRAME_RAID25.."17_Feedback",
				relative_pt = "BOTTOMRIGHT",
				xOfs        = 0,
				yOfs        = 0,
			},
			options = 
			{
				skinName  = nUI_UNITSKIN_RAID25RIGHT,
				enabled   = true,
				
				strata    = nil,
				level     = 4,
				
				unit_id   = "raid21",
				party_id  = nil,
				raid_id	  = 21,
				
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
		[nUI_UNITFRAME_RAID25.."22"] = 
		{
			anchor = 
			{
				anchor_pt   = "TOPRIGHT",
				relative_to = nUI_UNITFRAME_RAID25.."18_Feedback",
				relative_pt = "BOTTOMRIGHT",
				xOfs        = 0,
				yOfs        = 0,
			},
			options = 
			{
				skinName  = nUI_UNITSKIN_RAID25RIGHT,
				enabled   = true,
				
				strata    = nil,
				level     = 4,
				
				unit_id   = "raid22",
				party_id  = nil,
				raid_id	  = 22,
				
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
		[nUI_UNITFRAME_RAID25.."23"] = 
		{
			anchor = 
			{
				anchor_pt   = "TOPRIGHT",
				relative_to = nUI_UNITFRAME_RAID25.."19_Feedback",
				relative_pt = "BOTTOMRIGHT",
				xOfs        = 0,
				yOfs        = 0,
			},
			options = 
			{
				skinName  = nUI_UNITSKIN_RAID25RIGHT,
				enabled   = true,
				
				strata    = nil,
				level     = 4,
				
				unit_id   = "raid23",
				party_id  = nil,
				raid_id	  = 23,
				
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
		[nUI_UNITFRAME_RAID25.."24"] = 
		{
			anchor = 
			{
				anchor_pt   = "TOPRIGHT",
				relative_to = nUI_UNITFRAME_RAID25.."20_Feedback",
				relative_pt = "BOTTOMRIGHT",
				xOfs        = 0,
				yOfs        = 0,
			},
			options = 
			{
				skinName  = nUI_UNITSKIN_RAID25RIGHT,
				enabled   = true,
				
				strata    = nil,
				level     = 4,
				
				unit_id   = "raid24",
				party_id  = nil,
				raid_id	  = 24,
				
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
		[nUI_UNITFRAME_RAID25MOUSE] = 
		{
			anchor = 
			{
				anchor_pt   = "TOP",
				relative_to = nUI_UNITFRAME_RAID25FOCUS,
				relative_pt = "BOTTOM",
				xOfs        = 0,
				yOfs        = -7,
			},
			options = 
			{
				skinName  = nUI_UNITSKIN_RAID25MOUSE,
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
		[nUI_UNITFRAME_RAID25BOSS.."2"] = 
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
		[nUI_UNITFRAME_RAID25BOSS.."3"] = 
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
		[nUI_UNITFRAME_RAID25BOSS.."1"] = 
		{
			anchor = 
			{
				anchor_pt   = "RIGHT",
				relative_to = nUI_UNITFRAME_RAID25BOSS.."2",
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
		[nUI_UNITFRAME_RAID25BOSS.."4"] = 
		{
			anchor = 
			{
				anchor_pt   = "LEFT",
				relative_to = nUI_UNITFRAME_RAID25BOSS.."3",
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
