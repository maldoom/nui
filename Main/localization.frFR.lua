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

Translation (French) by...

Khisanth - (EU) Suramar
khisanth.wow@gmail.com

-and-

Copyright (c) 2008 by David ANGELELLI
All Rights Reserved
E-mail: < snesman@pc-dream.net >

Realm: 	Krasus (PvE) [French]
Name:	Tullia (Nightelf Rogue)

--]]---------------------------------------------------------------------------

if nUI_Locale == "frFR" then
		
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
	
	nUI_L["Welcome back to %s, %s..."] = "Bienvenue à %s, %s...";
	nUI_L["nUI %s version %s is loaded!"] = "nUI %s version %s est chargée!";
	nUI_L["Type '/nui' for a list of available nUI commands."] = "Taper '/nui' pour la liste des commandes disponibles.";
	
	-- splash frame strings

	nUI_L["splash title"] = "%s a été mis à jour en %s %s";
	nUI_L["splash info"]  = "Pour le guide d'utilisation, des galleries, les dernières versions, la FAQ, les forums de support technique ou faire un don, merci de visiter |cFF00FFFFhttp://www.nUIaddon.com|r";
	nUI_L["plus info"]    = "utilisez la version 'classique' de nUI... il existe également une version '|cFF00FFFFnUI+|r' gratuite qui ajoute des fenêtres pour les raid de 15, 20, 25 et 40 joueurs ainsi que des fonctions additionnelles. Merci de visiter |cFF00FFFFhttp://www.nUIaddon.com/plus.html|r pour plus d'informations.";
	
	-- clock strings
	
	nUI_L["am"] = "am";
	nUI_L["pm"] = "pm";
	nUI_L["<hour>:<minute><suffix>"] = "%d:%02d%s";
	nUI_L["<hour>:<minute>"] = "%02d:%02d";
	nUI_L["(S) <hour>:<minute><suffix> - <hour>:<minute><suffix> (L)"] = "(S) %d:%02d%s - %d:%02d%s (L)";
	nUI_L["(S) <hour>:<minute> - <hour>:<minute> (L)"] = "(S) %02d:%02d - %02d:%02d (L)";
	
	-- state strings
	
	nUI_L["|cFF00FF00ENABLED|r"]  = "|cFF00FF00ACTIVE(E)|r";
	nUI_L["|cFFFF0000DISABLED|r"] = "|cFFFF0000DESACTIVE(E)|r";
	nUI_L["~INTERRUPTED~"]        = "~INTERROMPUE~";
	nUI_L["~FAILED~"]             = "~ECHOUE~";
	nUI_L["~MISSED~"]             = "~RATE~";
	nUI_L["OFFLINE"]              = "HORS LIGNE";
	nUI_L["DND"]                  = "NPD";
	nUI_L["AFK"]                  = "AFK";
	nUI_L["DEAD"]                 = "MORT";
	nUI_L["GHOST"]                = "FANTOME";
	nUI_L["FD"]                   = "FM";
	nUI_L["TAXI"]                 = "TAXI";
	nUI_L["OOR"]				  = "HP";
	
	-- power types

	-- this entire section is new... it contains the labels used to describe the
	--        unit's current health and power type in tooltips and other areas
	
	nUI_L["HEALTH"]      = "Santé";	
	nUI_L["MANA"]        = "Mana";
	nUI_L["RAGE"]        = "Rage";
	nUI_L["FOCUS"]       = "Focus";
	nUI_L["ENERGY"]      = "Energie";
	nUI_L["RUNES"]       = "Runes";
	nUI_L["RUNIC_POWER"] = "Puissance Runique";
	nUI_L["AMMO"]        = "Munitions"; -- vehicles
	nUI_L["FUEL"]        = "Fuel"; -- vehicles
	
	-- time remaining (cooldowns, buffs, etc.)
	
	nUI_L["TimeLeftInHours"]   = "%0.0fh";
	nUI_L["TimeLeftInMinutes"] = "%0.0fm";
	nUI_L["TimeLeftInSeconds"] = "%0.0fs";
	nUI_L["TimeLeftInTenths"]  = "%0.1fs";
	
	-- raid and party role tooltip strings
	
	nUI_L["Party Role: |cFF00FFFF%s|r"] = "Fonction groupe: |cFF00FFFF%s|r";
	nUI_L["Raid Role: |cFF00FFFF%s|r"]  = "Fonction raid: |cFF00FFFF%s|r";
	nUI_L["Raid Leader"]                = "Chef de raid";
	nUI_L["Party Leader"]               = "Chef du groupe";
	nUI_L["Raid Assistant"]             = "Assistant Raid";
	nUI_L["Main Tank"]                  = "Tank principal";
	nUI_L["Off-Tank"]                   = "Tank secondaire";
	nUI_L["Master Looter"]              = "Chef du butin";
	
	-- hunter pet feeder strings
	
	nUI_L[nUI_FOOD_MEAT]	= "viande";     -- do not edit this line
	nUI_L[nUI_FOOD_FISH]	= "poisson";    -- do not edit this line
	nUI_L[nUI_FOOD_BREAD]	= "pain";       -- do not edit this line
	nUI_L[nUI_FOOD_CHEESE]  = "fromage";    -- do not edit this line
	nUI_L[nUI_FOOD_FRUIT]	= "fruit";      -- do not edit this line
	nUI_L[nUI_FOOD_FUNGUS]  = "champignon"; -- do not edit this line
	
	nUI_L["Click to feed %s"]           = "Cliquez pour nourrir %s"; 
	nUI_L["Click to cancel feeding"]    = "Cliquez pour annuler nourrir"; 
	nUI_L["nUI: %s can eat %s%s%s"]     = "nUI: %s peut manger %s%s%s";
	nUI_L[" or "]                       = " ou ";
	nUI_L["nUI: You don't have a pet!"] = "nUI: Vous n'avez pas de familier!";
	
	nUI_L["nUI: You can feed %s the following...\n"] = "nUI: Vous pouvez nourrir %s avec ce qui suit...\n";
	nUI_L["nUI: You have nothing you can feed %s in your current inventory"] = "nUI: Vous n'avez rien pour nourrir %s dans votre inventaire";
		
	-- status bar strings
	
	nUI_L["nUI: Cannot change status bar config while in combat!"] = "nUI: Impossible de changer la configuration de la barre de status pendant le combat!";
	nUI_L["nUI: [%s] is not a valid option for orienting a status bar... use LEFT, RIGHT, TOP or BOTTOM"] = "nUI: [%s] n'est pas une option valide pour l'orientation d'une barre de status... utilisez LEFT, RIGHT, TOP or BOTTOM";
	nUI_L["nUI: Can not change status bar overlays while in combat!"] = "nUI: Impossible de changer le recouvrement de la barre de status durant un combat!";
	nUI_L["nUI: The maximum value (%d) of a status bar must be greater than the minimum value (%d)"] = "nUI: La valeur maximale (%d) d'une barre de status doit être plus grande que la valeur minimale (%d)";
	
	-- information panel strings
	
	nUI_L["Minimap"] = "Minicarte";
		
	nUI_L[nUI_INFOPANEL_COMBATLOG]      		= "Panneau info: Affichage Journal de combat";
	nUI_L[nUI_INFOPANEL_COMBATLOG.."Label"]		= "Combat";
	
	nUI_L[nUI_INFOPANEL_BMM]		      		= "Panneau info: Affichage Minicarte du champs de bataille ";
	nUI_L[nUI_INFOPANEL_BMM.."Label"]			= "Carte";
	
	nUI_L[nUI_INFOPANEL_RECOUNT]		   		= "Panneau info: Affichage Recount";
	nUI_L[nUI_INFOPANEL_RECOUNT.."Label"]		= "Recount";
	
	nUI_L[nUI_INFOPANEL_OMEN3]		      		= "Panneau info: Affichage Omen3";
	nUI_L[nUI_INFOPANEL_OMEN3.."Label"]			= "Omen3";
	
	nUI_L[nUI_INFOPANEL_SKADA]		      		= "IPanneau info: Skada Damage/Threat Meter Mode";
	nUI_L[nUI_INFOPANEL_SKADA.."Label"]			= "Skada";
	
	nUI_L[nUI_INFOPANEL_OMEN3KLH]	      		= "Panneau info: Affichage combiné Omen3 + KLH Threat Meter";
	nUI_L[nUI_INFOPANEL_OMEN3KLH.."Label"]		= "Menace";
	
	nUI_L[nUI_INFOPANEL_KLH]		      		= "Panneau info: KLH Threat Meter";
	nUI_L[nUI_INFOPANEL_KLH.."Label"]			= "KTM";
	
	nUI_L[nUI_INFOPANEL_KLHRECOUNT]	      		= "Panneau info: KLH Threat + Recount";
	nUI_L[nUI_INFOPANEL_KLHRECOUNT.."Label"]	= "KTM+";
	
	nUI_L["nUI: You need to go to the WoW Interface menu, select the 'Social' option and turn off the 'Simple Chat' menu option to enable integrated combat log support in nUI."] = "nUI: Vous devez utiliser le menu Interface de WoW, Choisir l'option 'Social' et désactiver l'option de menu 'Chat Simple' pour activer le support du journal de combat intégré à nUI.";
	nUI_L["The %s Info Panel plugin is a core plugin to nUI and cannot be disabled"] = "Le plugin du panneau d'info %s est un plugin noyau de nUI et ne peut pas être désactivé";
	nUI_L["Click to change information panels"] = "Cliquez pour change de panneau d'information";
	nUI_L["nUI: Cannot initialize the Info Panel plugin [ %s ] -- it does not have an initPanel() interface method"] = "nUI: Impossible d'initialiser  le plugin du Panneau d'information [ |cFF00FFFF%s|r ] -- il n'a pas de méthode d'interface initPanel()";
	nUI_L["nUI: Cannot initialize the Info Panel plugin [ %s ] -- No global object by that name exists"] = "nUI: Impossible d'initialiser  le plugin du Panneau d'information [ |cFF00FFFF%s|r ] -- Pas d'objet global de ce nom existant";	
	nUI_L["nUI: Cannot select the Info Panel plugin [ %s ] -- it does not have a setSelected() interface method"] = "nUI: Impossible de choisir le plugin du Panneau d'information [ |cFF00FFFF%s|r ] -- il n'a pas de méthode d'interface setSelected()";
	
	-- HUD layout strings (heads up display)
	
	nUI_L["Click to change HUD layouts"] = "Cliquez pour changer la disposition du HUD";
	
	nUI_L[nUI_HUDLAYOUT_PLAYERTARGET]	   		= "Disposition HUD: Joueur à gauche / Cible à droite";
	nUI_L[nUI_HUDLAYOUT_PLAYERTARGET.."Label"]	= "Joueur/Cible";
	
	nUI_L[nUI_HUDLAYOUT_HEALTHPOWER]	   		= "Disposition HUD: Vie à gauche / Capacité à droite";
	nUI_L[nUI_HUDLAYOUT_HEALTHPOWER.."Label"]	= "Vie/Capacité";
	
	nUI_L[nUI_HUDLAYOUT_SIDEBYSIDE]	   			= "Disposition HUD: Barres horizontales côtes à côtes";
	nUI_L[nUI_HUDLAYOUT_SIDEBYSIDE.."Label"]	= "Côte à côte";
	
	nUI_L[nUI_HUDLAYOUT_NOBARS]	   				= "Disposition HUD: HUD Simple (pas de barres)";
	nUI_L[nUI_HUDLAYOUT_NOBARS.."Label"]		= "HUD Simple";
	
	nUI_L[nUI_HUDLAYOUT_NOHUD]		   			= "Disposition HUD:: Désactivé (pas de HUD)";
	nUI_L[nUI_HUDLAYOUT_NOHUD.."Label"]			= "Pas de HUD";
	
	nUI_L[nUI_HUDMODE_PLAYERTARGET]        = "nUI Mode HUD Joueur/Cible";
	nUI_L[nUI_HUDSKIN_PLAYERTARGET_PET]    = nUI_L[nUI_HUDMODE_PLAYERTARGET]..": skin d'affichage des données du familier du joueur";
	nUI_L[nUI_HUDSKIN_PLAYERTARGET_PLAYER] = nUI_L[nUI_HUDMODE_PLAYERTARGET]..": skin d'affichage des données du joueur";
	nUI_L[nUI_HUDSKIN_PLAYERTARGET_TARGET] = nUI_L[nUI_HUDMODE_PLAYERTARGET]..": skin d'affichage des données de la cible";
	nUI_L[nUI_HUDSKIN_PLAYERTARGET_TOT]    = nUI_L[nUI_HUDMODE_PLAYERTARGET]..": skin d'affichage des données de la cible de la cible (CdC)";
	nUI_L[nUI_HUDSKIN_PLAYERTARGET_CASTBAR] = nUI_L[nUI_HUDMODE_PLAYERTARGET]..": skin d'affichage de la barre de sort du joueur";
	
	nUI_L[nUI_HUDMODE_HEALTHPOWER]         = "nUI Mode HUD Vie/Capacité";
	nUI_L[nUI_HUDSKIN_HEALTHPOWER_PET]     = nUI_L[nUI_HUDMODE_HEALTHPOWER]..": skin d'affichage des données du familier du joueur";
	nUI_L[nUI_HUDSKIN_HEALTHPOWER_PLAYER]  = nUI_L[nUI_HUDMODE_HEALTHPOWER]..": skin d'affichage des données du joueur";
	nUI_L[nUI_HUDSKIN_HEALTHPOWER_TARGET]  = nUI_L[nUI_HUDMODE_HEALTHPOWER]..": skin d'affichage des données de la cible";
	nUI_L[nUI_HUDSKIN_HEALTHPOWER_TOT]     = nUI_L[nUI_HUDMODE_HEALTHPOWER]..": skin d'affichage des données de la cible de la cible (CdC)";
	nUI_L[nUI_HUDSKIN_HEALTHPOWER_CASTBAR] = nUI_L[nUI_HUDMODE_HEALTHPOWER]..": skin d'affichage de la barre de sort du joueur";
	
	nUI_L[nUI_HUDMODE_SIDEBYSIDE]          = "nUI Mode HUD Côte à côte";
	nUI_L[nUI_HUDSKIN_SIDEBYSIDE_PET]      = nUI_L[nUI_HUDMODE_SIDEBYSIDE]..": skin d'affichage des données du familier du joueur";
	nUI_L[nUI_HUDSKIN_SIDEBYSIDE_PLAYER]   = nUI_L[nUI_HUDMODE_SIDEBYSIDE]..": skin d'affichage des données du joueur";
	nUI_L[nUI_HUDSKIN_SIDEBYSIDE_TARGET]   = nUI_L[nUI_HUDMODE_SIDEBYSIDE]..": skin d'affichage des données de la cible";
	nUI_L[nUI_HUDSKIN_SIDEBYSIDE_TOT]      = nUI_L[nUI_HUDMODE_SIDEBYSIDE]..": skin d'affichage des données de la cible de la cible (CdC)";
	nUI_L[nUI_HUDSKIN_SIDEBYSIDE_CASTBAR]  = nUI_L[nUI_HUDMODE_SIDEBYSIDE]..": skin d'affichage de la barre de sort du joueur"; 
	
	nUI_L[nUI_HUDMODE_NOBARS]              = "nUI Mode HUD Simple sans Barre"; 
	nUI_L[nUI_HUDSKIN_NOBARS_CASTBAR]      = nUI_L[nUI_HUDMODE_NOBARS]..": skin d'affichage de la barre de sort du joueur";
	nUI_L[nUI_HUDSKIN_NOBARS_PLAYER]       = nUI_L[nUI_HUDMODE_NOBARS]..": skin d'affichage des données du joueur";
	nUI_L[nUI_HUDSKIN_NOBARS_TARGET]       = nUI_L[nUI_HUDMODE_NOBARS]..": skin d'affichage de la cible";
	
	-- nUI_Unit strings
	
	nUI_L["Pet"]        = "Fam.";
	nUI_L["Target"]     = "Cible";	
	nUI_L["Range"]      = "Portée";
	nUI_L["MELEE"]      = "MELEE";
	nUI_L["Elite"]      = "Elite";
	nUI_L["Rare"]       = "Rare";
	nUI_L["Rare Elite"] = "Rare Elite";
	nUI_L["World Boss"] = "World Boss";
	nUI_L["Vehicle"]    = "Véhicule"; 
	
	nUI_L["unit: player"]             = "Joueur";
	nUI_L["unit: vehicle"]            = "Le véhicule du joueur"; 
	nUI_L["unit: pet"]		          = "Familier du joueur";
	nUI_L["unit: pettarget"]          = "Cible du familier du joueur";
	nUI_L["unit: focus"]              = "Focus du joueur";
	nUI_L["unit: focustarget"]        = "Cible du focus du joueur";
	nUI_L["unit: target"]             = "Cible du joueur";
	nUI_L["unit: %s-target"]          = "Cible de %s";
	nUI_L["unit: mouseover"]          = "Suvol souris de la Cible";
	nUI_L["unit: targettarget"]       = "Cible de la cible (CdC)";
	nUI_L["unit: targettargettarget"] = "Cible de CdC (CCdC)";
	nUI_L["unit: party%d"]            = "Membre du Groupe %d";
	nUI_L["unit: party%dpet"]         = "Familier du Membre du Groupe %d";
	nUI_L["unit: party%dtarget"]      = "Cible du Membre du Groupe %d";
	nUI_L["unit: party%dpettarget"]   = "Cible du Familier du Membre du Groupe %d";
	nUI_L["unit: raid%d"]             = "Membre du Raid %d";
	nUI_L["unit: raid%dpet"]          = "Familier du Membre du Raid %d";
	nUI_L["unit: raid%dtarget"]       = "Cible du Membre du Raid %d";
	nUI_L["unit: raid%dpettarget"]    = "Cible du Familier du Membre du Raid %d";

	nUI_L[nUI_UNITMODE_PLAYER]        = "nUI Mode joueur solo";
	nUI_L[nUI_UNITSKIN_SOLOFOCUS]     = nUI_L[nUI_UNITMODE_PLAYER]..": Skin de la fenêtre focus du joueur";
	nUI_L[nUI_UNITSKIN_SOLOMOUSE]     = nUI_L[nUI_UNITMODE_PLAYER]..": Skin de la fenêtre du survol souris sur cible";
	nUI_L[nUI_UNITSKIN_SOLOVEHICLE]   = nUI_L[nUI_UNITMODE_PLAYER]..": Skin de la fenêtre du véhicule";
	nUI_L[nUI_UNITSKIN_SOLOPET]       = nUI_L[nUI_UNITMODE_PLAYER]..": Skin de la fenêtre du familier du joueur";
	nUI_L[nUI_UNITSKIN_SOLOPETBUTTON] = nUI_L[nUI_UNITMODE_PLAYER]..": Skin du bouton de la cible du familier... i.e. Cible du familier, Focus du familier du joueur, etc";
	nUI_L[nUI_UNITSKIN_SOLOPLAYER]    = nUI_L[nUI_UNITMODE_PLAYER]..": Skin de la fenêtre du joueur";
	nUI_L[nUI_UNITSKIN_SOLOTARGET]    = nUI_L[nUI_UNITMODE_PLAYER]..": Skin de la fenêtre de la cible";
	nUI_L[nUI_UNITSKIN_SOLOTGTBUTTON] = nUI_L[nUI_UNITMODE_PLAYER]..": Skin du bouton cible de la fenêtre de la cible... i.e. Cible du focus du joueur, etc.";
	nUI_L[nUI_UNITSKIN_SOLOTOT]       = nUI_L[nUI_UNITMODE_PLAYER]..": Skin de la fenêtre de la Cible de la Cible (CdC)";

	nUI_L[nUI_UNITMODE_PARTY]          = "nUI Mode Groupe";
	nUI_L[nUI_UNITSKIN_PARTYFOCUS]     = nUI_L[nUI_UNITMODE_PARTY]..": Skin de la fenêtre du focus du joueur";
	nUI_L[nUI_UNITSKIN_PARTYMOUSE]     = nUI_L[nUI_UNITMODE_PARTY]..": Skin de la fenêtre du survol souris sur cible";
	nUI_L[nUI_UNITSKIN_PARTYVEHICLE]   = nUI_L[nUI_UNITMODE_PARTY]..": Skin de la fenêtre du véhicule";
	nUI_L[nUI_UNITSKIN_PARTYPLAYER]    = nUI_L[nUI_UNITMODE_PARTY]..": Skin de la fenêtre du joueur";
	nUI_L[nUI_UNITSKIN_PARTYPET]       = nUI_L[nUI_UNITMODE_PARTY]..": Skin de la fenêtre du familier du joueu";
	nUI_L[nUI_UNITSKIN_PARTYTARGET]    = nUI_L[nUI_UNITMODE_PARTY]..": Skin de la fenêtre de la cible";
	nUI_L[nUI_UNITSKIN_PARTYTOT]       = nUI_L[nUI_UNITMODE_PARTY]..": Skin de la fenêtre de la Cible de la Cible (CdC)";
	nUI_L[nUI_UNITSKIN_PARTYFOCUS]     = nUI_L[nUI_UNITMODE_PARTY]..": Skin de la fenêtre du focus du joueur";
	nUI_L[nUI_UNITSKIN_PARTYLEFT]      = nUI_L[nUI_UNITMODE_PARTY]..": Skin de la partie gauche des membres du groupe";
	nUI_L[nUI_UNITSKIN_PARTYRIGHT]     = nUI_L[nUI_UNITMODE_PARTY]..": Skin de la partie droite des membres du groupe";
	nUI_L[nUI_UNITSKIN_PARTYPETBUTTON] = nUI_L[nUI_UNITMODE_PARTY]..": Skin des boutons cible des familiers du groupe";
	nUI_L[nUI_UNITSKIN_PARTYTGTBUTTON] = nUI_L[nUI_UNITMODE_PARTY]..": Skin du bouton cible des membres du groupe";
	nUI_L[nUI_UNITSKIN_PARTYMOUSE]     = nUI_L[nUI_UNITMODE_PARTY]..": Skin de la fenêtre survol souris";
	
	nUI_L[nUI_UNITMODE_RAID10]          ="nUI Mode Raid 10 joueurs";
	nUI_L[nUI_UNITSKIN_RAID10FOCUS]     = nUI_L[nUI_UNITMODE_RAID10]..": Skin de la fenêtre du focus du joueur";
	nUI_L[nUI_UNITSKIN_RAID10MOUSE]     = nUI_L[nUI_UNITMODE_RAID10]..": Skin de la fenêtre du survol souris sur cible";
	nUI_L[nUI_UNITSKIN_RAID10VEHICLE]   = nUI_L[nUI_UNITMODE_RAID10]..": Skin de la fenêtre du véhicule"; 
	nUI_L[nUI_UNITSKIN_RAID10PLAYER]    = nUI_L[nUI_UNITMODE_RAID10]..": Skin de la fenêtre du joueur";
	nUI_L[nUI_UNITSKIN_RAID10PET]       = nUI_L[nUI_UNITMODE_RAID10]..": Skin de la fenêtre du familier du joueu";
	nUI_L[nUI_UNITSKIN_RAID10TARGET]    = nUI_L[nUI_UNITMODE_RAID10]..": Skin de la fenêtre de la cible";
	nUI_L[nUI_UNITSKIN_RAID10TOT]       = nUI_L[nUI_UNITMODE_RAID10]..": Skin de la fenêtre de la Cible de la Cible (CdC)";
	nUI_L[nUI_UNITSKIN_RAID10FOCUS]     = nUI_L[nUI_UNITMODE_RAID10]..": Skin de la fenêtre du focus du joueur";
	nUI_L[nUI_UNITSKIN_RAID10LEFT]      = nUI_L[nUI_UNITMODE_RAID10]..": Skin de la partie gauche des membres du raid";
	nUI_L[nUI_UNITSKIN_RAID10RIGHT]     = nUI_L[nUI_UNITMODE_RAID10]..": Skin de la partie droite des membres du groupe";
	nUI_L[nUI_UNITSKIN_RAID10PETBUTTON] = nUI_L[nUI_UNITMODE_RAID10]..": Skin des boutons cible des familiers du raid";
	nUI_L[nUI_UNITSKIN_RAID10TGTBUTTON] = nUI_L[nUI_UNITMODE_RAID10]..": Skin du bouton cible des membres du raid";
	nUI_L[nUI_UNITSKIN_RAID10MOUSE]     = nUI_L[nUI_UNITMODE_RAID10]..": Skin de la fenêtre survol souris";
		
	nUI_L[nUI_UNITMODE_RAID15]          ="nUI Mode Raid 15 joueurs";
	nUI_L[nUI_UNITSKIN_RAID15FOCUS]     = nUI_L[nUI_UNITMODE_RAID15]..": Skin de la fenêtre du focus du joueur";
	nUI_L[nUI_UNITSKIN_RAID15MOUSE]     = nUI_L[nUI_UNITMODE_RAID15]..": Skin de la fenêtre du survol souris sur cible";
	nUI_L[nUI_UNITSKIN_RAID15VEHICLE]   = nUI_L[nUI_UNITMODE_RAID15]..": Skin de la fenêtre du véhicule";
	nUI_L[nUI_UNITSKIN_RAID15PLAYER]    = nUI_L[nUI_UNITMODE_RAID10]..": Skin de la fenêtre du joueur";
	nUI_L[nUI_UNITSKIN_RAID15PET]       = nUI_L[nUI_UNITMODE_RAID10]..": Skin de la fenêtre du familier du joueu";
	nUI_L[nUI_UNITSKIN_RAID15TARGET]    = nUI_L[nUI_UNITMODE_RAID10]..": Skin de la fenêtre de la cible";
	nUI_L[nUI_UNITSKIN_RAID15TOT]       = nUI_L[nUI_UNITMODE_RAID10]..": Skin de la fenêtre de la Cible de la Cible (CdC)";
	nUI_L[nUI_UNITSKIN_RAID15FOCUS]     = nUI_L[nUI_UNITMODE_RAID10]..": Skin de la fenêtre du focus du joueur";
	nUI_L[nUI_UNITSKIN_RAID15LEFT]      = nUI_L[nUI_UNITMODE_RAID10]..": Skin de la partie gauche des membres du raid";
	nUI_L[nUI_UNITSKIN_RAID15RIGHT]     = nUI_L[nUI_UNITMODE_RAID10]..": Skin de la partie droite des membres du groupe";
	nUI_L[nUI_UNITSKIN_RAID15PETBUTTON] = nUI_L[nUI_UNITMODE_RAID10]..": Skin des boutons cible des familiers du raid";
	nUI_L[nUI_UNITSKIN_RAID15TGTBUTTON] = nUI_L[nUI_UNITMODE_RAID10]..": Skin du bouton cible des membres du raid";
	nUI_L[nUI_UNITSKIN_RAID15MOUSE]     = nUI_L[nUI_UNITMODE_RAID10]..": Skin de la fenêtre survol souris";
	
	nUI_L[nUI_UNITMODE_RAID20]          ="nUI Mode Raid 20 joueurs";
	nUI_L[nUI_UNITSKIN_RAID20FOCUS]     = nUI_L[nUI_UNITMODE_RAID20]..": Skin de la fenêtre du focus du joueur";
	nUI_L[nUI_UNITSKIN_RAID20MOUSE]     = nUI_L[nUI_UNITMODE_RAID20]..": Skin de la fenêtre du survol souris sur cible";
	nUI_L[nUI_UNITSKIN_RAID20VEHICLE]   = nUI_L[nUI_UNITMODE_RAID20]..": Skin de la fenêtre du véhicule";
	nUI_L[nUI_UNITSKIN_RAID20PLAYER]    = nUI_L[nUI_UNITMODE_RAID10]..": Skin de la fenêtre du joueur";
	nUI_L[nUI_UNITSKIN_RAID20PET]       = nUI_L[nUI_UNITMODE_RAID10]..": Skin de la fenêtre du familier du joueu";
	nUI_L[nUI_UNITSKIN_RAID20TARGET]    = nUI_L[nUI_UNITMODE_RAID10]..": Skin de la fenêtre de la cible";
	nUI_L[nUI_UNITSKIN_RAID20TOT]       = nUI_L[nUI_UNITMODE_RAID10]..": Skin de la fenêtre de la Cible de la Cible (CdC)";
	nUI_L[nUI_UNITSKIN_RAID20FOCUS]     = nUI_L[nUI_UNITMODE_RAID10]..": Skin de la fenêtre du focus du joueur";
	nUI_L[nUI_UNITSKIN_RAID20LEFT]      = nUI_L[nUI_UNITMODE_RAID10]..": Skin de la partie gauche des membres du raid";
	nUI_L[nUI_UNITSKIN_RAID20RIGHT]     = nUI_L[nUI_UNITMODE_RAID10]..": Skin de la partie droite des membres du groupe";
	nUI_L[nUI_UNITSKIN_RAID20PETBUTTON] = nUI_L[nUI_UNITMODE_RAID10]..": Skin des boutons cible des familiers du raid";
	nUI_L[nUI_UNITSKIN_RAID20TGTBUTTON] = nUI_L[nUI_UNITMODE_RAID10]..": Skin du bouton cible des membres du raid";
	nUI_L[nUI_UNITSKIN_RAID20MOUSE]     = nUI_L[nUI_UNITMODE_RAID10]..": Skin de la fenêtre survol souris";
	
	nUI_L[nUI_UNITMODE_RAID25]          ="nUI Mode Raid 25 joueurs";
	nUI_L[nUI_UNITSKIN_RAID25FOCUS]     = nUI_L[nUI_UNITMODE_RAID25]..": Skin de la fenêtre du focus du joueur";
	nUI_L[nUI_UNITSKIN_RAID25MOUSE]     = nUI_L[nUI_UNITMODE_RAID25]..": Skin de la fenêtre du survol souris sur cible";
	nUI_L[nUI_UNITSKIN_RAID25VEHICLE]   = nUI_L[nUI_UNITMODE_RAID25]..": Skin de la fenêtre du véhicule";
	nUI_L[nUI_UNITSKIN_RAID25PLAYER]    = nUI_L[nUI_UNITMODE_RAID10]..": Skin de la fenêtre du joueur";
	nUI_L[nUI_UNITSKIN_RAID25PET]       = nUI_L[nUI_UNITMODE_RAID10]..": Skin de la fenêtre du familier du joueu";
	nUI_L[nUI_UNITSKIN_RAID25TARGET]    = nUI_L[nUI_UNITMODE_RAID10]..": Skin de la fenêtre de la cible";
	nUI_L[nUI_UNITSKIN_RAID25TOT]       = nUI_L[nUI_UNITMODE_RAID10]..": Skin de la fenêtre de la Cible de la Cible (CdC)";
	nUI_L[nUI_UNITSKIN_RAID25FOCUS]     = nUI_L[nUI_UNITMODE_RAID10]..": Skin de la fenêtre du focus du joueur";
	nUI_L[nUI_UNITSKIN_RAID25LEFT]      = nUI_L[nUI_UNITMODE_RAID10]..": Skin de la partie gauche des membres du raid";
	nUI_L[nUI_UNITSKIN_RAID25RIGHT]     = nUI_L[nUI_UNITMODE_RAID10]..": Skin de la partie droite des membres du groupe";
	nUI_L[nUI_UNITSKIN_RAID25PETBUTTON] = nUI_L[nUI_UNITMODE_RAID10]..": Skin des boutons cible des familiers du raid";
	nUI_L[nUI_UNITSKIN_RAID25TGTBUTTON] = nUI_L[nUI_UNITMODE_RAID10]..": Skin du bouton cible des membres du raid";
	nUI_L[nUI_UNITSKIN_RAID25MOUSE]     = nUI_L[nUI_UNITMODE_RAID10]..": Skin de la fenêtre survol souris";
	
	nUI_L[nUI_UNITMODE_RAID40]          ="nUI Mode Raid 40 joueurs";
	nUI_L[nUI_UNITSKIN_RAID40FOCUS]     = nUI_L[nUI_UNITMODE_RAID40]..": Skin de la fenêtre du focus du joueur";
	nUI_L[nUI_UNITSKIN_RAID40MOUSE]     = nUI_L[nUI_UNITMODE_RAID40]..": Skin de la fenêtre du survol souris sur cible";
	nUI_L[nUI_UNITSKIN_RAID40VEHICLE]   = nUI_L[nUI_UNITMODE_RAID40]..": Skin de la fenêtre du véhicule";
	nUI_L[nUI_UNITSKIN_RAID40PLAYER]    = nUI_L[nUI_UNITMODE_RAID10]..": Skin de la fenêtre du joueur";
	nUI_L[nUI_UNITSKIN_RAID40PET]       = nUI_L[nUI_UNITMODE_RAID10]..": Skin de la fenêtre du familier du joueu";
	nUI_L[nUI_UNITSKIN_RAID40TARGET]    = nUI_L[nUI_UNITMODE_RAID10]..": Skin de la fenêtre de la cible";
	nUI_L[nUI_UNITSKIN_RAID40TOT]       = nUI_L[nUI_UNITMODE_RAID10]..": Skin de la fenêtre de la Cible de la Cible (CdC)";
	nUI_L[nUI_UNITSKIN_RAID40FOCUS]     = nUI_L[nUI_UNITMODE_RAID10]..": Skin de la fenêtre du focus du joueur";
	nUI_L[nUI_UNITSKIN_RAID40LEFT]      = nUI_L[nUI_UNITMODE_RAID10]..": Skin de la partie gauche des membres du raid";
	nUI_L[nUI_UNITSKIN_RAID40RIGHT]     = nUI_L[nUI_UNITMODE_RAID10]..": Skin de la partie droite des membres du groupe";
	nUI_L[nUI_UNITSKIN_RAID40PETBUTTON] = nUI_L[nUI_UNITMODE_RAID10]..": Skin des boutons cible des familiers du raid";
	nUI_L[nUI_UNITSKIN_RAID40TGTBUTTON] = nUI_L[nUI_UNITMODE_RAID10]..": Skin du bouton cible des membres du raid";
	nUI_L[nUI_UNITSKIN_RAID40MOUSE]     = nUI_L[nUI_UNITMODE_RAID10]..": Skin de la fenêtre survol souris";
	
	nUI_L[nUI_UNITPANEL_PLAYER]      		= "Panneau d'fenêtre : Mode Joueur Solo";
	nUI_L[nUI_UNITPANEL_PLAYER.."Label"]	= "Joueur";
	
	nUI_L[nUI_UNITPANEL_PARTY]       		= "Panneau d'fenêtre: Mode Groupe";
	nUI_L[nUI_UNITPANEL_PARTY.."Label"] 	= "Groupe";
	
	nUI_L[nUI_UNITPANEL_RAID10]      		= "Panneau d'fenêtre: Mode Raid 10 Joueurs";
	nUI_L[nUI_UNITPANEL_RAID10.."Label"]	= "Raid 10";
	
	nUI_L[nUI_UNITPANEL_RAID15]      		= "Panneau d'fenêtre: Mode Raid 15 Joueurs";
	nUI_L[nUI_UNITPANEL_RAID15.."Label"]	= "Raid 15";
	
	nUI_L[nUI_UNITPANEL_RAID20]      		= "Panneau d'fenêtre: Mode Raid 20 Joueurs";
	nUI_L[nUI_UNITPANEL_RAID20.."Label"]	= "Raid 20";
	
	nUI_L[nUI_UNITPANEL_RAID25]      		= "Panneau d'fenêtre: Mode Raid 25 Joueurs";
	nUI_L[nUI_UNITPANEL_RAID25.."Label"]	= "Raid 25";
	
	nUI_L[nUI_UNITPANEL_RAID40]      		= "Panneau d'fenêtre: Mode Raid 40 Joueurs";
	nUI_L[nUI_UNITPANEL_RAID40.."Label"]	= "Raid 40";
	
	nUI_L["Click to change unit frame panels"] = "Cliquez pour changer le panneau d'unité";
	
	nUI_L["<unnamed frame>"] = "<frame sans nom>";
	nUI_L["unit change"] = "changement d'unité";
	nUI_L["unit class"] = "classe de l'unité";
	nUI_L["unit label"] = "label de l'unité";
	nUI_L["unit level"] = "niveau de l'untié";
	nUI_L["unit reaction"] = "reaction de l'unité";
	nUI_L["unit health"] = "vie de l'unité";
	nUI_L["unit power"] = "puissancede l'unité";
	nUI_L["unit portrait"] = "portrait de l'unité";
	nUI_L["raid group"] = "groupe de raid";
	nUI_L["unit PvP"] = "fenêtre PvP";
	nUI_L["raid target"] = "cible raid";
	nUI_L["casting bar"] = "barre de sort";
	nUI_L["ready check"] = "ready check";
	nUI_L["unit status"] = "status unité";
	nUI_L["unit aura"] = "aura de l'unité";
	nUI_L["unit combat"] = "combat de l'unité";
	nUI_L["unit resting"] = "repot de l'unité";
	nUI_L["unit role"] = "rôle de l'unité";
	nUI_L["unit runes"]        = "runes de l'unité";
	nUI_L["unit feedback"] = "retour de l'unité";
	nUI_L["unit combo points"] = "Points de combo de l'unité";
	nUI_L["unit range"]        = "Distance de l'unité";
	nUI_L["unit spec"]         = "Spé de l'unité";
	nUI_L["unit threat"]       = "Menace de l'unité";  -- changed in threat status for a given unit
	
	nUI_L["Talent Build: <build name> (<talent points>)"] = "Talent Build: |cFF00FFFF%s|r (%s)";
	nUI_L["passed unit id is <nil> in callback table for %s"] = "L'unité adoptée est <nil> dans la table de callback pour %s"; 
	nUI_L["nUI: Warning.. anchoring %s to %s -- anchor point has a <nil> value."] = "nUI: Attention.. Ancrage de %s à %s -- le point d'ancrage a la valeur <nil>.";
	nUI_L["nUI: Cannot register %s for scaling... frame does not have an applyScale() method"] = "nUI: Impossible d'enregistrer %s for redimensionnement... la frame n'a pas de méthode applyScale().";
	nUI_L["nUI: Cannot register %s for scaling... frame does not have an applyAnchor() method"] = "nUI: Impossible d'enregistrer %s for redimensionnement... la frame n'a pas de métohde applyAnchor().";
	nUI_L["nUI: %s %s callback %s does not have a newUnitInfo() method."] = "nUI: %s %s callback %s n'a pas de méthode newUnitInfo().";
	nUI_L["nUI_UnitClass.lua: unhandled unit class [%s] for [%s]"] = "nUI_UnitClass.lua: fenêtre de classe [%s] non gérée pour [%s]";
	nUI_L["nUI: click-casting registration is %s"] = "nUI: l'enreigstrement du click-casting registration sur %s";
	nUI_L["nUI: must pass a valid parent frame to nUI_Unit:createFrame() for unit id [%s (%s)]"] = "nUI: Nom de fenêtre parent valide requis par nUI_Unit:createFrame() pour l'fenêtre ID [%s (%s)]";
	nUI_L["nUI says: Gratz for reaching level %d %s!"] = "nUI dit: Félicitation pour avoir atteint le niveau %d %s!";
	nUI_L["nUI_Unit: [%s] is not a valid unit frame element type!"] = "nUI_Unit: [%s] n'est pas une un type d'élément de fenêtre valide !";
	nUI_L["nUI_Unit: [%s] is not a known unit skin name!"] = "nUI_Unit: [%s] n'est pas un nom d'habillage connu!";
	
	-- nUI_Unit hunter pet strings
	
	nUI_L["Your pet"] = "Votre familier";
	nUI_L["quickly"] = "rapidement";
	nUI_L["slowly"] = "lentement";
	nUI_L["nUI: %s is happy."] = "nUI: %s est content.";
	nUI_L["nUI: %s is unhappy... time to feed!"] = "nUI: %s est mécontent... il est temps de le nourrir!";
	nUI_L["nUI: Warning! %s is |cFFFFFFFFNOT|r happy! Better feed soon."] = "nUI: Attntion! %s n'est |cFFFFFFFFPAS|r heureux! Vous devriez le nourrir rapidement.";
	nUI_L["nUI: Warning... %s is %s losing loyalty "] = "nUI: Attention... %s perd % en loyauté";
	nUI_L["nUI: %s is %s gaining loyalty"] = "nUI: %s gagne %s en loyauté";
	nUI_L["nUI: %s has stopped gaining loyalty"] = "nUI: %s a cessé de gagné en loyauté";
	nUI_L["nUI: %s has stopped losing loyalty"] = "nUI: %s a cessé de perdre en loyauté";
	nUI_L["Your pet's current damage bonus is %d%%"] = "Le bonus aux dommages actuel de votre familier est de %+d%%"; 
	nUI_L["Your pet's current damage penalty is %d%%"] = "La pénalité aux dommages actuelle de votre familier est de %+d%%"; 
	nUI_L["nUI: It looks to me like you're a little busy... maybe you should try feeding %s AFTER you leave combat?"] = "nUI: Il me semble que vous êtes un peu occupé... vous devriez peut-être essayer de nourrir %s APRES avoir quitté le combat ?"; 
	nUI_L["nUI: I looked everywhere, but I couldn't find a pet to feed. Perhaps he's in your backpack?"] = "nUI: J'ai regardé par tout, mais je n'ai pu trouver de familier à nourrir. Peut-être est-il dans votre sac à dos?"; 
	nUI_L["nUI: You know, I could be wrong, but I don't think feeding %s is a very good idea... it doesn't look to me like what you have in your bags is what %s is thinking about eating."] = "nUI: Vous savez, je peux me tromper, mais je ne pense pas que nourrir %s soit une très bonne idée... il ne me semble pas que ce que vous avez dans votre sac soit ce dont %s est envie de manger."; 

	-- miscelaneous strings
	
	nUI_L["Version"]                     = "nUI Version |cFF00FF00%s|r";
	nUI_L["Copyright"]                   = "Copyright (C) 2008 by K. Scott Piel";
	nUI_L["Rights"]                      = "Tous droits réservés";
	nUI_L["Off Hand Weapon:"]            = "Arme main secondaire:";
	nUI_L["Main Hand Weapon:"]           = "Arme main principale:";
	nUI_L["Group %d"]                    = "Groupe %d";
	nUI_L["MS"]                          = "MS";
	nUI_L["FPS"]				         = "IPS";
	nUI_L["Minimap Button Bag"]          = "Sac des boutons de la Minicarte";
	nUI_L["System Performance Stats..."] = "Stats Performance du Système...";
	nUI_L["PvP Time Remaining: <time_left>"] = "PvP Temps restant: |cFF50FF50%s|r"
	
	nUI_L["Cursor: <cursor_x,cursor_y>  /  Player: <player_x,player_y>"] = "Curseur: |cFF00FFFF<%0.1f, %0.1f>|r  /  Joueur: |cFF00FFFF<%0.1f, %0.1f>|r";
	nUI_L["nUI has disabled the plugin 'nui_AuraBars' as it is now incorporated in nUI 5.0 -- Please use '/nui rl' to reload the UI. You should uninstall nUI_AuraBars as well."] = "nUI a désactivé le plugin 'nui_AuraBars' car il estt mainteant intégré dans nUI 5.0 -- Merci d'utiliser '/nui rl' pour recahrger l'interface. Vous devriez désinstaller nUI_AuraBars également.";
	
	-- key binding strings
	
	nUI_L["HUD Layout"]                  = "Affichages HUD"; 
	nUI_L["Unit Panel Mode"]             = "Mode d'affichage unités"; 
	nUI_L["Info Panel Mode"]             = "Mode du panneau d'infos";
	nUI_L["Key Binding"]                 = "Raccourcis claviers";
	nUI_L["Miscellaneous Bindings"]      = "Raccourcis divers";
	nUI_L["No key bindings found"]       = "Pas de raccourcis clavier trouvé"; 
	nUI_L["<ctrl-alt-right click> to change bindings"] = "<ctrl-alt-clic droit> pour changer les raccourcis";

	-- rare spotting strings
	
	nUI_L["You have spotted a rare mob: |cFF00FF00<mob name>|r<location>"] = "Vous avez ciblé un monstre rare: |cFF00FF00%s|r%s";
	nUI_L["You have spotted a rare elite mob: |cFF00FF00<mob name>|r<location>"] = "Vous avez ciblé un monstre élite rare: |cFF00FF00%s|r%s";
	
	-- faction / reputation bar strings
	
	nUI_L["Unknown"]    = "Inconnu";
	nUI_L["Hated"]      = "Haï";
	nUI_L["Hostile"]    = "Hostile";
	nUI_L["Unfriendly"] = "Inamical";
	nUI_L["Neutral"]    = "Neutre";
	nUI_L["Friendly"]   = "Amical";
	nUI_L["Honored"]    = "Honoré";
	nUI_L["Revered"]    = "Reveré";
	nUI_L["Exalted"]    = "Exalté";
	
	nUI_L["Faction: <faction name>"]    = "Faction: |cFF00FFFF%s|r";
	nUI_L["Reputation: <rep level>"]    = "Réputation: |cFF00FFFF%s|r";
	nUI_L["Current Rep: <number>"]      = "Rép Actuelle: |cFF00FFFF%d|r";
	nUI_L["Required Rep: <number>"]     = "Rép Requise: |cFF00FFFF%d|r";
	nUI_L["Remaining Rep: <number>"]    = "Rép Manquante: |cFF00FFFF%d|r";
	nUI_L["Percent Complete: <number>"] = "Pourcentage Complet: |cFF00FFFF%0.1f%%|r";
	nUI_L["<faction name> (<reputation>) <current rep> of <required rep> (<percent complete>)"] = "%s (%s) %d de %d (%0.1f%%)";
	
	nUI_L[nUI_FACTION_UPDATE_START_STRING]    = "Réputation avec ";
	nUI_L[nUI_FACTION_UPDATE_END_STRING]      = " a augmentée de";
	nUI_L[nUI_FACTION_UPDATE_INCREASE_STRING] = "augmentée";
	
	-- player experience bar strings
	
	nUI_L["Current level: <level>"]                         = "Niveau actuel: |cFF00FFFF%d|r";
	nUI_L["Current XP: <experience points>"]                = "XP actuel: |cFF00FFFF%d|r";
	nUI_L["Required XP: <XP required to reach next level>"] = "XP requis: |cFF00FFFF%d|r";
	nUI_L["Remaining XP: <XP remaining to level>"]          = "XP manquante: |cFF00FFFF%d|r";
	nUI_L["Percent complete: <current XP / required XP>"]   = "Pourcentage complété: |cFF00FFFF%0.1f%%|r";
	nUI_L["Rested XP: <total rested experience> (percent)"] = "XP de Repos: |cFF00FFFF%d|r (%0.1f%%)";
	nUI_L["Rested Levels: <levels>"]                        = "Niveaux de repos: |cFF00FFFF%0.2f|r";
	nUI_L["Level <player level>: <experience> of <max experience> (<percent of total>), <rested xp> rested XP"] = "Niveau  %d: %d sur %d (%0.1f%%), %d XP de repos";
	
	-- health race bar tooltip strings
	
	nUI_L["nUI Health Race Stats..."] = "nUI Stats Course de Vie...";
	nUI_L["No current advantage to <player> or <target>"] = "Aucun avantage actuellement pour %s ou %s";
	nUI_L["<unit name>'s Health: <current>/<maximum> (<percent>)"] = "Vie de %s: |cFF00FF00%d/%d|r (|cFFFFFFFF%0.1f%%|r)";
	nUI_L["Advantage to <player>: <pct>"] = "Avantage à %s: (|cFF00FF00%+0.1f%%|r)";
	nUI_L["Advantage to <target>: <pct>"] = "Avantage à %s: (|cFFFFC0C0%0.1f%%|r)";
	
	-- skinning system messages
	
	nUI_L["nUI could not load the currently selected skin [ %s ]... perhaps you have it disabled? Switching to the default nUI skin."] = "nUI ne peut pas charger la skin couramment sélectionnée [ |cFFFFC0C0%s|r ]... peut-être l'avez-vous désactivée ? Remplacement par la skin par défaut."; 
	nUI_L["nUI: Cannot register %s for skinning... frame does not have an applySkin() method"] = "nUI: ne peut enregistrer |cFFFFC0C0%s|r pour habillage... la fenêtre n'a pas de méthode applySkin()"; 
	
	-- names of the various frames that nUI allows the user to move on the screen
	
	nUI_L["Micro-Menu"]                = "Micro-Menu";
	nUI_L["Capture Bar"]               = "Barre de Capture";
	nUI_L["Watched Quests"]            = "Quêtes suivies";
	nUI_L["Quest Timer"]               = "Timer de quête";
	nUI_L["Equipment Durability"]      = "Durabilité de l'équipement";
	nUI_L["PvP Objectives"]            = "Objectifs PVP";
	nUI_L["Watched Achievments"]       = "suivi des Haut-faits";
	nUI_L["In-Game Tooltips"]          = "Bulles d'aide de jeu";
	nUI_L["Bag Bar"]                   = "Barre des sacs";
	nUI_L["Group Loot Frame"]          = "Fenêtre de loot de groupe";
	nUI_L["nUI_ActionBar"]             = "Barre principale / Page d'action 1";
	nUI_L["nUI_BottomLeftBar"]         = "Barre inférieure gauche / Page d'action 2";
	nUI_L["nUI_LeftUnitBar"]           = "Barre de fenêtre d'unité gauche / Page d'action 3";
	nUI_L["nUI_RightUnitBar"]          = "Barre de fenêtre d'unité droite / Page d'action 4";
	nUI_L["nUI_TopRightBar"]           = "Barre supérieure droite / Page d'action 5";
	nUI_L["nUI_TopLeftBar"]            = "Barre supérieure gauche / Page d'action 6";
	nUI_L["nUI_BottomRightBar"]        = "Barre inférieure droite";
	nUI_L["Pet/Stance/Shapeshift Bar"] = "Barre Familier/Position/Changement de forme";
	nUI_L["Vehicle Seat Indicator"]    = "Indicateur Place de Vehicule";
	nUI_L["Voice Chat Talkers"]        = "Parlant Chat Vocal";
	nUI_L["Timer Bar"]                 = "Barre Timer";
	
	-- slash command processing	
	
	nUI_SlashCommands =
	{
		[nUI_SLASHCMD_HELP] =
		{
			command = "help",
			options = "{command}",
			desc    = "Affiche la liste de toutes les commandes disponibles si {command} n'est pas fournie, si {command} est fournie, affiche les informations sur la commande spécifiée",
			message = nil,
		},
		[nUI_SLASHCMD_RELOAD] =
		{
			command = "rl",
			options = nil,
			desc    = "Recharge l'interface utilisateur et les addons (identique à /console reloadui)",
			message = nil,
		},
		[nUI_SLASHCMD_BUTTONBAG] =
		{
			command = "bb",
			options = nil,
			desc    = "Cette commande alterne l'affichage du Sac de Boutons de la minicarte ON et OFF.",
			message = nil,
		},
		[nUI_SLASHCMD_MOVERS] =
		{
			command = "movers",
			options = nil,
			desc    = "Active et désactive le déplacement des fenêtres UI standards de Blizzard telles que bulles d'aide, durabilité, timer de quête, etc.",
			message = "nUI: Le déplacement des fenêtres Blizzard est %s", -- enabled or disabled
		},
		[nUI_SLASHCMD_CONSOLE] =
		{
			command = "console",
			options = "{on|off|mouseover}",
			desc    = "Règle l'option de  visibilité pour la console supérieure où 'on' affiche toujours la console, 'off' cache la console et 'mouseover' affiche la console quand la souris passe sur la console.",
			message = "nUI: La visibilité de la console supérieure est réglée sur %s", -- "on", "off" or "mouseover"
		},
		[nUI_SLASHCMD_TOOLTIPS] =
		{
			command = "tooltips",
			options = "{owner|mouse|fixed|default}",
			desc    = "Cette option définie la position des bulles d'aides d'information où 'owner' affiche les bulles d'aide à côté de la fenêtre d'origine, 'mouse' affiche la bulle d'aide à la position de la souris, 'fixed' affiche toutres les bulles d'aide à une position fixe ou 'default' pour aucune gestion particulière des bulles d'aide",
			message = "nUI: Mode d'affiche des bulles d'aide réglé sur |cFF00FFFF%s|r", -- the chosen tooltip mode
		},
		[nUI_SLASHCMD_COMBATTIPS] =
		{
			command = "combattips",
			options = nil,
			desc    = "Cette option bascule l'affichage de l'aide des boutons d'action on et off pendant le combat. Par défaut, l'affichage de l'aide est désactivé durant les combats.",
			message = "nUI: Affichage de l'aide en combat : %s", -- enabled or disabled
		},
		[nUI_SLASHCMD_BAGSCALE] =
		{
			command = "bagscale",
			options = "{n}",
			desc    = "Cette option augmente ou diminue la taille de vos sacs où {n} est un nombre compris entre 0.5 et 1.5 -- 1 par défaut",
			message = "nUI: L'echelle des sacs est modifiée en |cFF00FFFF%0.2f|r", -- the chosen scale
		},
		[nUI_SLASHCMD_BAGBAR] =
		{
			command = "bagbar",
			options = "{on|off|mouseover}",
			desc    = "Cette option règle l'affichage de la barre des sacs sur on, off ou visible sur survole de la souris. Sur 'on' par défaut.",
			message = "nUI: L'affichage de la barre des sacs a été réglé sur |cFF00FFFF%s|r", -- on, off or mouseover
		},
		[nUI_SLASHCMD_CALENDAR] = 
		{
			command = "calendrier",
			options = nil,
			desc    = "Par défaut, nUI déplace le boutton du calendrier de guilde de la minimap vers le sac de bouttons. Cette option active ou désactive cette fonction, permettant de laisser le calendrier de guilde s'afficher sur la minicarte.",
			message = "nUI: LA gestion du bouton du calendrier de guilde a été %s", -- ENABLED or DISABLED
		},
		[nUI_SLASHCMD_FRAMERATE] =
		{
			command = "framerate",
			options = "{n}",
			desc    = "Cette option change (ou active) le taux de rafraichissement maximum des animations de barres et fenêtres d'fenêtre. Augmentez {n} pour plus de fluidité, diminuez {n} pour la performance. Valeur par défaut "..nUI_DEFAULT_FRAME_RATE.." images par seconde.",
			message = "nUI: Votre taux de rafraichissement à été changé par |cFF00FFFF%0.0fFPS|r", -- the chosen rate in frames per second... change FPS if you need a different abreviation!
		},
		[nUI_SLASHCMD_FEEDBACK] =
		{
			command = "feedback",
			options = "{curse|disease|magic|poison}",
			desc    = "nUI fournit une surbrillance d'une fenêtre d'unité pour chaque unité qui est subit un effet de poison, maladie, magique ou malédiction. Par défaut, les quatres types sont indiqués. Cette option vous permet de les régler individuellement afin de ne mettre en surbrillance que ceux que vous pouvez supprimer.",
			message = "nUI: Surlignage des fenêtres d'unité pour les |effets de  cFF00FFFF%s|r a été %s", -- aura type and enabled or disabled
		},
		[nUI_SLASHCMD_SHOWHITS] =
		{
			command = "showhits",
			options = nil,
			desc    = "nUI's surligne le fond d'unité en rouge et vert pour indiquer quand l'unité subit des dommages ou reçoit des soins. Cette option permute cette fonction on et off. Par défaut réglé sur on.",
			message = "nUI: L'affichage des dégâts et soins des fenêtres d'unité a été %s", -- enabled or disabled
		},
		[nUI_SLASHCMD_MAXAURAS] = 
		{
			command = "maxauras",
			options = "{1-40}",
			desc    = "Par défaut nUI affiche jusqu'au maximum possible de 40 effets sur chacune des unités clés : joueur, familier, véhicule et cible. Cette option vous permet de définir le nombre maximum d'effets d'une valeur comprise entre 0 et 40. régler maxauras à zéro (0) désactivera l'affichage des effets.",
			message = "nUI: Le nombre maximum d'effets a été réglé sur |cFF00FFFF%d|r", -- a number from 0 to 40
		},
		[nUI_SLASHCMD_AUTOGROUP] =
		{
			command = "autogroup",
			options = nil,
			desc    = "Par défaut nUI change automatiquement votre panneau d'unité pour celui correspondant au mieux à votre situation quand vous joignez ou quittez un groupe ou un raid ou quand le roster change. Cette option permute cette fonction sur on et off.",
			message = "nUI: Permutation automatique du panneau d'unité est %s quand vous joignez et quittez groupes et raids",
		},
		[nUI_SLASHCMD_RAIDSORT] = 
		{
			command = "raidsort",
			options = "{unit|group|class|name}",
			desc    = "Sélectionne l'ordre de tri utilisé pour afficher les fenêtres d'unités dans un raid. L'option 'unit' trie les fenêtres par l'ID des unités de raid1 à raid40. L'option 'group' trie les fenêtres par numéro de groupe, l'option 'class' tri par classe et l'option 'name' trie en fonction du nom des joueurs. Par défaut, le trie des fenêtres s'effectue selon le groupe de raid.",
			message = "nUI: Tri des membres du raid réglé sur |cFF00FF00%s|r", -- sort option: group, unit or class
		},
		[nUI_SLASHCMD_SHOWANIM] =
		{
			command = "anim",
			options = nil,
			desc    = "Cette commande alterne l'affichage des portraits et barres d'fenêtres animés ON et OFF",
			message = "nUI: Affichage de portraits animés %s", -- enabled or disabled
		},
		[nUI_SLASHCMD_HPLOST] = 
		{
			command = "hplost",
			options = nil,
			desc    = "Cette option règle l'affichage de la santé du joueur sur la fenêtre d'unité sur sa vie restante ou perdue. Cela est particulièrement utile pour les soigneurs.",
			message = "nUI: L'affichage de la valeur de la santé a été changée en %s", -- "health remaining" or "health lost"
		},
		[nUI_SLASHCMD_HUD] =
		{
			command  = "hud",
			options  = nil,
			desc     = "Cette commande permet l'accès à une série de commandes utilisées pour le comportement du HUD de nUI. Utilisez la commande '/nui hud' seule pour avoir la liste des sosus-commandes disponibles.",
			message  = nil,
			sub_menu =
			{
				[nUI_SLASHCMD_HUD_SCALE] =
				{
					command = "scale",
					options = "{n}",
					desc    = "Cette option règle l'échelle du HUD où 0.25 <= {n} <= 1.75. de petites valeurs de {n} diminuent la taille du HUD et de grandes valeurs augmententsa taille. Par défaut {n} = 1",
					message = "nUI: L'échelle du HUD a été réglée sur |cFF00FFFF%0.2f|r", -- a number
				},
				[nUI_SLASHCMD_HUD_SHOWNPC] =
				{
					command = "shownpc",
					options = nil,
					desc    = "Cette option alterne l'affichage des barres du HUD pour le ciblage de PNJs non-attaquables ON et OFF quand hors combat",
					message = "nUI: Barres HUD sur ciblage de PNJs non-attaquables a été %s", -- enabled or disabled
				},
				[nUI_SLASHCMD_HUD_FOCUS] = 
				{
					command = "focus",
					options = nil,
					desc    = "Par défaut, le HUD n'affiche pas d'information sur le focus du joueur. Activer cette option remplacera la cible et CdC du HUD avec le focus du joueur et le focus de la cible quand une focalisation est choisie.",
					message = "nUI: L'affichage HUD pour le focus du joueur et le focus de la cible est %s", -- enabled or disabled
				},
				[nUI_SLASHCMD_HUD_HEALTHRACE] =
				{
					command = "healthrace",
					options = nil,
					desc    = "Cette option alterne l'affichage de la barre Course de Vie du HUD ON et OFF",
					message = "nUI: L'affichage de la barre HUD Course de Vie a été %s", -- enabled or disabled
				},
				[nUI_SLASHCMD_HUD_COOLDOWN] =
				{
					command = "cooldown",
					options = nil,
					desc    = "Cette option règle l'affichage de la barre de cooldown des sorts du HUD, les messages d'alerte de rafraichissement et les sons des rafraichissements on et off.",
					message = "nUI: La barre de rafraichissement des sorts du HUDa été réglée sur %s",
				},
				[nUI_SLASHCMD_HUD_CDALERT] =
				{
					command = "cdalert",
					options = nil,
					desc    = "Quand la barre de rafraichissement de sorts du HUD est activée, cette option permute l'affichage des messages de disponibilité on ou off.",
					message = "nUI: Les messages HUD de disponibilité des sorts ont été %s",
				},
				[nUI_SLASHCMD_HUD_CDSOUND] =
				{
					command = "cdsound",
					options = nil,
					desc    = "Quand la barre de rafraichissement des sorts du HUD est activée, cette option permute le jeu d'un son quand prêt sur on ou off.",
					message = "nUI: Le son HUD de la disponibilité d'un sort a été %s",
				},
				[nUI_SLASHCMD_HUD_CDMIN] =
				{
					command = "cdmin",
					options = "{n}",
					desc    = "Défini la durée minimum requise pour qu'un sort soit affiché dans la barre des rafraichissements quand celui-ci s'enclenche. Si la période de rafraichissement initiale est inférieure à {n}, il ne s'affichera pas. La valeur par défaut est '/nui hud cdmin 2'",
					message = "nUI: Le temps minimum pour l'affichage HUD du rafraichissement des sorts a été réglé sur |cFF00FFFF%d|r secondes", -- time in seconds.
				},
				[nUI_SLASHCMD_HUD_HGAP] =
				{
					command = "hgap",
					options = "{n}",
					desc    = "Cette option règle l'écart entre les côtés gauches et droits du HUD où {n} est un nombre plus grand que 0. Augmentez {n} pour augmenter l'écart entrela gauche et la droite du HUD. La valeur par défaut de {n} est 400",
					message = "nUI: L'écart horizontal du HUD est de |cFF00FFFF%0.0f|r", -- a number greater than zero
				},
				[nUI_SLASHCMD_HUD_VOFS] = 
				{
					command = "vofs",
					options = "{n}",
					desc    = "Cette option règle le décalage vertical du HUD depuis le centre du point de vue. La valeur par défaut est '/nui hud vofs 0' qui place le HUD au centre vertical du point de vue. Les valeurs inféreures à 0 déplacent le HUD vers le bas, celles grandes que 0 déplacent le HUD vers le haut.",
					message = "nUI: Le décalage vertical du HUD a été réglé sur |cFF00FFFF%0.0f|r", -- a number
				},
				[nUI_SLASHCMD_HUD_IDLEALPHA] =
				{
					command = "idlealpha",
					options = "{n}",
					desc    = "Cette option règle la transparence du HUD quand vous êtes inactif avec {n} = 0 pour un HUD invisible et {n} = 1 pour un HUD totalement opaque. Par défaut {n} = 0",
					message = "nUI: L'alpha du HUDquand inactif a été réglée sur |cFF00FFFF%0.2f|r", -- a number between 0 and 1
				},
				[nUI_SLASHCMD_HUD_REGENALPHA] =
				{
					command = "regenalpha",
					options = "{n}",
					desc    = "Cette option règle la transparence du HUD quand vous (ou votre familier) régénérez votre vie, votre puissance ou subissez un effet négatif où {n} = 0 pour un HUD invisible et {n} = 1 pour un HUD totalement opaque . The default is {n} = 0.35",
					message = "nUI: L'alpha du HUD durant régénération a été réglé sur |cFF00FFFF%0.2f|r", -- a number between 0 and 1
				},
				[nUI_SLASHCMD_HUD_TARGETALPHA] =
				{
					command = "targetalpha",
					options = "{n}",
					desc    = "Cette option règle la transparence du HUD quand vous avez ciblé une cible valide où {n} = 0 pour un invisible HUD et {n} = 1 pour HUD totalement opaque. La valeur par défaut est {n} = 0.75",
					message = "nUI: l'apha du HUD de ciblage a éé réglé sur |cFF00FFFF%0.2f|r", -- a number between 0 and 1
				},
				[nUI_SLASHCMD_HUD_COMBATALPHA] =
				{
					command = "combatalpha",
					options = "{n}",
					desc    = "Cette option règle la transparence du HUD quand vous ou votre familier êtes en combat où {n} = 0 pour un HUD invisible et {n} = 1 pour un HUD totalement opaque. La valeur par défaut est {n} = 1",
					message = "nUI: L'apha du HUD en combat a été réglé sur |cFF00FFFF%0.2f|r", -- a number between 0 and 1
				},
			},
		},
		[nUI_SLASHCMD_BAR] = 
		{
			command  = "bar",
			options  = nil,
			desc     = "Cette commande donne accès à une liste de commandes utilisées pour contrôler le fonctionnement des barres d'action de nUI. Utilisez la commande '/nui bar' seule pour obtenir la liste des paramètres disponibles.",
			message  = nil,
			sub_menu =
			{
				[nUI_SLASHCMD_BAR_COOLDOWN] = 
				{
					command = "cooldown",
					options = nil,
					desc    = "Cette option est utilisée pour switcher l'affichage des rafraichissements (affichés en jaune sur la barre d'action) on et off. By default this feature is enabled.",
					message = "nUI: Le temps de rafraichissement sur la barre d'action est %s", -- enabled or disabled
				},
				[nUI_SLASHCMD_BAR_DURATION] = 
				{
					command = "duration",
					options = nil,
					desc    = "Par défaut, quand vous lancez un sort sur une cible, le temps du sort restant est affiché en bleu sur la barre d'action. Cette option désactive cette fonctionnalité.",
					message = "nUI: Temps des sorts sur la barre d'action %s", -- enabled or disabled
				},
				[nUI_SLASHCMD_BAR_MACRO] =
				{
					command = "macro",
					options = nil,
					desc    = "Quand vous placez une macro personnalisée dans la barre d'action, nUI affiche son nom sur le bouton. Cette option permet de switcher cet affichage entre on ou off.",
					message = "nUI: Affichage du nom des macros dans la barre d'action %s", -- enabled or disabled
				},
				[nUI_SLASHCMD_BAR_STACKCOUNT] = 
				{
					command = "stackcount",
					options = nil,
					desc    = "nUI affiche normalement le nombre de piles d'objets de votre inventaire placés dans la barre d'action dans le coin inférieur droit du bouton. Cette option vous permet de régler l'affichage sur on ou off.",
					message = "nUI: Affichage du nombre de piles dans la barre d'action %s", -- enabled or disabled
				},
				[nUI_SLASHCMD_BAR_KEYBIND] = 
				{
					command = "keybind",
					options = nil,
					desc    = "Quand vous avez un raccourcis clavier sur un bouton d'action, le nom de la touche est normalement affiché dans le coin supérieur gauche. Cette option vous permet de régler cette indication sur on ou off.",
					message = "nUI: Affichage du nom des raccourcis clavier %s", -- enabled or disabled
				},
				[nUI_SLASHCMD_BAR_DIMMING] = 
				{
					command = "dimming",
					options = nil,
					desc    = "Par défaut, quand vous êtes en combat, si une action de votre barre n'est pas utilisable ou en cours sur votre cible, elle est assombrie pour signaler que vous ne pouvez ou n'avez pas encore besoin de la lancer et s'illumine quand elle s'enclenche ou s'efface de la cible. Cette option fait passer cette fonctionnalité sur on ou off.",
					message = "nUI: Assombrissement d'actions en cours de rafraichissement, ou inutilisables ", -- enabled or disabled
				},
				[nUI_SLASHCMD_BAR_DIMALPHA] =
				{
					command = "dimalpha",
					options = "{n}",
					desc    = "Normalement quand un bouton d'action est assombrit parce qu'il n'est pas utilisable ou en cours sur la cible, il est affiché avec 30% d'opactité. Cette option vous permet de régler un opacité personnelle entre 0 pour une transparence totale 1 pour une opacité totale. La commande par défaut est '/nui dimalpha 0.30'",
					message = "nUI: L'opacité de l'assombrissement a été réglée sur |cFF00FFFF%0.1f%%|r", -- a number between 0% and 100%
				},
				[nUI_SLASHCMD_BAR_MOUSEOVER] =
				{
					command = "mouseover",
					options = nil,
					desc    = "Par défaut, nUI affiche ces barres d'actions en permanence. Quand la fonction '/nui mouseover' est activée, nUI cache les barres à moins que le curseur de la souris ne les survole.",
					message = "nUI: Affichage des barres d'action basé sur le survol de la souris %s", -- enabled or disabled
				},
				[nUI_SLASHCMD_BAR_TOTEMS] =
				{
					command = "totems",
					options = nil,
					desc    = "nUI utilise la barre des totems par défaut de Blizzards pour les chamans. Si vous préfèrez utiliser un addon alternatif pour les totems, l'option '/nui bar totems' peut être utilisée pour cachr la barre des totems par défaut.",
					message = "nUI: Masquage de la barre des totems de Blizzard %s", -- enabled or disabled
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
		[nUI_SLASHCMD_MOUNTSCALE] =
		{
			command = "mountscale",
			options = "{n}",
			desc    = "Cette option régle l'échelle d'affichage de l'indicateur des sièges affiché au centre du haut de l'affichage quand vous êtes sur une monture sépciale. La commande par défaut est '/nui mountscale 1' où 0.5 < {n} < 1.5 -- les valeurs inférieures à 1.0 réduisent la taille de l'indicateur, les valeurs de {n} > 1.0 augmentent sa taille.",
			message = "nUI: L'échelle de l'indicateur de siège des montures spéciales a été réglé sur |cFF00FFFF%s|r", -- a number between 0.5 and 1.5
		},
		[nUI_SLASHCMD_CLOCK] =
		{
			command = "clock",
			options = "{server|local|both}",
			desc    = "Cette option règle l'affichage de l'horloge du panneau afin d'afficher au choix l'heure locale courante{local}, l'heure serveur courante {server} ou à la fois l'heure locale et l'heure serveur {both}. Le réglage par défaut est {server}",
			message = "nUI: Le mode d'affichage de l'horloge du panneau a été réglé sur |cFF00FFFF%s|r",
		},
		[nUI_SLASHCMD_MAPCOORDS] = 
		{
			command = "mapcoords",
			options = nil,
			desc    = "Cette option règle l'affichage des coordonées du joueur et du curseur sur la carte du monde on et off. Sur on par défaut.",
			message = "nUI: Coordonées sur la carte du monde %s", -- "ENABLED" or "DISABLED"
		},
		[nUI_SLASHCMD_ROUNDMAP] =
		{
			command = "roundmap",
			options = nil,
			desc    = "Cette option alterne l'affichage de la mini-carte entre la minicarte carrée (square)par défaut et une minicarte ronde (round)",
			message = "nUI: La forme de la mini-carte a été réglée sur |cFF00FFFF%s|r", -- "round" or "square"
		},
		[nUI_SLASHCMD_MINIMAP] =
		{
			command = "minimap",
			options = nil,
			desc    = "Cette option active et désactive la gestion de la minicarte par nUI. Quand activé, nUI va essayer de déplacer la minicarte sur le panneau nUI will attempt to move the minimap into the dashboard. Dans le cas contraire, la minicarte de Blizzard n'est pas modifiée par nUI (les boutons de la minicarte le restent). Changer de mode forcera un rechargement de l'interface!",
			message = "nUI: La gestion de la minicarte a été %s", -- enabled or disabled
		},
		[nUI_SLASHCMD_ONEBAG] =
		{
			command = "onebag",
			options = nil,
			desc    = "Cette option règle l'affichage des sacs de l'inventaire sur votre barre des sacs pour montrer soit votre sac à dos uniquement ou les cinq sacs. Cela NE combine PAS actuellement tous vos sacs dans un seul, cette fonction n'est disponible que pour supporter les mods tierces partie tels qu'ArkInventory.",
			message = "nUI: L'affichage du boutton de sac unique a été %s", -- enabled or disabled
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
			desc    = "Cette option règle le niveau de message du débugueur de nUI. En principe vous ne devriez change le niveau de débug uniquement à la demande de l'uatuer du mod. Utilisez {n} = 0 pour désactiver le débuggage complètement (par défaut).",
			message = "nUI: Votre niveau de débugage est de |cFF00FFFF%d|r", -- an integer value
		},
		[nUI_SLASHCMD_LASTITEM+2] = 
		{
			command = "profile",
			options = nil,
			desc    = "Cette option règle le profilage du fonctionnement de nUI on et off. Le profilage est off par défaut et l'activer ne surcharge pas. L'état du profilage N'est PAS sauvegardé entre les sessions de recharge de la console. Vous ne devriez pas activer le profilage à moins que ce ne soit demandé par l'auteur.",
			message = "nUI: Le profilage du fonctionnement a été %s", -- enabled or disabled
		},
	};
	
	nUI_L["round"]  = "round";
	nUI_L["square"] = "square";
	
	nUI_L["health remaining"] = "|cFF00FF00de vie restante|r"; -- used to tell the player that unit frames are displaying health remaining
	nUI_L["health lost"]      = "|cFFFF0000de vie perdue|r"; -- used to tell the player that unit frames are displaying health lost
	
	-- these strings are the optional arguments to their respective commands and can be 
	-- translated to make sense in the local language
	
	nUI_L[nUI_SLASHCMD_OPTIONS( nUI_SLASHCMD_CLOCK, "server" )] = "server";
	nUI_L[nUI_SLASHCMD_OPTIONS( nUI_SLASHCMD_CLOCK, "local" )]  = "local";
	nUI_L[nUI_SLASHCMD_OPTIONS( nUI_SLASHCMD_CLOCK, "both" )]   = "both";
	
	nUI_L[nUI_SLASHCMD_OPTIONS( nUI_SLASHCMD_RAIDSORT, "unit" )]  = "unit";  -- command option used to select sorting of raid unit frames by unit id
	nUI_L[nUI_SLASHCMD_OPTIONS( nUI_SLASHCMD_RAIDSORT, "group" )] = "group";  -- command option used to select sorting of raid unit frames by raid group
	nUI_L[nUI_SLASHCMD_OPTIONS( nUI_SLASHCMD_RAIDSORT, "class" )] = "class";  -- command option used to select sorting of raid unit frames by player class
	nUI_L[nUI_SLASHCMD_OPTIONS( nUI_SLASHCMD_RAIDSORT, "name" )]  = "name"; -- command option used to select sorting of raid unit frames by player class
	
	nUI_L[nUI_SLASHCMD_OPTIONS( nUI_SLASHCMD_FEEDBACK, "curse" )]    = "curse";
	nUI_L[nUI_SLASHCMD_OPTIONS( nUI_SLASHCMD_FEEDBACK, "disease" )]  = "disease";
	nUI_L[nUI_SLASHCMD_OPTIONS( nUI_SLASHCMD_FEEDBACK, "magic" )]    = "magic";
	nUI_L[nUI_SLASHCMD_OPTIONS( nUI_SLASHCMD_FEEDBACK, "poison" )]   = "poison";
	
	nUI_L[nUI_SLASHCMD_OPTIONS( nUI_SLASHCMD_CONSOLE, "on" )]        = "on";
	nUI_L[nUI_SLASHCMD_OPTIONS( nUI_SLASHCMD_CONSOLE, "off" )]       = "off";
	nUI_L[nUI_SLASHCMD_OPTIONS( nUI_SLASHCMD_CONSOLE, "mouseover" )] = "mouseover";
	
	nUI_L[nUI_SLASHCMD_OPTIONS( nUI_SLASHCMD_BAGBAR, "on" )]        = "on";
	nUI_L[nUI_SLASHCMD_OPTIONS( nUI_SLASHCMD_BAGBAR, "off" )]       = "off";
	nUI_L[nUI_SLASHCMD_OPTIONS( nUI_SLASHCMD_BAGBAR, "mouseover" )] = "mouseover";
	
	nUI_L[nUI_SLASHCMD_OPTIONS( nUI_SLASHCMD_TOOLTIPS, "owner" )]   = "ouwner";
	nUI_L[nUI_SLASHCMD_OPTIONS( nUI_SLASHCMD_TOOLTIPS, "mouse" )]   = "mouse";
	nUI_L[nUI_SLASHCMD_OPTIONS( nUI_SLASHCMD_TOOLTIPS, "fixed" )]   = "fixed";
	nUI_L[nUI_SLASHCMD_OPTIONS( nUI_SLASHCMD_TOOLTIPS, "default" )] = "default";
	
	-- miscellaneous slash command messages printed to the player
	
	nUI_L["The value [ %s ] is not a valid nUI slash command. Try [ /nui help ] for a list of commands"] = "L'entrée [ |cFFFFC000%s|r ] n'est pas une commande nUI valide. Essayez [ |cFF00FFFF/nui help|r ] pour la liste des commandes";
	nUI_L["nUI currently supports the following list of slash commands..."]	= "nUI supporte actuellement la liste de commnades suivantes..."; 
	nUI_L["The '/nui %s' slash command currently supports the following list of sub-commands..."] = "La commande '|cFF00FFFF/nui %s|r' supporte actuellement la liste de sous-commandes suivante...";
	nUI_L["nUI: [ %s ] is not a valid tooltip settings option... please choose from %s, %s, %s or %s"] = "nUI: [ |cFFFFC0C0%s|r ] n'est pas une option de bulle d'aide valide... merci de choisir entre |cFF00FFFF%s|r, |cFF00FFFF%s|r, |cFF00FFFF%s|r et |cFF00FFFF%s|r";
	nUI_L["nUI: [ %s ] is not a valid console visibility option... please choose from %s, %s or %s"] = "nUI: [ |cFFFFC0C0%s|r ] n'est pas une option de visibilité de la console valide... merci de choisir entre |cFF00FFFF%s|r, |cFF00FFFF%s|r et |cFF00FFFF%s|r";
	nUI_L["nUI: [ %s ] is not a valid alpha value... please choose a number between 0 and 1 where 0 is fully transparent and 1 is fully opaque."] = "nUI: [ |cFFFFC0C0%s|r ] n'est pas une valeur alpha valide... merci de choisir un nombre entre 0 et 1 où 0 est transparence totale et 1 est opacité totale.";
	nUI_L["nUI: [ %s ] is not a valid horizontal gap value... please choose a number between 1 and 1200 where 1 is very narrow and 1200 is very wide."] = "nUI: [ |cFFFFC0C0%s|r ] n'est pas une valeur d'écartement horizontal valide... merci de choisir un nombre entre 1 et 1200 où 1 est très rapproché et 1200 est très éloigné.";
	nUI_L["nUI: [ %s ] is not a valid clock option... please choose either 'local' to display the local time, 'server' to display the server time or 'both' to display both times."] = "nUI: [ %s ] n'est pas une option d'horloge valide... merci de choisir entre 'local' pour afficher l'heure locale, 'server' pour afficher l'heure serveur et 'both' pour afficher les deux.";
	nUI_L["nUI: [ %s ] is not a valid feedback option... please choose either <curse>, <disease>, <magic> or <poison>"] = "nUI: [ %s ] n'est pas une option de retour valide... merci de choisir entre '%s', '%s', '%s' ou '%s'";-- alerts the user when they have entered an invalid feedback highlighting option
	nUI_L["nUI: [ %s ] is not a valid raid sorting option... please choose either <unit>, <group> or <class>"] = "nUI: [ %s ] n'est pas une option de tri de raid valide... merci de choisir entre '%s', '%s' or '%s'";
	nUI_L["nUI: [ %s ] is not a valid special mount indicator display scale. The scale must be a number between 0.5 and 1.5"] = "nUI: [ %s ] n'est pas une valeur d'échelle valide pour l'indicateur de monture spéciale. L'echelle doit être un nombre compris entre 0.5 et 1.5";
	
end
