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

nUI_UnitPanels[nUI_UNITPANEL_PARTY] =
{
	desc     = nUI_L[nUI_UNITPANEL_PARTY],			-- player friendly name/description of the panel
	label    = nUI_L[nUI_UNITPANEL_PARTY.."Label"],	-- label to use on the panel selection button face
	rotation = nUI_UNITMODE_PARTY,					-- index or position this panel appears on/in when clicking the selector button
	enabled  = true,								-- whether or not the player has the panel enabled
	selected = false,								-- whether or not this is the currently selected panel
	automode = "party",								-- selects to automatically display this panel when player joins a party
	
	loadOrder =
	{
		[1]  = nUI_UNITFRAME_PARTY.."1",
		[2]  = nUI_UNITFRAME_PARTYP.."1",
		[3]  = nUI_UNITFRAME_PARTYT.."1",
		[4]  = nUI_UNITFRAME_PARTY.."2",
		[5]  = nUI_UNITFRAME_PARTYP.."2",
		[6]  = nUI_UNITFRAME_PARTYT.."2",
		[7]  = nUI_UNITFRAME_PARTY.."3",
		[8]  = nUI_UNITFRAME_PARTYP.."3",
		[9]  = nUI_UNITFRAME_PARTYT.."3",
		[10] = nUI_UNITFRAME_PARTY.."4",
		[11] = nUI_UNITFRAME_PARTYP.."4",
		[12] = nUI_UNITFRAME_PARTYT.."4",
		[13] = nUI_UNITFRAME_PARTYPLAYER,
		[14] = nUI_UNITFRAME_PARTYTARGET,
		[15] = nUI_UNITFRAME_PARTYTARGETP,
		[16] = nUI_UNITFRAME_PARTYTOT,
		[17] = nUI_UNITFRAME_PARTYTOTT,
		[18] = nUI_UNITFRAME_PARTYFOCUS,
		[19] = nUI_UNITFRAME_PARTYFOCUST,
		[20] = nUI_UNITFRAME_PARTYMOUSE,
		[21] = nUI_UNITFRAME_PARTYPET,
		[22] = nUI_UNITFRAME_PARTYPETT,
		[23] = nUI_UNITFRAME_PARTYVEHICLE,
		[24] = nUI_UNITFRAME_PARTYBOSS.."2",
		[25] = nUI_UNITFRAME_PARTYBOSS.."3",
		[26] = nUI_UNITFRAME_PARTYBOSS.."1",
		[27] = nUI_UNITFRAME_PARTYBOSS.."4",
	},
	
	units =
	{
		[nUI_UNITFRAME_PARTY.."1"] = 
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
				skinName  = nUI_UNITSKIN_PARTYLEFT,
				enabled   = true,
				
				strata    = nil,
				level     = 4,
				
				unit_id   = "party1",
				party_id  = 1,
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
		[nUI_UNITFRAME_PARTYP.."1"] = 
		{
			anchor = 
			{
				anchor_pt   = "TOPLEFT",
				relative_to = nUI_UNITFRAME_PARTY.."1_Stats",
				relative_pt = "BOTTOMLEFT",
				xOfs        = 0,
				yOfs        = -1,
			},
			options = 
			{
				skinName  = nUI_UNITSKIN_PARTYPETBUTTON,
				enabled   = true,
				
				strata    = nil,
				level     = 6,
				
				unit_id   = "partypet1",
				party_id  = 1,
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
		[nUI_UNITFRAME_PARTYT.."1"] = 
		{
			anchor = 
			{
				anchor_pt   = "TOPRIGHT",
				relative_to = nUI_UNITFRAME_PARTY.."1_Stats",
				relative_pt = "BOTTOMRIGHT",
				xOfs        = 0,
				yOfs        = -1,
			},
			options = 
			{
				skinName  = nUI_UNITSKIN_PARTYTGTBUTTON,
				enabled   = true,
				
				strata    = nil,
				level     = 6,
				
				unit_id   = "party1target",
				party_id  = 1,
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
		[nUI_UNITFRAME_PARTY.."3"] = 
		{
			anchor = 
			{
				anchor_pt   = "TOP",
				relative_to = nUI_UNITFRAME_PARTY.."1_Feedback",
				relative_pt = "BOTTOM",
				xOfs        = 0,
				yOfs        = 0,
			},
			options = 
			{
				skinName  = nUI_UNITSKIN_PARTYLEFT,
				enabled   = true,
				
				strata    = nil,
				level     = 4,
				
				unit_id   = "party3",
				party_id  = 3,
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
		[nUI_UNITFRAME_PARTYP.."3"] = 
		{
			anchor = 
			{
				anchor_pt   = "TOPLEFT",
				relative_to = nUI_UNITFRAME_PARTY.."3_Stats",
				relative_pt = "BOTTOMLEFT",
				xOfs        = 0,
				yOfs        = -1,
			},
			options = 
			{
				skinName  = nUI_UNITSKIN_PARTYPETBUTTON,
				enabled   = true,
				
				strata    = nil,
				level     = 6,
				
				unit_id   = "partypet3",
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
		[nUI_UNITFRAME_PARTYT.."3"] = 
		{
			anchor = 
			{
				anchor_pt   = "TOPRIGHT",
				relative_to = nUI_UNITFRAME_PARTY.."3_Stats",
				relative_pt = "BOTTOMRIGHT",
				xOfs        = 0,
				yOfs        = -1,
			},
			options = 
			{
				skinName  = nUI_UNITSKIN_PARTYTGTBUTTON,
				enabled   = true,
				
				strata    = nil,
				level     = 6,
				
				unit_id   = "party3target",
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
		[nUI_UNITFRAME_PARTY.."2"] = 
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
				skinName  = nUI_UNITSKIN_PARTYRIGHT,
				enabled   = true,
				
				strata    = nil,
				level     = 4,
				
				unit_id   = "party2",
				party_id  = 2,
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
		[nUI_UNITFRAME_PARTYP.."2"] = 
		{
			anchor = 
			{
				anchor_pt   = "TOPLEFT",
				relative_to = nUI_UNITFRAME_PARTY.."2_Stats",
				relative_pt = "BOTTOMLEFT",
				xOfs        = 0,
				yOfs        = -1,
			},
			options = 
			{
				skinName  = nUI_UNITSKIN_PARTYPETBUTTON,
				enabled   = true,
				
				strata    = nil,
				level     = 6,
				
				unit_id   = "partypet2",
				party_id  = 2,
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
		[nUI_UNITFRAME_PARTYT.."2"] = 
		{
			anchor = 
			{
				anchor_pt   = "TOPRIGHT",
				relative_to = nUI_UNITFRAME_PARTY.."2_Stats",
				relative_pt = "BOTTOMRIGHT",
				xOfs        = 0,
				yOfs        = -1,
			},
			options = 
			{
				skinName  = nUI_UNITSKIN_PARTYTGTBUTTON,
				enabled   = true,
				
				strata    = nil,
				level     = 6,
				
				unit_id   = "party2target",
				party_id  = 2,
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
		[nUI_UNITFRAME_PARTY.."4"] = 
		{
			anchor = 
			{
				anchor_pt   = "TOP",
				relative_to = nUI_UNITFRAME_PARTY.."2_Feedback",
				relative_pt = "BOTTOM",
				xOfs        = 0,
				yOfs        = 0,
			},
			options = 
			{
				skinName  = nUI_UNITSKIN_PARTYRIGHT,
				enabled   = true,
				
				strata    = nil,
				level     = 4,
				
				unit_id   = "party4",
				party_id  = 4,
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
		[nUI_UNITFRAME_PARTYP.."4"] = 
		{
			anchor = 
			{
				anchor_pt   = "TOPLEFT",
				relative_to = nUI_UNITFRAME_PARTY.."4_Stats",
				relative_pt = "BOTTOMLEFT",
				xOfs        = 0,
				yOfs        = -1,
			},
			options = 
			{
				skinName  = nUI_UNITSKIN_PARTYPETBUTTON,
				enabled   = true,
				
				strata    = nil,
				level     = 6,
				
				unit_id   = "partypet4",
				party_id  = 4,
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
		[nUI_UNITFRAME_PARTYT.."4"] = 
		{
			anchor = 
			{
				anchor_pt   = "TOPRIGHT",
				relative_to = nUI_UNITFRAME_PARTY.."4_Stats",
				relative_pt = "BOTTOMRIGHT",
				xOfs        = 0,
				yOfs        = -1,
			},
			options = 
			{
				skinName  = nUI_UNITSKIN_PARTYTGTBUTTON,
				enabled   = true,
				
				strata    = nil,
				level     = 6,
				
				unit_id   = "party4target",
				party_id  = 4,
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
		[nUI_UNITFRAME_PARTYPLAYER] = 
		{
			anchor = 
			{
				anchor_pt   = "TOPRIGHT",
				relative_to = nUI_UNITFRAME_PARTYFOCUS,
				relative_pt = "TOPLEFT",
				xOfs        = -7,
				yOfs        = 0,
			},
			options = 
			{
				skinName  = nUI_UNITSKIN_PARTYPLAYER,
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
		[nUI_UNITFRAME_PARTYVEHICLE] = 
		{
			anchor = 
			{
				anchor_pt   = "RIGHT",
				relative_to = nUI_UNITFRAME_PARTYMOUSE,
				relative_pt = "LEFT",
				xOfs        = -7,
				yOfs        = 0,
			},
			options = 
			{
				skinName  = nUI_UNITSKIN_PARTYVEHICLE,
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
		[nUI_UNITFRAME_PARTYPET] = 
		{
			anchor = 
			{
				anchor_pt   = "RIGHT",
				relative_to = nUI_UNITFRAME_PARTYMOUSE,
				relative_pt = "LEFT",
				xOfs        = -7,
				yOfs        = 0,
			},
			options = 
			{
				skinName  = nUI_UNITSKIN_PARTYPET,
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
		[nUI_UNITFRAME_PARTYTARGET] = 
		{
			anchor = 
			{
				anchor_pt   = "TOPLEFT",
				relative_to = nUI_UNITFRAME_PARTYFOCUS,
				relative_pt = "TOPRIGHT",
				xOfs        = 7,
				yOfs        = 0,
			},
			options = 
			{
				skinName  = nUI_UNITSKIN_PARTYTARGET,
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
		[nUI_UNITFRAME_PARTYTARGETP] = 
		{
			anchor = 
			{
				anchor_pt   = "TOPLEFT",
				relative_to = nUI_UNITFRAME_PARTYTARGET.."_Label",
				relative_pt = "BOTTOMLEFT",
				xOfs        = 5,
				yOfs        = -1,
			},
			options = 
			{
				skinName  = nUI_UNITSKIN_PARTYPETBUTTON,
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
		[nUI_UNITFRAME_PARTYTOT] = 
		{
			anchor = 
			{
				anchor_pt   = "LEFT",
				relative_to = nUI_UNITFRAME_PARTYMOUSE,
				relative_pt = "RIGHT",
				xOfs        = 7,
				yOfs        = 0,
			},
			options = 
			{
				skinName  = nUI_UNITSKIN_PARTYTOT,
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
		[nUI_UNITFRAME_PARTYFOCUS] = 
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
				skinName  = nUI_UNITSKIN_PARTYFOCUS,
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
		[nUI_UNITFRAME_PARTYFOCUSP] = 
		{
			anchor = 
			{
				anchor_pt   = "TOPLEFT",
				relative_to = nUI_UNITFRAME_PARTYFOCUS.."_Label",
				relative_pt = "BOTTOMLEFT",
				xOfs        = 5,
				yOfs        = -1,
			},
			options = 
			{
				skinName  = nUI_UNITSKIN_PARTYPETBUTTON,
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
		[nUI_UNITFRAME_PARTYFOCUST] = 
		{
			anchor = 
			{
				anchor_pt   = "TOPRIGHT",
				relative_to = nUI_UNITFRAME_PARTYFOCUS.."_Label",
				relative_pt = "BOTTOMRIGHT",
				xOfs        = -5,
				yOfs        = -1,
			},
			options = 
			{
				skinName  = nUI_UNITSKIN_PARTYTGTBUTTON,
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
		[nUI_UNITFRAME_PARTYMOUSE] = 
		{
			anchor = 
			{
				anchor_pt   = "TOP",
				relative_to = nUI_UNITFRAME_PARTYFOCUS,
				relative_pt = "BOTTOM",
				xOfs        = 0,
				yOfs        = -7,
			},
			options = 
			{
				skinName  = nUI_UNITSKIN_PARTYMOUSE,
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
		[nUI_UNITFRAME_PARTYBOSS.."2"] = 
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
		[nUI_UNITFRAME_PARTYBOSS.."3"] = 
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
		[nUI_UNITFRAME_PARTYBOSS.."1"] = 
		{
			anchor = 
			{
				anchor_pt   = "RIGHT",
				relative_to = nUI_UNITFRAME_PARTYBOSS.."2",
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
		[nUI_UNITFRAME_PARTYBOSS.."4"] = 
		{
			anchor = 
			{
				anchor_pt   = "LEFT",
				relative_to = nUI_UNITFRAME_PARTYBOSS.."3",
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
