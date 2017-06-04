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

nUI_UnitPanels[nUI_UNITPANEL_RAID40] =
{
	desc     = nUI_L[nUI_UNITPANEL_RAID40],			 	-- player friendly name/description of the panel
	label    = nUI_L[nUI_UNITPANEL_RAID40.."Label"],	-- label to use on the panel selection button face
	rotation = nUI_UNITMODE_RAID40,						-- index or position this panel appears on/in when clicking the selector button
	enabled  = true,									-- whether or not the player has the panel enabled
	selected = true,									-- whether or not this is the currently selected panel
	automode = "raid40",								-- selects to automatically display this frame when player is in a raid of 16 to 20 members
	
	loadOrder =
	 {
		[1]   = nUI_UNITFRAME_RAID40.."1",
		[2]   = nUI_UNITFRAME_RAID40P.."1",
		[3]   = nUI_UNITFRAME_RAID40T.."1",
		[4]   = nUI_UNITFRAME_RAID40.."2",
		[5]   = nUI_UNITFRAME_RAID40P.."2",
		[6]   = nUI_UNITFRAME_RAID40T.."2",
		[7]   = nUI_UNITFRAME_RAID40.."3",
		[8]   = nUI_UNITFRAME_RAID40P.."3",
		[9]   = nUI_UNITFRAME_RAID40T.."3",
		[10]  = nUI_UNITFRAME_RAID40.."4",
		[11]  = nUI_UNITFRAME_RAID40P.."4",
		[12]  = nUI_UNITFRAME_RAID40T.."4",
		[13]  = nUI_UNITFRAME_RAID40.."5",
		[14]  = nUI_UNITFRAME_RAID40P.."5",
		[15]  = nUI_UNITFRAME_RAID40T.."5",
		[16]  = nUI_UNITFRAME_RAID40.."6",
		[17]  = nUI_UNITFRAME_RAID40P.."6",
		[18]  = nUI_UNITFRAME_RAID40T.."6",
		[19]  = nUI_UNITFRAME_RAID40.."7",
		[20]  = nUI_UNITFRAME_RAID40P.."7",
		[21]  = nUI_UNITFRAME_RAID40T.."7",
		[22]  = nUI_UNITFRAME_RAID40.."8",
		[23]  = nUI_UNITFRAME_RAID40P.."8",
		[24]  = nUI_UNITFRAME_RAID40T.."8",
		[25]  = nUI_UNITFRAME_RAID40.."9",
		[26]  = nUI_UNITFRAME_RAID40P.."9",
		[27]  = nUI_UNITFRAME_RAID40T.."9",
		[28]  = nUI_UNITFRAME_RAID40.."10",
		[29]  = nUI_UNITFRAME_RAID40P.."10",
		[30]  = nUI_UNITFRAME_RAID40T.."10",
		[31]  = nUI_UNITFRAME_RAID40.."11",
		[32]  = nUI_UNITFRAME_RAID40P.."11",
		[33]  = nUI_UNITFRAME_RAID40T.."11",
		[34]  = nUI_UNITFRAME_RAID40.."12",
		[35]  = nUI_UNITFRAME_RAID40P.."12",
		[36]  = nUI_UNITFRAME_RAID40T.."12",
		[37]  = nUI_UNITFRAME_RAID40.."13",
		[38]  = nUI_UNITFRAME_RAID40P.."13",
		[39]  = nUI_UNITFRAME_RAID40T.."13",
		[40]  = nUI_UNITFRAME_RAID40.."14",
		[41]  = nUI_UNITFRAME_RAID40P.."14",
		[42]  = nUI_UNITFRAME_RAID40T.."14",
		[43]  = nUI_UNITFRAME_RAID40.."15",
		[44]  = nUI_UNITFRAME_RAID40P.."15",
		[45]  = nUI_UNITFRAME_RAID40T.."15",
		[46]  = nUI_UNITFRAME_RAID40.."16",
		[47]  = nUI_UNITFRAME_RAID40P.."16",
		[48]  = nUI_UNITFRAME_RAID40T.."16",
		[49]  = nUI_UNITFRAME_RAID40.."17",
		[50]  = nUI_UNITFRAME_RAID40P.."17",
		[51]  = nUI_UNITFRAME_RAID40T.."17",
		[52]  = nUI_UNITFRAME_RAID40.."18",
		[53]  = nUI_UNITFRAME_RAID40P.."18",
		[54]  = nUI_UNITFRAME_RAID40T.."18",
		[55]  = nUI_UNITFRAME_RAID40.."19",
		[56]  = nUI_UNITFRAME_RAID40P.."19",
		[57]  = nUI_UNITFRAME_RAID40T.."19",
		[58]  = nUI_UNITFRAME_RAID40.."20",
		[59]  = nUI_UNITFRAME_RAID40P.."20",
		[60]  = nUI_UNITFRAME_RAID40T.."20",
		[61]  = nUI_UNITFRAME_RAID40.."21",
		[62]  = nUI_UNITFRAME_RAID40P.."21",
		[63]  = nUI_UNITFRAME_RAID40T.."21",
		[64]  = nUI_UNITFRAME_RAID40.."22",
		[65]  = nUI_UNITFRAME_RAID40P.."22",
		[66]  = nUI_UNITFRAME_RAID40T.."22",
		[67]  = nUI_UNITFRAME_RAID40.."23",
		[68]  = nUI_UNITFRAME_RAID40P.."23",
		[69]  = nUI_UNITFRAME_RAID40T.."23",
		[70]  = nUI_UNITFRAME_RAID40.."24",
		[71]  = nUI_UNITFRAME_RAID40P.."24",
		[72]  = nUI_UNITFRAME_RAID40T.."24",
		[73]  = nUI_UNITFRAME_RAID40.."25",
		[74]  = nUI_UNITFRAME_RAID40P.."25",
		[75]  = nUI_UNITFRAME_RAID40T.."25",
		[76]  = nUI_UNITFRAME_RAID40.."26",
		[77]  = nUI_UNITFRAME_RAID40P.."26",
		[78]  = nUI_UNITFRAME_RAID40T.."26",
		[79]  = nUI_UNITFRAME_RAID40.."27",
		[80]  = nUI_UNITFRAME_RAID40P.."27",
		[81]  = nUI_UNITFRAME_RAID40T.."27",
		[82]  = nUI_UNITFRAME_RAID40.."28",
		[83]  = nUI_UNITFRAME_RAID40P.."28",
		[84]  = nUI_UNITFRAME_RAID40T.."28",
		[85]  = nUI_UNITFRAME_RAID40.."29",
		[86]  = nUI_UNITFRAME_RAID40P.."29",
		[87]  = nUI_UNITFRAME_RAID40T.."29",
		[88]  = nUI_UNITFRAME_RAID40.."30",
		[89]  = nUI_UNITFRAME_RAID40P.."30",
		[90]  = nUI_UNITFRAME_RAID40T.."30",
		[91]  = nUI_UNITFRAME_RAID40.."31",
		[92]  = nUI_UNITFRAME_RAID40P.."31",
		[93]  = nUI_UNITFRAME_RAID40T.."31",
		[94]  = nUI_UNITFRAME_RAID40.."32",
		[95]  = nUI_UNITFRAME_RAID40P.."32",
		[96]  = nUI_UNITFRAME_RAID40T.."32",
		[97]  = nUI_UNITFRAME_RAID40.."33",
		[98]  = nUI_UNITFRAME_RAID40P.."33",
		[99]  = nUI_UNITFRAME_RAID40T.."33",
		[100] = nUI_UNITFRAME_RAID40.."34",
		[101] = nUI_UNITFRAME_RAID40P.."34",
		[102] = nUI_UNITFRAME_RAID40T.."34",
		[103] = nUI_UNITFRAME_RAID40.."35",
		[104] = nUI_UNITFRAME_RAID40P.."35",
		[105] = nUI_UNITFRAME_RAID40T.."35",
		[106] = nUI_UNITFRAME_RAID40.."36",
		[107] = nUI_UNITFRAME_RAID40P.."36",
		[108] = nUI_UNITFRAME_RAID40T.."36",
		[109] = nUI_UNITFRAME_RAID40.."37",
		[110] = nUI_UNITFRAME_RAID40P.."37",
		[111] = nUI_UNITFRAME_RAID40T.."37",
		[112] = nUI_UNITFRAME_RAID40.."38",
		[113] = nUI_UNITFRAME_RAID40P.."38",
		[114] = nUI_UNITFRAME_RAID40T.."38",
		[115] = nUI_UNITFRAME_RAID40.."39",
		[116] = nUI_UNITFRAME_RAID40P.."39",
		[117] = nUI_UNITFRAME_RAID40T.."39",
		[118] = nUI_UNITFRAME_RAID40.."40",
		[119] = nUI_UNITFRAME_RAID40P.."40",
		[120] = nUI_UNITFRAME_RAID40T.."40",
		[121] = nUI_UNITFRAME_RAID40PLAYER,
		[122] = nUI_UNITFRAME_RAID40PET,
		[123] = nUI_UNITFRAME_RAID40PETT,
		[124] = nUI_UNITFRAME_RAID40VEHICLE,
		[125] = nUI_UNITFRAME_RAID40TARGET,
		[126] = nUI_UNITFRAME_RAID40TARGETP,
		[127] = nUI_UNITFRAME_RAID40TOT,
		[128] = nUI_UNITFRAME_RAID40TOTT,
		[129] = nUI_UNITFRAME_RAID40FOCUS,
		[130] = nUI_UNITFRAME_RAID40FOCUSP,
		[131] = nUI_UNITFRAME_RAID40FOCUST,
		[132] = nUI_UNITFRAME_RAID40MOUSE,
		[133] = nUI_UNITFRAME_RAID40BOSS.."2",
		[134] = nUI_UNITFRAME_RAID40BOSS.."3",
		[135] = nUI_UNITFRAME_RAID40BOSS.."1",
		[136] = nUI_UNITFRAME_RAID40BOSS.."4",
	},
	
	units =
	{
		[nUI_UNITFRAME_RAID40.."1"] = 
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
				skinName  = nUI_UNITSKIN_RAID40LEFT,
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
		[nUI_UNITFRAME_RAID40.."2"] = 
		{
			anchor = 
			{
				anchor_pt   = "TOPLEFT",
				relative_to = nUI_UNITFRAME_RAID40.."1_Feedback",
				relative_pt = "TOPRIGHT",
				xOfs        = 0,
				yOfs        = 0,
			},
			options = 
			{
				skinName  = nUI_UNITSKIN_RAID40LEFT,
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
		[nUI_UNITFRAME_RAID40.."3"] = 
		{
			anchor = 
			{
				anchor_pt   = "TOPLEFT",
				relative_to = nUI_UNITFRAME_RAID40.."2_Feedback",
				relative_pt = "TOPRIGHT",
				xOfs        = 0,
				yOfs        = 0,
			},
			options = 
			{
				skinName  = nUI_UNITSKIN_RAID40LEFT,
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
		[nUI_UNITFRAME_RAID40.."4"] = 
		{
			anchor = 
			{
				anchor_pt   = "TOPLEFT",
				relative_to = nUI_UNITFRAME_RAID40.."3_Feedback",
				relative_pt = "TOPRIGHT",
				xOfs        = 0,
				yOfs        = 0,
			},
			options = 
			{
				skinName  = nUI_UNITSKIN_RAID40LEFT,
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
		[nUI_UNITFRAME_RAID40.."5"] = 
		{
			anchor = 
			{
				anchor_pt   = "TOPLEFT",
				relative_to = nUI_UNITFRAME_RAID40.."4_Feedback",
				relative_pt = "TOPRIGHT",
				xOfs        = 0,
				yOfs        = 0,
			},
			options = 
			{
				skinName  = nUI_UNITSKIN_RAID40LEFT,
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
		[nUI_UNITFRAME_RAID40.."6"] = 
		{
			anchor = 
			{
				anchor_pt   = "TOPLEFT",
				relative_to = nUI_UNITFRAME_RAID40.."1_Feedback",
				relative_pt = "BOTTOMLEFT",
				xOfs        = 0,
				yOfs        = 0,
			},
			options = 
			{
				skinName  = nUI_UNITSKIN_RAID40LEFT,
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
		[nUI_UNITFRAME_RAID40.."7"] = 
		{
			anchor = 
			{
				anchor_pt   = "TOPLEFT",
				relative_to = nUI_UNITFRAME_RAID40.."2_Feedback",
				relative_pt = "BOTTOMLEFT",
				xOfs        = 0,
				yOfs        = 0,
			},
			options = 
			{
				skinName  = nUI_UNITSKIN_RAID40LEFT,
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
		[nUI_UNITFRAME_RAID40.."8"] = 
		{
			anchor = 
			{
				anchor_pt   = "TOPLEFT",
				relative_to = nUI_UNITFRAME_RAID40.."3_Feedback",
				relative_pt = "BOTTOMLEFT",
				xOfs        = 0,
				yOfs        = 0,
			},
			options = 
			{
				skinName  = nUI_UNITSKIN_RAID40LEFT,
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
		[nUI_UNITFRAME_RAID40.."9"] = 
		{
			anchor = 
			{
				anchor_pt   = "TOPLEFT",
				relative_to = nUI_UNITFRAME_RAID40.."4_Feedback",
				relative_pt = "BOTTOMLEFT",
				xOfs        = 0,
				yOfs        = 0,
			},
			options = 
			{
				skinName  = nUI_UNITSKIN_RAID40LEFT,
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
		[nUI_UNITFRAME_RAID40.."10"] = 
		{
			anchor = 
			{
				anchor_pt   = "TOPLEFT",
				relative_to = nUI_UNITFRAME_RAID40.."5_Feedback",
				relative_pt = "BOTTOMLEFT",
				xOfs        = 0,
				yOfs        = 0,
			},
			options = 
			{
				skinName  = nUI_UNITSKIN_RAID40LEFT,
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
		[nUI_UNITFRAME_RAID40.."11"] = 
		{
			anchor = 
			{
				anchor_pt   = "TOPLEFT",
				relative_to = nUI_UNITFRAME_RAID40.."6_Feedback",
				relative_pt = "BOTTOMLEFT",
				xOfs        = 0,
				yOfs        = 0,
			},
			options = 
			{
				skinName  = nUI_UNITSKIN_RAID40LEFT,
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
		[nUI_UNITFRAME_RAID40.."12"] = 
		{
			anchor = 
			{
				anchor_pt   = "TOPLEFT",
				relative_to = nUI_UNITFRAME_RAID40.."7_Feedback",
				relative_pt = "BOTTOMLEFT",
				xOfs        = 0,
				yOfs        = 0,
			},
			options = 
			{
				skinName  = nUI_UNITSKIN_RAID40LEFT,
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
		[nUI_UNITFRAME_RAID40.."13"] = 
		{
			anchor = 
			{
				anchor_pt   = "TOPLEFT",
				relative_to = nUI_UNITFRAME_RAID40.."8_Feedback",
				relative_pt = "BOTTOMLEFT",
				xOfs        = 0,
				yOfs        = 0,
			},
			options = 
			{
				skinName  = nUI_UNITSKIN_RAID40LEFT,
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
		[nUI_UNITFRAME_RAID40.."14"] = 
		{
			anchor = 
			{
				anchor_pt   = "TOPLEFT",
				relative_to = nUI_UNITFRAME_RAID40.."9_Feedback",
				relative_pt = "BOTTOMLEFT",
				xOfs        = 0,
				yOfs        = 0,
			},
			options = 
			{
				skinName  = nUI_UNITSKIN_RAID40LEFT,
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
		[nUI_UNITFRAME_RAID40.."15"] = 
		{
			anchor = 
			{
				anchor_pt   = "TOPLEFT",
				relative_to = nUI_UNITFRAME_RAID40.."10_Feedback",
				relative_pt = "BOTTOMLEFT",
				xOfs        = 0,
				yOfs        = 0,
			},
			options = 
			{
				skinName  = nUI_UNITSKIN_RAID40LEFT,
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
		[nUI_UNITFRAME_RAID40.."16"] = 
		{
			anchor = 
			{
				anchor_pt   = "TOPLEFT",
				relative_to = nUI_UNITFRAME_RAID40.."11_Feedback",
				relative_pt = "BOTTOMLEFT",
				xOfs        = 0,
				yOfs        = 0,
			},
			options = 
			{
				skinName  = nUI_UNITSKIN_RAID40LEFT,
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
		[nUI_UNITFRAME_RAID40.."17"] = 
		{
			anchor = 
			{
				anchor_pt   = "TOPLEFT",
				relative_to = nUI_UNITFRAME_RAID40.."12_Feedback",
				relative_pt = "BOTTOMLEFT",
				xOfs        = 0,
				yOfs        = 0,
			},
			options = 
			{
				skinName  = nUI_UNITSKIN_RAID40LEFT,
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
		[nUI_UNITFRAME_RAID40.."18"] = 
		{
			anchor = 
			{
				anchor_pt   = "TOPLEFT",
				relative_to = nUI_UNITFRAME_RAID40.."13_Feedback",
				relative_pt = "BOTTOMLEFT",
				xOfs        = 0,
				yOfs        = 0,
			},
			options = 
			{
				skinName  = nUI_UNITSKIN_RAID40LEFT,
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
		[nUI_UNITFRAME_RAID40.."19"] = 
		{
			anchor = 
			{
				anchor_pt   = "TOPLEFT",
				relative_to = nUI_UNITFRAME_RAID40.."14_Feedback",
				relative_pt = "BOTTOMLEFT",
				xOfs        = 0,
				yOfs        = 0,
			},
			options = 
			{
				skinName  = nUI_UNITSKIN_RAID40LEFT,
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
		[nUI_UNITFRAME_RAID40.."20"] = 
		{
			anchor = 
			{
				anchor_pt   = "TOPLEFT",
				relative_to = nUI_UNITFRAME_RAID40.."15_Feedback",
				relative_pt = "BOTTOMLEFT",
				xOfs        = 0,
				yOfs        = 0,
			},
			options = 
			{
				skinName  = nUI_UNITSKIN_RAID40LEFT,
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
		[nUI_UNITFRAME_RAID40PLAYER] = 
		{
			anchor = 
			{
				anchor_pt   = "TOPRIGHT",
				relative_to = nUI_UNITFRAME_RAID40MOUSE,
				relative_pt = "TOPLEFT",
				xOfs        = -7,
				yOfs        = 0,
			},
			options = 
			{
				skinName  = nUI_UNITSKIN_RAID40PLAYER,
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
		[nUI_UNITFRAME_RAID40VEHICLE] = 
		{
			anchor = 
			{
				anchor_pt   = "TOPRIGHT",
				relative_to = nUI_UNITFRAME_RAID40PLAYER,
				relative_pt = "TOPLEFT",
				xOfs        = -7,
				yOfs        = 0,
			},
			options = 
			{
				skinName  = nUI_UNITSKIN_RAID40VEHICLE,
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
		[nUI_UNITFRAME_RAID40PET] = 
		{
			anchor = 
			{
				anchor_pt   = "TOPRIGHT",
				relative_to = nUI_UNITFRAME_RAID40PLAYER,
				relative_pt = "TOPLEFT",
				xOfs        = -7,
				yOfs        = 0,
			},
			options = 
			{
				skinName  = nUI_UNITSKIN_RAID40PET,
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
		[nUI_UNITFRAME_RAID40TARGET] = 
		{
			anchor = 
			{
				anchor_pt   = "TOPLEFT",
				relative_to = nUI_UNITFRAME_RAID40MOUSE,
				relative_pt = "TOPRIGHT",
				xOfs        = 7,
				yOfs        = 0,
			},
			options = 
			{
				skinName  = nUI_UNITSKIN_RAID40TARGET,
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
		[nUI_UNITFRAME_RAID40TOT] = 
		{
			anchor = 
			{
				anchor_pt   = "TOPLEFT",
				relative_to = nUI_UNITFRAME_RAID40TARGET,
				relative_pt = "TOPRIGHT",
				xOfs        = 7,
				yOfs        = 0,
			},
			options = 
			{
				skinName  = nUI_UNITSKIN_RAID40TOT,
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
		[nUI_UNITFRAME_RAID40FOCUS] = 
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
				skinName  = nUI_UNITSKIN_RAID40FOCUS,
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
		[nUI_UNITFRAME_RAID40FOCUST] = 
		{
			anchor = 
			{
				anchor_pt   = "TOPRIGHT",
				relative_to = nUI_UNITFRAME_RAID40FOCUS.."_Label",
				relative_pt = "BOTTOMRIGHT",
				xOfs        = -5,
				yOfs        = -1,
			},
			options = 
			{
				skinName  = nUI_UNITSKIN_RAID40TGTBUTTON,
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
		[nUI_UNITFRAME_RAID40.."21"] = 
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
				skinName  = nUI_UNITSKIN_RAID40RIGHT,
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
		[nUI_UNITFRAME_RAID40.."22"] = 
		{
			anchor = 
			{
				anchor_pt   = "TOPRIGHT",
				relative_to = nUI_UNITFRAME_RAID40.."21_Feedback",
				relative_pt = "TOPLEFT",
				xOfs        = 0,
				yOfs        = 0,
			},
			options = 
			{
				skinName  = nUI_UNITSKIN_RAID40RIGHT,
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
		[nUI_UNITFRAME_RAID40.."23"] = 
		{
			anchor = 
			{
				anchor_pt   = "TOPRIGHT",
				relative_to = nUI_UNITFRAME_RAID40.."22_Feedback",
				relative_pt = "TOPLEFT",
				xOfs        = 0,
				yOfs        = 0,
			},
			options = 
			{
				skinName  = nUI_UNITSKIN_RAID40RIGHT,
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
		[nUI_UNITFRAME_RAID40.."24"] = 
		{
			anchor = 
			{
				anchor_pt   = "TOPRIGHT",
				relative_to = nUI_UNITFRAME_RAID40.."23_Feedback",
				relative_pt = "TOPLEFT",
				xOfs        = 0,
				yOfs        = 0,
			},
			options = 
			{
				skinName  = nUI_UNITSKIN_RAID40RIGHT,
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
		[nUI_UNITFRAME_RAID40.."25"] = 
		{
			anchor = 
			{
				anchor_pt   = "TOPRIGHT",
				relative_to = nUI_UNITFRAME_RAID40.."24_Feedback",
				relative_pt = "TOPLEFT",
				xOfs        = 0,
				yOfs        = 0,
			},
			options = 
			{
				skinName  = nUI_UNITSKIN_RAID40RIGHT,
				enabled   = true,
				
				strata    = nil,
				level     = 4,
				
				unit_id   = "raid25",
				party_id  = nil,
				raid_id	  = 25,
				
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
		[nUI_UNITFRAME_RAID40.."26"] = 
		{
			anchor = 
			{
				anchor_pt   = "TOPRIGHT",
				relative_to = nUI_UNITFRAME_RAID40.."21_Feedback",
				relative_pt = "BOTTOMRIGHT",
				xOfs        = 0,
				yOfs        = 0,
			},
			options = 
			{
				skinName  = nUI_UNITSKIN_RAID40RIGHT,
				enabled   = true,
				
				strata    = nil,
				level     = 4,
				
				unit_id   = "raid26",
				party_id  = nil,
				raid_id	  = 26,
				
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
		[nUI_UNITFRAME_RAID40.."27"] = 
		{
			anchor = 
			{
				anchor_pt   = "TOPRIGHT",
				relative_to = nUI_UNITFRAME_RAID40.."22_Feedback",
				relative_pt = "BOTTOMRIGHT",
				xOfs        = 0,
				yOfs        = 0,
			},
			options = 
			{
				skinName  = nUI_UNITSKIN_RAID40RIGHT,
				enabled   = true,
				
				strata    = nil,
				level     = 4,
				
				unit_id   = "raid27",
				party_id  = nil,
				raid_id	  = 27,
				
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
		[nUI_UNITFRAME_RAID40.."28"] = 
		{
			anchor = 
			{
				anchor_pt   = "TOPRIGHT",
				relative_to = nUI_UNITFRAME_RAID40.."23_Feedback",
				relative_pt = "BOTTOMRIGHT",
				xOfs        = 0,
				yOfs        = 0,
			},
			options = 
			{
				skinName  = nUI_UNITSKIN_RAID40RIGHT,
				enabled   = true,
				
				strata    = nil,
				level     = 4,
				
				unit_id   = "raid28",
				party_id  = nil,
				raid_id	  = 28,
				
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
		[nUI_UNITFRAME_RAID40.."29"] = 
		{
			anchor = 
			{
				anchor_pt   = "TOPRIGHT",
				relative_to = nUI_UNITFRAME_RAID40.."24_Feedback",
				relative_pt = "BOTTOMRIGHT",
				xOfs        = 0,
				yOfs        = 0,
			},
			options = 
			{
				skinName  = nUI_UNITSKIN_RAID40RIGHT,
				enabled   = true,
				
				strata    = nil,
				level     = 4,
				
				unit_id   = "raid29",
				party_id  = nil,
				raid_id	  = 29,
				
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
		[nUI_UNITFRAME_RAID40.."30"] = 
		{
			anchor = 
			{
				anchor_pt   = "TOPRIGHT",
				relative_to = nUI_UNITFRAME_RAID40.."25_Feedback",
				relative_pt = "BOTTOMRIGHT",
				xOfs        = 0,
				yOfs        = 0,
			},
			options = 
			{
				skinName  = nUI_UNITSKIN_RAID40RIGHT,
				enabled   = true,
				
				strata    = nil,
				level     = 4,
				
				unit_id   = "raid30",
				party_id  = nil,
				raid_id	  = 30,
				
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
		[nUI_UNITFRAME_RAID40.."31"] = 
		{
			anchor = 
			{
				anchor_pt   = "TOPRIGHT",
				relative_to = nUI_UNITFRAME_RAID40.."26_Feedback",
				relative_pt = "BOTTOMRIGHT",
				xOfs        = 0,
				yOfs        = 0,
			},
			options = 
			{
				skinName  = nUI_UNITSKIN_RAID40RIGHT,
				enabled   = true,
				
				strata    = nil,
				level     = 4,
				
				unit_id   = "raid31",
				party_id  = nil,
				raid_id	  = 31,
				
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
		[nUI_UNITFRAME_RAID40.."32"] = 
		{
			anchor = 
			{
				anchor_pt   = "TOPRIGHT",
				relative_to = nUI_UNITFRAME_RAID40.."27_Feedback",
				relative_pt = "BOTTOMRIGHT",
				xOfs        = 0,
				yOfs        = 0,
			},
			options = 
			{
				skinName  = nUI_UNITSKIN_RAID40RIGHT,
				enabled   = true,
				
				strata    = nil,
				level     = 4,
				
				unit_id   = "raid32",
				party_id  = nil,
				raid_id	  = 32,
				
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
		[nUI_UNITFRAME_RAID40.."33"] = 
		{
			anchor = 
			{
				anchor_pt   = "TOPRIGHT",
				relative_to = nUI_UNITFRAME_RAID40.."28_Feedback",
				relative_pt = "BOTTOMRIGHT",
				xOfs        = 0,
				yOfs        = 0,
			},
			options = 
			{
				skinName  = nUI_UNITSKIN_RAID40RIGHT,
				enabled   = true,
				
				strata    = nil,
				level     = 4,
				
				unit_id   = "raid33",
				party_id  = nil,
				raid_id	  = 33,
				
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
		[nUI_UNITFRAME_RAID40.."34"] = 
		{
			anchor = 
			{
				anchor_pt   = "TOPRIGHT",
				relative_to = nUI_UNITFRAME_RAID40.."29_Feedback",
				relative_pt = "BOTTOMRIGHT",
				xOfs        = 0,
				yOfs        = 0,
			},
			options = 
			{
				skinName  = nUI_UNITSKIN_RAID40RIGHT,
				enabled   = true,
				
				strata    = nil,
				level     = 4,
				
				unit_id   = "raid34",
				party_id  = nil,
				raid_id	  = 34,
				
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
		[nUI_UNITFRAME_RAID40.."35"] = 
		{
			anchor = 
			{
				anchor_pt   = "TOPRIGHT",
				relative_to = nUI_UNITFRAME_RAID40.."30_Feedback",
				relative_pt = "BOTTOMRIGHT",
				xOfs        = 0,
				yOfs        = 0,
			},
			options = 
			{
				skinName  = nUI_UNITSKIN_RAID40RIGHT,
				enabled   = true,
				
				strata    = nil,
				level     = 4,
				
				unit_id   = "raid35",
				party_id  = nil,
				raid_id	  = 35,
				
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
		[nUI_UNITFRAME_RAID40.."36"] = 
		{
			anchor = 
			{
				anchor_pt   = "TOPRIGHT",
				relative_to = nUI_UNITFRAME_RAID40.."31_Feedback",
				relative_pt = "BOTTOMRIGHT",
				xOfs        = 0,
				yOfs        = 0,
			},
			options = 
			{
				skinName  = nUI_UNITSKIN_RAID40RIGHT,
				enabled   = true,
				
				strata    = nil,
				level     = 4,
				
				unit_id   = "raid36",
				party_id  = nil,
				raid_id	  = 36,
				
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
		[nUI_UNITFRAME_RAID40.."37"] = 
		{
			anchor = 
			{
				anchor_pt   = "TOPRIGHT",
				relative_to = nUI_UNITFRAME_RAID40.."32_Feedback",
				relative_pt = "BOTTOMRIGHT",
				xOfs        = 0,
				yOfs        = 0,
			},
			options = 
			{
				skinName  = nUI_UNITSKIN_RAID40RIGHT,
				enabled   = true,
				
				strata    = nil,
				level     = 4,
				
				unit_id   = "raid37",
				party_id  = nil,
				raid_id	  = 37,
				
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
		[nUI_UNITFRAME_RAID40.."38"] = 
		{
			anchor = 
			{
				anchor_pt   = "TOPRIGHT",
				relative_to = nUI_UNITFRAME_RAID40.."33_Feedback",
				relative_pt = "BOTTOMRIGHT",
				xOfs        = 0,
				yOfs        = 0,
			},
			options = 
			{
				skinName  = nUI_UNITSKIN_RAID40RIGHT,
				enabled   = true,
				
				strata    = nil,
				level     = 4,
				
				unit_id   = "raid38",
				party_id  = nil,
				raid_id	  = 38,
				
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
		[nUI_UNITFRAME_RAID40.."39"] = 
		{
			anchor = 
			{
				anchor_pt   = "TOPRIGHT",
				relative_to = nUI_UNITFRAME_RAID40.."34_Feedback",
				relative_pt = "BOTTOMRIGHT",
				xOfs        = 0,
				yOfs        = 0,
			},
			options = 
			{
				skinName  = nUI_UNITSKIN_RAID40RIGHT,
				enabled   = true,
				
				strata    = nil,
				level     = 4,
				
				unit_id   = "raid39",
				party_id  = nil,
				raid_id	  = 39,
				
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
		[nUI_UNITFRAME_RAID40.."40"] = 
		{
			anchor = 
			{
				anchor_pt   = "TOPRIGHT",
				relative_to = nUI_UNITFRAME_RAID40.."35_Feedback",
				relative_pt = "BOTTOMRIGHT",
				xOfs        = 0,
				yOfs        = 0,
			},
			options = 
			{
				skinName  = nUI_UNITSKIN_RAID40RIGHT,
				enabled   = true,
				
				strata    = nil,
				level     = 4,
				
				unit_id   = "raid40",
				party_id  = nil,
				raid_id	  = 40,
				
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
		[nUI_UNITFRAME_RAID40MOUSE] = 
		{
			anchor = 
			{
				anchor_pt   = "TOP",
				relative_to = nUI_UNITFRAME_RAID40FOCUS,
				relative_pt = "BOTTOM",
				xOfs        = 0,
				yOfs        = -7,
			},
			options = 
			{
				skinName  = nUI_UNITSKIN_RAID40MOUSE,
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
		[nUI_UNITFRAME_RAID40BOSS.."2"] = 
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
		[nUI_UNITFRAME_RAID40BOSS.."3"] = 
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
		[nUI_UNITFRAME_RAID40BOSS.."1"] = 
		{
			anchor = 
			{
				anchor_pt   = "RIGHT",
				relative_to = nUI_UNITFRAME_RAID40BOSS.."2",
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
		[nUI_UNITFRAME_RAID40BOSS.."4"] = 
		{
			anchor = 
			{
				anchor_pt   = "LEFT",
				relative_to = nUI_UNITFRAME_RAID40BOSS.."3",
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
