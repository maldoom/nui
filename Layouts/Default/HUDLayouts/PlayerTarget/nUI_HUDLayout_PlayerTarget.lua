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

if not nUI_HUDLayouts then nUI_HUDLayouts = {}; end

-------------------------------------------------------------------------------
-- default configuration for the combat log info panel

nUI_HUDLayouts[nUI_HUDLAYOUT_PLAYERTARGET] =
{	
	enabled   = true,
	desc      = nUI_L[nUI_HUDLAYOUT_PLAYERTARGET],			-- player friendly name/description of the layout
	label     = nUI_L[nUI_HUDLAYOUT_PLAYERTARGET.."Label"],	-- label to use on the panel selection button face
	rotation  = nUI_HUDMODE_PLAYERTARGET,					-- index or position this panel appears on/in when clicking the selector button
	
	options  =
	{
		enabled     = true,
		scale       = 1,
		show_race   = false,
		show_threat = false,
		show_pet    = false,
		show_tot    = false,
		npc_bars    = false,
		hGap        = 500,
		vGap        = 400,
		
		focus_pairs =
		{
			["target"] =
			{
				normal = nUI_HUDUNIT_PLAYERTARGET_TARGET,
				focus  = nUI_HUDUNIT_PLAYERTARGET_FOCUS,
			},
			["tot"] =
			{
				normal = nUI_HUDUNIT_PLAYERTARGET_TOT,
				focus  = nUI_HUDUNIT_PLAYERTARGET_FOCUSTARGET,
			},
		},
		
		alpha =
		{
			idle    = 0,
			regen   = 0.35,
			target  = 0.75,
			combat  = 1,
		},
	},
	elements =
	{
		cooldown_bar =
		{
			enabled = true;
			name    = nUI_HUDLAYOUT_PLAYERTARGET.."_CooldownBar",
			
			anchor =
			{
				anchor_pt   = "BOTTOM",
				relative_to = nUI_HUDLAYOUT_PLAYERTARGET.."Bottom",
				relative_pt = "CENTER",
				xOfs        = 0,
				yOfs        = 8,
			},
			options =
			{
				enabled      = true,
				scale        = 1,
				rows         = 1,
				cols         = 10,
				btn_size     = 45,
				hGap         = 2,
				vGap         = 0,
				origin       = "TOPLEFT",
				sound        = "Sound\\Event Sounds\\Wisp\\WispYes1.wav",
				fade         = false,
				dynamic_size = true,
				horizontal   = true,
				clickable    = false,
			
				message =
				{
					enabled     = true,
					fontsize    = 25,
					justifyH    = "CENTER",
					justifyV    = "BOTTOM",
					anchor_pt   = "BOTTOM",
					relative_pt = "BOTTOM",
					outline     = "THICKOUTLINE",
					xOfs        = 0,
					yOfs        = 2,
					color       = { r = 1, g = 0.75, b = 0.75, a = 1 },
				},
				
				timer =
				{
					enabled     = true,
					fontsize    = 10.5,
					justifyH    = "CENTER",
					justifyV    = "BOTTOM",
					anchor_pt   = "TOP",
					relative_pt = "BOTTOM",
					xOfs        = 0,
					yOfs        = -1,
				},
			},
		},
		
		units =
		{
			[nUI_HUDUNIT_PLAYERTARGET_CASTBAR] =
			{
				options = 
				{
					skinName  = nUI_HUDSKIN_PLAYERTARGET_CASTBAR,
					enabled   = true,
					
					strata    = nil,
					level     = nil,
					
					unit_id   = "player",
					party_id  = nil,
					raid_id	  = nil,
					
					scale     = 1,
					clickable = false,
					fade      = false,
				},
			},
			[nUI_HUDUNIT_PLAYERTARGET_PLAYER] =
			{
				options = 
				{
					skinName  = nUI_HUDSKIN_PLAYERTARGET_PLAYER,
					enabled   = true,
					
					strata    = nil,
					level     = nil,
					
					unit_id   = "player",
					party_id  = nil,
					raid_id	  = nil,
					
					scale     = 1,
					clickable = false,
					fade      = true,
				},
			},
			[nUI_HUDUNIT_PLAYERTARGET_PET] =
			{
				options = 
				{
					skinName  = nUI_HUDSKIN_PLAYERTARGET_PET,
					enabled   = true,
					
					strata    = nil,
					level     = nil,
					
					unit_id   = "pet",
					party_id  = nil,
					raid_id	  = nil,
					
					scale     = 1,
					clickable = false,
					fade      = true,
				},
			},
			[nUI_HUDUNIT_PLAYERTARGET_TARGET] =
			{
				options = 
				{
					skinName   = nUI_HUDSKIN_PLAYERTARGET_TARGET,
					enabled    = true,
					
					strata     = nil,
					level      = nil,
					
					unit_id    = "target",
					party_id   = nil,
					raid_id	   = nil,
					visibility = "[target=target, exists] show; hide";
					
					scale      = 1,
					clickable  = false,
					fade       = true,
				},
			},
			[nUI_HUDUNIT_PLAYERTARGET_FOCUS] =
			{
				options = 
				{
					skinName   = nUI_HUDSKIN_PLAYERTARGET_TARGET,
					enabled    = true,
					
					strata     = nil,
					level      = nil,
					
					unit_id    = "focus",
					party_id   = nil,
					raid_id	   = nil,
					visibility = "hide";
					
					scale      = 1,
					clickable  = false,
					fade       = true,
				},
			},
			[nUI_HUDUNIT_PLAYERTARGET_TOT] =
			{
				options = 
				{
					skinName   = nUI_HUDSKIN_PLAYERTARGET_TOT,
					enabled    = true,
					
					strata     = nil,
					level      = nil,
					
					unit_id    = "targettarget",
					party_id   = nil,
					raid_id	   = nil,
					visibility = "[target=targettarget, exists] show; hide";
					
					scale      = 1,
					clickable  = false,
					fade       = true,
				},
			},
			[nUI_HUDUNIT_PLAYERTARGET_FOCUSTARGET] =
			{
				options = 
				{
					skinName   = nUI_HUDSKIN_PLAYERTARGET_TOT,
					enabled    = true,
					
					strata     = nil,
					level      = nil,
					
					unit_id    = "focustarget",
					party_id   = nil,
					raid_id	   = nil,
					visibility = "hide";
					
					scale      = 1,
					clickable  = false,
					fade       = true,
				},
			},
		},
	},
};
