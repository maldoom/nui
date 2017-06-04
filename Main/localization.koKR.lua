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

if nUI_Locale == "koKR" then		-- Korean
		
--	nUI_L["font1"] = "Interface\\AddOns\\nUI\\Layouts\\Default\\Fonts\\ABF.ttf";
--	nUI_L["font1"] = "Interface\\AddOns\\nUI\\Layouts\\Default\\Fonts\\Accidental Presidency.ttf";
--	nUI_L["font1"] = "Interface\\AddOns\\nUI\\Layouts\\Default\\Fonts\\Adventure.ttf";
--	nUI_L["font1"] = "Interface\\AddOns\\nUI\\Layouts\\Default\\Fonts\\Bazooka.ttf";
--	nUI_L["font1"] = "Interface\\AddOns\\nUI\\Layouts\\Default\\Fonts\\Emblem.ttf";
--	nUI_L["font1"] = "Interface\\AddOns\\nUI\\Layouts\\Default\\Fonts\\Enigma__2.ttf";
	nUI_L["font1"] = "Interface\\AddOns\\nUI\\Layouts\\Default\\Fonts\\Tw_Cen_MT_Bold.ttf";
--	nUI_L["font1"] = "Interface\\AddOns\\nUI\\Layouts\\Default\\Fonts\\VeraSe.ttf";
--	nUI_L["font1"] = "Fonts\\ARIALN.TTF";

--	nUI_L["font2"] = "Fonts\\FRIZQT__.TTF";
	nUI_L["font2"] = "Interface\\AddOns\\nUI\\Layouts\\Default\\Fonts\\Emblem.ttf";
	
	nUI_L["Welcome back to %s, %s..."] = "Welcome back to %s, %s...";
	nUI_L["nUI %s version %s is loaded!"] = "nUI %s version %s is loaded!";
	nUI_L["Type '/nui' for a list of available nUI commands."] = "Type '/nui' for a list of available nUI commands.";
	
	-- splash frame strings
	-- new -- this entire section is new
		
	nUI_L["splash title"] = "%s has been upgraded to %s %s";
	nUI_L["splash info"]  = "For the user guide, galleries, the latest downloads, nUI's FAQ, technical support forums or to make a donation to support nUI, please visit |cFF00FFFFhttp://www.nUIaddon.com|r";
	nUI_L["plus info"]    = "You are running the 'Release' version of nUI... there is also a free version 'nUI+' available which includes 15, 20, 25 and 40 man raid frames as well as additional features. Please visit |cFF00FFFFhttp://www.nUIaddon.com/plus.html|r for more information.";
	
	-- clock strings
	
	nUI_L["am"] = "am";
	nUI_L["pm"] = "pm";
	nUI_L["<hour>:<minute><suffix>"] = "%d:%02d%s";
	nUI_L["<hour>:<minute>"] = "%02d:%02d";
	nUI_L["(S) <hour>:<minute><suffix> - <hour>:<minute><suffix> (L)"] = "(S) %d:%02d%s - %d:%02d%s (L)";
	nUI_L["(S) <hour>:<minute> - <hour>:<minute> (L)"] = "(S) %02d:%02d - %02d:%02d (L)";
	
	-- state strings
	
	nUI_L["|cFF00FF00ENABLED|r"]  = "|cFF00FF00ENABLED|r";
	nUI_L["|cFFFF0000DISABLED|r"] = "|cFFFF0000DISABLED|r";
	nUI_L["~INTERRUPTED~"]        = "~INTERRUPTED~";
	nUI_L["~FAILED~"]             = "~FAILED~";
	nUI_L["~MISSED~"]             = "~MISSED~";
	nUI_L["OFFLINE"]              = "OFFLINE";
	nUI_L["DND"]                  = "DND"; 
	nUI_L["AFK"]                  = "AFK";
	nUI_L["DEAD"]                 = "DEAD";
	nUI_L["GHOST"]                = "GHOST";
	nUI_L["FD"]                   = "FD";
	nUI_L["TAXI"]                 = "TAXI";
	nUI_L["OOR"]				  = "OOR"; -- new -- abbreviation for "out of range"
	
	-- power types

	-- new -- this entire section is new... it contains the labels used to describe the
	--        unit's current health and power type in tooltips and other areas
	
	nUI_L["HEALTH"]      = "Health";	
	nUI_L["MANA"]        = "Mana";
	nUI_L["RAGE"]        = "Rage";
	nUI_L["FOCUS"]       = "Focus";
	nUI_L["ENERGY"]      = "Energy";
	nUI_L["RUNES"]       = "Runes";
	nUI_L["RUNIC_POWER"] = "Runic Power";
	nUI_L["AMMO"]        = "Ammo"; -- vehicles
	nUI_L["FUEL"]        = "Fuel"; -- vehicles
	
	-- time remaining (cooldowns, buffs, etc.)
	
	nUI_L["TimeLeftInHours"]   = "%0.0fh";
	nUI_L["TimeLeftInMinutes"] = "%0.0fm";
	nUI_L["TimeLeftInSeconds"] = "%0.0fs";
	nUI_L["TimeLeftInTenths"]  = "%0.1fs";
	
	-- raid and party role tooltip strings
	
	nUI_L["Party Role: |cFF00FFFF%s|r"] = "Party Role: |cFF00FFFF%s|r";
	nUI_L["Raid Role: |cFF00FFFF%s|r"]  = "Raid Role: |cFF00FFFF%s|r";
	nUI_L["Raid Leader"]                = "Raid Leader";
	nUI_L["Party Leader"]               = "Party Leader";
	nUI_L["Raid Assistant"]             = "Raid Assistant";
	nUI_L["Main Tank"]                  = "Main Tank";
	nUI_L["Off-Tank"]                   = "Off-Tank";
	nUI_L["Master Looter"]              = "Master Looter";
	
	-- hunter pet feeder strings
	
	nUI_L[nUI_FOOD_MEAT]   = "meat";	-- do not edit this line
	nUI_L[nUI_FOOD_FISH]   = "fish";    -- do not edit this line
	nUI_L[nUI_FOOD_BREAD]  = "bread";   -- do not edit this line
	nUI_L[nUI_FOOD_CHEESE] = "cheese";  -- do not edit this line
	nUI_L[nUI_FOOD_FRUIT]  = "fruit";   -- do not edit this line
	nUI_L[nUI_FOOD_FUNGUS] = "fungus";  -- do not edit htis line
	
	nUI_L["Click to feed %s"]           = "Click to feed %s";
	nUI_L["Click to cancel feeding"]    = "Click to cancel feeding";
	nUI_L["nUI: %s can eat %s%s%s"]     = "nUI: %s can eat %s%s%s";
	nUI_L[" or "]                       = " or ";
	nUI_L["nUI: You don't have a pet!"] = "nUI: You don't have a pet!";
	
	nUI_L["nUI: You can feed %s the following...\n"] = "nUI: You can feed %s the following...\n";
	nUI_L["nUI: You have nothing you can feed %s in your current inventory"] = "nUI: You have nothing you can feed %s in your current inventory";
	
	-- status bar strings
	
	nUI_L["nUI: Cannot change status bar config while in combat!"] = "nUI: Cannot change status bar config while in combat!";
	nUI_L["nUI: [%s] is not a valid option for orienting a status bar... use LEFT, RIGHT, TOP or BOTTOM"] = "nUI: [%s] is not a valid option for orienting a status bar... use LEFT, RIGHT, TOP or BOTTOM";
	nUI_L["nUI: Can not change status bar overlays while in combat!"] = "nUI: Can not change status bar overlays while in combat!";
	nUI_L["nUI: The maximum value (%d) of a status bar must be greater than the minimum value (%d)"] = "nUI: The maximum value (%d) of a status bar must be greater than the minimum value (%d)";
	
	-- information panel strings
	
	nUI_L["Minimap"] = "Minimap";
	
	nUI_L[nUI_INFOPANEL_COMBATLOG]      		= "Info Panel: Combat Log Display Mode";
	nUI_L[nUI_INFOPANEL_COMBATLOG.."Label"]		= "Combat";
	
	nUI_L[nUI_INFOPANEL_BMM]		      		= "Info Panel: Battlefield Minimap Mode";
	nUI_L[nUI_INFOPANEL_BMM.."Label"]			= "Map";
	
	nUI_L[nUI_INFOPANEL_RECOUNT]		   		= "Info Panel: Recount Damage Meter Mode";
	nUI_L[nUI_INFOPANEL_RECOUNT.."Label"]		= "Recount";
	
	nUI_L[nUI_INFOPANEL_OMEN3]		      		= "Info Panel: Omen3 Threat Meter Mode";
	nUI_L[nUI_INFOPANEL_OMEN3.."Label"]			= "Omen3";
	
	nUI_L[nUI_INFOPANEL_SKADA]		      		= "Info Panel: Skada Damage/Threat Meter Mode"; -- new
	nUI_L[nUI_INFOPANEL_SKADA.."Label"]			= "Skada";
	
	nUI_L[nUI_INFOPANEL_OMEN3KLH]	      		= "Info Panel: Combined Omen3 + KLH Threat Meter Mode";
	nUI_L[nUI_INFOPANEL_OMEN3KLH.."Label"]		= "Threat";
	
	nUI_L[nUI_INFOPANEL_OMEN3RECOUNT]		   	= "Info Panel: Omen3 Threat + Recount Damage Meter Mode";
	nUI_L[nUI_INFOPANEL_OMEN3RECOUNT.."Label"]	= "Omen3+";
	
	nUI_L[nUI_INFOPANEL_KLH]		      		= "Info Panel: KLH Threat Meter Mode";
	nUI_L[nUI_INFOPANEL_KLH.."Label"]			= "KTM";
	
	nUI_L[nUI_INFOPANEL_KLHRECOUNT]	      		= "Info Panel: KLH Threat + Recount Damage Meter Mode";
	nUI_L[nUI_INFOPANEL_KLHRECOUNT.."Label"]	= "KTM+";
	
	nUI_L["nUI: You need to go to the WoW Interface menu, select the 'Social' option and turn off the 'Simple Chat' menu option to enable integrated combat log support in nUI."] = "nUI: You need to go to the WoW Interface menu, select the 'Social' option and turn off the 'Simple Chat' menu option to enable integrated combat log support in nUI.";
	nUI_L["The %s Info Panel plugin is a core plugin to nUI and cannot be disabled"] = "The %s Info Panel plugin is a core plugin to nUI and cannot be disabled";
	nUI_L["Click to change information panels"] = "Click to change information panels";
	nUI_L["nUI: Cannot initialize the Info Panel plugin [ %s ] -- it does not have an initPanel() interface method"] = "nUI: Cannot initialize the Info Panel plugin [ |cFF00FFFF%s|r ] -- it does not have an initPanel() interface method";
	nUI_L["nUI: Cannot initialize the Info Panel plugin [ %s ] -- No global object by that name exists"] = "nUI: Cannot initialize the Info Panel plugin [ |cFF00FFFF%s|r ] -- No global object by that name exists";	
	nUI_L["nUI: Cannot select the Info Panel plugin [ %s ] -- it does not have a setSelected() interface method"] = "nUI: cannot select the Info Panel plugin [ |cFF00FFFF%s|r ] -- it does not have a setSelected() interface method";
	
	-- HUD layout strings (heads up display)
	
	nUI_L["Click to change HUD layouts"] = "Click to change HUD layouts";
	
	nUI_L[nUI_HUDLAYOUT_PLAYERTARGET]	   		= "HUD Layout: Player Left / Target Right";
	nUI_L[nUI_HUDLAYOUT_PLAYERTARGET.."Label"]	= "Player/Target";
	
	nUI_L[nUI_HUDLAYOUT_HEALTHPOWER]	   		= "HUD Layout: Health Left / Power Right";
	nUI_L[nUI_HUDLAYOUT_HEALTHPOWER.."Label"]	= "Health/Power";
	
	nUI_L[nUI_HUDLAYOUT_SIDEBYSIDE]	   			= "HUD Layout: Side-by-side Horizontal Bars";
	nUI_L[nUI_HUDLAYOUT_SIDEBYSIDE.."Label"]	= "Side by Side";
	
	nUI_L[nUI_HUDLAYOUT_NOBARS]	   				= "HUD Layout: Simple HUD (no bars)";
	nUI_L[nUI_HUDLAYOUT_NOBARS.."Label"]		= "Simple HUD";
	
	nUI_L[nUI_HUDLAYOUT_NOHUD]		   			= "HUD Layout: Disabled (no HUD)";
	nUI_L[nUI_HUDLAYOUT_NOHUD.."Label"]			= "No HUD";
	
	nUI_L[nUI_HUDMODE_PLAYERTARGET]        = "nUI Player/Target HUD Mode";
	nUI_L[nUI_HUDSKIN_PLAYERTARGET_PET]    = nUI_L[nUI_HUDMODE_PLAYERTARGET]..": skin for displaying the Player Pet's unit data";
	nUI_L[nUI_HUDSKIN_PLAYERTARGET_PLAYER] = nUI_L[nUI_HUDMODE_PLAYERTARGET]..": skin for displaying the Player's unit data";
	nUI_L[nUI_HUDSKIN_PLAYERTARGET_TARGET] = nUI_L[nUI_HUDMODE_PLAYERTARGET]..": skin for displaying the Target's unit data";
	nUI_L[nUI_HUDSKIN_PLAYERTARGET_TOT]    = nUI_L[nUI_HUDMODE_PLAYERTARGET]..": skin for displaying the Target of Target's (ToT) unit data";
	nUI_L[nUI_HUDSKIN_PLAYERTARGET_CASTBAR] = nUI_L[nUI_HUDMODE_PLAYERTARGET]..": skin for displaying the Player's casting bar"; -- new
	
	nUI_L[nUI_HUDMODE_HEALTHPOWER]         = "nUI Health/Power HUD Mode";
	nUI_L[nUI_HUDSKIN_HEALTHPOWER_PET]     = nUI_L[nUI_HUDMODE_HEALTHPOWER]..": skin for displaying the Player Pet's unit data";
	nUI_L[nUI_HUDSKIN_HEALTHPOWER_PLAYER]  = nUI_L[nUI_HUDMODE_HEALTHPOWER]..": skin for displaying the Player's unit data";
	nUI_L[nUI_HUDSKIN_HEALTHPOWER_TARGET]  = nUI_L[nUI_HUDMODE_HEALTHPOWER]..": skin for displaying the Target's unit data";
	nUI_L[nUI_HUDSKIN_HEALTHPOWER_TOT]     = nUI_L[nUI_HUDMODE_HEALTHPOWER]..": skin for displaying the Target of Target's (ToT) unit data";
	nUI_L[nUI_HUDSKIN_HEALTHPOWER_CASTBAR] = nUI_L[nUI_HUDMODE_HEALTHPOWER]..": skin for displaying the Player's casting bar"; -- new
	
	nUI_L[nUI_HUDMODE_SIDEBYSIDE]          = "nUI Side by Side HUD Mode";
	nUI_L[nUI_HUDSKIN_SIDEBYSIDE_PET]      = nUI_L[nUI_HUDMODE_SIDEBYSIDE]..": skin for displaying the Player Pet's unit data";
	nUI_L[nUI_HUDSKIN_SIDEBYSIDE_PLAYER]   = nUI_L[nUI_HUDMODE_SIDEBYSIDE]..": skin for displaying the Player's unit data";
	nUI_L[nUI_HUDSKIN_SIDEBYSIDE_TARGET]   = nUI_L[nUI_HUDMODE_SIDEBYSIDE]..": skin for displaying the Target's unit data";
	nUI_L[nUI_HUDSKIN_SIDEBYSIDE_TOT]      = nUI_L[nUI_HUDMODE_SIDEBYSIDE]..": skin for displaying the Target of Target's (ToT) unit data";
	nUI_L[nUI_HUDSKIN_SIDEBYSIDE_CASTBAR]  = nUI_L[nUI_HUDMODE_SIDEBYSIDE]..": skin for displaying the Player's casting bar"; -- new
	
	nUI_L[nUI_HUDMODE_NOBARS]              = "nUI Simple Barless HUD Mode"; -- new
	nUI_L[nUI_HUDSKIN_NOBARS_CASTBAR]      = nUI_L[nUI_HUDMODE_NOBARS]..": skin for displaying the Player's casting bar"; -- new
	nUI_L[nUI_HUDSKIN_NOBARS_PLAYER]       = nUI_L[nUI_HUDMODE_NOBARS]..": skin for displaying the Player's unit data"; -- new
	nUI_L[nUI_HUDSKIN_NOBARS_TARGET]       = nUI_L[nUI_HUDMODE_NOBARS]..": skin for displaying the Target's unit data"; -- new
	
	-- nUI_Unit strings
	
	nUI_L["Pet"]        = "Pet";
	nUI_L["Target"]     = "Target";	
	nUI_L["Range"]      = "Range";
	nUI_L["MELEE"]      = "MELEE";      -- new -- used by the range to target module to indicate target is in melee or physical combat range
	nUI_L["Elite"]      = "Elite";      -- new -- used in unit frames to show the target is an elite mob
	nUI_L["Rare"]       = "Rare";       -- new -- used in unit frames to show the target is non-elite rare mob
	nUI_L["Rare Elite"] = "Rare Elite"; -- new -- used in unit frames to indate the target is both a rare mob and an elite mob
	nUI_L["World Boss"] = "World Boss"; -- new -- used in unit frames to indicate the target mob is a world boss
	nUI_L["Vehicle"]    = "Vehicle";    -- new -- used to identify that unit in question is a vehicle
	
	nUI_L["unit: player"]             = "Player";
	nUI_L["unit: vehicle"]            = "The Player's Vehicle"; -- new -- for WotLK vehicle unit frames
	nUI_L["unit: pet"]		          = "Player's Pet";
	nUI_L["unit: pettarget"]          = "Player Pet's Target";
	nUI_L["unit: focus"]              = "Player's Focus";
	nUI_L["unit: focustarget"]        = "Target of Player's Focus";
	nUI_L["unit: target"]             = "Player's Target";
	nUI_L["unit: %s-target"]          = "%s's Target";
	nUI_L["unit: mouseover"]          = "Mouseover Target";
	nUI_L["unit: targettarget"]       = "Target of Target (ToT)";
	nUI_L["unit: targettargettarget"] = "Target of ToT (ToTT)";
	nUI_L["unit: party%d"]            = "Party Member %d";
	nUI_L["unit: party%dpet"]         = "Party Member %d's Pet";
	nUI_L["unit: party%dtarget"]      = "Party Member %d's Target";
	nUI_L["unit: party%dpettarget"]   = "Party Member %d Pet's Target";
	nUI_L["unit: raid%d"]             = "Raid Member %d";
	nUI_L["unit: raid%dpet"]          = "Raid Member %d's Pet";
	nUI_L["unit: raid%dtarget"]       = "Raid Member %d's Target";
	nUI_L["unit: raid%dpettarget"]    = "Raid Member %d Pet's Target";

	nUI_L[nUI_UNITMODE_PLAYER]        = "nUI Solo Player Mode";
	nUI_L[nUI_UNITSKIN_SOLOFOCUS]     = nUI_L[nUI_UNITMODE_PLAYER]..": Player Focus' unit skin";
	nUI_L[nUI_UNITSKIN_SOLOMOUSE]     = nUI_L[nUI_UNITMODE_PLAYER]..": Mouseover target unit skin";
	nUI_L[nUI_UNITSKIN_SOLOVEHICLE]   = nUI_L[nUI_UNITMODE_PLAYER]..": Vehicle unit skin"; -- new -- for WotLK vehicle unit frames
	nUI_L[nUI_UNITSKIN_SOLOPET]       = nUI_L[nUI_UNITMODE_PLAYER]..": Player Pet's unit skin";
	nUI_L[nUI_UNITSKIN_SOLOPETBUTTON] = nUI_L[nUI_UNITMODE_PLAYER]..": Pet targeting button unit skins... i.e. Target's Pet, Player Focus' Pet, etc";
	nUI_L[nUI_UNITSKIN_SOLOPLAYER]    = nUI_L[nUI_UNITMODE_PLAYER]..": Player's unit skin";
	nUI_L[nUI_UNITSKIN_SOLOTARGET]    = nUI_L[nUI_UNITMODE_PLAYER]..": Target's unit skin";
	nUI_L[nUI_UNITSKIN_SOLOTGTBUTTON] = nUI_L[nUI_UNITMODE_PLAYER]..": Target targeting button unit skins... i.e. Player Focus' target, etc.";
	nUI_L[nUI_UNITSKIN_SOLOTOT]       = nUI_L[nUI_UNITMODE_PLAYER]..": Target of Target's (ToT) unit skin";

	nUI_L[nUI_UNITMODE_PARTY]          = "nUI Party/Group Mode";
	nUI_L[nUI_UNITSKIN_PARTYFOCUS]     = nUI_L[nUI_UNITMODE_PARTY]..": Player Focus' unit skin";
	nUI_L[nUI_UNITSKIN_PARTYMOUSE]     = nUI_L[nUI_UNITMODE_PARTY]..": Mouseover target unit skin";
	nUI_L[nUI_UNITSKIN_PARTYVEHICLE]   = nUI_L[nUI_UNITMODE_PARTY]..": Vehicle unit skin"; -- new -- for WotLK vehicle unit frames
	nUI_L[nUI_UNITSKIN_PARTYPLAYER]    = nUI_L[nUI_UNITMODE_PARTY]..": Player's unit skin";
	nUI_L[nUI_UNITSKIN_PARTYPET]       = nUI_L[nUI_UNITMODE_PARTY]..": Player Pet's unit skin";
	nUI_L[nUI_UNITSKIN_PARTYTARGET]    = nUI_L[nUI_UNITMODE_PARTY]..": Target's unit skin";
	nUI_L[nUI_UNITSKIN_PARTYTOT]       = nUI_L[nUI_UNITMODE_PARTY]..": Target of Target's (ToT) unit skin";
	nUI_L[nUI_UNITSKIN_PARTYFOCUS]     = nUI_L[nUI_UNITMODE_PARTY]..": Player Focus' unit skin";
	nUI_L[nUI_UNITSKIN_PARTYLEFT]      = nUI_L[nUI_UNITMODE_PARTY]..": Left side party member unit skin";
	nUI_L[nUI_UNITSKIN_PARTYRIGHT]     = nUI_L[nUI_UNITMODE_PARTY]..": Right side party member unit skin";
	nUI_L[nUI_UNITSKIN_PARTYPETBUTTON] = nUI_L[nUI_UNITMODE_PARTY]..": Party Member and Focus' pet button unit skin";
	nUI_L[nUI_UNITSKIN_PARTYTGTBUTTON] = nUI_L[nUI_UNITMODE_PARTY]..": Party Member and Focus' target button unit skin";
	nUI_L[nUI_UNITSKIN_PARTYMOUSE]     = nUI_L[nUI_UNITMODE_PARTY]..": Mouseover unit skin";
	
	nUI_L[nUI_UNITMODE_RAID10]          ="nUI 10 Player Raid Mode";
	nUI_L[nUI_UNITSKIN_RAID10FOCUS]     = nUI_L[nUI_UNITMODE_RAID10]..": Player Focus' unit skin";
	nUI_L[nUI_UNITSKIN_RAID10MOUSE]     = nUI_L[nUI_UNITMODE_RAID10]..": Mouseover target unit skin";
	nUI_L[nUI_UNITSKIN_RAID10VEHICLE]   = nUI_L[nUI_UNITMODE_RAID10]..": Vehicle unit skin"; -- new -- for WotLK vehicle unit frames
	nUI_L[nUI_UNITSKIN_RAID10PLAYER]    = nUI_L[nUI_UNITMODE_RAID10]..": Player's unit skin";
	nUI_L[nUI_UNITSKIN_RAID10PET]       = nUI_L[nUI_UNITMODE_RAID10]..": Player Pet's unit skin";
	nUI_L[nUI_UNITSKIN_RAID10TARGET]    = nUI_L[nUI_UNITMODE_RAID10]..": Target's unit skin";
	nUI_L[nUI_UNITSKIN_RAID10TOT]       = nUI_L[nUI_UNITMODE_RAID10]..": Target of Target's (ToT) unit skin";
	nUI_L[nUI_UNITSKIN_RAID10FOCUS]     = nUI_L[nUI_UNITMODE_RAID10]..": Player Focus' unit skin";
	nUI_L[nUI_UNITSKIN_RAID10LEFT]      = nUI_L[nUI_UNITMODE_RAID10]..": Left side raid member unit skin";
	nUI_L[nUI_UNITSKIN_RAID10RIGHT]     = nUI_L[nUI_UNITMODE_RAID10]..": Right side raid member unit skin";
	nUI_L[nUI_UNITSKIN_RAID10PETBUTTON] = nUI_L[nUI_UNITMODE_RAID10]..": Raid Member and Focus' pet button unit skin";
	nUI_L[nUI_UNITSKIN_RAID10TGTBUTTON] = nUI_L[nUI_UNITMODE_RAID10]..": Raid Member and Focus' target button unit skin";
	nUI_L[nUI_UNITSKIN_RAID10MOUSE]     = nUI_L[nUI_UNITMODE_RAID10]..": Mouseover unit skin";
	
	-- new -- all of these sections have been added for 5.0
	
	nUI_L[nUI_UNITMODE_RAID15]          ="nUI 15 Player Raid Mode";
	nUI_L[nUI_UNITSKIN_RAID15FOCUS]     = nUI_L[nUI_UNITMODE_RAID15]..": Player Focus' unit skin";
	nUI_L[nUI_UNITSKIN_RAID15MOUSE]     = nUI_L[nUI_UNITMODE_RAID15]..": Mouseover target unit skin";
	nUI_L[nUI_UNITSKIN_RAID15VEHICLE]   = nUI_L[nUI_UNITMODE_RAID15]..": Vehicle unit skin";
	nUI_L[nUI_UNITSKIN_RAID15PLAYER]    = nUI_L[nUI_UNITMODE_RAID15]..": Player's unit skin";
	nUI_L[nUI_UNITSKIN_RAID15PET]       = nUI_L[nUI_UNITMODE_RAID15]..": Player Pet's unit skin";
	nUI_L[nUI_UNITSKIN_RAID15TARGET]    = nUI_L[nUI_UNITMODE_RAID15]..": Target's unit skin";
	nUI_L[nUI_UNITSKIN_RAID15TOT]       = nUI_L[nUI_UNITMODE_RAID15]..": Target of Target's (ToT) unit skin";
	nUI_L[nUI_UNITSKIN_RAID15FOCUS]     = nUI_L[nUI_UNITMODE_RAID15]..": Player Focus' unit skin";
	nUI_L[nUI_UNITSKIN_RAID15LEFT]      = nUI_L[nUI_UNITMODE_RAID15]..": Left side raid member unit skin";
	nUI_L[nUI_UNITSKIN_RAID15RIGHT]     = nUI_L[nUI_UNITMODE_RAID15]..": Right side raid member unit skin";
	nUI_L[nUI_UNITSKIN_RAID15PETBUTTON] = nUI_L[nUI_UNITMODE_RAID15]..": Raid Member and Focus' pet button unit skin";
	nUI_L[nUI_UNITSKIN_RAID15TGTBUTTON] = nUI_L[nUI_UNITMODE_RAID15]..": Raid Member and Focus' target button unit skin";
	nUI_L[nUI_UNITSKIN_RAID15MOUSE]     = nUI_L[nUI_UNITMODE_RAID15]..": Mouseover unit skin";
	
	nUI_L[nUI_UNITMODE_RAID20]          ="nUI 20 Player Raid Mode";
	nUI_L[nUI_UNITSKIN_RAID20FOCUS]     = nUI_L[nUI_UNITMODE_RAID20]..": Player Focus' unit skin";
	nUI_L[nUI_UNITSKIN_RAID20MOUSE]     = nUI_L[nUI_UNITMODE_RAID20]..": Mouseover target unit skin";
	nUI_L[nUI_UNITSKIN_RAID20VEHICLE]   = nUI_L[nUI_UNITMODE_RAID20]..": Vehicle unit skin";
	nUI_L[nUI_UNITSKIN_RAID20PLAYER]    = nUI_L[nUI_UNITMODE_RAID20]..": Player's unit skin";
	nUI_L[nUI_UNITSKIN_RAID20PET]       = nUI_L[nUI_UNITMODE_RAID20]..": Player Pet's unit skin";
	nUI_L[nUI_UNITSKIN_RAID20TARGET]    = nUI_L[nUI_UNITMODE_RAID20]..": Target's unit skin";
	nUI_L[nUI_UNITSKIN_RAID20TOT]       = nUI_L[nUI_UNITMODE_RAID20]..": Target of Target's (ToT) unit skin";
	nUI_L[nUI_UNITSKIN_RAID20FOCUS]     = nUI_L[nUI_UNITMODE_RAID20]..": Player Focus' unit skin";
	nUI_L[nUI_UNITSKIN_RAID20LEFT]      = nUI_L[nUI_UNITMODE_RAID20]..": Left side raid member unit skin";
	nUI_L[nUI_UNITSKIN_RAID20RIGHT]     = nUI_L[nUI_UNITMODE_RAID20]..": Right side raid member unit skin";
	nUI_L[nUI_UNITSKIN_RAID20PETBUTTON] = nUI_L[nUI_UNITMODE_RAID20]..": Raid Member and Focus' pet button unit skin";
	nUI_L[nUI_UNITSKIN_RAID20TGTBUTTON] = nUI_L[nUI_UNITMODE_RAID20]..": Raid Member and Focus' target button unit skin";
	nUI_L[nUI_UNITSKIN_RAID20MOUSE]     = nUI_L[nUI_UNITMODE_RAID20]..": Mouseover unit skin";
	
	nUI_L[nUI_UNITMODE_RAID25]          ="nUI 25 Player Raid Mode";
	nUI_L[nUI_UNITSKIN_RAID25FOCUS]     = nUI_L[nUI_UNITMODE_RAID25]..": Player Focus' unit skin";
	nUI_L[nUI_UNITSKIN_RAID25MOUSE]     = nUI_L[nUI_UNITMODE_RAID25]..": Mouseover target unit skin";
	nUI_L[nUI_UNITSKIN_RAID25VEHICLE]   = nUI_L[nUI_UNITMODE_RAID25]..": Vehicle unit skin";
	nUI_L[nUI_UNITSKIN_RAID25PLAYER]    = nUI_L[nUI_UNITMODE_RAID25]..": Player's unit skin";
	nUI_L[nUI_UNITSKIN_RAID25PET]       = nUI_L[nUI_UNITMODE_RAID25]..": Player Pet's unit skin";
	nUI_L[nUI_UNITSKIN_RAID25TARGET]    = nUI_L[nUI_UNITMODE_RAID25]..": Target's unit skin";
	nUI_L[nUI_UNITSKIN_RAID25TOT]       = nUI_L[nUI_UNITMODE_RAID25]..": Target of Target's (ToT) unit skin";
	nUI_L[nUI_UNITSKIN_RAID25FOCUS]     = nUI_L[nUI_UNITMODE_RAID25]..": Player Focus' unit skin";
	nUI_L[nUI_UNITSKIN_RAID25LEFT]      = nUI_L[nUI_UNITMODE_RAID25]..": Left side raid member unit skin";
	nUI_L[nUI_UNITSKIN_RAID25RIGHT]     = nUI_L[nUI_UNITMODE_RAID25]..": Right side raid member unit skin";
	nUI_L[nUI_UNITSKIN_RAID25PETBUTTON] = nUI_L[nUI_UNITMODE_RAID25]..": Raid Member and Focus' pet button unit skin";
	nUI_L[nUI_UNITSKIN_RAID25TGTBUTTON] = nUI_L[nUI_UNITMODE_RAID25]..": Raid Member and Focus' target button unit skin";
	nUI_L[nUI_UNITSKIN_RAID25MOUSE]     = nUI_L[nUI_UNITMODE_RAID25]..": Mouseover unit skin";
	
	nUI_L[nUI_UNITMODE_RAID40]          ="nUI 40 Player Raid Mode";
	nUI_L[nUI_UNITSKIN_RAID40FOCUS]     = nUI_L[nUI_UNITMODE_RAID40]..": Player Focus' unit skin";
	nUI_L[nUI_UNITSKIN_RAID40MOUSE]     = nUI_L[nUI_UNITMODE_RAID40]..": Mouseover target unit skin";
	nUI_L[nUI_UNITSKIN_RAID40VEHICLE]   = nUI_L[nUI_UNITMODE_RAID40]..": Vehicle unit skin";
	nUI_L[nUI_UNITSKIN_RAID40PLAYER]    = nUI_L[nUI_UNITMODE_RAID40]..": Player's unit skin";
	nUI_L[nUI_UNITSKIN_RAID40PET]       = nUI_L[nUI_UNITMODE_RAID40]..": Player Pet's unit skin";
	nUI_L[nUI_UNITSKIN_RAID40TARGET]    = nUI_L[nUI_UNITMODE_RAID40]..": Target's unit skin";
	nUI_L[nUI_UNITSKIN_RAID40TOT]       = nUI_L[nUI_UNITMODE_RAID40]..": Target of Target's (ToT) unit skin";
	nUI_L[nUI_UNITSKIN_RAID40FOCUS]     = nUI_L[nUI_UNITMODE_RAID40]..": Player Focus' unit skin";
	nUI_L[nUI_UNITSKIN_RAID40LEFT]      = nUI_L[nUI_UNITMODE_RAID40]..": Left side raid member unit skin";
	nUI_L[nUI_UNITSKIN_RAID40RIGHT]     = nUI_L[nUI_UNITMODE_RAID40]..": Right side raid member unit skin";
	nUI_L[nUI_UNITSKIN_RAID40PETBUTTON] = nUI_L[nUI_UNITMODE_RAID40]..": Raid Member and Focus' pet button unit skin";
	nUI_L[nUI_UNITSKIN_RAID40TGTBUTTON] = nUI_L[nUI_UNITMODE_RAID40]..": Raid Member and Focus' target button unit skin";
	nUI_L[nUI_UNITSKIN_RAID40MOUSE]     = nUI_L[nUI_UNITMODE_RAID40]..": Mouseover unit skin";
	
	nUI_L[nUI_UNITPANEL_PLAYER]      		= "Unit Panel: Solo Player Mode";
	nUI_L[nUI_UNITPANEL_PLAYER.."Label"]	= "Player";
	
	nUI_L[nUI_UNITPANEL_PARTY]       		= "Unit Panel: Party/Group Mode";
	nUI_L[nUI_UNITPANEL_PARTY.."Label"] 	= "Party";
	
	nUI_L[nUI_UNITPANEL_RAID10]      		= "Unit Panel: 10 Player Raid Mode";
	nUI_L[nUI_UNITPANEL_RAID10.."Label"]	= "Raid 10";
	
	nUI_L[nUI_UNITPANEL_RAID15]      		= "Unit Panel: 15 Player Raid Mode";
	nUI_L[nUI_UNITPANEL_RAID15.."Label"]	= "Raid 15";
	
	nUI_L[nUI_UNITPANEL_RAID20]      		= "Unit Panel: 20 Player Raid Mode";
	nUI_L[nUI_UNITPANEL_RAID20.."Label"]	= "Raid 20";
	
	nUI_L[nUI_UNITPANEL_RAID25]      		= "Unit Panel: 25 Player Raid Mode";
	nUI_L[nUI_UNITPANEL_RAID25.."Label"]	= "Raid 25";
	
	nUI_L[nUI_UNITPANEL_RAID40]      		= "Unit Panel: 40 Player Raid Mode";
	nUI_L[nUI_UNITPANEL_RAID40.."Label"]	= "Raid 40";
	
	nUI_L["Click to change unit frame panels"] = "Click to change unit frame panels";
	
	nUI_L["<unnamed frame>"] = "<unnamed frame>";
	nUI_L["unit change"] = "unit change";
	nUI_L["unit class"] = "unit class";
	nUI_L["unit label"] = "unit label";
	nUI_L["unit level"] = "unit level";
	nUI_L["unit reaction"] = "unit reaction";
	nUI_L["unit health"] = "unit health";
	nUI_L["unit power"] = "unit power";
	nUI_L["unit portrait"] = "unit portrait";
	nUI_L["raid group"] = "raid group";
	nUI_L["unit PvP"] = "unit PvP";
	nUI_L["raid target"] = "raid target";
	nUI_L["casting bar"] = "casting bar";
	nUI_L["ready check"] = "ready check";
	nUI_L["unit status"] = "unit status";
	nUI_L["unit aura"] = "unit aura";
	nUI_L["unit combat"] = "unit combat";
	nUI_L["unit resting"] = "unit resting";
	nUI_L["unit role"] = "unit role";
	nUI_L["unit runes"]        = "unit runes"; -- new -- Death Knight rune frame events
	nUI_L["unit feedback"] = "unit feedback";
	nUI_L["unit combo points"] = "unit combo points"; -- new -- unit frame module that display's rogue/druid combe point icons
	nUI_L["unit range"]        = "unit range"; -- new -- unit frame module that calculates the range to target
	nUI_L["unit spec"]         = "unit spec"; -- new -- unit frame module that determines the unit's talent build (or displays elite/rare/world boss tags)
	nUI_L["unit threat"]       = "unit threat"; -- new -- changed in threat status for a given unit
	
	nUI_L["Talent Build: <build name> (<talent points>)"] = "Talent Build: |cFF00FFFF%s|r (%s)"; -- new -- used to display the unit's talent tree build in the unit frame mouseover tooltip
	nUI_L["passed unit id is <nil> in callback table for %s"] = "passed unit id is <nil> in callback table for %s";
	nUI_L["nUI: Warning.. anchoring %s to %s -- anchor point has a <nil> value."] = "nUI: Warning.. anchoring %s to %s -- anchor point has a <nil> value.";
	nUI_L["nUI: Cannot register %s for scaling... frame does not have a applyScale() method"] = "nUI: Cannot register %s for scaling... frame does not have a applyScale() method";
	nUI_L["nUI: Cannot register %s for scaling... frame does not have a applyAnchor() method"] = "nUI: Cannot register %s for scaling... frame does not have a applyAnchor() method";
	nUI_L["nUI: %s %s callback %s does not have a newUnitInfo() method."] = "nUI: %s %s callback %s does not have a newUnitInfo() method.";
	nUI_L["nUI_UnitClass.lua: unhandled unit class [%s] for [%s]"] = "nUI_UnitClass.lua: unhandled unit class [%s] for [%s]";
	nUI_L["nUI: click-casting registration is %s"] = "nUI: click-casting registration is %s";
	nUI_L["nUI: must pass a valid parent frame to nUI_Unit:createFrame() for unit id [%s (%s)]"] = "nUI: must pass a valid parent frame to nUI_Unit:createFrame() for unit id [%s (%s)]";
	nUI_L["nUI says: Gratz for reaching level %d %s!"] = "nUI says: Gratz for reaching level %d %s!";
	nUI_L["nUI_Unit: [%s] is not a valid unit frame element type!"] = "nUI_Unit: [%s] is not a valid unit frame element type!";
	nUI_L["nUI_Unit: [%s] is not a known unit skin name!"] = "nUI_Unit: [%s] is not a known unit skin name!";
	nUI_L["Your pet's current damage bonus is %d%%"] = "Your pet's current damage bonus is %+d%%";
	nUI_L["Your pet's current damage penalty is %d%%"] = "Your pet's current damage penalty is %+d%%";
	nUI_L["nUI: It looks to me like you're a little busy... maybe you should try feeding %s AFTER you leave combat?"] = "nUI: It looks to me like you're a little busy... maybe you should try feeding %s AFTER you leave combat?";
	nUI_L["nUI: I looked everywhere, but I couldn't find a pet to feed. Perhaps he's in your backpack?"] = "nUI: I looked everywhere, but I couldn't find a pet to feed. Perhaps he's in your backpack?";
	nUI_L["nUI: You know, I could be wrong, but I don't think feeding %s is a very good idea... it doesn't look to me like what you have in your bags is what %s is thinking about eating."] = "nUI: You know, I could be wrong, but I don't think feeding %s is a very good idea... it doesn't look to me like what you have in your bags is what %s is thinking about eating.";
	
	-- nUI_Unit hunter pet strings
	
	nUI_L["Your pet"] = "Your pet";
	nUI_L["quickly"] = "quickly";
	nUI_L["slowly"] = "slowly";
	nUI_L["nUI: %s is happy."] = "nUI: %s is happy.";
	nUI_L["nUI: %s is unhappy... time to feed!"] = "nUI: %s is unhappy... time to feed!";
	nUI_L["nUI: Warning! %s is |cFFFFFFFFNOT|r happy! Better feed soon."] = "nUI: Warning! %s is |cFFFFFFFFNOT|r happy! Better feed soon.";
	nUI_L["nUI: Warning... %s is %s losing loyalty "] = "nUI: Warning... %s is %s losing loyalty ";
	nUI_L["nUI: %s is %s gaining loyalty"] = "nUI: %s is %s gaining loyalty";
	nUI_L["nUI: %s has stopped gaining loyalty"] = "nUI: %s has stopped gaining loyalty";
	nUI_L["nUI: %s has stopped losing loyalty"] = "nUI: %s has stopped losing loyalty";
	
	-- miscelaneous strings
	
	nUI_L["Version"]                     = "nUI Version |cFF00FF00%s|r";
	nUI_L["Copyright"]                   = "Copyright (C) 2008 by K. Scott Piel";
	nUI_L["Rights"]                      = "All Rights Reserved";
	nUI_L["Off Hand Weapon:"]            = "Off Hand Weapon:";
	nUI_L["Main Hand Weapon:"]           = "Main Hand Weapon:";
	nUI_L["Group %d"]                    = "Group %d";
	nUI_L["MS"]                          = "MS";
	nUI_L["FPS"]				         = "FPS";
	nUI_L["Minimap Button Bag"]          = "Minimap Button Bag";
	nUI_L["System Performance Stats..."] = "System Performance Stats..."; -- new... header label for in-game tooltip showing current frame rate, latency and addon memory usage information
	nUI_L["PvP Time Remaining: <time_left>"] = "PvP Time Remaining: |cFF50FF50%s|r" -- new -- displays the amount of time left before the PvP flag clears in the player tooltip
	
	nUI_L["Cursor: <cursor_x,cursor_y>  /  Player: <player_x,player_y>"] = "Cursor: |cFF00FFFF<%0.1f, %0.1f>|r  /  Player: |cFF00FFFF<%0.1f, %0.1f>|r"; -- new
	nUI_L["nUI has disabled the plugin 'nui_AuraBars' as it is now incorporated in nUI 5.0 -- Please use '/nui rl' to reload the UI. You should uninstall nUI_AuraBars as well."] = "nUI has disabled the plugin 'nui_AuraBars' as it is now incorporated in nUI 5.0 -- Please use '/nui rl' to reload the UI. You should uninstall nUI_AuraBars as well."; -- new
	
	-- key binding strings
	
	nUI_L["HUD Layout"]                  = "HUD Layout"; -- new -- used as a label in the keybinding interface to identify the button used to change HUD layouts
	nUI_L["Unit Panel Mode"]             = "Unit Panel Mode"; -- new -- used as a label in the keybinding interface to identify the button used to change unit panels (player/party/raid10)
	nUI_L["Info Panel Mode"]             = "Info Panel Mode"; -- new -- used as a label in the keybinding interface to identify the button used to change information panels (map, omen3, recount, etc)
	nUI_L["Key Binding"]                 = "Key Binding"; -- new -- used a label to identify key bindings on action button tooltips
	nUI_L["Miscellaneous Bindings"]      = "Miscellaneous Bindings"; -- new -- header label in the key binding interface for nUI's miscellaneous keys like unit panel, info panel, hud, buttonbag
	nUI_L["No key bindings found"]       = "No key bindings found"; -- new -- printed in tooltips if there are no key bindings for an action button
	nUI_L["<ctrl-alt-right click> to change bindings"] = "<ctrl-alt-right click> to change bindings"; -- new -- printed in tooltip to alert the user on how to change key bindings

	-- rare spotting strings
	
	nUI_L["You have spotted a rare mob: |cFF00FF00<mob name>|r<location>"] = "You have spotted a rare mob: |cFF00FF00%s|r%s"; -- new -- used by the rare spotter function to alert the user to a rare mob being sighted
	nUI_L["You have spotted a rare elite mob: |cFF00FF00<mob name>|r<location>"] = "You have spotted a rare elite mob: |cFF00FF00%s|r%s"; -- new -- used by the rare spotter function to alert the user to a rare mob being sighted
	
	-- faction / reputation bar strings
	
	nUI_L["Unknown"]    = "Unknown"; -- new -- these strings are all used to print the player's reputation with a given faction
	nUI_L["Hated"]      = "Hated"; -- new -- i.e. "You are Hated by the Bucksail Buckaneers"
	nUI_L["Hostile"]    = "Hostile"; -- new
	nUI_L["Unfriendly"] = "Unfriendly"; -- new
	nUI_L["Neutral"]    = "Neutral"; -- new
	nUI_L["Friendly"]   = "Friendly"; -- new
	nUI_L["Honored"]    = "Honored"; -- new
	nUI_L["Revered"]    = "Revered"; -- new
	nUI_L["Exalted"]    = "Exalted"; -- new
	
	nUI_L["Faction: <faction name>"]    = "Faction: |cFF00FFFF%s|r"; -- new -- used to display faction name in reputation bar mouseover tooltip
	nUI_L["Reputation: <rep level>"]    = "Reputation: |cFF00FFFF%s|r"; -- new -- one of "Hated", "Hostile", "Neutral", "Honored", etc.
	nUI_L["Current Rep: <number>"]      = "Current Rep: |cFF00FFFF%d|r"; -- new -- how much reputation has the player earned toward the next level?
	nUI_L["Required Rep: <number>"]     = "Required Rep: |cFF00FFFF%d|r"; -- new -- how reputation does the player need to get to the next level?
	nUI_L["Remaining Rep: <number>"]    = "Remaining Rep: |cFF00FFFF%d|r"; -- new -- how much reputation is left to earn to reach the next level? (required rep - current rep = remaining rep)
	nUI_L["Percent Complete: <number>"] = "Percent Complete: |cFF00FFFF%0.1f%%|r"; -- new -- how much of this level has the player completed as a percent of total? (currently rep / required rep = percent complete)
	nUI_L["<faction name> (<reputation>) <current rep> of <required rep> (<percent complete>)"] = "%s (%s) %d of %d (%0.1f%%)"; -- new -- used to print a reputation bar label showing current faction facts
	
	nUI_L[nUI_FACTION_UPDATE_START_STRING]    = "Reputation with "; -- new -- used to mark the beginning of a faction update line in combat log
	nUI_L[nUI_FACTION_UPDATE_END_STRING]      = " increased"; -- new -- used to mark the end of the faction name in the update line
	nUI_L[nUI_FACTION_UPDATE_INCREASE_STRING] = "increased"; -- new -- used to indicate that the update is an increase in faction
	
	-- player experience bar strings
	
	nUI_L["Current level: <level>"]                         = "Current level: |cFF00FFFF%d|r"; -- new -- used to print the player's current level in tooltip text
	nUI_L["Current XP: <experience points>"]                = "Current XP: |cFF00FFFF%d|r"; -- new -- how much XP has the player earned so far in this level
	nUI_L["Required XP: <XP required to reach next level>"] = "Required XP: |cFF00FFFF%d|r"; -- new -- how much XP has the player got to earn to complete this level
	nUI_L["Remaining XP: <XP remaining to level>"]          = "Remaining XP: |cFF00FFFF%d|r"; -- new -- how much XP is left to earn to complete this level (required XP - current XP = remaining XP)
	nUI_L["Percent complete: <current XP / required XP>"]   = "Percent complete: |cFF00FFFF%0.1f%%|r"; -- new -- how much of this level has the player completed as a percent (current XP / required XP = percent complete)
	nUI_L["Rested XP: <total rested experience> (percent)"] = "Rested XP: |cFF00FFFF%d|r (%0.1f%%)"; -- new -- prints how much total rested XP the player has remaining as both a value and a percent of the total XP required for the current level
	nUI_L["Rested Levels: <levels>"]                        = "Rested Levels: |cFF00FFFF%0.2f|r"; -- new -- the number of levels the player can earn from their current XP + rested XP remaining
	nUI_L["Level <player level>: <experience> of <max experience> (<percent of total>), <rested xp> rested XP"] = "Level %d: %d of %d (%0.1f%%), %d rested XP"; -- new -- used to display player's current experience level
	
	-- health race bar tooltip strings
	
	nUI_L["nUI Health Race Stats..."] = "nUI Health Race Stats...";
	nUI_L["No current advantage to <player> or <target>"] = "No current advantage to %s or %s";
	nUI_L["<unit name>'s Health: <current>/<maximum> (<percent>)"] = "%s's Health: |cFF00FF00%d/%d|r (|cFFFFFFFF%0.1f%%|r)";
	nUI_L["Advantage to <player>: <pct>"] = "Advantage to %s: (|cFF00FF00%+0.1f%%|r)";
	nUI_L["Advantage to <target>: <pct>"] = "Advantage to %s: (|cFFFFC0C0%0.1f%%|r)";
	
	-- skinning system messages
	
	nUI_L["nUI could not load the currently selected skin [ %s ]... perhaps you have it disabled? Switching to the default nUI skin."] = "nUI could not load the currently selected skin [ |cFFFFC0C0%s|r ]... perhaps you have it disabled? Switching to the default nUI skin.";
	nUI_L["nUI: Cannot register %s for skinning... frame does not have a applySkin() method"] = "nUI: Cannot register |cFFFFC0C0%s|r for skinning... frame does not have a applySkin() method";
	
	-- names of the various frames that nUI allows the user to move on the screen
	
	nUI_L["Micro-Menu"]                = "Micro-Menu";
	nUI_L["Capture Bar"]               = "Capture Bar";
	nUI_L["Watched Quests"]            = "Watched Quests";
	nUI_L["Quest Timer"]               = "Quest Timer";
	nUI_L["Equipment Durability"]      = "Equipment Durability";
	nUI_L["PvP Objectives"]            = "PvP Objectives";
	nUI_L["Watched Achievments"]       = "Watched Achievments"; -- new... the '/nui movers' label for the achievements watch frame mover label
	nUI_L["In-Game Tooltips"]          = "In-Game Tooltips";
	nUI_L["Bag Bar"]                   = "Bag Bar";
	nUI_L["Group Loot Frame"]          = "Group Loot Frame"; -- new -- used to label the four group looting frames (greed/need frames)
	nUI_L["nUI_ActionBar"]             = "Main Bar / Action Page 1"; -- new
	nUI_L["nUI_BottomLeftBar"]         = "Bottom Left Bar / Action Page 2"; -- new
	nUI_L["nUI_LeftUnitBar"]           = "Left Unit Frame Bar / Action Page 3"; -- new
	nUI_L["nUI_RightUnitBar"]          = "Right Unit Frame Bar / Action Page 4"; -- new
	nUI_L["nUI_TopRightBar"]           = "Top Right Bar / Action Page 5"; -- new
	nUI_L["nUI_TopLeftBar"]            = "Top Left Bar / Action Page 6"; -- new
	nUI_L["nUI_BottomRightBar"]        = "Bottom Right Bar"; -- new
	nUI_L["Pet/Stance/Shapeshift Bar"] = "Pet/Stance/Shapeshift Bar";
	nUI_L["Vehicle Seat Indicator"]    = "Vehicle Seat Indicator"; -- new
	nUI_L["Voice Chat Talkers"]        = "Voice Chat Talkers"; -- new
	nUI_L["Timer Bar"]                 = "Timer Bar"; -- new
	
	-- slash command processing	
	
	nUI_SlashCommands =
	{
		[nUI_SLASHCMD_HELP] =
		{
			command = "help",
			options = "{command}",
			desc    = "Displays the list of all available slash commands if {command} is not given or, if {command} is given, displays information about that specific command",
			message = nil,
		},
		[nUI_SLASHCMD_RELOAD] =
		{
			command = "rl",
			options = nil,
			desc    = "Reloads the user interface and all enabled mods (same as /console reloadui)",
			message = nil,
		},
		[nUI_SLASHCMD_BUTTONBAG] =
		{
			command = "bb",
			options = nil,
			desc    = "This command toggles the display of the Minimap Button Bag on and off.",
			message = nil,
		},
		[nUI_SLASHCMD_MOVERS] =
		{
			command = "movers",
			options = nil,
			desc    = "Enables and disables moving the standard Blizzard UI frames such as tooltips, durability, quest timer, etc.",
			message = "nUI: Blizzard frame movers have been %s", -- enabled or disabled
		},
		[nUI_SLASHCMD_CONSOLE] =
		{
			command = "console",
			options = "{on|off|mouseover}",
			desc    = "Sets the visibility option for the top console where 'on' always show the console, 'off' always hides the console and 'mouseover' shows the console when the mouse is over the console.",
			message = "nUI: Top console visibility has been set to %s", -- "on", "off" or "mouseover"
		},
		[nUI_SLASHCMD_TOOLTIPS] =
		{
			command = "tooltips",
			options = "{owner|mouse|fixed|default}",
			desc    = "This option sets the location of the mouseover tooltips where 'owner' displays the tooltip next to the frame that owns it, 'mouse' displays the tooltip at the current mouse location, 'fixed' displays all tooltips at a fixed location on screen or 'default' does not manage tooltips at all",
			message = "nUI: Tooltip display mode changed to |cFF00FFFF%s|r", -- the chosen tooltip mode
		},
		[nUI_SLASHCMD_COMBATTIPS] = -- new
		{
			command = "combattips",
			options = nil,
			desc    = "This option toggles display of action button tooltips on and off while in combat lockdown. The default is to hide the tooltips in your action bar buttons while in combat.",
			message = "nUI: Tooltip display during combat lockdown has been %s", -- enabled or disabled
		},
		[nUI_SLASHCMD_BAGSCALE] =
		{
			command = "bagscale",
			options = "{n}",
			desc    = "This option increases and decreases the size of your bags where {n} is a number between 0.5 and 1.5 -- 1 is the default",
			message = "nUI: Your bag scale has been changed to |cFF00FFFF%0.2f|r", -- the chosen scale
		},
		[nUI_SLASHCMD_BAGBAR] = -- new
		{
			command = "bagbar",
			options = "{on|off|mouseover}",
			desc    = "This option sets the bag bar display on, off or only visible on mouseover. The default is always on.",
			message = "nUI: The bag bar's display has been set to |cFF00FFFF%s|r", -- on, off or mouseover
		},
		[nUI_SLASHCMD_CALENDAR] = -- new
		{
			command = "calendar",
			options = nil,
			desc    = "By default, nUI moves the guild calendar button from the minimap into the button bag. This option toggles that on and off allowing for leaving the guild calendar displayed on the minimap.",
			message = "nUI: The management of the guild calendar button has been %s", -- ENABLED or DISABLED
		},
		[nUI_SLASHCMD_FRAMERATE] =
		{
			command = "framerate",
			options = "{n}",
			desc    = "This option changes (or throttles) the maximum refresh rate for bar animations and unit frames. Increase {n} for smoothness, decrease {n} for performance. The default is "..nUI_DEFAULT_FRAME_RATE.." frames per second.",
			message = "nUI: Your refresh frame rate has been changed to |cFF00FFFF%0.0fFPS|r", -- the chosen rate in frames per second... change FPS if you need a different abreviation!
		},
		[nUI_SLASHCMD_FEEDBACK] = -- new
		{
			command = "feedback",
			options = "{curse|disease|magic|poison}",
			desc    = "nUI provides a highlight on unit frames for any unit which has a curse, disease, magic or poison aura debuff on it. By default, all four types are highlighted. This option lets you turn each one on or off individually so that only those auras you can dispell are highlighted.",
			message = "nUI: Unit frame highlights for |cFF00FFFF%s debuffs|r has been %s", -- aura type and enabled or disabled
		},
		[nUI_SLASHCMD_SHOWHITS] = -- new
		{
			command = "showhits",
			options = nil,
			desc    = "nUI's unit frames highlight the background red and green to show when the unit is taking damage or receiving heals. This option toggles that behavior on and off. By default it is on.",
			message = "nUI: Unit frame display of hits and heals has been %s", -- enabled or disabled
		},
		[nUI_SLASHCMD_MAXAURAS] = -- new
		{
			command = "maxauras",
			options = "{1-40}",
			desc    = "By default nUI will display up to the maximum possible 40 auras on each of the key units: player, pet, vehicle and target. This option lets you set the maximum number of auras to a smaller value between 0 and 40. Setting maxauras to zero (0) will disable the aura display.",
			message = "nUI: The maximum number of auras has been set to |cFF00FFFF%d|r", -- a number from 0 to 40
		},
		[nUI_SLASHCMD_AUTOGROUP] = -- new
		{
			command = "autogroup",
			options = nil,
			desc    = "By default nUI automatically changes your unit panel to the best fitting panel when you join or leave a group or raid or when your raid roster changes. This option toggles that behavior on and off.",
			message = "nUI: Automatic unit panel switch is %s when joining and leaving groups or raids",
		},
		[nUI_SLASHCMD_RAIDSORT] = -- new
		{
			command = "raidsort",
			options = "{unit|group|class|name}",
			desc    = "Selects the sort order used to display unit frames while in a raid. The 'unit' option sorts unit frames by the unit ID from raid1 to raid40. The 'group' option sorts unit frames by the raid group number, the 'class' option sorts by the player class and the 'name' option sorts by player name. The default is to sort unit frames by the raid group.",
			message = "nUI: Raid group sorting has been set to |cFF00FF00%s|r", -- sort option: group, unit or class
		},
		[nUI_SLASHCMD_SHOWANIM] =
		{
			command = "anim",
			options = nil,
			desc    = "This option toggles display of animated unit portraits and unit bars on and off",
			message = "nUI: Display of animated unit frames has been %s", -- enabled or disabled
		},
		[nUI_SLASHCMD_HPLOST] = -- new 
		{
			command = "hplost",
			options = nil,
			desc    = "This option toggles display of player health on unit frames from HP remaining to HP lost. This is of particular value to healers.",
			message = "nUI: Display of health values has been changed to %s", -- "health remaining" or "health lost"
		},
		[nUI_SLASHCMD_HUD] =
		{
			command  = "hud",
			options  = nil,
			desc     = "This command provides access to a set of commands used to control the behavior of the nUI HUD. Use the '/nui hud' command alone for a list of available sub-commands.",
			message  = nil,
			sub_menu =
			{
				[nUI_SLASHCMD_HUD_SCALE] =
				{
					command = "scale",
					options = "{n}",
					desc    = "This option sets the scale of the HUD where 0.25 <= {n} <= 1.75. Smaller values of {n} descrease the HUD size and larger values increase the size. The default is {n} = 1",
					message = "nUI: The HUD scale has been set to |cFF00FFFF%0.2f|r", -- a number
				},
				[nUI_SLASHCMD_HUD_SHOWNPC] =
				{
					command = "shownpc",
					options = nil,
					desc    = "This option toggles display of HUD bars for non-attackable NPC targets on and off when out of combat",
					message = "nUI: Non-attackable NPC target HUD bar display has been %s", -- enabled or disabled
				},
				[nUI_SLASHCMD_HUD_FOCUS] = -- new
				{
					command = "focus",
					options = nil,
					desc    = "By default, the HUD does not display information about the player's focus. Enabling this option will replace the HUD target and ToT with the player's focus and focus target when a focus is selected.",
					message = "nUI: HUD display of the player focus and focus target is %s", -- enabled or disabled
				},
				[nUI_SLASHCMD_HUD_HEALTHRACE] =
				{
					command = "healthrace",
					options = nil,
					desc    = "This option toggles display of in-HUD health race bar on and off",
					message = "nUI: The HUD health race bar display has been %s", -- enabled or disabled
				},
				[nUI_SLASHCMD_HUD_COOLDOWN] = -- new
				{
					command = "cooldown",
					options = nil,
					desc    = "This option toggles display of in-HUD spell cooldown bar, cooldown alert messages and cooldown sounds on and off.",
					message = "nUI: The HUD spell cooldown bar display has been %s",
				},
				[nUI_SLASHCMD_HUD_CDALERT] = -- new
				{
					command = "cdalert",
					options = nil,
					desc    = "When the in-HUD spell cooldown bar is enabled, this option turns the display of ready messages on and off.",
					message = "nUI: The HUD spell cooldown ready messages have been %s",
				},
				[nUI_SLASHCMD_HUD_CDSOUND] = -- new
				{
					command = "cdsound",
					options = nil,
					desc    = "When the in-HUD spell cooldown bar is enabled, this option turns the playing of ready sounds on and off.",
					message = "nUI: The HUD spell cooldown ready sound has been %s",
				},
				[nUI_SLASHCMD_HUD_CDMIN] = -- new
				{
					command = "cdmin",
					options = "{n}",
					desc    = "This sets the minimum amount of time required for a spell to be displayed on the cooldown bar when it first begins the cooldown. If the initial cooldown period is less than {n}, it won't display. The default value is '/nui hud cdmin 2'",
					message = "nUI: The HUD spell cooldown minimum time has been set to |cFF00FFFF%d|r seconds", -- time in seconds.
				},
				[nUI_SLASHCMD_HUD_HGAP] =
				{
					command = "hgap",
					options = "{n}",
					desc    = "This option sets horizontal gap between the left and right sides of the HUD where {n} is a number greater than 0. Increase {n} to increase the gap between the left and right of the HUD. The default value of {n} is 400",
					message = "nUI: The horizontal HUD gap has been set to |cFF00FFFF%0.0f|r", -- a number greater than zero
				},
				[nUI_SLASHCMD_HUD_VOFS] = -- new
				{
					command = "vofs",
					options = "{n}",
					desc    = "This option sets vertical offset of the HUD from the center of the view port. The default is '/nui hud vofs 0' which places the HUD at the vertical center of the viewport. Values less than 0 move the HUD down, greater than 0 moves the HUD up.",
					message = "nUI: The vertical HUD offset has been set to |cFF00FFFF%0.0f|r", -- a number
				},
				[nUI_SLASHCMD_HUD_IDLEALPHA] =
				{
					command = "idlealpha",
					options = "{n}",
					desc    = "This option sets the transparency of the HUD when you are completely idle where {n} = 0 for an invisible HUD and {n} = 1 for a fully opaque HUD. The default is {n} = 0",
					message = "nUI: The HUD idle alpha has been set to |cFF00FFFF%0.2f|r", -- a number between 0 and 1
				},
				[nUI_SLASHCMD_HUD_REGENALPHA] =
				{
					command = "regenalpha",
					options = "{n}",
					desc    = "This option sets the transparency of the HUD when you (or your pet) are regenerating health, regenerating power or are debuffed where {n} = 0 for an invisible HUD and {n} = 1 for a fully opaque HUD. The default is {n} = 0.35",
					message = "nUI: The HUD regen alpha has been set to |cFF00FFFF%0.2f|r", -- a number between 0 and 1
				},
				[nUI_SLASHCMD_HUD_TARGETALPHA] =
				{
					command = "targetalpha",
					options = "{n}",
					desc    = "This option sets the transparency of the HUD when you have selected a valid target where {n} = 0 for an invisible HUD and {n} = 1 for a fully opaque HUD. The default is {n} = 0.75",
					message = "nUI: The HUD targeting alpha has been set to |cFF00FFFF%0.2f|r", -- a number between 0 and 1
				},
				[nUI_SLASHCMD_HUD_COMBATALPHA] =
				{
					command = "combatalpha",
					options = "{n}",
					desc    = "This option sets the transparency of the HUD when you or your pet are in combat where {n} = 0 for an invisible HUD and {n} = 1 for a fully opaque HUD. The default is {n} = 1",
					message = "nUI: The HUD combat alpha has been set to |cFF00FFFF%0.2f|r", -- a number between 0 and 1
				},
			},
		},
		[nUI_SLASHCMD_BAR] = -- new
		{
			command  = "bar",
			options  = nil,
			desc     = "This command provides access to a set of commands used to control the behavior of the nUI action bars. Use the '/nui bar' command alone for a list of available sub-commands.",
			message  = nil,
			sub_menu =
			{
				[nUI_SLASHCMD_BAR_COOLDOWN] = -- new
				{
					command = "cooldown",
					options = nil,
					desc    = "This option is used to turn the display of cooldowns (displayed in yellow on the action bar) on and off. By default this feature is enabled.",
					message = "nUI: Action bar cooldown timers are %s", -- enabled or disabled
				},
				[nUI_SLASHCMD_BAR_DURATION] = -- new
				{
					command = "duration",
					options = nil,
					desc    = "By default, when you cast a spell on a target, the time remaining on the spell is displayed in blue on the action bar. This option turns that timer feature off.",
					message = "nUI: Action bar spell duration timers are %s", -- enabled or disabled
				},
				[nUI_SLASHCMD_BAR_MACRO] = -- new
				{
					command = "macro",
					options = nil,
					desc    = "When you place a custom macro on the action bar, nUI display's the macro's name on the button. This option will turn that display on and off.",
					message = "nUI: Macro name display on the action bar is %s", -- enabled or disabled
				},
				[nUI_SLASHCMD_BAR_STACKCOUNT] = -- new
				{
					command = "stackcount",
					options = nil,
					desc    = "nUI normally displays the stack counts of inventory items that are on your action bars in the lower right corner of the button. This option can be used to turn that display on and off.",
					message = "nUI: Stack count display on action buttons is %s", -- enabled or disabled
				},
				[nUI_SLASHCMD_BAR_KEYBIND] = -- new
				{
					command = "keybind",
					options = nil,
					desc    = "When you have a key bound to an action button, the key name is normally displayed in the top left corner of the button. This option can be used to turn that display on and off.",
					message = "nUI: Display of action button key binding names is %s", -- enabled or disabled
				},
				[nUI_SLASHCMD_BAR_DIMMING] = -- new
				{
					command = "dimming",
					options = nil,
					desc    = "By default, while you are in combat, if any action on your bar is unusable or active on your target, it is dimmed as a cue that you cannot or do not need to cast it yet and brightens when it procs or expires on the target. This option toggles this behavior on and off.",
					message = "nUI: Dimming of actions on cooldown, or unusable, is %s", -- enabled or disabled
				},
				[nUI_SLASHCMD_BAR_DIMALPHA] = -- new
				{
					command = "dimalpha",
					options = "{n}",
					desc    = "Normally when an action button is dimmed because it is unusable or active on the target, it is displayed at 30% opactity. This option allows you to set a custom opacity between 0 for fully transparent and 1 for fully opaque. The default is '/nui dimalpha 0.30'",
					message = "nUI: Dimming opactity has been set to |cFF00FFFF%0.1f%%|r", -- a number between 0% and 100%
				},
				[nUI_SLASHCMD_BAR_MOUSEOVER] = -- new
				{
					command = "mouseover",
					options = nil,
					desc    = "By default, nUI displays its action bars at all times. When the '/nui mouseover' function is enabled, nUI will hide the bar unless and until your mouse point is hovering over the bar.",
					message = "nUI: Display of action bars based on mouseover is %s", -- enabled or disabled
				},
				[nUI_SLASHCMD_BAR_TOTEMS] = -- new
				{
					command = "totems",
					options = nil,
					desc    = "nUI uses the default Blizzard totem bar for Shamans. If you would prefer to use an alternate addon for totems, the '/nui bar totems' option can be used to cause nUI to hide the default totem bar.",
					message = "nUI: Hiding of the default Blizzard totem bar has been %s", -- enabled or disabled
				},
				[nUI_SLASHCMD_BAR_BOOMKIN] = -- new
				{
					command = "boomkin",
					options = nil,
					desc    = "nUI does not use a dedicated Boomkin bar by default, using that bar for the action bar at the bottom right of the dashboard instead. The '/nui bar boomkin' will toggle the use of the bottom right action bar on and off as a dedicated bar for your boomkin.",
					message = "nUI: the dedicated Boomkin action bar has been %s", -- enabled or disabled
				},
			},
		},
		[nUI_SLASHCMD_MOUNTSCALE] = -- new
		{
			command = "mountscale",
			options = "{n}",
			desc    = "This option sets the scale for the seat indicator displayed at the top center of the display when you are on a special mount. The default is '/nui mountscale 1' where 0.5 < {n} < 1.5 -- values less than 1.0 cause the indicator to be smaller, values of {n} > 1.0 increase its size.",
			message = "nUI: The scale of the special mount seat indicator has been set to |cFF00FFFF%s|r", -- a number between 0.5 and 1.5
		},
		[nUI_SLASHCMD_CLOCK] = -- new
		{
			command = "clock",
			options = "{server|local|both}",
			desc    = "This option sets the display of the dashboard clock to either display the current local time {local}, the current server time {server} or both the server and local time together {both}. The default setting is {server}",
			message = "nUI: The dashboard clock display mode has been set to |cFF00FFFF%s|r",
		},
		[nUI_SLASHCMD_MAPCOORDS] = -- new
		{
			command = "mapcoords",
			options = nil,
			desc    = "This option toggles the display of player and cursor map coordinates in the world map on and off. It is on by default.",
			message = "nUI: World map coordinates have been %s", -- "ENABLED" or "DISABLED"
		},
		[nUI_SLASHCMD_ROUNDMAP] = -- new 
		{
			command = "roundmap",
			options = nil,
			desc    = "This option toggles the minimap display between the default square minimap and a round minimap",
			message = "nUI: The minimap shape has been set to |cFF00FFFF%s|r", -- "round" or "square"
		},
		[nUI_SLASHCMD_MINIMAP] = -- new
		{
			command = "minimap",
			options = nil,
			desc    = "This option toggles nUI's management of the minimap on and off. When enabled, nUI will attempt to move the minimap into the dashboard, otherwise the Blizzard minimap is not modified by nUI (though the minimap buttons still are). Changing this option will force a UI reload!",
			message = "nUI: Management of the minimap has been %s", -- enabled or disabled
		},
		[nUI_SLASHCMD_ONEBAG] = -- new
		{
			command = "onebag",
			options = nil,
			desc    = "This option toggles the display of inventory bags on your bag bar to show either your backpack only or all five bags. This does NOT actually combine all of your bags into a single bag at this time, it is provided to support third party mods such as ArkInventory.",
			message = "nUI: Single bag button display has been %s", -- enabled or disabled
		},
		[nUI_SLASHCMD_WATCHFRAME] =
		{
			command = "watchframe",
			options = nil,
			desc    = "This command causes nUI to reset the size and location of the advanced objectives tracking window the default location for the current nUI layout.",
			message = "nUI: The advanced objectives tracking window has been reset",
		},
		[nUI_SLASHCMD_VIEWPORT] =
		{
			command = "viewport",
			options = nil,
			desc    = "This command toggles the use of a viewport in nUI on and off. When enabled, the default, the character and HUD are centered in the displayable area.",
			message = "nUI: The viewport has been %s", -- enabled or disabled
		},
		[nUI_SLASHCMD_LASTITEM+1] =
		{
			command = "debug",
			options = "{n}",
			desc    = "This option sets the nUI debugger messaging level. As a rule you should only change debug levels if you are asked to by the mod author. Use {n} = 0 to turn debugging off entirely (the default).",
			message = "nUI: Your debugging level has been set to |cFF00FFFF%d|r", -- an integer value
		},
		[nUI_SLASHCMD_LASTITEM+2] = -- new
		{
			command = "profile",
			options = nil,
			desc    = "This option toggles runtime profiling of nUI on and off. Profiling is off by default and enabling this feature does increase overhead. The profiling state is NOT saved between sessions of console reloads. You should not enable profiling unless asked to do so by the mod author.",
			message = "nUI: Runtime profiling has been %s", -- enabled or disabled
		},
	};
	
	nUI_L["round"]  = "round"; -- new -- used to display the current minimap shape selection
	nUI_L["square"] = "square"; -- new
	
	nUI_L["health remaining"] = "|cFF00FF00health remaining|r"; -- new -- used to tell the player that unit frames are displaying health remaining
	nUI_L["health lost"]      = "|cFFFF0000health lost|r"; -- new -- used to tell the player that unit frames are displaying health lost
	
	-- these strings are the optional arguments to their respective commands and can be 
	-- translated to make sense in the local language
	
	nUI_L[nUI_SLASHCMD_OPTIONS( nUI_SLASHCMD_CLOCK, "server" )] = "server"; -- new -- command option used to select the server time dashboard clock format
	nUI_L[nUI_SLASHCMD_OPTIONS( nUI_SLASHCMD_CLOCK, "local" )]  = "local"; -- new -- command option used to select the local time clock format
	nUI_L[nUI_SLASHCMD_OPTIONS( nUI_SLASHCMD_CLOCK, "both" )]   = "both"; -- new -- command option used to select both server and local time clock display
	
	nUI_L[nUI_SLASHCMD_OPTIONS( nUI_SLASHCMD_RAIDSORT, "unit" )]  = "unit"; -- new -- command option used to select sorting of raid unit frames by unit id
	nUI_L[nUI_SLASHCMD_OPTIONS( nUI_SLASHCMD_RAIDSORT, "group" )] = "group"; -- new -- command option used to select sorting of raid unit frames by raid group
	nUI_L[nUI_SLASHCMD_OPTIONS( nUI_SLASHCMD_RAIDSORT, "class" )] = "class"; -- new -- command option used to select sorting of raid unit frames by player class
	nUI_L[nUI_SLASHCMD_OPTIONS( nUI_SLASHCMD_RAIDSORT, "name" )]  = "name"; -- new -- command option used to select sorting of raid unit frames by player class
	
	nUI_L[nUI_SLASHCMD_OPTIONS( nUI_SLASHCMD_FEEDBACK, "curse" )]    = "curse";
	nUI_L[nUI_SLASHCMD_OPTIONS( nUI_SLASHCMD_FEEDBACK, "disease" )]  = "disease";
	nUI_L[nUI_SLASHCMD_OPTIONS( nUI_SLASHCMD_FEEDBACK, "magic" )]    = "magic";
	nUI_L[nUI_SLASHCMD_OPTIONS( nUI_SLASHCMD_FEEDBACK, "poison" )]   = "poison";
	
	nUI_L[nUI_SLASHCMD_OPTIONS( nUI_SLASHCMD_CONSOLE, "on" )]        = "on";
	nUI_L[nUI_SLASHCMD_OPTIONS( nUI_SLASHCMD_CONSOLE, "off" )]       = "off";
	nUI_L[nUI_SLASHCMD_OPTIONS( nUI_SLASHCMD_CONSOLE, "mouseover" )] = "mouseover";
	
	nUI_L[nUI_SLASHCMD_OPTIONS( nUI_SLASHCMD_BAGBAR, "on" )]        = "on"; -- new
	nUI_L[nUI_SLASHCMD_OPTIONS( nUI_SLASHCMD_BAGBAR, "off" )]       = "off"; -- new
	nUI_L[nUI_SLASHCMD_OPTIONS( nUI_SLASHCMD_BAGBAR, "mouseover" )] = "mouseover"; -- new
	
	nUI_L[nUI_SLASHCMD_OPTIONS( nUI_SLASHCMD_TOOLTIPS, "owner" )]   = "owner";
	nUI_L[nUI_SLASHCMD_OPTIONS( nUI_SLASHCMD_TOOLTIPS, "mouse" )]   = "mouse";
	nUI_L[nUI_SLASHCMD_OPTIONS( nUI_SLASHCMD_TOOLTIPS, "fixed" )]   = "fixed";
	nUI_L[nUI_SLASHCMD_OPTIONS( nUI_SLASHCMD_TOOLTIPS, "default" )] = "default";
	
	-- miscellaneous slash command messages printed to the player
	
	nUI_L["The value [ %s ] is not a valid nUI slash command. Try [ /nui help ] for a list of commands"] = "The value [ |cFFFFC000%s|r ] is not a valid nUI slash command. Try [ |cFF00FFFF/nui help|r ] for a list of commands";
	nUI_L["nUI currently supports the following list of slash commands..."]	= "nUI currently supports the following list of slash commands..."; 
	nUI_L["The '/nui %s' slash command currently supports the following list of sub-commands..."] = "The '|cFF00FFFF/nui %s|r' slash command currently supports the following list of sub-commands...";
	nUI_L["nUI: [ %s ] is not a valid tooltip settings option... please choose from %s, %s, %s or %s"] = "nUI: [ |cFFFFC0C0%s|r ] is not a valid tooltip settings option... please choose from |cFF00FFFF%s|r, |cFF00FFFF%s|r, |cFF00FFFF%s|r or |cFF00FFFF%s|r";
	nUI_L["nUI: [ %s ] is not a valid console visibility option... please choose from %s, %s or %s"] = "nUI: [ |cFFFFC0C0%s|r ] is not a valid console visibility option... please choose from |cFF00FFFF%s|r, |cFF00FFFF%s|r or |cFF00FFFF%s|r";
	nUI_L["nUI: [ %s ] is not a valid alpha value... please choose choose a number between 0 and 1 where 0 is fully transparent and 1 is fully opaque."] = "nUI: [ |cFFFFC0C0%s|r ] is not a valid alpha value... please choose choose a number between 0 and 1 where 0 is fully transparent and 1 is fully opaque.";
	nUI_L["nUI: [ %s ] is not a valid horizontal gap value... please choose choose a number between 1 and 1200 where 1 is very narrow and 1200 is very wide."] = "nUI: [ |cFFFFC0C0%s|r ] is not a valid horizontal gap value... please choose choose a number between 1 and 1200 where 1 is very narrow and 1200 is very wide.";
	nUI_L["nUI: [ %s ] is not a valid clock option... please choose either 'local' to display the local time, 'server' to display the server time or 'both' to display both times."] = "nUI: [ %s ] is not a valid clock option... please choose either 'local' to display the local time, 'server' to display the server time or 'both' to display both times."; -- new -- message displayed when the player selects an invalid '/nui clock {option}' value
	nUI_L["nUI: [ %s ] is not a valid feedback option... please choose either <curse>, <disease>, <magic> or <poison>"] = "nUI: [ %s ] is not a valid feedback option... please choose either '%s', '%s', '%s' or '%s'"; -- new -- alerts the user when they have entered an invalid feedback highlighting option
	nUI_L["nUI: [ %s ] is not a valid raid sorting option... please choose either <unit>, <group> or <class>"] = "nUI: [ %s ] is not a valid raid sorting option... please choose either '%s', '%s' or '%s'";	-- new
	nUI_L["nUI: [ %s ] is not a valid special mount indicator display scale. The scale must be a number between 0.5 and 1.5"] = "nUI: [ %s ] is not a valid special mount indicator display scale. The scale must be a number between 0.5 and 1.5"; -- new
		
end
