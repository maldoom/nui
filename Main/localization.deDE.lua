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

-------------------------------------------------------------------------------

Translation (German)

Copyright (c) 2008 by Andre Patock
All Rights Reserved
E-mail: < andre.patock@gmx.net >


Realm: 	Alleria (PvE) [German]
Name:	Aldea (Nightelf Druid - heal)

and

Copyright (c) 2008 by Marcel Waizenhöfer
All Rights Reserved
E-mail: < ogogo@gmx.de >

Realm		Azshara (PvP) [German]
Name: Balaur (Bloodelf - Hunter)

and

Copyright (c) 2008 by Marius Schur
All Rights Reserved


Realm: Der Rat von Dalaran (RP-PvE) [German]
Name:  Env� (Bloodelf Warlock)

and

Copyright (c) 2008 by Alexander Schwarz
All Rights Reserved


Realm: Alleria (PvE) [German]
Name:	Wavebow (Nightelf Hunter - Beast Master)


Wenn die Übersetzung teilweise nicht so gut ist, sendet mir einfach per E-mail 
eine bessere Version zu.

-------------------------------------------------------------------------------

Übersetzung der deutschen Umlaute in LUA-Code:  


	Lua-Code 	Beispiel
ä	\195\164	Jäger = J\195\164ger
Ä	\195\132	Ärger = \195\132rger
ö	\195\182	schön = sch\195\182n
Ö	\195\150	Ödipus = \195\150dipus
ü	\195\188	Rüstung = R\195\188stung
Ü	\195\156	Übung = \195\156bung
ß	\195\159	Straße = Stra\195\159e 

-------------------------------------------------------------------------------


Diese Datei ist ein Teil von nUI.
	
	Bei nUI handelt es sich um eine frei verfügbare Software.
	Du kannst sie weitergeben und/oder sie unter Bedingungen der GNU General 
	Public License License as published by the Free Software Foundation modifizieren.

	nUI wird verteilt in der Hoffnung, dass es von Nutzen sein wird, aber OHNE JEDE GARANTIE; 
	sogar ohne die implizite Gew�hrleistung der Marktf�higkeit oder Eignung f�r einen bestimmten 
	Zweck. Lese die GNU General Public License f r ausf hrlichere Informationen.

	Du solltest eine Kopie der GNU General Public License zusammen mit nUI haben. 
	Ist dies nicht der Fall, siehe <http://www.gnu.org/licenses/>.

Diese Software wird von dem Inhaber von Urheberrechten und Beitragszahler
"As is" und jegliche ausdr�ckliche oder stillschweigend, zur Gew�hrleistung, einschlie�lich, aber nicht
Beschr�nkt auf die gesetzlichen Gew hrleistungen der Marktg ngigkeit und die Eignung f�r
einen besonderen Zweck abgelehnt. In keinem Fall kann laut des Urheberrecht der
Eigent mers oder der Beitragszahler haftbar gemacht werden f�r etwaige direkte, indirekte, zuf�llige,
SPEZIELLE, EXEMPLARISCHE ODER FOLGESCH�DEN (EINSCHLIESSLICH,
Beschr�nkt sich auf die Beschaffung von Ersatz Waren oder Dienstleistungen; VERLUST VON NUTZUNG,
Daten oder Gewinne; oder gesch�ftlicher Unterbrechung) f�hrte, jedoch zu und �ber etwaige
Theorie der Haftung, ob im Vertrag, verschuldensunabh�ngige Haftung oder unerlaubter Handlung
(Einschlie�lich Fahrl�ssigkeit oder anderweitig). 
Die Nutzung dieser Software besteht auf eigene Gefahr, auch wenn die M�glichkeit eines Schadens oder 
der Verlust von daten besteht.

--]]---------------------------------------------------------------------------

if nUI_Locale == "deDE" then
	
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
	
	nUI_L["splash title"] = "%s ha sido actualizado a la versión de %s %s";
	nUI_L["splash info"]  = "Para la guia de usuario, galerias, últimas descargas, preguntas frequentes de nUI, foros de soporte tecnico o para donar para mantener nUI, por favor visita |cFF00FFFFhttp://www.nUIaddon.com|r";
	nUI_L["plus info"]    = "You are running the 'Release' version of nUI... there is also a free version 'nUI+' available which includes 15, 20, 25 and 40 man raid frames as well as additional features. Please visit |cFF00FFFFhttp://www.nUIaddon.com/plus.html|r for more information.";
	
	-- splash frame strings
		
	nUI_L["splash title"] = "%s wurde auf %s %s upgegraded";
	nUI_L["splash info"]  = "F\195\188r die Anleitung, Gallerien, letzten Downloads, nUI'FAQ (Häufig gestellte Fragen), Technisches Support-Forum or f\195\188r Spenden an nUI, bitte besuche |cFF00FFFFhttp://www.nUIaddon.com|r";
	nUI_L["plus info"]    = "Momentan ist die 'Release' Version von nUI installiert... es giebt noch eine andere kostenlose Version '|cFF00FFFFnUI+|r' welche die 15, 20, 25 und 40er Raid Ansichten als zusätzliches Feature besitzt. Bitte besuche |cFF00FFFFhttp://www.nUIaddon.com/plus.html|r f\195\188r weitere Informationen.";
	
	-- clock strings
	
	nUI_L["am"]                      = "am";		-- 12:01 in the morning until noon suffix
	nUI_L["pm"]                      = "pm";		-- 12:00 noon to midnight suffix
	nUI_L["<hour>:<minute><suffix>"] = "%d:%02d%s"; --  12 hour clock format
	nUI_L["<hour>:<minute>"]         = "%02d:%02d"; --  24 hour clock format
	nUI_L["(S) <hour>:<minute><suffix> - <hour>:<minute><suffix> (L)"] = "(S) %d:%02d%s - %d:%02d%s (L)"; -- 12 hour clock format where (S) is short for "Server time" and "L" is short for "Local time"
	nUI_L["(S) <hour>:<minute> - <hour>:<minute> (L)"] = "(S) %02d:%02d - %02d:%02d (L)"; -- 24 hour clock format where (S) is short for "Server time" and (L) is short for "Local time"
	
	-- state strings
	
	nUI_L["|cFF00FF00ENABLED|r"]  = "|cFF00FF00EINGESCHALTET|r";
	nUI_L["|cFFFF0000DISABLED|r"] = "|cFFFF0000AUSGESCHALTET|r";
	nUI_L["~INTERRUPTED~"]        = "~UNTERBROCHEN~";
	nUI_L["~FAILED~"]             = "~FEHLGESCHLAGEN~";
	nUI_L["~MISSED~"]             = "~VERFEHLT~";
	nUI_L["OFFLINE"]              = "OFFLINE";
	nUI_L["DND"]                  = "DND"; -- Do Not Disturb abbreviation
	nUI_L["AFK"]                  = "AFK";
	nUI_L["DEAD"]                 = "TOT";
	nUI_L["GHOST"]                = "GEIST";
	nUI_L["FD"]                   = "FD";
	nUI_L["TAXI"]                 = "TAXI";
	nUI_L["OOR"]		          = "OOR"; -- abbreviation for "out of range"
	
	-- power types

	-- -- this entire section is new... it contains the labels used to describe the
	--        unit's current health and power type in tooltips and other areas
	
	nUI_L["HEALTH"]      = "Leben  ";	
	nUI_L["MANA"]        = "Mana";
	nUI_L["RAGE"]        = "Wut";
	nUI_L["FOCUS"]       = "Fokus";
	nUI_L["ENERGY"]      = "Energie";
	nUI_L["RUNES"]       = "Runen";
	nUI_L["RUNIC_POWER"] = "Runenmacht";
	nUI_L["AMMO"]        = "Munition"; -- vehicles
	nUI_L["FUEL"]        = "Treibstoff"; -- vehicles
	
	-- time remaining (cooldowns, buffs, etc.)
	
	nUI_L["TimeLeftInHours"]   = "%0.0fh";
	nUI_L["TimeLeftInMinutes"] = "%0.0fm";
	nUI_L["TimeLeftInSeconds"] = "%0.0fs";
	nUI_L["TimeLeftInTenths"]  = "%0.1fs";
	
	-- raid and party role tooltip strings
	
	nUI_L["Party Role: |cFF00FFFF%s|r"] = "Gruppenfunktion: |cFF00FFFF%s|r";
	nUI_L["Raid Role: |cFF00FFFF%s|r"]  = "Raidfunktion: |cFF00FFFF%s|r";
	nUI_L["Raid Leader"]                = "Raidanf\195\188hrer";
	nUI_L["Party Leader"]               = "Gruppenanf\195\188hrer";
	nUI_L["Raid Assistant"]             = "Raidassistent";
	nUI_L["Main Tank"]                  = "Main Tank";
	nUI_L["Off-Tank"]                   = "Off-Tank";
	nUI_L["Master Looter"]              = "Beutemeister";
	
	-- hunter pet feeder strings
	
	nUI_L[nUI_FOOD_MEAT]   = "fleisch"; -- do not edit these strings in any way
	nUI_L[nUI_FOOD_FISH]   = "fisch";   -- do not edit these strings in any way
	nUI_L[nUI_FOOD_BREAD]  = "brot";    -- do not edit these strings in any way
	nUI_L[nUI_FOOD_CHEESE] = "k\195\164se";    -- do not edit these strings in any way
	nUI_L[nUI_FOOD_FRUIT]  = "obst";    -- do not edit these strings in any way
	nUI_L[nUI_FOOD_FUNGUS] = "fungus";  -- do not edit these strings in any way

	nUI_L["Click to feed %s"]           = "Klicken, um %s zu f\195\188ttern";
	nUI_L["Click to cancel feeding"]    = "Klicken, um nicht mehr zu f\195\188ttern";
	nUI_L["nUI: %s can eat %s%s%s"]     = "nUI: %s kann %s %s %s essen";	
	nUI_L[" or "]                       = " oder ";
	nUI_L["nUI: You don't have a pet!"] = "nUI: Du hast keinen Begleiter!";
	
	nUI_L["nUI: You can feed %s the following...\n"] = "nUI: Du kannst %s mit folgendem f\195\188ttern...\n";
	nUI_L["nUI: You have nothing you can feed %s in your current inventory"] = "nUI: Du hast nichts in Deinem Rucksack, was %s essen k\195\182nnte";
	
	-- status bar strings
	
	nUI_L["nUI: Cannot change status bar config while in combat!"] = "nUI: Die Konfiguration der Statusleiste kann w\195\164hrend des Kampfes nicht ver\195\164ndert werden!";
	nUI_L["nUI: [%s] is not a valid option for orienting a status bar... use LEFT, RIGHT, TOP or BOTTOM"] = "nUI: [%s] ist keine g\195\188ltige Option f\195\188r die Ausrichtung einer Statusleiste... verwende LEFT, RIGHT, TOP oder BOTTOM";
	nUI_L["nUI: Can not change status bar overlays while in combat!"] = "nUI: Die Oberfl\195\164che der Statusleisten kann w\195\164hrend des Kampfes nicht ver\195\164ndert werden!";
	nUI_L["nUI: The maximum value (%d) of a status bar must be greater than the minimum value (%d)"] = "nUI: Der maximale Wert (%d) der Statusleiste muss gr\195\182�er sein als der Mindestwert (%d)";
	
	-- information panel strings
	
		
	nUI_L["Minimap"] = "Minimap";
	
	nUI_L[nUI_INFOPANEL_COMBATLOG]      		= "Info Panel: Kampfloganzeige";
	nUI_L[nUI_INFOPANEL_COMBATLOG.."Label"]		= "Kampflog"; -- small word or abbreviation to show on the panel selector button
	
	nUI_L[nUI_INFOPANEL_BMM]		      	    = "Info Panel: Karte des Schlachtfeldes";
	nUI_L[nUI_INFOPANEL_BMM.."Label"]			= "Map"; -- small word or abbreviation to show on the panel selector button
	
	nUI_L[nUI_INFOPANEL_RECOUNT]		   		= "Info Panel: 'Recount' Schadensanzeige Modus";
	nUI_L[nUI_INFOPANEL_RECOUNT.."Label"]		= "Recount"; -- small word or abbreviation to show on the panel selector button
	
	nUI_L[nUI_INFOPANEL_OMEN3]		      	    = "Info Panel: 'Omen3' Aggro Modus";
	nUI_L[nUI_INFOPANEL_OMEN3.."Label"]			= "Omen3"; -- small word or abbreviation to show on the panel selector button
	
	nUI_L[nUI_INFOPANEL_SKADA]		      		= "Info Panel: Skada-Damage/Aggro Meter Modus";
	nUI_L[nUI_INFOPANEL_SKADA.."Label"]			= "Skada";
	
	nUI_L[nUI_INFOPANEL_OMEN3KLH]	      		= "Info Panel: 'Omen3' + 'KLH' Aggro Modus";
	nUI_L[nUI_INFOPANEL_OMEN3KLH.."Label"]		= "Threat"; -- small word or abbreviation to show on the panel selector button
	
	nUI_L[nUI_INFOPANEL_KLH]		      	    = "Info Panel: 'KLH' Aggro Modus";
	nUI_L[nUI_INFOPANEL_KLH.."Label"]			= "KTM"; -- small word or abbreviation to show on the panel selector button
	
	nUI_L[nUI_INFOPANEL_KLHRECOUNT]	      	    = "Info Panel: 'KLH' Aggro + Recount Schadensanzeige Modus";
	nUI_L[nUI_INFOPANEL_KLHRECOUNT.."Label"]	= "KTM+"; -- small word or abbreviation to show on the panel selector button
	
	nUI_L["nUI: You need to go to the WoW Interface menu, select the 'Social' option and turn off the 'Simple Chat' menu option to enable integrated combat log support in nUI."] = "nUI: Die Option 'Einfacher Chat' muss im WoW-Interfacemen\195\188 in der Rubrik 'Geselligkeit' deaktiviert werden, damit die in nUI integrierte Kampflogunterst\195\188tzung aktiviert wird.";
	nUI_L["The %s Info Panel plugin is a core plugin to nUI and cannot be disabled"] = "Das %s Info Panel Plugin ist ein Kernbestandteil von nUI und kann nicht deaktiviert werden";
	nUI_L["Click to change information panels"] = "Klicken, um den Anzeigemodus des Info Panels zu \195\164ndern";
	nUI_L["nUI: Cannot initialize the Info Panel plugin [ %s ] -- it does not have an initPanel() interface method"] = "nUI: Das Info Panel Plugin konnte nicht geladen werden [ |cFF00FFFF%s|r ] -- es hat keine initPanel() Interfacemethode";
	nUI_L["nUI: Cannot initialize the Info Panel plugin [ %s ] -- No global object by that name exists"] = "nUI: Das Info Panel Plugin konnte nicht geladen werden [ |cFF00FFFF%s|r ] -- Es existiert kein globales Objekt mit diesem Namen";	
	nUI_L["nUI: Cannot select the Info Panel plugin [ %s ] -- it does not have a setSelected() interface method"] = "nUI: Das Info Panel Plugin konnte nicht geladen werden [ |cFF00FFFF%s|r ] -- es hat keine setSelected() Interfacemethode";
	
	-- HUD layout strings (heads up display)
			
	nUI_L["Click to change HUD layouts"] = "Klicken, um die Darstellung des HUD's zu \195\164ndern";
	
	nUI_L[nUI_HUDLAYOUT_PLAYERTARGET]	   		= "HUD Layout: Spieler links | Ziel rechts"; -- mouseover tooltip phrase
	nUI_L[nUI_HUDLAYOUT_PLAYERTARGET.."Label"]	= "Spieler|Ziel"; -- small phrase or abbreviation to show on the HUD selector button
	
	nUI_L[nUI_HUDLAYOUT_HEALTHPOWER]	   		= "HUD Layout: Gesundheit (Leben) links | Energie (Mana, Wut etc.) rechts";
	nUI_L[nUI_HUDLAYOUT_HEALTHPOWER.."Label"]	= "Leben|Mana"; -- small phrase or abbreviation to show on the HUD selector button
	
	nUI_L[nUI_HUDLAYOUT_SIDEBYSIDE]	   		    = "HUD Layout: Nebeneinanderliegende horizontale Leisten";
	nUI_L[nUI_HUDLAYOUT_SIDEBYSIDE.."Label"]	= "Horizontal"; -- small phrase or abbreviation to show on the HUD selector button
	
	nUI_L[nUI_HUDLAYOUT_NOBARS]	   				= "HUD Layout: Einfaches HUD (Leisten werden nicht angezeigt)";
	nUI_L[nUI_HUDLAYOUT_NOBARS.."Label"]		= "Einfach"; -- small phrase or abbreviation to show on the HUD selector button
	
	nUI_L[nUI_HUDLAYOUT_NOHUD]			   		= "HUD Layout: Deaktiviert (HUD ist komplett ausgeschaltet)";
	nUI_L[nUI_HUDLAYOUT_NOHUD.."Label"]			= "Kein HUD"; -- small phrase or abbreviation to show on the panel selector button
	
	nUI_L[nUI_HUDMODE_PLAYERTARGET]         = "nUI Spieler/Ziel HUD Modus";
	nUI_L[nUI_HUDSKIN_PLAYERTARGET_PET]     = nUI_L[nUI_HUDMODE_PLAYERTARGET]..": Skin zur Anzeige der Werte des Begleiters";
	nUI_L[nUI_HUDSKIN_PLAYERTARGET_PLAYER]  = nUI_L[nUI_HUDMODE_PLAYERTARGET]..": Skin zur Anzeige der Werte des Spielers";
	nUI_L[nUI_HUDSKIN_PLAYERTARGET_TARGET]  = nUI_L[nUI_HUDMODE_PLAYERTARGET]..": Skin zur Anzeige des Werte des Ziels";
	nUI_L[nUI_HUDSKIN_PLAYERTARGET_TOT]     = nUI_L[nUI_HUDMODE_PLAYERTARGET]..": Skin zur Anzeige der Werte des Ziel des Ziels (ToT)";
	nUI_L[nUI_HUDSKIN_PLAYERTARGET_CASTBAR] = nUI_L[nUI_HUDMODE_PLAYERTARGET]..": Skin zur Anzeige der Zauberleiste des Spielers";
	
	nUI_L[nUI_HUDMODE_HEALTHPOWER]         = "nUI Leben/Mana HUD Modus";
	nUI_L[nUI_HUDSKIN_HEALTHPOWER_PET]     = nUI_L[nUI_HUDMODE_HEALTHPOWER]..": Skin zur Anzeige der Werte des Begleiters";
	nUI_L[nUI_HUDSKIN_HEALTHPOWER_PLAYER]  = nUI_L[nUI_HUDMODE_HEALTHPOWER]..": Skin zur Anzeige der Werte des Spielers";
	nUI_L[nUI_HUDSKIN_HEALTHPOWER_TARGET]  = nUI_L[nUI_HUDMODE_HEALTHPOWER]..": Skin zur Anzeige des Werte des Ziels";
	nUI_L[nUI_HUDSKIN_HEALTHPOWER_TOT]     = nUI_L[nUI_HUDMODE_HEALTHPOWER]..": Skin zur Anzeige der Werte des Ziel des Ziels (ToT)";
	nUI_L[nUI_HUDSKIN_HEALTHPOWER_CASTBAR] = nUI_L[nUI_HUDMODE_HEALTHPOWER]..": Skin zur Anzeige der Zauberleiste des Spielers";
	
	nUI_L[nUI_HUDMODE_SIDEBYSIDE]          = "nUI Horizontales HUD Modus";
	nUI_L[nUI_HUDSKIN_SIDEBYSIDE_PET]      = nUI_L[nUI_HUDMODE_SIDEBYSIDE]..": Skin zur Anzeige der Werte des Begleiters";
	nUI_L[nUI_HUDSKIN_SIDEBYSIDE_PLAYER]   = nUI_L[nUI_HUDMODE_SIDEBYSIDE]..": Skin zur Anzeige der Werte des Spielers";
	nUI_L[nUI_HUDSKIN_SIDEBYSIDE_TARGET]   = nUI_L[nUI_HUDMODE_SIDEBYSIDE]..": Skin zur Anzeige des Werte des Ziels";
	nUI_L[nUI_HUDSKIN_SIDEBYSIDE_TOT]      = nUI_L[nUI_HUDMODE_SIDEBYSIDE]..": Skin zur Anzeige der Werte des Ziel des Ziels (ToT)";
	nUI_L[nUI_HUDSKIN_SIDEBYSIDE_CASTBAR]  = nUI_L[nUI_HUDMODE_SIDEBYSIDE]..": Skin zur Anzeige der Zauberleiste des Spielers";
	
	nUI_L[nUI_HUDMODE_NOBARS]              = "nUI Einfacher Balkenloser HUD Modus";
	nUI_L[nUI_HUDSKIN_NOBARS_CASTBAR]      = nUI_L[nUI_HUDMODE_NOBARS]..": Skin zur Anzeige der Zauberleiste des Spielers";
	nUI_L[nUI_HUDSKIN_NOBARS_PLAYER]       = nUI_L[nUI_HUDMODE_NOBARS]..": Skin zur Anzeige der Werte des Spielers";
	nUI_L[nUI_HUDSKIN_NOBARS_TARGET]       = nUI_L[nUI_HUDMODE_NOBARS]..": Skin zur Anzeige des Werte des Ziels";
	
	-- nUI_Unit strings
	
	nUI_L["Pet"]        = "Begleiter";
	nUI_L["Target"]     = "Ziel";
	nUI_L["Range"]      = "Entfernung";
	nUI_L["MELEE"]      = "NAHKAMPF";
	nUI_L["Elite"]      = "Elite";
	nUI_L["Rare"]       = "Rar";
	nUI_L["Rare Elite"] = "Rar Elite";
	nUI_L["World Boss"] = "Weltboss";
	nUI_L["Vehicle"]    = "Fahrzeug"; --  used to identify that unit in question is a vehicle
	
	nUI_L["unit: player"]             = "Spieler";
	nUI_L["unit: vehicle"]            = "Fahrzeug des Spielers"; -- for WotLK vehicle unit frames
	nUI_L["unit: pet"]		    = "Begleiter des Spielers";
	nUI_L["unit: pettarget"]          = "Ziel des Begleiters";
	nUI_L["unit: focus"]              = "Fokus des Spielers";
	nUI_L["unit: focustarget"]        = "Ziel des Spielerfokus";
	nUI_L["unit: target"]             = "Ziel des Spielers";
	nUI_L["unit: %s-target"]          = "%s's Ziel";
	nUI_L["unit: mouseover"]          = "Mouseoverziel";
	nUI_L["unit: targettarget"]       = "Ziel des Ziels (ToT)";
	nUI_L["unit: targettargettarget"] = "Ziel des ToT (ToTT)";
	nUI_L["unit: party%d"]            = "Gruppenmitglied %d";
	nUI_L["unit: party%dpet"]         = "Gruppenmitglied %d's Begleiter";
	nUI_L["unit: party%dtarget"]      = "Gruppenmitglied %d's Ziel";
	nUI_L["unit: party%dpettarget"]   = "Grupppenmitglied %d's Ziel des Begleiters";
	nUI_L["unit: raid%d"]             = "Raiditglied %d";
	nUI_L["unit: raid%dpet"]          = "Raidmitglied %d's Begleiter";
	nUI_L["unit: raid%dtarget"]       = "Raidmitglied %d's Ziel";
	nUI_L["unit: raid%dpettarget"]    = "Raidmitglied %d's Ziel des Begleiters";

	nUI_L[nUI_UNITMODE_PLAYER]        = "nUI Solo Modus"; 
	nUI_L[nUI_UNITSKIN_SOLOFOCUS]     = nUI_L[nUI_UNITMODE_PLAYER]..": Skin des Fokus des Spielers"; 
	nUI_L[nUI_UNITSKIN_SOLOMOUSE]     = nUI_L[nUI_UNITMODE_PLAYER]..": Skin des Mouseoverziels"; 
	nUI_L[nUI_UNITSKIN_SOLOVEHICLE]   = nUI_L[nUI_UNITMODE_PLAYER]..": Skin des Fahrzeugs"; -- for WotLK vehicle unit frames
	nUI_L[nUI_UNITSKIN_SOLOPET]       = nUI_L[nUI_UNITMODE_PLAYER]..": Skin des Begleiters"; 
	nUI_L[nUI_UNITSKIN_SOLOPETBUTTON] = nUI_L[nUI_UNITMODE_PLAYER]..": Skin der Auswahl-/Schaltfl\195\164che f\195\188r das Begleiterziel... z.B. f\195\188r Begleiter des Ziels, Begeleiter des Spielerfokus, etc."; 
	nUI_L[nUI_UNITSKIN_SOLOPLAYER]    = nUI_L[nUI_UNITMODE_PLAYER]..": Skin des Spielers"; 
	nUI_L[nUI_UNITSKIN_SOLOTARGET]    = nUI_L[nUI_UNITMODE_PLAYER]..": Skin des Ziels"; 
	nUI_L[nUI_UNITSKIN_SOLOTGTBUTTON] = nUI_L[nUI_UNITMODE_PLAYER]..": Skin der Auswahl-/Schaltfl\195\164che f\195\188r das Ziel... z.B. f\195\188r Ziel des Spielerfokus, etc."; 
	nUI_L[nUI_UNITSKIN_SOLOTOT]       = nUI_L[nUI_UNITMODE_PLAYER]..": Skin des Ziel des Ziels (ToT)"; 

	nUI_L[nUI_UNITMODE_PARTY]          = "nUI Party/Gruppen Modus"; 
	nUI_L[nUI_UNITSKIN_PARTYFOCUS]     = nUI_L[nUI_UNITMODE_PARTY]..": Skin des Fokus des Spielers"; 
	nUI_L[nUI_UNITSKIN_PARTYMOUSE]     = nUI_L[nUI_UNITMODE_PARTY]..": Skin des Mouseoverziels"; 
	nUI_L[nUI_UNITSKIN_PARTYVEHICLE]   = nUI_L[nUI_UNITMODE_PARTY]..": Skin des Fahrzeugs"; -- for WotLK vehicle unit frames
	nUI_L[nUI_UNITSKIN_PARTYPLAYER]    = nUI_L[nUI_UNITMODE_PARTY]..": Skin des Spielers"; 
	nUI_L[nUI_UNITSKIN_PARTYPET]       = nUI_L[nUI_UNITMODE_PARTY]..": Skin des Begleiters"; 
	nUI_L[nUI_UNITSKIN_PARTYTARGET]    = nUI_L[nUI_UNITMODE_PARTY]..": Skin des Ziels";
	nUI_L[nUI_UNITSKIN_PARTYTOT]       = nUI_L[nUI_UNITMODE_PARTY]..": Skin des Ziel des Ziels (ToT)";
	nUI_L[nUI_UNITSKIN_PARTYFOCUS]     = nUI_L[nUI_UNITMODE_PARTY]..": Skin des Fokus des Spielers";
	nUI_L[nUI_UNITSKIN_PARTYLEFT]      = nUI_L[nUI_UNITMODE_PARTY]..": Skin der Gruppenmitglieder auf der linken Seite "; 
	nUI_L[nUI_UNITSKIN_PARTYRIGHT]     = nUI_L[nUI_UNITMODE_PARTY]..": Skin der Gruppenmitglieder auf der rechten Seite "; 
	nUI_L[nUI_UNITSKIN_PARTYPETBUTTON] = nUI_L[nUI_UNITMODE_PARTY]..": Skin der Auswahl-/Schaltfl\195\164che f\195\188r den Begleiter der Gruppenmitglieder und des Fokus"; 
	nUI_L[nUI_UNITSKIN_PARTYTGTBUTTON] = nUI_L[nUI_UNITMODE_PARTY]..": Skin der Auswahl-/Schaltfl\195\164che f\195\188r das Ziel der Gruppenmitglieder und des Fokus"; 
	nUI_L[nUI_UNITSKIN_PARTYMOUSE]     = nUI_L[nUI_UNITMODE_PARTY]..": Skin des Mouseoverziels";
	
	nUI_L[nUI_UNITMODE_RAID10]          ="nUI 10 Spieler Raid Modus";
	nUI_L[nUI_UNITSKIN_RAID10FOCUS]     = nUI_L[nUI_UNITMODE_RAID10]..": Skin des Fokus des Spielers";
	nUI_L[nUI_UNITSKIN_RAID10MOUSE]     = nUI_L[nUI_UNITMODE_RAID10]..": Skin des Mouseoverziels";
	nUI_L[nUI_UNITSKIN_RAID10VEHICLE]   = nUI_L[nUI_UNITMODE_RAID10]..": Skin des Fahrzeugs"; -- for WotLK vehicle unit frames
	nUI_L[nUI_UNITSKIN_RAID10PLAYER]    = nUI_L[nUI_UNITMODE_RAID10]..": Skin des Spielers";
	nUI_L[nUI_UNITSKIN_RAID10PET]       = nUI_L[nUI_UNITMODE_RAID10]..": Skin des Begleiters";
	nUI_L[nUI_UNITSKIN_RAID10TARGET]    = nUI_L[nUI_UNITMODE_RAID10]..": Skin des Ziels";
	nUI_L[nUI_UNITSKIN_RAID10TOT]       = nUI_L[nUI_UNITMODE_RAID10]..": Skin des Ziel des Ziels (ToT)";
	nUI_L[nUI_UNITSKIN_RAID10FOCUS]     = nUI_L[nUI_UNITMODE_RAID10]..": Skin des Fokus des Spielers";
	nUI_L[nUI_UNITSKIN_RAID10LEFT]      = nUI_L[nUI_UNITMODE_RAID10]..": Skin der Raidmitglieder auf der linken Seite";
	nUI_L[nUI_UNITSKIN_RAID10RIGHT]     = nUI_L[nUI_UNITMODE_RAID10]..": Skin der Raidmitglieder auf der rechten Seite";
	nUI_L[nUI_UNITSKIN_RAID10PETBUTTON] = nUI_L[nUI_UNITMODE_RAID10]..": Skin der Auswahl-/Schaltfl\195\164che f\195\188r den Begleiter der Raidmitglieder und des Fokus";
	nUI_L[nUI_UNITSKIN_RAID10TGTBUTTON] = nUI_L[nUI_UNITMODE_RAID10]..": Skin der Auswahl-/Schaltfl\195\164che f\195\188r das Ziel der Raidmitglieder und des Fokus";
	nUI_L[nUI_UNITSKIN_RAID10MOUSE]     = nUI_L[nUI_UNITMODE_RAID10]..": Skin des Mouseoverziels";
	
	
	nUI_L[nUI_UNITMODE_RAID15]          ="nUI 15 Spieler Raid Modus";
	nUI_L[nUI_UNITSKIN_RAID15FOCUS]     = nUI_L[nUI_UNITMODE_RAID15]..": Skin des Fokus des Spielers";
	nUI_L[nUI_UNITSKIN_RAID15MOUSE]     = nUI_L[nUI_UNITMODE_RAID15]..": Skin des Mouseoverziels";
	nUI_L[nUI_UNITSKIN_RAID15VEHICLE]   = nUI_L[nUI_UNITMODE_RAID15]..": Skin des Fahrzeugs";
	nUI_L[nUI_UNITSKIN_RAID15PLAYER]    = nUI_L[nUI_UNITMODE_RAID15]..": Skin des Spielers";
	nUI_L[nUI_UNITSKIN_RAID15PET]       = nUI_L[nUI_UNITMODE_RAID15]..": Skin des Begleiters";
	nUI_L[nUI_UNITSKIN_RAID15TARGET]    = nUI_L[nUI_UNITMODE_RAID15]..": Skin des Ziels";
	nUI_L[nUI_UNITSKIN_RAID15TOT]       = nUI_L[nUI_UNITMODE_RAID15]..": Skin des Ziel des Ziels (ToT)";
	nUI_L[nUI_UNITSKIN_RAID15FOCUS]     = nUI_L[nUI_UNITMODE_RAID15]..": Skin des Fokus des Spielers";
	nUI_L[nUI_UNITSKIN_RAID15LEFT]      = nUI_L[nUI_UNITMODE_RAID15]..": Skin der Raidmitglieder auf der linken Seite";
	nUI_L[nUI_UNITSKIN_RAID15RIGHT]     = nUI_L[nUI_UNITMODE_RAID15]..": Skin der Raidmitglieder auf der rechten Seite";
	nUI_L[nUI_UNITSKIN_RAID15PETBUTTON] = nUI_L[nUI_UNITMODE_RAID15]..": Skin der Auswahl-/Schaltfl\195\164che f\195\188r den Begleiter der Raidmitglieder und des Fokus";
	nUI_L[nUI_UNITSKIN_RAID15TGTBUTTON] = nUI_L[nUI_UNITMODE_RAID15]..": Skin der Auswahl-/Schaltfl\195\164che f\195\188r das Ziel der Raidmitglieder und des Fokus";
	nUI_L[nUI_UNITSKIN_RAID15MOUSE]     = nUI_L[nUI_UNITMODE_RAID15]..": Skin des Mouseoverziels";
	
	nUI_L[nUI_UNITMODE_RAID20]          ="nUI 20 Spieler Raid Modus";
	nUI_L[nUI_UNITSKIN_RAID20FOCUS]     = nUI_L[nUI_UNITMODE_RAID20]..": Player Focus' unit skin";
	nUI_L[nUI_UNITSKIN_RAID20MOUSE]     = nUI_L[nUI_UNITMODE_RAID20]..": Mouseover target unit skin";
	nUI_L[nUI_UNITSKIN_RAID20VEHICLE]   = nUI_L[nUI_UNITMODE_RAID20]..": Vehicle unit skin";
	nUI_L[nUI_UNITSKIN_RAID20PLAYER]    = nUI_L[nUI_UNITMODE_RAID20]..": Player's unit skin";
	nUI_L[nUI_UNITSKIN_RAID20PET]       = nUI_L[nUI_UNITMODE_RAID20]..": Player Pet's unit skin";
	nUI_L[nUI_UNITSKIN_RAID20TARGET]    = nUI_L[nUI_UNITMODE_RAID20]..": Target's unit skin";
	nUI_L[nUI_UNITSKIN_RAID20TOT]       = nUI_L[nUI_UNITMODE_RAID20]..": Skin des Ziel des Ziels (ToT)";
	nUI_L[nUI_UNITSKIN_RAID20FOCUS]     = nUI_L[nUI_UNITMODE_RAID20]..": Skin des Fokus des Spielers";
	nUI_L[nUI_UNITSKIN_RAID20LEFT]      = nUI_L[nUI_UNITMODE_RAID20]..": Skin der Raidmitglieder auf der linken Seite";
	nUI_L[nUI_UNITSKIN_RAID20RIGHT]     = nUI_L[nUI_UNITMODE_RAID20]..": Skin der Raidmitglieder auf der rechten Seite";
	nUI_L[nUI_UNITSKIN_RAID20PETBUTTON] = nUI_L[nUI_UNITMODE_RAID20]..": Skin der Auswahl-/Schaltfl\195\164che f\195\188r den Begleiter der Raidmitglieder und des Fokus";
	nUI_L[nUI_UNITSKIN_RAID20TGTBUTTON] = nUI_L[nUI_UNITMODE_RAID20]..": Skin der Auswahl-/Schaltfl\195\164che f\195\188r das Ziel der Raidmitglieder und des Fokus";
	nUI_L[nUI_UNITSKIN_RAID20MOUSE]     = nUI_L[nUI_UNITMODE_RAID20]..": Skin des Mouseoverziels";
	
	nUI_L[nUI_UNITMODE_RAID25]          ="nUI 25 Spieler Raid Modus";
	nUI_L[nUI_UNITSKIN_RAID25FOCUS]     = nUI_L[nUI_UNITMODE_RAID25]..": Player Focus' unit skin";
	nUI_L[nUI_UNITSKIN_RAID25MOUSE]     = nUI_L[nUI_UNITMODE_RAID25]..": Mouseover target unit skin";
	nUI_L[nUI_UNITSKIN_RAID25VEHICLE]   = nUI_L[nUI_UNITMODE_RAID25]..": Vehicle unit skin";
	nUI_L[nUI_UNITSKIN_RAID25PLAYER]    = nUI_L[nUI_UNITMODE_RAID25]..": Player's unit skin";
	nUI_L[nUI_UNITSKIN_RAID25PET]       = nUI_L[nUI_UNITMODE_RAID25]..": Player Pet's unit skin";
	nUI_L[nUI_UNITSKIN_RAID25TARGET]    = nUI_L[nUI_UNITMODE_RAID25]..": Target's unit skin";
	nUI_L[nUI_UNITSKIN_RAID25TOT]       = nUI_L[nUI_UNITMODE_RAID25]..": Skin des Ziel des Ziels (ToT)";
	nUI_L[nUI_UNITSKIN_RAID25FOCUS]     = nUI_L[nUI_UNITMODE_RAID25]..": Skin des Fokus des Spielers";
	nUI_L[nUI_UNITSKIN_RAID25LEFT]      = nUI_L[nUI_UNITMODE_RAID25]..": Skin der Raidmitglieder auf der linken Seite";
	nUI_L[nUI_UNITSKIN_RAID25RIGHT]     = nUI_L[nUI_UNITMODE_RAID25]..": Skin der Raidmitglieder auf der rechten Seite";
	nUI_L[nUI_UNITSKIN_RAID25PETBUTTON] = nUI_L[nUI_UNITMODE_RAID25]..": Skin der Auswahl-/Schaltfl\195\164che f\195\188r den Begleiter der Raidmitglieder und des Fokus";
	nUI_L[nUI_UNITSKIN_RAID25TGTBUTTON] = nUI_L[nUI_UNITMODE_RAID25]..": Skin der Auswahl-/Schaltfl\195\164che f\195\188r das Ziel der Raidmitglieder und des Fokus";
	nUI_L[nUI_UNITSKIN_RAID25MOUSE]     = nUI_L[nUI_UNITMODE_RAID25]..": Skin des Mouseoverziels";
	
	nUI_L[nUI_UNITMODE_RAID40]          ="nUI 40 Spieler Raid Modus";
	nUI_L[nUI_UNITSKIN_RAID40FOCUS]     = nUI_L[nUI_UNITMODE_RAID40]..": Player Focus' unit skin";
	nUI_L[nUI_UNITSKIN_RAID40MOUSE]     = nUI_L[nUI_UNITMODE_RAID40]..": Mouseover target unit skin";
	nUI_L[nUI_UNITSKIN_RAID40VEHICLE]   = nUI_L[nUI_UNITMODE_RAID40]..": Vehicle unit skin";
	nUI_L[nUI_UNITSKIN_RAID40PLAYER]    = nUI_L[nUI_UNITMODE_RAID40]..": Player's unit skin";
	nUI_L[nUI_UNITSKIN_RAID40PET]       = nUI_L[nUI_UNITMODE_RAID40]..": Player Pet's unit skin";
	nUI_L[nUI_UNITSKIN_RAID40TARGET]    = nUI_L[nUI_UNITMODE_RAID40]..": Target's unit skin";
	nUI_L[nUI_UNITSKIN_RAID40TOT]       = nUI_L[nUI_UNITMODE_RAID40]..": Skin des Ziel des Ziels (ToT)";
	nUI_L[nUI_UNITSKIN_RAID40FOCUS]     = nUI_L[nUI_UNITMODE_RAID40]..": Skin des Fokus des Spielers";
	nUI_L[nUI_UNITSKIN_RAID40LEFT]      = nUI_L[nUI_UNITMODE_RAID40]..": Skin der Raidmitglieder auf der linken Seite";
	nUI_L[nUI_UNITSKIN_RAID40RIGHT]     = nUI_L[nUI_UNITMODE_RAID40]..": Skin der Raidmitglieder auf der rechten Seite";
	nUI_L[nUI_UNITSKIN_RAID40PETBUTTON] = nUI_L[nUI_UNITMODE_RAID40]..": Skin der Auswahl-/Schaltfl\195\164che f\195\188r den Begleiter der Raidmitglieder und des Fokus";
	nUI_L[nUI_UNITSKIN_RAID40TGTBUTTON] = nUI_L[nUI_UNITMODE_RAID40]..": Skin der Auswahl-/Schaltfl\195\164che f\195\188r das Ziel der Raidmitglieder und des Fokus";
	nUI_L[nUI_UNITSKIN_RAID40MOUSE]     = nUI_L[nUI_UNITMODE_RAID40]..": Skin des Mouseoverziels";
	
	nUI_L[nUI_UNITPANEL_PLAYER]      		= "Einheiten Panel: Solospielermodus";
	nUI_L[nUI_UNITPANEL_PLAYER.."Label"]	= "Solo";
	
	nUI_L[nUI_UNITPANEL_PARTY]       		= "Einheiten Panel: Gruppenmodus";
	nUI_L[nUI_UNITPANEL_PARTY.."Label"] 	= "Gruppe";
	
	nUI_L[nUI_UNITPANEL_RAID10]      		= "Einheiten Panel: 10-Spieler-Raid Modus";
	nUI_L[nUI_UNITPANEL_RAID10.."Label"]	= "Raid 10";
	
	nUI_L[nUI_UNITPANEL_RAID15]      		= "Einheiten Panel: 15-Spieler-Raid Modus";
	nUI_L[nUI_UNITPANEL_RAID15.."Label"]	= "Raid 15";
	
	nUI_L[nUI_UNITPANEL_RAID20]      		= "Einheiten Panel: 20-Spieler-Raid Modus";
	nUI_L[nUI_UNITPANEL_RAID20.."Label"]	= "Raid 20";
	
	nUI_L[nUI_UNITPANEL_RAID25]      		= "Einheiten Panel: 25-Spieler-Raid Modus";
	nUI_L[nUI_UNITPANEL_RAID25.."Label"]	= "Raid 25";
        
	nUI_L[nUI_UNITPANEL_RAID40]      		= "Einheiten Panel: 40-Spieler-Raid Modus";
	nUI_L[nUI_UNITPANEL_RAID40.."Label"]	= "Raid 40";
	
	nUI_L["Click to change unit frame panels"] = "Klicken, um das Layout des Einheiten Panels zu \195\164ndern";
	
	nUI_L["<unnamed frame>"]   = "<unbekannter frame>";
	nUI_L["unit change"]       = "\195\132nderung";
	nUI_L["unit class"]        = "Klasse";
	nUI_L["unit label"]        = "Name";
	nUI_L["unit level"]        = "Stufe";
	nUI_L["unit reaction"]     = "Reaktion";
	nUI_L["unit health"]       = "Gesundheit";
	nUI_L["unit power"]        = "Energie";
	nUI_L["unit portrait"]     = "Portrait";
	nUI_L["raid group"]        = "Raidgruppe";
	nUI_L["unit PvP"]          = "PvP";
	nUI_L["raid target"]       = "Raidziel";
	nUI_L["casting bar"]       = "Zauberleiste";
	nUI_L["ready check"]       = "Bereitschaftscheck";
	nUI_L["unit status"]       = "Status";
	nUI_L["unit aura"]         = "Aura";
	nUI_L["unit combat"]       = "Kampf";
	nUI_L["unit resting"]      = "ausruhen";
	nUI_L["unit role"]         = "Funktion";
	nUI_L["unit runes"]        = "Runenmacht"; -- Death Knight rune frame events
	nUI_L["unit feedback"]     = "R\195\188ckmeldung";
	nUI_L["unit combo points"] = "Combopunkte"; -- unit frame module that display's rogue/druid combe point icons
	nUI_L["unit range"]        = "Entfernung"; -- unit frame module that calculates the range to target
	nUI_L["unit spec"]         = "Talentbaum"; -- unit frame module that determines the unit's talent build (or displays elite/rare/world boss tags)
	nUI_L["unit threat"]       = "Bedrohung"; -- changed in threat status for a given unit
	
	nUI_L["Talent Build: <build name> (<talent points>)"] = "Talentbaum: |cFF00FFFF%s|r (%s)"; -- used to display the unit's talent tree build in the unit frame mouseover tooltip
	nUI_L["passed unit id is <nil> in callback table for %s"] = "'passed unit id' ist <nil> im 'callback table' f\195\188r %s";
	nUI_L["nUI: Warning.. anchoring %s to %s -- anchor point has a <nil> value."] = "nUI: Warnung.. Verankerung von %s zu %s -- Ankerpunkt hat einen <nil> Wert.";
	nUI_L["nUI: Cannot register %s for scaling... frame does not have a applyScale() method"] = "nUI: Kann %s nicht f\195\188r Skalierung registrieren... der Frame hat keine 'applyScale() Methode'";
	nUI_L["nUI: Cannot register %s for scaling... frame does not have a applyAnchor() method"] = "nUI: Kann %s nicht f\195\188r Skalierung registrieren... der Frame hat keine 'applyAnchor() Methode'";
	nUI_L["nUI: %s %s callback %s does not have a newUnitInfo() method."] = "%s %s 'callback' %s hat keine 'newUnitInfo() Methode'";
	nUI_L["nUI_UnitClass.lua: unhandled unit class [%s] for [%s]"] = "nUI_UnitClass.lua: unbehandelte 'unit class' [%s] f\195\188r [%s]";
	nUI_L["nUI: click-casting registration is %s"] = "nUI: Die Klick-Casting-Registrierung ist %s";
	nUI_L["nUI: must pass a valid parent frame to nUI_Unit:createFrame() for unit id [%s (%s)]"] = "nUI: muss einen g\195\188ltigen 'parent frame' zu n'UI_Unit:createFrame()' f\195\188r 'unit id [%s (%s)]' haben";
	nUI_L["nUI says: Gratz for reaching level %d %s!"] = "nUI sagt: Gl\195\188ckwunsch zum erreichen der Stufe %d, %s!";
	nUI_L["nUI_Unit: [%s] is not a valid unit frame element type!"] = "nUI_Unit: [%s] ist kein g\195\188ltiger 'unit frame element' Typ!";
	nUI_L["nUI_Unit: [%s] is not a known unit skin name!"] = "nUI_Unit: [%s] Ist kein g\195\188ltiger 'unit skin' Name!";
	
	-- nUI_Unit hunter pet strings
	
	nUI_L["Your pet"] = "Dein Begleiter";
	nUI_L["quickly"] = "schnell";
	nUI_L["slowly"] = "langsam";
	nUI_L["nUI: %s is happy."] = "nUI: %s ist gl\195\188cklich.";
	nUI_L["nUI: %s is unhappy... time to feed!"] = "nUI: %s ist ungl\195\188cklich ... Zeit zum f\195\188ttern, yam!";
	nUI_L["nUI: Warning! %s is |cFFFFFFFFNOT|r happy! Better feed soon."] = "nUI: Warnung! %s ist |cFFFFFFFFNICHT|r gl\195\188cklich! Am besten gleich f\195\188ttern.";
	nUI_L["nUI: Warning... %s is %s losing loyalty "] = "nUI: Warnung... %s verliert %s an Loyalit\195\164t ";
	nUI_L["nUI: %s is %s gaining loyalty"] = "nUI: %s gewinnt %s an Loyalit\195\164t zur\195\188ck";
	nUI_L["nUI: %s has stopped gaining loyalty"] = "nUI: %s hat aufgeh\195\182rt an Loyalit\195\164t zu gewinnen";
	nUI_L["nUI: %s has stopped losing loyalty"] = "nUI: %s hat aufgeh\195\182rt an Loyalit\195\164t zu verlieren";
	nUI_L["Your pet's current damage bonus is %d%%"] = "Der Schadensbonus Deines Begleiters betr\195\164gt %+d%%";
	nUI_L["Your pet's current damage penalty is %d%%"] = "Die Schadenseinbuse Deines Begleiters betr\195\164gt %+d%%";
	nUI_L["nUI: It looks to me like you're a little busy... maybe you should try feeding %s AFTER you leave combat?"] = "nUI: Es scheint, als h\195\164ttest du gerade wenig Zeit... vielleicht solltest du versuchen, %s nach dem Kampf f\195\188ttern?";
	nUI_L["nUI: I looked everywhere, but I couldn't find a pet to feed. Perhaps he's in your backpack?"] = "nUI: Ich habe \195\188berall nachgeschaut, aber ich konnte einfach keinen Begleiter zum f\195\188ttern finden. M\195\182glicherweise hat er sich in Deinem Rucksack versteckt?";
	nUI_L["nUI: You know, I could be wrong, but I don't think feeding %s is a very good idea... it doesn't look to me like what you have in your bags is what %s is thinking about eating."] = "nUI: Sicher, ich k\195\182nnte Unrecht haben... aber ich denke nicht, dass es eine gute Idee w\195\164re, %s jetzt zu f\195\188ttern. Die Sachen in Deinem Rucksack w\195\164ren bestimmt nicht das, was %s essen w\195\188rde.";

	-- miscelaneous strings
	
	nUI_L["Version"]                     = "nUI Version |cFF00FF00%s|r"; -- prints the current version number
	nUI_L["Copyright"]                   = "Copyright (C) 2008 by K. Scott Piel"; 
	nUI_L["Rights"]                      = "Alle Rechte vorbehalten";
	nUI_L["Off Hand Weapon:"]            = "Nebenhand Waffe:";
	nUI_L["Main Hand Weapon:"]           = "Haupthand Waffe:";
	nUI_L["Group %d"]                    = "Gruppe %d";
	nUI_L["MS"]                          = "MS"; -- abbreviation label for latency in milliseconds
	nUI_L["FPS"]			             = "FPS"; -- abbreviation label for frame rate in "Frames Per Second"
	nUI_L["Minimap Button Bag"]          = "Minimap Button Bag"; -- label for the bag bar "button bag" used to hold the collection of buttons that are normally around the minimap
	nUI_L["System Performance Stats..."] = "Systemperformance..."; -- header label for in-game tooltip showing current frame rate, latency and addon memory usage information
	nUI_L["PvP Time Remaining: <time_left>"] = "PvP Verbleibende Dauer: |cFF50FF50%s|r" -- displays the amount of time left before the PvP flag clears in the player tooltip
	
	nUI_L["Cursor: <cursor_x,cursor_y>  /  Player: <player_x,player_y>"] = "Zeiger: |cFF00FFFF<%0.1f, %0.1f>|r  /  Spieler: |cFF00FFFF<%0.1f, %0.1f>|r";
	nUI_L["nUI has disabled the plugin 'nui_AuraBars' as it is now incorporated in nUI 5.0 -- Please use '/nui rl' to reload the UI. You should uninstall nUI_AuraBars as well."] = "nUI hat das Plugin 'nui_AuraBars' Deaktiviert da es seit nUI Version 5.00 Integriert ist -- Bitte nutze den Befehl '/nui rl' um das Interface neu zu laden. Bitte deinstalliere auch nUI_AuraBars um Fehler zu vermeiden.";
	
	-- key binding strings
	
	nUI_L["HUD Layout"]                  = "HUD Layout"; -- used as a label in the keybinding interface to identify the button used to change HUD layouts
	nUI_L["Unit Panel Mode"]             = "Einheiten Panel"; -- used as a label in the keybinding interface to identify the button used to change unit panels (player/party/raid10)
	nUI_L["Info Panel Mode"]             = "Info Panel"; -- used as a label in the keybinding interface to identify the button used to change information panels (map, omen3, recount, etc)
	nUI_L["Key Binding"]                 = "Tastenbelegung"; -- used a label to identify key bindings on action button tooltips
	nUI_L["Miscellaneous Bindings"]      = "Verschiedene Belegungen"; -- header label in the key binding interface for nUI's miscellaneous keys like unit panel, info panel, hud, buttonbag
	nUI_L["No key bindings found"]       = "Keine Tastenbelegung gefunden"; -- printed in tooltips if there are no key bindings for an action button
	nUI_L["<ctrl-alt-right click> to change bindings"] = "<STRG+ALT+Rechtsklick> zum \195\164ndern der Tastenbelegung"; -- printed in tooltip to alert the user on how to change key bindings

	-- rare spotting strings
	
	nUI_L["You have spotted a rare mob: |cFF00FF00<mob name>|r<location>"] = "Du hast einen 'Rar' Mob entdeckt: |cFF00FF00%s|r%s"; -- used by the rare spotter function to alert the user to a rare mob being sighted
	nUI_L["You have spotted a rare elite mob: |cFF00FF00<mob name>|r<location>"] = "Du hast einen 'Rar-Elite' Mob entdeckt: |cFF00FF00%s|r%s"; -- used by the rare spotter function to alert the user to a rare mob being sighted
	
	-- faction / reputation bar strings
	
	nUI_L["Unknown"]    = "Unbekannt"; -- these strings are all used to print the player's reputation with a given faction
	nUI_L["Hated"]      = "Hasserf\195\188llt"; -- i.e. "You are Hated by the Bucksail Buckaneers"
	nUI_L["Hostile"]    = "Feindselig";
	nUI_L["Unfriendly"] = "Unfreundlich";
	nUI_L["Neutral"]    = "Neutral";
	nUI_L["Friendly"]   = "Freundlich";
	nUI_L["Honored"]    = "Wohlwollend";
	nUI_L["Revered"]    = "Respektvoll";
	nUI_L["Exalted"]    = "Ehrf\195\188rchtig";
	
	nUI_L["Faction: <faction name>"]    = "Fraktion: |cFF00FFFF%s|r"; -- used to display faction name in reputation bar mouseover tooltip
	nUI_L["Reputation: <rep level>"]    = "Ruf: |cFF00FFFF%s|r"; -- one of "Hated", "Hostile", "Neutral", "Honored", etc.
	nUI_L["Current Rep: <number>"]      = "Erreichter Ruf: |cFF00FFFF%d|r"; -- how much reputation has the player earned toward the next level?
	nUI_L["Required Rep: <number>"]     = "Ben\195\182tigter Ruf: |cFF00FFFF%d|r"; -- how much reputation does the player need to get to the next level?
	nUI_L["Remaining Rep: <number>"]    = "Restlicher Ruf: |cFF00FFFF%d|r"; -- how much reputation is left to earn to reach the next level? (required rep - current rep = remaining rep)
	nUI_L["Percent Complete: <number>"] = "Komplett: |cFF00FFFF%0.1f%%|r"; -- how much of this level has the player completed as a percent of total? (currently rep / required rep = percent complete)
	nUI_L["<faction name> (<reputation>) <current rep> of <required rep> (<percent complete>)"] = "%s (%s) %d of %d (%0.1f%%)"; -- used to print a reputation bar label showing current faction facts
	
	nUI_L[nUI_FACTION_UPDATE_START_STRING]    = "Euer Ruf bei der Fraktion "; -- used to mark the beginning of a faction update line in combat log
	nUI_L[nUI_FACTION_UPDATE_END_STRING]      = " hat sich um"; -- used to mark the end of the faction name in the update line
	nUI_L[nUI_FACTION_UPDATE_INCREASE_STRING] = "erh\195\182ht"; -- used to indicate that the update is an increase in faction
	
	-- player experience bar strings
	
	nUI_L["Current level: <level>"]                         = "Erreichte Stufe: |cFF00FFFF%d|r"; -- used to print the player's current level in tooltip text
	nUI_L["Current XP: <experience points>"]                = "Erreichte XP: |cFF00FFFF%d|r"; -- how much XP has the player earned so far in this level
	nUI_L["Required XP: <XP required to reach next level>"] = "Ben\195\182tigte XP: |cFF00FFFF%d|r"; -- how much XP has the player got to earn to complete this level
	nUI_L["Remaining XP: <XP remaining to level>"]          = "Restliche XP: |cFF00FFFF%d|r"; -- how much XP is left to earn to complete this level (required XP - current XP = remaining XP)
	nUI_L["Percent complete: <current XP / required XP>"]   = "Komplett: |cFF00FFFF%0.1f%%|r"; -- how much of this level has the player completed as a percent (current XP / required XP = percent complete)
	nUI_L["Rested XP: <total rested experience> (percent)"] = "XP erholt: |cFF00FFFF%d|r (%0.1f%%)"; -- prints how much total rested XP the player has remaining as both a value and a percent of the total XP required for the current level
	nUI_L["Rested Levels: <levels>"]                        = "Stufen erholt: |cFF00FFFF%0.2f|r"; -- the number of levels the player can earn from their current XP + rested XP remaining
	nUI_L["Level <player level>: <experience> of <max experience> (<percent of total>), <rested xp> rested XP"] = "Stufe %d: %d von %d (%0.1f%%), %d erhohlte XP"; -- used to display player's current experience level
	
	-- health race bar tooltip strings
	
	nUI_L["nUI Health Race Stats..."] = "nUI Health Race Status..."; -- HELP --
	nUI_L["No current advantage to <player> or <target>"] = "Derzeit kein Vorteil f\195\188r %s oder %s";
	nUI_L["<unit name>'s Health: <current>/<maximum> (<percent>)"] = "%s's Gesundheit: |cFF00FF00%d/%d|r (|cFFFFFFFF%0.1f%%|r)";
	nUI_L["Advantage to <player>: <pct>"] = "Vorteil f\195\188r %s: (|cFF00FF00%+0.1f%%|r)";
	nUI_L["Advantage to <target>: <pct>"] = "Vorteil f\195\188r %s: (|cFFFFC0C0%0.1f%%|r)";
	
	-- skinning system messages
	
	nUI_L["nUI could not load the currently selected skin [ %s ]... perhaps you have it disabled? Switching to the default nUI skin."] = "nUI konnte den gew\195\164hlten Skin nicht laden [ |cFFFFC0C0%s|r ]... m\195\182glicherwei�e ist der Skin deaktiviert? Schalte auf Standartskin um.";
	nUI_L["nUI: Cannot register %s for skinning... frame does not have a applySkin() method"] = "nUI: Kann |cFFFFC0C0%s|r nicht f\195\188r skinning registrieren... der Frame hat keine 'applySkin() Methode'";
	
	-- names of the various frames that nUI allows the user to move on the screen
	
	-- these are labels for all of the movable frames in UI (the frames the user can drag around after using '/nui movers'
	
	nUI_L["Micro-Menu"]                = "Micro-Men\195\188";
	nUI_L["Capture Bar"]               = "Eroberungsleiste";
	nUI_L["Watched Quests"]            = "Beobachtete Quests";
	nUI_L["Quest Timer"]               = "Quest Timer";
	nUI_L["Equipment Durability"]      = "Ausr\195\188stungshaltbarkeit";
	nUI_L["PvP Objectives"]            = "PvP Ziele";
	nUI_L["Watched Achievments"]       = "Beobachtete Erfolge"; -- the '/nui movers' label for the achievements watch frame mover label
	nUI_L["In-Game Tooltips"]          = "In-Game Tooltips";
	nUI_L["Bag Bar"]                   = "Taschenleiste";
	nUI_L["Group Loot Frame"]          = "Gruppenbeutefenster"; -- used to label the four group looting frames (greed/need frames)
	nUI_L["nUI_ActionBar"]             = "Hauptleiste / Aktionsleiste 1";
	nUI_L["nUI_BottomLeftBar"]         = "Untere linke Leiste / Aktionsleiste 2";
	nUI_L["nUI_LeftUnitBar"]           = "Linke Leiste / Aktionsleiste 3";
	nUI_L["nUI_RightUnitBar"]          = "Rechte Leiste / Aktionsleiste 4";
	nUI_L["nUI_TopRightBar"]           = "Obere rechte Leiste / Aktionsleiste 5";
	nUI_L["nUI_TopLeftBar"]            = "Obere linke Leiste / Aktionsleiste 6";
	nUI_L["nUI_BottomRightBar"]        = "Untere rechte Leiste";
	nUI_L["Pet/Stance/Shapeshift Bar"] = "Begleiter-/Haltungs-/Verstohlenheitsleiste";
	nUI_L["Vehicle Seat Indicator"]    = "Fahrzeug - Sitzpl\195\164tze";
	nUI_L["Voice Chat Talkers"]        = "Sprach-Chat Sprecher";
	nUI_L["Timer Bar"]                 = "Timer Bar / Zeit Leiste";
	
	-- slash command processing	
	
	-- there are four components to each slash command entry... the command word the user types after the "/nui", a list of options
	-- (or arguments if you prefer) the user can provide to the command, a description of the command itself and a message that
	-- is printed after the command is executed. Any or all of these elements can be translated to make sense in the local language
	-- The only thing that cannot be translated, of course, is the "/nui" prefix itself. If any element is "nil" then it just does 
	-- not apply to that command and can be ignored.
	
	nUI_SlashCommands =
	{
		[nUI_SLASHCMD_HELP] =
		{
			command = "help",
			options = "{command}",
			desc    = "Zeigt eine Liste mit allen verf\195\188gbaren Befehlen an, wenn {command} nicht existiert oder zeigt eine genaue Beschreibung des Befehls an, wenn {command} existiert.",
			message = nil,
		},
		[nUI_SLASHCMD_RELOAD] =
		{
			command = "rl",
			options = nil,
			desc    = "L\195\164dt das User Interface neu. Manche Einstellungen erfordern zus\195\164tzlich einen Neustart des Inteface, damit diese aktiviert werden (auch '/console reloadui')",
			message = nil,
		},
		[nUI_SLASHCMD_BUTTONBAG] =
		{
			command = "bb",
			options = nil,
			desc    = "Dieser Befehl blendet die Minimap-Button-Bag ein und aus (die Minimap-Button-Bag sammelt und sortiert die Addon-Buttons anstelle der Minimap).",
			message = nil,
		},
		[nUI_SLASHCMD_MOVERS] =
		{
			command = "movers",
			options = nil,
			desc    = "Mit dieser Option kann man alle Blizzard-Fenster, wie z.B. das Handelsfenster, das Talentfenster oder das Questfenster etc. frei positionieren.",
			message = "nUI: Blizzard-Fenster poistionieren wurde auf %s ge\195\164ndert", -- enabled or disabled
		},
		[nUI_SLASHCMD_CONSOLE] =
		{
			command = "console",
			options = "{on|off|mouseover}",
			desc    = "Stellt die Sichtbarkeit der Konsole am oberen Bildschirmrand ein. Mit 'on' wird die Konsole immer angezeigt, mit 'off' wird die Konsole versteck und mit 'mouseover' wird die Konsole nur eingeblendet, wenn man mit der Maus dar\195\188ber f\195\164hrt.",
			message = "nUI: Die Sichtbarkeit der Konsole wurde auf %s ge\195\164ndert", -- "on", "off" or "mouseover"
		},
		[nUI_SLASHCMD_TOOLTIPS] =
		{
			command = "tooltips",
			options = "{owner|mouse|fixed|default}",
			desc    = "Bestimmt die Position der Mouseover Tooltips. Mit 'owner' wird der Tooltip neben dem zugeh\195\182rigen Frame angezeigt, mit 'mouse' wird der Tooltip direkt am Mauszeiger dargestellt, 'fixed' zeigt alle Tooltips an einer festgelegten Stelle am Bildschirm an und 'default' stellt die Tooltips auf die Blizzard-Standardeinstellung um (Interface wird neugeladen)",
			message = "nUI: Tooltipanzeige wurde auf |cFF00FFFF%s|r ge\195\164ndert", -- the chosen tooltip mode
		},
		[nUI_SLASHCMD_COMBATTIPS] =
		{
			command = "combattips",
			options = nil,
			desc    = "Diese Option schaltet die Anzeige der Tooltips f\195\188r Aktionsleisten an oder aus, w\195\164hrend man sich im Kampfmodus befindet. Als Standardeinstellung werden die Tooltips w\195\164hrend eines Kampfes versteckt.",
			message = "nUI: Die Anzeige der Tooltips w\195\164hrend des Kampfes wurde %s", -- enabled or disabled
		},
		[nUI_SLASHCMD_BAGSCALE] =
		{
			command = "bagscale",
			options = "{n}",
			desc    = "Diese Option vergr\195\182�ert oder verringert die Gr\195\182�e der Taschen, wobei {n} eine Zahl zwischen 0.5 und 1.5 sein muss -- 1 ist die Standarteinstellung",
			message = "nUI: Die Taschengr\195\182�e wurde auf |cFF00FFFF%0.2f|r ge\195\164ndert", -- the chosen scale
		},
		[nUI_SLASHCMD_BAGBAR] =
		{
			command = "bagbar",
			options = "{on|off|mouseover}",
			desc    = "Diese Option schaltet die Taschenanzeige auf on, off oder nur sichtbar bei Mouseover (mit Mauszeiger dar\195\188berfahren). Die Standart Einstellung ist on.",
			message = "nUI: Die Taschenanzeige wurde auf |cFF00FFFF%s|r geschaltet", -- on, off or mouseover
		},
		[nUI_SLASHCMD_CALENDAR] =
		{
			command = "calendar",
			options = nil,
			desc    = "Standartgem\195\164\195\159, bewegt nUI den Knopf f\195\188r den Kalender von der Minimap in den ButtonBag. Mit dieser Option kann man den Knopf entweder an der Minimap lassen oder in den ButtonBag verschieben.",
			message = "nUI: Der KalenderKnopf wird im ButtonBag angezeigt wurde auf %s gesetzt", -- ENABLED or DISABLED
		},
		[nUI_SLASHCMD_FRAMERATE] =
		{
			command = "framerate",
			options = "{n}",
			desc    = "Mit dieser Option kann die maximale Abfragerate der Animationen und der Leisten ver\195\164ndert werden (FPS). Erh\195\182he {n}, damit das Interface in besserer Qualit\195\164t dargestellt wird (Performanceverlust bzw. weniger FPS) oder verringere {n}, damit das Interface fl\195\188ssiger dargstellt wird (Performancegewninn bzw. mehr FPS). Die Standarteinstellung ist "..nUI_DEFAULT_FRAME_RATE.." Bilder pro Sekunde (FPS).",
			message = "nUI: Die Bildwiederhohlrate wurde auf |cFF00FFFF%0.0fFPS|r ge\195\164ndert", -- the chosen rate in frames per second... change FPS if you need a different abreviation!
		},
		[nUI_SLASHCMD_FEEDBACK] =
		{
			command = "feedback",
			options = "{curse|disease|magic|poison}",
			desc    = "nUI Diese Option f\195\188gt den Charakter Fenstern (Unten Mitte) leuchteffekte hinzu z.b. bei Fl\195\188chen, Krankheiten, Magie oder Gift DeBuffs. Standartgem\195\164\195\159 werden alle 4 Statusver\195\164nderungen angezeigt. Diese Option l\195\164sst dich jede einzele anzeige einer Statusver\195\164nderung an oder aus-schalten z.b. damit man nurnoch die Statusver\195\164nderungen hat die man Dispellen kann.",
			message = "nUI: Charakterfenster Leuchteffekte von |cFF00FFFF%s debuffs|r wurden auf %s gestellt", -- aura type and enabled or disabled
		},
		[nUI_SLASHCMD_SHOWHITS] =
		{
			command = "showhits",
			options = nil,
			desc    = "nUI's Charakter Fenster Hintergr\195\188nde werden Rot und Gr\195\188n gef\195\164rbt wenn derjenige Schaden oder Heilung erh\195\164hlt. Aktiviere die Effekte mit on oder Deaktiviere sie mit off. Die Standarteinstellung ist on.",
			message = "nUI: Die Charakterfenster Leuchteffekte bei Schaden und Heilung wurde auf  %s gestellt", -- enabled or disabled
		},
		[nUI_SLASHCMD_MAXAURAS] =
		{
			command = "maxauras",
			options = "{1-40}",
			desc    = "Standartgem\195\164\195\159 wird nUI bis zu dem Maximum von 40 Buffs/Debuffs von Spieler, Begleiter, Fahrzeug und dem Ziel anzeigen. Diese Option l\195\164sst dich die Maximale Anzeige von Buffs/Debuffs zwischen 0 und 40 festlegen. Falls man den Wert (0) eintr\195\164gt wird die Balkenanzeige Deaktiviert.",
			message = "nUI: Die Maximale Anzeige von Buffs/Debuffs wurde auf |cFF00FFFF%d|r ge\195\164ndert", -- a number from 0 to 40
		},
		[nUI_SLASHCMD_AUTOGROUP] =
		{
			command = "autogroup",
			options = nil,
			desc    = "Standartgem\195\164\195\159 schaltet nUI automatisch die Anzeige der Gruppe/Schaltz\195\188ge um, damit man jeweils das passende Layout daf\195\188r hat wenn man eine Gruppe/Raid betritt oder verl\195\164sst. Hiermit Schaltet man dies on oder off.",
			message = "nUI: Automatisches \195\164ndern der Gruppen/Schaltzuganzeige wurde ge\195\164ndert auf%s bei betreten oder verlassen der Gruppe oder des Raids",
		},
		[nUI_SLASHCMD_RAIDSORT] =
		{
			command = "raidsort",
			options = "{unit|group|class|name}",
			desc    = "Mit dieser Option kann man die Anzeige des Raids bestimmen in welcher die Mitglieder nacheinander angezeigt werden sollen. Der Befehl 'unit' sortiert die Raidmitglieder nach der ID die sie vom Schlachtzug erhalten. Der Befehl 'group' sortiert die Mitglieder nach den jeweiligen Gruppen auf, der Befehl 'class' sortiert die Spieler nach der Art ihrer Klasse und der Befehl 'name' sortiert den Raid nach den Namen. Standartgem\195\164\195\159 wird als Gruppe sortiert.",
			message = "nUI: Die Raidanordnung wurde auf |cFF00FF00%s|r ge\195\164ndert", -- sort option: group, unit, name or class
		},
		[nUI_SLASHCMD_SHOWANIM] =
		{
			command = "anim",
			options = nil,
			desc    = "Diese Option Schaltet die Animation der Portraits(Bilder) und der Leisten ein und aus",
			message = "nUI: Die Animationen wurden %s geschallten<y", -- enabled or disabled
		},
		[nUI_SLASHCMD_HPLOST] =
		{
			command = "hplost",
			options = nil,
			desc    = "Diese Option \195\164ndert die Darstellung der Lebensanzeige von Leben verbleibend auf Leben verloren um. Diese Option ist f\195\188r Heiler n\195\188tzlich.",
			message = "nUI: Die Lebensanzeige wurde auf %s ge\195\164ndert", -- "health remaining" or "health lost"
		},
		[nUI_SLASHCMD_HUD] =
		{
			command  = "hud",
			options  = nil,
			desc     = "Dieser Befehl giebt Zugriff auf die Befehle um das HUD von nUI einzustellen. Nutze den Befehl '/nui hud' um eine Liste der Unter-Befehle anzeigen zu lassen.",
			message  = nil,
			sub_menu =
			{
				[nUI_SLASHCMD_HUD_SCALE] =
				{
					command = "scale",
					options = "{n}",
					desc    = "Diese Option legt die Gr\195\182�e des HUD fest wobei 0.25 <= {n} <= 1.75. Ein kleinerer Wert von {n} verkleinert das HUD und ein gr\195\182�erer Wert vergr\195\182�ert das HUD. Der Standart Wert von {n} = 1",
					message = "nUI: Die Gr\195\182�e des HUD wurde auf |cFF00FFFF%0.2f|r gesetzt", -- a number
				},
				[nUI_SLASHCMD_HUD_SHOWNPC] =
				{
					command = "shownpc",
					options = nil,
					desc    = "Diese Option schaltet das HUD bei befreundeten NPC's sofern man sich nicht im Kampf befindet aus.",
					message = "nUI: HUD bei Befreundeten NPC's anzeigen ( sofern nicht im Kampf ) %s", -- enabled or disabled
				},
				[nUI_SLASHCMD_HUD_FOCUS] =
				{
					command = "focus",
					options = nil,
					desc    = "Standartgem\195\164\195\159 zeigt das HUD das Focus-Ziel nicht an. Beim Aktivieren dieser Option wird beim HUD das Ziel und das Ziel des Ziels mit dem Focus und dem Ziel des Focus'es getauscht, sofern ein Focus-Target gesetzt wurde.",
					message = "nUI: HUD Anzeige des Spieler Focus und das Ziel des Focus wurde auf %s ge\195\164ndert", -- enabled or disabled
				},
				[nUI_SLASHCMD_HUD_HEALTHRACE] =
				{
					command = "healthrace",
					options = nil,
					desc    = "Diese Option schaltet die integrierte Lebenleiste im HUD an und aus.",
					message = "nUI: Die Lebensanzeige vom HUD wurde %s", -- enabled or disabled
				},
				[nUI_SLASHCMD_HUD_COOLDOWN] =
				{
					command = "cooldown",
					options = nil,
					desc    = "Diese Option schaltet die Anzeige der im HUD integrierten Cooldown-Symbole, Cooldown-Warnungen und Cooldown-Sounds on oder off.",
					message = "nUI: integriertes HUD-Cooldown-System wurde auf %s ge\195\164ndert",
				},
				[nUI_SLASHCMD_HUD_CDALERT] =
				{
					command = "cdalert",
					options = nil,
					desc    = "Wenn die integrierte HUD-Cooldownleiste Aktiviert ist, zeigt diese Option wenn eine F\195\164higkeit bereit ist eine Text-Warnung an, \195\164ndere dies mit on oder off.",
					message = "nUI: Die HUD-Cooldown Warnungen wurde auf %s ge\195\164ndert",
				},
				[nUI_SLASHCMD_HUD_CDSOUND] =
				{
					command = "cdsound",
					options = nil,
					desc    = "Wenn die integrierte HUD-Cooldownleiste Aktiviert ist, werden T\195\182ne abgegeben sofern eine F\195\164higkeit wieder nutzbar wird, \195\164ndere dies mit on oder off.",
					message = "nUI: Der Sound des integrierten HUD-Cooldown-Systems wurde auf %s ge\195\164ndert",
				},
				[nUI_SLASHCMD_HUD_CDMIN] =
				{
					command = "cdmin",
					options = "{n}",
					desc    = "Diese Option legt die Zeit fest die ein Cooldown mindestens haben muss damit er im HUD angezeigt wird. Cooldowns die weniger als {n} ben\195\182tigen werden nicht angezeigt. Der Standart Wert ist '/nui hud cdmin 2'",
					message = "nUI: Die im HUD-Cooldownzeit wurde auf mindestens |cFF00FFFF%d|r sekunden ge\195\164ndert", -- time in seconds.
				},
				[nUI_SLASHCMD_HUD_HGAP] =
				{
					command = "hgap",
					options = "{n}",
					desc    = "Diese Option stellt den Horizontalen Abstand zwischen der Linken und der Rechten seite des HUD's ein wobei {n} gr\195\182�er seien MUSS als 0. Erh\195\182he {n} um den Abstand zu vergr\195\182�ern. Der Standart Wert von {n} ist 400",
					message = "nUI: Der Horizontale Abstand wurde auf |cFF00FFFF%0.0f|r gesetzt", -- a number greater than zero
				},
				[nUI_SLASHCMD_HUD_VOFS] =
				{
					command = "vofs",
					options = "{n}",
					desc    = "Diese Option stellt den Vertikalen abstand des HUD's zur mitte des Interfaces ein. Der Standart Wert ist '/nui hud vofs 0' welches das HUD genau in der Mitte des Bildes plaziert. Werte die Kleiner als 0 sind verschieben das HUD nach unten , Werte die H\195\182her als 0 sind bewegen das HUD nach oben.",
					message = "nUI: Der Vertikale-Offset Wert wurde auf |cFF00FFFF%0.0f|r ge\195\164ndert", -- a number
				},
				[nUI_SLASHCMD_HUD_IDLEALPHA] =
				{
					command = "idlealpha",
					options = "{n}",
					desc    = "Diese Option stellt die Transparenz des HUD's w\195\164rend man sich nicht im Kampf befindet ein. Woebei {n} = 0 f\195\188r komplett unsichtbar und {n} = 1 f\195\188r Komplett sichtbares HUD ist. Der Standart Wert von {n} = 0",
					message = "nUI: Die Sichtbarkeit des HUD's wurde auf |cFF00FFFF%0.2f|r gesetzt", -- a number between 0 and 1
				},
				[nUI_SLASHCMD_HUD_REGENALPHA] =
				{
					command = "regenalpha",
					options = "{n}",
					desc    = "Diese Option stellt die Transparenz des HUD's w\195\164rend man selbst (oder der Begleiter) Leben/Energie/Mana Regeneriert oder einen Debuffed hat wobei {n} = 0 f\195\188r komplett unsichtbar ist und {n} = 1 f\195\188r Komplett sichtbares HUD ist. Der Standart Wert von {n} = 0.35",
					message = "nUI: Die Transparenz des HUD's w\195\164rend man Reggt oder Debuffed ist wurde auf |cFF00FFFF%0.2f|r gesetzt", -- a number between 0 and 1
				},
				[nUI_SLASHCMD_HUD_TARGETALPHA] =
				{
					command = "targetalpha",
					options = "{n}",
					desc    = "Diese Option legt die Transpraenz des HUD's w\195\164rend man ein richtiges Ziel hat (z.b. Angreifbar) fest, wobei {n} = 0 f\195\188r komplett unsichtbar und {n} = 1 f\195\188r ein komplett sichtbares HUD ist. Der Standart Wert von {n} = 0.75",
					message = "nUI: Die Transparenz des HUD's w\195\164rend man ein richtiges ziel gew\195\164hlt hat wurde auf |cFF00FFFF%0.2f|r gesetzt", -- a number between 0 and 1
				},
				[nUI_SLASHCMD_HUD_COMBATALPHA] =
				{
					command = "combatalpha",
					options = "{n}",
					desc    = "Diese Option legt die Transparenz w\195\164rend man sich selbst oder der Begleiter im Kampf befindet fest, wobei {n} = 0 f\195\188r komplett unsichtbar und {n} = 1 f\195\188r ein komplett sichtbares HUD ist. Der Standart Wert von {n} = 1",
					message = "nUI: Die Transparenz des HUD's w\195\164rend des Kampfes wurde auf |cFF00FFFF%0.2f|r gesetzt", -- a number between 0 and 1
				},
			},
		},
		[nUI_SLASHCMD_BAR] =
		{
			command  = "bar",
			options  = nil,
			desc     = "Dieser Befehl giebt zugriff auf eine vielzahl von Option f\195\188r die Aktionsleisten von nUI. Benutze den Befehl '/nui bar' um alle Befehle f\195\188r die Aktionsleisten anzeigen zu lassen.",
			message  = nil,
			sub_menu =
			{
				[nUI_SLASHCMD_BAR_COOLDOWN] =
				{
					command = "cooldown",
					options = nil,
					desc    = "Mit dieser Option deaktiviert man die Cooldowns auf den Aktionsleisten (werden in Gelb angezeigt auf den Fertigkeiten). Standartgem\195\164 \195\159 ist diese Option Aktiviert.",
					message = "nUI: Die Cooldowns in den Aktionsleisten wurden auf %s gestellt", -- enabled or disabled
				},
				[nUI_SLASHCMD_BAR_DURATION] =
				{
					command = "duration",
					options = nil,
					desc    = "Wenn man auf jemanden eine Fertigkeit wirkt wird in Blau die verbleibende Dauer der Fertigkeit angezeigt wie lange sie noch Aktiv ist. Diese Option Deaktiviert diese Anzeige.",
					message = "nUI: Aktionsleisten-Fertigkeiten dauer wurde auf %s ge\195\164ndert", -- enabled or disabled
				},
				[nUI_SLASHCMD_BAR_MACRO] =
				{
					command = "macro",
					options = nil,
					desc    = "Wenn man ein selbst erstelltes Macro in eine Aktionsleiste zieht, zeigt nUI den Macro-Namen an. Mit dieser Option deaktiviert man dies.",
					message = "nUI: Aktionsleisten-MacroNamen anzeigen wurde auf %s ge\195\164ndert", -- enabled or disabled
				},
				[nUI_SLASHCMD_BAR_STACKCOUNT] =
				{
					command = "stackcount",
					options = nil,
					desc    = "nUI Normalerwei\195\159e wird in den Aktionsleisten bei einem Gegenstand der stapelbar ist die Menge der Gegenst\195\164nde in der unteren rechten Ecke angezeigt. Mit dieser Option kann dies an oder abgeschalten werden.",
					message = "nUI: Die Stapelanzeige der Aktionsleisten wurde auf %s ge\195\164ndert", -- enabled or disabled
				},
				[nUI_SLASHCMD_BAR_KEYBIND] =
				{
					command = "keybind",
					options = nil,
					desc    = "Normalerwei\195\159e wenn du in der Aktionsleiste einen Aktionsknopf mit einem Hotkey verbindest wird oben Links der Hotkey angezeigt mit dem dieser Aktionsknopf verbunden ist. Mit dieser Option kann man die Anzeige an oder ausschalten.",
					message = "nUI: Anzeige der Hotkeys auf den Aktionsleisten wurde auf %s ge\195\164ndert", -- enabled or disabled
				},
				[nUI_SLASHCMD_BAR_DIMMING] =
				{
					command = "dimming",
					options = nil,
					desc    = "Standartgem\195\164 \195\159 w\195\164rend man sich im Kampf befindet werden F\195\164higkeiten und Gegenst\195\164nde die nicht benutzbar, oder bereits aktiv sind verdunkelt. Mit dieser Option kann man dies Abschalten.",
					message = "nUI:Verdunkelung der Aktionsleisten wurde auf %s ge\195\164ndert", -- enabled or disabled
				},
				[nUI_SLASHCMD_BAR_DIMALPHA] =
				{
					command = "dimalpha",
					options = "{n}",
					desc    = "Wenn eine F\195\164higkeit gedimmt wird wird sie normalerwei\195\159e nurnoch mit 30% der Sichtbarkeit angezeigt. Hiermit kann man die Sichtbarkeit selbst bestimmte 0 macht die F\195\164higkeit komplett durchsichtig wobei beim Wert 1 die Fertigkeit voll sichtbar bleibt. Der Standart Wert ist '/nui dimalpha 0.30'",
					message = "nUI: Die Sichtbarkeit wurde auf |cFF00FFFF%0.1f%%|r ge\195\164ndert", -- a number between 0% and 100%
				},
				[nUI_SLASHCMD_BAR_MOUSEOVER] =
				{
					command = "mouseover",
					options = nil,
					desc    = "Standartgem\195\164 \195\159 werden alle Aktionsleisten angezeigt. Wenn man die Option '/nui mouseover' Aktiviert, wird nUI die Aktionsleisten nurnoch anzeigen sofern man mit dem Mauszeiger dar\195\188ber f\195\164hrt.",
					message = "nUI: Die Anzeige der Aktionsleisten durch Mouseover wurde auf %s ge\195\164ndert", -- enabled or disabled
				},
				[nUI_SLASHCMD_BAR_TOTEMS] =
				{
					command = "totems",
					options = nil,
					desc    = "nUI benutzt die Standart Totem-Leiste von Blizzard. Falls du ein anderes Addon haben solltest f\195\188r die Totems kannst du mit dieser Option die Blizzard-Totem leiste Deaktivieren '/nui bar totems' .",
					message = "nUI: Die Anzeige der Standart-Totem leiste wurde auf %s ge\195\164ndert", -- enabled or disabled
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
			desc    = "Mit dieser Option kann man die Gr\195\182 \195\159e der Sitzplatzanzeige von bestimmten Mounts einstellen. Der Standartwert ist '/nui mountscale 1' wobei 0.5 < {n} < 1.5 -- kleiner als 1.0 verkleinert die Anzeige, Wert die {n} > 1.0 sind vergr\195\182 \195\159ern die Anzeige.",
			message = "nUI: Die Sitzplatzanzeige wurde auf |cFF00FFFF%s|r ge\195\164ndert", -- a number between 0.5 and 1.5
		},
		[nUI_SLASHCMD_CLOCK] =
		{
			command = "clock",
			options = "{server|local|both}",
			desc    = "Diese Option stellt die Uhr auf die Lokale Zeit {local}, die momentane Server Zeit {server} oder beides zugleich {both} ein. Die Standart einstellung ist {server}",
			message = "nUI: Die Zeit wurde auf |cFF00FFFF%s|r gestellt",
		},
		[nUI_SLASHCMD_MAPCOORDS] =
		{
			command = "mapcoords",
			options = nil,
			desc    = "Diese Option schaltet die Anzeige der Koordinaten des Mauszeigers und des Spielers auf der Weltkarte an oder aus. Standart ist Aktiviert.",
			message = "nUI: Anzeigen der Koordinaten auf der Weltkarte wurde auf  %s ge\195\164ndert", -- "ENABLED" or "DISABLED"
		},
		[nUI_SLASHCMD_ROUNDMAP] =
		{
			command = "roundmap",
			options = nil,
			desc    = "Diese Option wechselt zwischen der normalen eckigen Minimap und einer runden.",
			message = "nUI: Die Minimap wurde auf |cFF00FFFF%s|r ge\195\164ndert", -- "round" or "square"
		},
		[nUI_SLASHCMD_MINIMAP] =
		{
			command = "minimap",
			options = nil,
			desc    = "Diese Option schaltet die Minimap an oder aus. Wenn sie angeschallten ist wird sie in nUI integriert (unten Mitte), falls ausgeschallten bleibt die Minimap so wie sie ist. (Die Minimapkn\195\182pfe bleiben da wo sie sind). Eine \195\164nderung erfordert ein neues laden des Interfaces!",
			message = "nUI: Die Minimap wurde %s geschallten", -- enabled or disabled
		},
		[nUI_SLASHCMD_ONEBAG] =
		{
			command = "onebag",
			options = nil,
			desc    = "Diese Option schaltet die Anzeige der Inventar-Taschen zwischen einer und 5 Taschen. Diese Option kombiniert noch NICHT alle Taschen zu einer um die unterst\195\188tzung eines Dritt Addons wie z.b. ArkInventory einzuschr\195\164nken.",
			message = "nUI: Single bag button wurde auf %s eingestellt", -- enabled or disabled
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
			desc    = "Diese Option stellt den Debugger von nUI auf das gew\195\188nschte Nachrichtenlevel ein. Man sollte diesen Wert nur \195\164ndern wenn man von einem Moderator zwecks Hilfe anfrage gebeten wurde. Nutze {n} = 0 um den Debugger zu Deaktivieren (Standart).",
			message = "nUI: Der DebuggLevel wurde auf |cFF00FFFF%d|r gesetzt", -- an integer value
		},
		[nUI_SLASHCMD_LASTITEM+2] =
		{
			command = "profile",
			options = nil,
			desc    = "Diese Option Speichert die WoW Sitzung in einem Profil. Dies Kostet sehr viel Rechenleistung. Normalerweise ist diese Option DEAKTIVIERT. Bitte Aktiviere diese Option nicht au\195\159er wenn du durch einen nUI Admin / Supporter darum gebeten wirst.",
			message = "nUI: Laufzeit Profil Speicherung wurde %s", -- enabled or disabled
		},
	};
	
	nUI_L["round"]  = "Rund"; -- used to display the current minimap shape selection
	nUI_L["square"] = "Quadrat";
	
	nUI_L["health remaining"] = "|cFF00FF00Leben verbleibend|r"; -- used to tell the player that unit frames are displaying health remaining
	nUI_L["health lost"]      = "|cFFFF0000Leben verloren|r"; -- used to tell the player that unit frames are displaying health lost
	
	-- these strings are the optional arguments to their respective commands and can be 
	-- translated to make sense in the local language
	
	nUI_L[nUI_SLASHCMD_OPTIONS( nUI_SLASHCMD_CLOCK, "server" )] = "server"; -- command option used to select the server time dashboard clock format
	nUI_L[nUI_SLASHCMD_OPTIONS( nUI_SLASHCMD_CLOCK, "local" )]  = "local"; -- command option used to select the local time clock format
	nUI_L[nUI_SLASHCMD_OPTIONS( nUI_SLASHCMD_CLOCK, "both" )]   = "both"; -- command option used to select both server and local time clock display
		
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
	
	nUI_L[nUI_SLASHCMD_OPTIONS( nUI_SLASHCMD_BAGBAR, "on" )]        = "on";
	nUI_L[nUI_SLASHCMD_OPTIONS( nUI_SLASHCMD_BAGBAR, "off" )]       = "off";
	nUI_L[nUI_SLASHCMD_OPTIONS( nUI_SLASHCMD_BAGBAR, "mouseover" )] = "mouseover";
	
	nUI_L[nUI_SLASHCMD_OPTIONS( nUI_SLASHCMD_TOOLTIPS, "owner" )]   = "owner";
	nUI_L[nUI_SLASHCMD_OPTIONS( nUI_SLASHCMD_TOOLTIPS, "mouse" )]   = "mouse";
	nUI_L[nUI_SLASHCMD_OPTIONS( nUI_SLASHCMD_TOOLTIPS, "fixed" )]   = "fixed";
	nUI_L[nUI_SLASHCMD_OPTIONS( nUI_SLASHCMD_TOOLTIPS, "default" )] = "default";
	
	-- miscellaneous slash command messages printed to the player
	
	nUI_L["The value [ %s ] is not a valid nUI slash command. Try [ /nui help ] for a list of commands"] = "Der Wert [ |cFFFFC000%s|r ] ist kein G\195\188ltiger /nUI Befehl. Nutze [ |cFF00FFFF/nui help|r ] f\195\188r eine Liste der m\195\182glichen Befehle";
	nUI_L["nUI currently supports the following list of slash commands..."]	= "nUI unterst\195\188zt momentan folgende Befehle..."; 
	nUI_L["The '/nui %s' slash command currently supports the following list of sub-commands..."] = "Der '|cFF00FFFF/nui %s|r' unterst\195\188tzt folgende Unter-Befehle...";
	nUI_L["nUI: [ %s ] is not a valid tooltip settings option... please choose from %s, %s, %s or %s"] = "nUI: [ |cFFFFC0C0%s|r ] is not a valid tooltip settings option... please choose from |cFF00FFFF%s|r, |cFF00FFFF%s|r, |cFF00FFFF%s|r or |cFF00FFFF%s|r";
	nUI_L["nUI: [ %s ] is not a valid console visibility option... please choose from %s, %s or %s"] = "nUI: [ |cFFFFC0C0%s|r ] ist kein richtiger Wert f\195\188r die Consolen Sichtbarkeit... bitte w\195\164hle zwischen |cFF00FFFF%s|r, |cFF00FFFF%s|r or |cFF00FFFF%s|r";
	nUI_L["nUI: [ %s ] is not a valid alpha value... please choose choose a number between 0 and 1 where 0 is fully transparent and 1 is fully opaque."] = "nUI: [ |cFFFFC0C0%s|r ] ist kein g\195\188ltiger Wert ... bitte w\195\164hle zwischen 0 und 1 wobei 0 komplett Transparent und 1 vollkommen sichtbar ist.";
	nUI_L["nUI: [ %s ] is not a valid horizontal gap value... please choose choose a number between 1 and 1200 where 1 is very narrow and 1200 is very wide."] = "nUI: [ |cFFFFC0C0%s|r ] ist kein g\195\188ltiger horizontal Wert ... bitte w\195\164hle zwischen 1 und 1200 wobei 1 sehr klein/d\195\188nn und 1200 Weit ist.";
	nUI_L["nUI: [ %s ] is not a valid clock option... please choose either 'local' to display the local time, 'server' to display the server time or 'both' to display both times."] = "nUI: [ %s ] ist kein g\195\188ltiger Zeit Wert... bitte w\195\164hle zwischen 'local' um die Lokale Zeit Anzuzeigen , 'server' um die Server Zeit anzuzeigen oder 'both' um beides anzeigen zu lassen."; -- message displayed when the player selects an invalid '/nui clock {option}' value		
	nUI_L["nUI: [ %s ] is not a valid feedback option... please choose either <curse>, <disease>, <magic> or <poison>"] = "nUI: [ %s ] ist keine G\195\188ltige feedback Option... bitte w\195\164hle zwischen '%s', '%s', '%s' oder '%s'"; -- alerts the user when they have entered an invalid feedback highlighting option
	nUI_L["nUI: [ %s ] is not a valid raid sorting option... please choose either <unit>, <group> or <class>"] = "nUI: [ %s ] is not a valid raid sorting option... please choose either '%s', '%s' or '%s'";	-- new
	nUI_L["nUI: [ %s ] is not a valid special mount indicator display scale. The scale must be a number between 0.5 and 1.5"] = "nUI: [ %s ] is not a valid special mount indicator display scale. The scale must be a number between 0.5 and 1.5"; -- new
			
end
