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

if nUI_Locale == "esMX" then
	
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
	
	nUI_L["Welcome back to %s, %s..."] = "Bienvenido de nuevo a %s, %s...";
	nUI_L["nUI %s version %s is loaded!"] = "¡nUI %s versión %s cargado!"; 
	nUI_L["Type '/nui' for a list of available nUI commands."] = "Escribe '/nui' para obtener una lista de los comandos disponibles de nUI."; 
	
	-- splash frame strings
		
	nUI_L["splash title"] = "%s ha sido actualizado a la versión de nUI %s %s";
	nUI_L["splash info"]  = "Para la guia de usuario, galerias, últimas descargas, preguntas frequentes de nUI, foros de soporte tecnico o para donar para mantener nUI, por favor visita |cFF00FFFFhttp://www.nUIaddon.com|r";
	nUI_L["plus info"]    = "Estas ejecutando la versión ‘Release’ de nUI….. también hay una versión gratuita ‘|cFF00FFFFnUI+|r’ disponible que incluye las ventanas de banda 15,20,25 y 40 así como características adicionales. Por favor visita |cFF00FFFFhttp://www.nUIaddon.com/plus.html|r para más información";
	
	-- clock strings
	
	nUI_L["am"] = "am";		
	nUI_L["pm"] = "pm";		
	nUI_L["<hour>:<minute><suffix>"] = "%d:%02d%s";
	nUI_L["<hour>:<minute>"] = "%02d:%02d";
	nUI_L["(S) <hour>:<minute><suffix> - <hour>:<minute><suffix> (L)"] = "(S) %d:%02d%s - %d:%02d%s (L)";
	nUI_L["(S) <hour>:<minute> - <hour>:<minute> (L)"] = "(S) %02d:%02d - %02d:%02d (L)";
	
	-- cadenas de estado
	
	nUI_L["|cFF00FF00ENABLED|r"]  = "|cFF00FF00ACTIVADO|r";
	nUI_L["|cFFFF0000DISABLED|r"] = "|cFFFF0000DESACTIVADO|r";
	nUI_L["~INTERRUPTED~"]        = "~INTERRUMPIDO~";
	nUI_L["~FAILED~"]             = "~FALLIDO~";
	nUI_L["~MISSED~"]             = "~FALLADO~";
	nUI_L["OFFLINE"]              = "DESCONECTADO";
	nUI_L["DND"]                  = "NM";
	nUI_L["AFK"]                  = "AUS";
	nUI_L["DEAD"]                 = "MUERTO";
	nUI_L["GHOST"]                = "FANTASMA";
	nUI_L["FD"]                   = "FM";
	nUI_L["TAXI"]                 = "TAXI";
	nUI_L["OOR"]				  = "FDR";
	
	-- power types

	nUI_L["HEALTH"]      = "Salud";	
	nUI_L["MANA"]        = "Mana";
	nUI_L["RAGE"]        = "Ira";
	nUI_L["FOCUS"]       = "Enfoque";
	nUI_L["ENERGY"]      = "Energía";
	nUI_L["RUNES"]       = "Runas";
	nUI_L["RUNIC_POWER"] = "Poder Rúnico";
	nUI_L["AMMO"]        = "Munición"; -- vehicles
	nUI_L["FUEL"]        = "Compustible"; -- vehicles
	
	-- time remaining (cooldowns, buffs, etc.)
	
	nUI_L["TimeLeftInHours"]   = "%0.0fh";
	nUI_L["TimeLeftInMinutes"] = "%0.0fm";
	nUI_L["TimeLeftInSeconds"] = "%0.0fs";
	nUI_L["TimeLeftInTenths"]  = "%0.1fs";
	
	-- raid and party role tooltip strings
	
	nUI_L["Party Role: |cFF00FFFF%s|r"] = "Rol de grupo : |cFF00FFFF%s|r";
	nUI_L["Raid Role: |cFF00FFFF%s|r"]  = "Rol de banda : |cFF00FFFF%s|r";
	nUI_L["Raid Leader"]                = "Líder de la banda";
	nUI_L["Party Leader"]               = "Líder del grupo";
	nUI_L["Raid Assistant"]             = "Ayudante de la banda";
	nUI_L["Main Tank"]                  = "Tanque Principal";
	nUI_L["Off-Tank"]                   = "Tanque Secundario";
	nUI_L["Master Looter"]              = "Maestro Despojador";
	
	-- hunter pet feeder strings
	
	nUI_L[nUI_FOOD_MEAT]	= "carne";   -- do not edit this line
	nUI_L[nUI_FOOD_FISH]	= "pescado"; -- do not edit this line
	nUI_L[nUI_FOOD_BREAD]	= "pan";     -- do not edit this line
	nUI_L[nUI_FOOD_CHEESE]  = "queso";   -- do not edit this line
	nUI_L[nUI_FOOD_FRUIT]	= "fruta";   -- do not edit this line
	nUI_L[nUI_FOOD_FUNGUS]  = "hongos";  -- do not edit this line
	
	nUI_L["Click to feed %s"]           = "Clic para alimentar a %s";
	nUI_L["Click to cancel feeding"]    = "Clic para dejar de alimentar";
	nUI_L["nUI: %s can eat %s%s%s"]     = "nUI: %s puede comer %s%s%s";
	nUI_L[" or "]                       = " o ";
	nUI_L["nUI: You don't have a pet!"] = "nUI: ¡No tienes una mascota!";
	
	nUI_L["nUI: You can feed %s the following...\n"] = "nUI: Puedes alimentar a %s con lo siguiente...\n";
	nUI_L["nUI: You have nothing you can feed %s in your current inventory"] = "nUI: Actualmente no tienes nada con que alimentar a  %s en tu inventario";
	
	-- cadenas de barra de estado
	
	nUI_L["nUI: Cannot change status bar config while in combat!"] = "nUI: ¡No se puede modificar la configuración de la barra de estado en combate!";
	nUI_L["nUI: [%s] is not a valid option for orienting a status bar... use LEFT, RIGHT, TOP or BOTTOM"] = "nUI: [%s] no es una opción de orientación válida para la barra de estado... utiliza LEFT, RIGHT, TOP o BOTTOM";
	nUI_L["nUI: Can not change status bar overlays while in combat!"] = "nUI: ¡No se puede cambiar la superposición de la barra de estado en combate!";
	nUI_L["nUI: The maximum value (%d) of a status bar must be greater than the minimum value (%d)"] = "nUI: El valor máximo (%d) de la barra de estado debe ser mayor que el valor mínimo (%d)";
	
	-- information panel strings
	
	nUI_L["Minimap"] = "Minimapa";
	
	nUI_L[nUI_INFOPANEL_COMBATLOG]      		= "Panel de Información : Modo de visualización del registro de combate";
	nUI_L[nUI_INFOPANEL_COMBATLOG.."Label"]		= "Combate";
	
	nUI_L[nUI_INFOPANEL_BMM]		      		= "Panel de Información : Modo del minimapa en campo de batalla";
	nUI_L[nUI_INFOPANEL_BMM.."Label"]			= "Mapa";
	
	nUI_L[nUI_INFOPANEL_RECOUNT]		   		= "Panel de Información : Modo para el contador de daño Recount";
	nUI_L[nUI_INFOPANEL_RECOUNT.."Label"]		= "Recount";
	
	nUI_L[nUI_INFOPANEL_OMEN3]		      		= "Info Panel: Modo del contador de amenaza Omen3";
	nUI_L[nUI_INFOPANEL_OMEN3.."Label"]			= "Omen3";
	
	nUI_L[nUI_INFOPANEL_SKADA]		      		= "Info Panel: Skada Damage/Threat Meter Mode";
	nUI_L[nUI_INFOPANEL_SKADA.."Label"]			= "Skada";
	
	nUI_L[nUI_INFOPANEL_OMEN3KLH]	      		= "Panel de Información : Modo del contador de amenaza Omen3 + KLH";
	nUI_L[nUI_INFOPANEL_OMEN3KLH.."Label"]		= "Amenaza";
	
	nUI_L[nUI_INFOPANEL_KLH]		      		= "Panel de Información : Modo del contador de amenaza KLH";
	nUI_L[nUI_INFOPANEL_KLH.."Label"]			= "KTM";
	
	nUI_L[nUI_INFOPANEL_KLHRECOUNT]	      		= "Panel de Información : Modo del contador de amenaza KLH  + daño Recount";
	nUI_L[nUI_INFOPANEL_KLHRECOUNT.."Label"]	= "KTM+";
	
	nUI_L["nUI: You need to go to the WoW Interface menu, select the 'Social' option and turn off the 'Simple Chat' menu option to enable integrated combat log support in nUI."] = "nUI: Tienes que ir al menú de Wow Interfaz, seleccionar la opción 'Social' y apagar la opción de menú 'Simple Chat' para activar el log de combate integrado en nUI.";
	nUI_L["The %s Info Panel plugin is a core plugin to nUI and cannot be disabled"] = "El plugin %s Info Panel es un plugin del núcleo de nUi y no puede desabilitarse";
	nUI_L["Click to change information panels"] = "Haz click para modificar los paneles de información";
	nUI_L["nUI: Cannot initialize the Info Panel plugin [ %s ] -- it does not have an initPanel() interface method"] = "nUI: No puedo inicializar el plugin del Info Panel [ |cFF00FFFF%s|r ] -- no tiene el método de interfaz initPanel()";
	nUI_L["nUI: Cannot initialize the Info Panel plugin [ %s ] -- No global object by that name exists"] = "nUI: No puedo inicializar el plugin del Info Panel [ |cFF00FFFF%s|r ] -- No existe objeto global con ese nombre";	
	nUI_L["nUI: Cannot select the Info Panel plugin [ %s ] -- it does not have a setSelected() interface method"] = "nUI: No puedo inicializar el plugin del Info Panel [ |cFF00FFFF%s|r ] -- no tiene el método de interfaz setSelected()";
	
	-- HUD layout strings (heads up display)
	
	nUI_L["Click to change HUD layouts"] = "Haz click para modificar el diseño del HUD";
	
	nUI_L[nUI_HUDLAYOUT_PLAYERTARGET]	   		= "Diseño del HUD : Jugador Izquierda / Objetivo Derecha";
	nUI_L[nUI_HUDLAYOUT_PLAYERTARGET.."Label"]	= "Jugador/Objetivo";
	
	nUI_L[nUI_HUDLAYOUT_HEALTHPOWER]	   		= "Diseño del HUD : Salud Izquierda / Poder Derecha";
	nUI_L[nUI_HUDLAYOUT_HEALTHPOWER.."Label"]	= "Salud/Poder";
	
	nUI_L[nUI_HUDLAYOUT_SIDEBYSIDE]	   			= "Diseño del HUD : Barras horizontales de lado a lado";
	nUI_L[nUI_HUDLAYOUT_SIDEBYSIDE.."Label"]	= "De lado a lado";
	
	nUI_L[nUI_HUDLAYOUT_NOBARS]	   				= "Diseño del HUD : HUD simple (sin barras)";
	nUI_L[nUI_HUDLAYOUT_NOBARS.."Label"]		= "HUD simple";
	
	nUI_L[nUI_HUDLAYOUT_NOHUD]		   			= "Diseño del HUD : Deshabilitado (sin HUD)";
	nUI_L[nUI_HUDLAYOUT_NOHUD.."Label"]			= "Sin HUD";
	
	nUI_L[nUI_HUDMODE_PLAYERTARGET]        = "Modo Jugador/Objetivo del HUD de nUI";
	nUI_L[nUI_HUDSKIN_PLAYERTARGET_PET]    = nUI_L[nUI_HUDMODE_PLAYERTARGET]..": piel para mostrar los datos de unidad de la mascota del Jugador";
	nUI_L[nUI_HUDSKIN_PLAYERTARGET_PLAYER] = nUI_L[nUI_HUDMODE_PLAYERTARGET]..": piel para mostrar los datos de unidad del Jugador";
	nUI_L[nUI_HUDSKIN_PLAYERTARGET_TARGET] = nUI_L[nUI_HUDMODE_PLAYERTARGET]..": piel para mostrar los datos de unidad del Objetivo";
	nUI_L[nUI_HUDSKIN_PLAYERTARGET_TOT]    = nUI_L[nUI_HUDMODE_PLAYERTARGET]..": piel para mostrar los datos de unidad del Objetivo del Objetivo (ToT)";
	nUI_L[nUI_HUDSKIN_PLAYERTARGET_CASTBAR] = nUI_L[nUI_HUDMODE_PLAYERTARGET]..": piel para mostrar los datos de unidad de la barra de casteo del Jugador";
	
	nUI_L[nUI_HUDMODE_HEALTHPOWER]         = "Modo Salud/Poder del HUD de nUI";
	nUI_L[nUI_HUDSKIN_HEALTHPOWER_PET]     = nUI_L[nUI_HUDMODE_HEALTHPOWER]..": piel para mostrar los datos de unidad de la mascota del Jugador";
	nUI_L[nUI_HUDSKIN_HEALTHPOWER_PLAYER]  = nUI_L[nUI_HUDMODE_HEALTHPOWER]..": piel para mostrar los datos de unidad del Jugador";
	nUI_L[nUI_HUDSKIN_HEALTHPOWER_TARGET]  = nUI_L[nUI_HUDMODE_HEALTHPOWER]..": piel para mostrar los datos de unidad del Objetivo";
	nUI_L[nUI_HUDSKIN_HEALTHPOWER_TOT]     = nUI_L[nUI_HUDMODE_HEALTHPOWER]..": piel para mostrar los datos de unidad del Objetivo del Objetivo (ToT)";
	nUI_L[nUI_HUDSKIN_HEALTHPOWER_CASTBAR] = nUI_L[nUI_HUDMODE_HEALTHPOWER]..": piel para mostrar los datos de unidad de la barra casteo del Jugador";
	
	nUI_L[nUI_HUDMODE_SIDEBYSIDE]          = "Modo Lado por Lado del HUD de nUI";
	nUI_L[nUI_HUDSKIN_SIDEBYSIDE_PET]      = nUI_L[nUI_HUDMODE_SIDEBYSIDE]..": piel para mostrar los datos de unidad de la mascota del Jugador";
	nUI_L[nUI_HUDSKIN_SIDEBYSIDE_PLAYER]   = nUI_L[nUI_HUDMODE_SIDEBYSIDE]..": piel para mostrar los datos de unidad del Jugador";
	nUI_L[nUI_HUDSKIN_SIDEBYSIDE_TARGET]   = nUI_L[nUI_HUDMODE_SIDEBYSIDE]..": piel para mostrar los datos de unidad del Objetivo";
	nUI_L[nUI_HUDSKIN_SIDEBYSIDE_TOT]      = nUI_L[nUI_HUDMODE_SIDEBYSIDE]..": piel para mostrar los datos de unidad del Objetivo del Objetivo (ToT)";
	nUI_L[nUI_HUDSKIN_SIDEBYSIDE_CASTBAR]  = nUI_L[nUI_HUDMODE_SIDEBYSIDE]..": piel para mostrar los datos de unidad de la barra casteo del Jugador";
	
	nUI_L[nUI_HUDMODE_NOBARS]              = "nUI Simple Barless HUD Mode";
	nUI_L[nUI_HUDSKIN_NOBARS_CASTBAR]      = nUI_L[nUI_HUDMODE_NOBARS]..": piel para mostrar los datos de unidad de la barra casteo del Jugador";
	nUI_L[nUI_HUDSKIN_NOBARS_PLAYER]       = nUI_L[nUI_HUDMODE_NOBARS]..": piel para mostrar los datos de unidad del Jugador";
	nUI_L[nUI_HUDSKIN_NOBARS_TARGET]       = nUI_L[nUI_HUDMODE_NOBARS]..": piel para mostrar los datos de unidad del Objetivo";
	
	-- cadenas nUI_Unit 
	
	nUI_L["Pet"]        = "Mascota";
	nUI_L["Target"]     = "Objetivo";	
	nUI_L["Range"]      = "Rango";
	nUI_L["MELEE"]      = "Melé";
	nUI_L["Elite"]      = "Élite";
	nUI_L["Rare"]       = "Raro";
	nUI_L["Rare Elite"] = "Élite Raro";
	nUI_L["World Boss"] = "Jefe del Mundo";
	nUI_L["Vehicle"]    = "Vehículo";
	
	nUI_L["unit: player"]             = "Jugador";
	nUI_L["unit: vehicle"]            = "Vehículo";
	nUI_L["unit: pet"]		          = "Mascota";
	nUI_L["unit: pettarget"]          = "Objetivo de la mascota";
	nUI_L["unit: focus"]              = "Foco";
	nUI_L["unit: focustarget"]        = "Objetivo del foco";
	nUI_L["unit: target"]             = "Objetivo del jugador";
	nUI_L["unit: %s-target"]          = "Objetivo de %s";
	nUI_L["unit: mouseover"]          = "Objetivo al pasar el ratón";
	nUI_L["unit: targettarget"]       = "Objetivo del objetivo (ToT)";
	nUI_L["unit: targettargettarget"] = "Objetivo del ToT (ToTT)";
	nUI_L["unit: party%d"]            = "Miembro de Grupo %d";
	nUI_L["unit: party%dpet"]         = "Mascota del Miembro de Grupo %d";
	nUI_L["unit: party%dtarget"]      = "Objetivo del Miembro del Grupo %d";
	nUI_L["unit: party%dpettarget"]   = "Objetivo de la Mascota del Miembro del Grupo %d";
	nUI_L["unit: raid%d"]             = "Miembro de la Banda %d";
	nUI_L["unit: raid%dpet"]          = "Mascota del Miembro de la Banda %d";
	nUI_L["unit: raid%dtarget"]       = "Objetivo del Miembro de la Banda %dt";
	nUI_L["unit: raid%dpettarget"]    = "Objetivo de la Mascota del Miembro de la Banda %d";

    nUI_L[nUI_UNITSKIN_BOSSFRAME]     = "nUI Boss unit skin";
    
	nUI_L[nUI_UNITMODE_PLAYER]        = "Modo de juego individual de nUI ";
	nUI_L[nUI_UNITSKIN_SOLOFOCUS]     = nUI_L[nUI_UNITMODE_PLAYER]..": Piel para mostrar los datos de unidad del Focus del jugador";
	nUI_L[nUI_UNITSKIN_SOLOMOUSE]     = nUI_L[nUI_UNITMODE_PLAYER]..": Piel para mostrar los datos de unidad del objetivo al pasar el ratón";
	nUI_L[nUI_UNITSKIN_SOLOVEHICLE]   = nUI_L[nUI_UNITMODE_PLAYER]..": Piel para mostrar los datos de unidad del vehículo";
	nUI_L[nUI_UNITSKIN_SOLOPET]       = nUI_L[nUI_UNITMODE_PLAYER]..": Piel para mostrar los datos de unidad de la mascota del jugador";
	nUI_L[nUI_UNITSKIN_SOLOPETBUTTON] = nUI_L[nUI_UNITMODE_PLAYER]..": Piel para mostrar los datos de unidad de los botones de los objetivos... p.e. Objetivo de Mascota, Mascota del Focus del Jugador, etc";
	nUI_L[nUI_UNITSKIN_SOLOPLAYER]    = nUI_L[nUI_UNITMODE_PLAYER]..": Piel para mostrar los datos de unidad del jugador";
	nUI_L[nUI_UNITSKIN_SOLOTARGET]    = nUI_L[nUI_UNITMODE_PLAYER]..": Piel para mostrar los datos de unidad del objetivo";
	nUI_L[nUI_UNITSKIN_SOLOTGTBUTTON] = nUI_L[nUI_UNITMODE_PLAYER]..": Piel para mostrar los datos de unidad de los botones del objetivo del obejtivo... p.e. Objetivo del focus del jugador, etc.";
	nUI_L[nUI_UNITSKIN_SOLOTOT]       = nUI_L[nUI_UNITMODE_PLAYER]..": Piel para mostrar los daros de unidad del Objetivo del Objetivo(ToT)";

	nUI_L[nUI_UNITMODE_PARTY]          = "Modo en grupo de nUI";
	nUI_L[nUI_UNITSKIN_PARTYFOCUS]     = nUI_L[nUI_UNITMODE_PARTY]..": Piel para mostrar los datos de unidad del focus del jugador";
	nUI_L[nUI_UNITSKIN_PARTYMOUSE]     = nUI_L[nUI_UNITMODE_PARTY]..": Piel para mostrar los datos de unidad del objetivo al pasar el ratón";
	nUI_L[nUI_UNITSKIN_PARTYVEHICLE]   = nUI_L[nUI_UNITMODE_PARTY]..": Piel para mostrar los datos de unidad del vehículo";
	nUI_L[nUI_UNITSKIN_PARTYPLAYER]    = nUI_L[nUI_UNITMODE_PARTY]..": Piel para mostrar los datos de unidad del jugador";
	nUI_L[nUI_UNITSKIN_PARTYPET]       = nUI_L[nUI_UNITMODE_PARTY]..": Piel para mostrar los datos de unidad de la mascota del jugador";
	nUI_L[nUI_UNITSKIN_PARTYTARGET]    = nUI_L[nUI_UNITMODE_PARTY]..": Piel para mostrar los datos de unidad del objetivo";
	nUI_L[nUI_UNITSKIN_PARTYTOT]       = nUI_L[nUI_UNITMODE_PARTY]..": Piel para mostrar los datos de unidad del objetivo del objetivo (ToT)";
	nUI_L[nUI_UNITSKIN_PARTYFOCUS]     = nUI_L[nUI_UNITMODE_PARTY]..": Piel para mostrar los datos de unidad del focus del jugador";
	nUI_L[nUI_UNITSKIN_PARTYLEFT]      = nUI_L[nUI_UNITMODE_PARTY]..": Piel para mostrar los datos de unidad de los miembros del lado izquierdo del grupo";
	nUI_L[nUI_UNITSKIN_PARTYRIGHT]     = nUI_L[nUI_UNITMODE_PARTY]..": Piel para mostrar los datos de unidad de los miembros del lado derecho del grupo";
	nUI_L[nUI_UNITSKIN_PARTYPETBUTTON] = nUI_L[nUI_UNITMODE_PARTY]..": Piel para mostrar los datos de unidad de los miembros del grupo y botones del focus de mascota";
	nUI_L[nUI_UNITSKIN_PARTYTGTBUTTON] = nUI_L[nUI_UNITMODE_PARTY]..": Piel para mostrar los datos de unidad de los miembros del grupo y botones del objetivo del objetivo";
	nUI_L[nUI_UNITSKIN_PARTYMOUSE]     = nUI_L[nUI_UNITMODE_PARTY]..": Piel para mostrar los datos de unidad al pasar el ratón";
	
	nUI_L[nUI_UNITMODE_RAID10]          ="Modo de banda de 10 jugadores de nUI";
	nUI_L[nUI_UNITSKIN_RAID10FOCUS]     = nUI_L[nUI_UNITMODE_RAID10]..": Piel para mostrar los datos de unidad del focus del jugador";
	nUI_L[nUI_UNITSKIN_RAID10MOUSE]     = nUI_L[nUI_UNITMODE_RAID10]..": Piel para mostrar los datos de unidad del objetivo al pasar el ratón";
	nUI_L[nUI_UNITSKIN_RAID10VEHICLE]   = nUI_L[nUI_UNITMODE_RAID10]..": Piel para mostrar los datos de unidad del vehículo";
	nUI_L[nUI_UNITSKIN_RAID10PLAYER]    = nUI_L[nUI_UNITMODE_RAID10]..": Piel para mostrar los datos de unidad del jugador";
	nUI_L[nUI_UNITSKIN_RAID10PET]       = nUI_L[nUI_UNITMODE_RAID10]..": Piel para mostrar los datos de unidad de la mascota del jugador";
	nUI_L[nUI_UNITSKIN_RAID10TARGET]    = nUI_L[nUI_UNITMODE_RAID10]..": Piel para mostrar los datos de unidad del objetivo";
	nUI_L[nUI_UNITSKIN_RAID10TOT]       = nUI_L[nUI_UNITMODE_RAID10]..": Piel para mostrar los datos de unidad del objetivo del objetivo (ToT)";
	nUI_L[nUI_UNITSKIN_RAID10FOCUS]     = nUI_L[nUI_UNITMODE_RAID10]..": Piel para mostrar los datos de unidad del focus del jugador";
	nUI_L[nUI_UNITSKIN_RAID10LEFT]      = nUI_L[nUI_UNITMODE_RAID10]..": Piel para mostrar los datos de unidad de los miembros del lado izquierdo de la banda";
	nUI_L[nUI_UNITSKIN_RAID10RIGHT]     = nUI_L[nUI_UNITMODE_RAID10]..": Piel para mostrar los datos de unidad de los miembros del lado derecho de la banda";
	nUI_L[nUI_UNITSKIN_RAID10PETBUTTON] = nUI_L[nUI_UNITMODE_RAID10]..": Piel para mostrar los datos de unidad de los miembros de la banda y botones del focus de mascota";
	nUI_L[nUI_UNITSKIN_RAID10TGTBUTTON] = nUI_L[nUI_UNITMODE_RAID10]..": Piel para mostrar los datos de unidad de los miembros de la banda y botones del objetivo del objetivo";
	nUI_L[nUI_UNITSKIN_RAID10MOUSE]     = nUI_L[nUI_UNITMODE_RAID10]..": Piel para mostrar los datos de unidad al pasar el ratón";
	
	nUI_L[nUI_UNITMODE_RAID15]          ="nUI 15 Player Raid Mode";
	nUI_L[nUI_UNITSKIN_RAID15FOCUS]     = nUI_L[nUI_UNITMODE_RAID15]..": Piel para mostrar los datos de unidad del enfoque del Objetivo";
	nUI_L[nUI_UNITSKIN_RAID15MOUSE]     = nUI_L[nUI_UNITMODE_RAID15]..": Piel para mostrar los datos de unidad del Objetivo al pasar el ratón";
	nUI_L[nUI_UNITSKIN_RAID15VEHICLE]   = nUI_L[nUI_UNITMODE_RAID15]..": Piel para mostrar los datos de unidad de los Vehículos";
	nUI_L[nUI_UNITSKIN_RAID15PLAYER]    = nUI_L[nUI_UNITMODE_RAID15]..": Piel para mostrar los datos de unidad del Jugador";
	nUI_L[nUI_UNITSKIN_RAID15PET]       = nUI_L[nUI_UNITMODE_RAID15]..": Piel para mostrar los datos de unidad de la Mascota del Jugador";
	nUI_L[nUI_UNITSKIN_RAID15TARGET]    = nUI_L[nUI_UNITMODE_RAID15]..": Piel para mostrar los datos de unidad del Objetivo";
	nUI_L[nUI_UNITSKIN_RAID15TOT]       = nUI_L[nUI_UNITMODE_RAID15]..": Piel para mostrar los datos de unidad del Objetivo del Objetivo (ToT)";
	nUI_L[nUI_UNITSKIN_RAID15FOCUS]     = nUI_L[nUI_UNITMODE_RAID15]..": Piel para mostrar los datos de unidad del enfoque del Jugador";
	nUI_L[nUI_UNITSKIN_RAID15LEFT]      = nUI_L[nUI_UNITMODE_RAID15]..": Piel para mostrar los datos de unidad del miembro del lado izquierdo de la Banda";
	nUI_L[nUI_UNITSKIN_RAID15RIGHT]     = nUI_L[nUI_UNITMODE_RAID15]..": Piel para mostrar los datos de unidad del miembro del lado derecho de la Banda";
	nUI_L[nUI_UNITSKIN_RAID15PETBUTTON] = nUI_L[nUI_UNITMODE_RAID15]..": Piel para mostrar los datos de unidad del miembro y del botón de enfoque de la mascota";
	nUI_L[nUI_UNITSKIN_RAID15TGTBUTTON] = nUI_L[nUI_UNITMODE_RAID15]..": Piel para mostrar los datos de unidad del miembro y del enfoque del Objetivo";
	nUI_L[nUI_UNITSKIN_RAID15MOUSE]     = nUI_L[nUI_UNITMODE_RAID15]..": Piel para mostrar los datos de unidad al pasar el ratón";
	
	nUI_L[nUI_UNITMODE_RAID20]          ="nUI 20 Player Raid Mode";
	nUI_L[nUI_UNITSKIN_RAID20FOCUS]     = nUI_L[nUI_UNITMODE_RAID20]..": Piel para mostrar los datos de unidad del enfoque del Objetivo";
	nUI_L[nUI_UNITSKIN_RAID20MOUSE]     = nUI_L[nUI_UNITMODE_RAID20]..": Piel para mostrar los datos de unidad del Objetivo al pasar el ratón";
	nUI_L[nUI_UNITSKIN_RAID20VEHICLE]   = nUI_L[nUI_UNITMODE_RAID20]..": Piel para mostrar los datos de unidad de los Vehículos";
	nUI_L[nUI_UNITSKIN_RAID20PLAYER]    = nUI_L[nUI_UNITMODE_RAID20]..": Piel para mostrar los datos de unidad del Jugador";
	nUI_L[nUI_UNITSKIN_RAID20PET]       = nUI_L[nUI_UNITMODE_RAID20]..": Piel para mostrar los datos de unidad de la Mascota del Jugador";
	nUI_L[nUI_UNITSKIN_RAID20TARGET]    = nUI_L[nUI_UNITMODE_RAID20]..": Piel para mostrar los datos de unidad del Objetivo";
	nUI_L[nUI_UNITSKIN_RAID20TOT]       = nUI_L[nUI_UNITMODE_RAID20]..": Piel para mostrar los datos de unidad del Objetivo del Objetivo (ToT)";
	nUI_L[nUI_UNITSKIN_RAID20FOCUS]     = nUI_L[nUI_UNITMODE_RAID20]..": Piel para mostrar los datos de unidad del enfoque del Jugador";
	nUI_L[nUI_UNITSKIN_RAID20LEFT]      = nUI_L[nUI_UNITMODE_RAID20]..": Piel para mostrar los datos de unidad del miembro del lado izquierdo de la Banda";
	nUI_L[nUI_UNITSKIN_RAID20RIGHT]     = nUI_L[nUI_UNITMODE_RAID20]..": Piel para mostrar los datos de unidad del miembro del lado derecho de la Banda";
	nUI_L[nUI_UNITSKIN_RAID20PETBUTTON] = nUI_L[nUI_UNITMODE_RAID20]..": Piel para mostrar los datos de unidad del miembro y del botón de enfoque de la mascota";
	nUI_L[nUI_UNITSKIN_RAID20TGTBUTTON] = nUI_L[nUI_UNITMODE_RAID20]..": Piel para mostrar los datos de unidad del miembro y del enfoque del Objetivo";
	nUI_L[nUI_UNITSKIN_RAID20MOUSE]     = nUI_L[nUI_UNITMODE_RAID20]..": Piel para mostrar los datos de unidad al pasar el ratón";
	
	nUI_L[nUI_UNITMODE_RAID25]          ="nUI 25 Player Raid Mode";
	nUI_L[nUI_UNITSKIN_RAID25FOCUS]     = nUI_L[nUI_UNITMODE_RAID25]..": Piel para mostrar los datos de unidad del enfoque del Objetivo";
	nUI_L[nUI_UNITSKIN_RAID25MOUSE]     = nUI_L[nUI_UNITMODE_RAID25]..": Piel para mostrar los datos de unidad del Objetivo al pasar el ratón";
	nUI_L[nUI_UNITSKIN_RAID25VEHICLE]   = nUI_L[nUI_UNITMODE_RAID25]..": Piel para mostrar los datos de unidad de los Vehículos";
	nUI_L[nUI_UNITSKIN_RAID25PLAYER]    = nUI_L[nUI_UNITMODE_RAID25]..": Piel para mostrar los datos de unidad del Jugador";
	nUI_L[nUI_UNITSKIN_RAID25PET]       = nUI_L[nUI_UNITMODE_RAID25]..": Piel para mostrar los datos de unidad de la Mascota del Jugador";
	nUI_L[nUI_UNITSKIN_RAID25TARGET]    = nUI_L[nUI_UNITMODE_RAID25]..": Piel para mostrar los datos de unidad del Objetivo";
	nUI_L[nUI_UNITSKIN_RAID25TOT]       = nUI_L[nUI_UNITMODE_RAID25]..": Piel para mostrar los datos de unidad del Objetivo del Objetivo (ToT)";
	nUI_L[nUI_UNITSKIN_RAID25FOCUS]     = nUI_L[nUI_UNITMODE_RAID25]..": Piel para mostrar los datos de unidad del enfoque del Jugador";
	nUI_L[nUI_UNITSKIN_RAID25LEFT]      = nUI_L[nUI_UNITMODE_RAID25]..": Piel para mostrar los datos de unidad del miembro del lado izquierdo de la Banda";
	nUI_L[nUI_UNITSKIN_RAID25RIGHT]     = nUI_L[nUI_UNITMODE_RAID25]..": Piel para mostrar los datos de unidad del miembro del lado derecho de la Banda";
	nUI_L[nUI_UNITSKIN_RAID25PETBUTTON] = nUI_L[nUI_UNITMODE_RAID25]..": Piel para mostrar los datos de unidad del miembro y del botón de enfoque de la mascota";
	nUI_L[nUI_UNITSKIN_RAID25TGTBUTTON] = nUI_L[nUI_UNITMODE_RAID25]..": Piel para mostrar los datos de unidad del miembro y del enfoque del Objetivo";
	nUI_L[nUI_UNITSKIN_RAID25MOUSE]     = nUI_L[nUI_UNITMODE_RAID25]..": Piel para mostrar los datos de unidad al pasar el ratón";
	
	nUI_L[nUI_UNITMODE_RAID40]          ="nUI 40 Player Raid Mode";
	nUI_L[nUI_UNITSKIN_RAID40FOCUS]     = nUI_L[nUI_UNITMODE_RAID40]..": Piel para mostrar los datos de unidad del enfoque del Objetivo";
	nUI_L[nUI_UNITSKIN_RAID40MOUSE]     = nUI_L[nUI_UNITMODE_RAID40]..": Piel para mostrar los datos de unidad del Objetivo al pasar el ratón";
	nUI_L[nUI_UNITSKIN_RAID40VEHICLE]   = nUI_L[nUI_UNITMODE_RAID40]..": Piel para mostrar los datos de unidad de los Vehículos";
	nUI_L[nUI_UNITSKIN_RAID40PLAYER]    = nUI_L[nUI_UNITMODE_RAID40]..": Piel para mostrar los datos de unidad del Jugador";
	nUI_L[nUI_UNITSKIN_RAID40PET]       = nUI_L[nUI_UNITMODE_RAID40]..": Piel para mostrar los datos de unidad de la Mascota del Jugador";
	nUI_L[nUI_UNITSKIN_RAID40TARGET]    = nUI_L[nUI_UNITMODE_RAID40]..": Piel para mostrar los datos de unidad del Objetivo";
	nUI_L[nUI_UNITSKIN_RAID40TOT]       = nUI_L[nUI_UNITMODE_RAID40]..": Piel para mostrar los datos de unidad del Objetivo del Objetivo (ToT)";
	nUI_L[nUI_UNITSKIN_RAID40FOCUS]     = nUI_L[nUI_UNITMODE_RAID40]..": Piel para mostrar los datos de unidad del enfoque del Jugador";
	nUI_L[nUI_UNITSKIN_RAID40LEFT]      = nUI_L[nUI_UNITMODE_RAID40]..": Piel para mostrar los datos de unidad del miembro del lado izquierdo de la Banda";
	nUI_L[nUI_UNITSKIN_RAID40RIGHT]     = nUI_L[nUI_UNITMODE_RAID40]..": Piel para mostrar los datos de unidad del miembro del lado derecho de la Banda";
	nUI_L[nUI_UNITSKIN_RAID40PETBUTTON] = nUI_L[nUI_UNITMODE_RAID40]..": Piel para mostrar los datos de unidad del miembro y del botón de enfoque de la mascota";
	nUI_L[nUI_UNITSKIN_RAID40TGTBUTTON] = nUI_L[nUI_UNITMODE_RAID40]..": Piel para mostrar los datos de unidad del miembro y del enfoque del Objetivo";
	nUI_L[nUI_UNITSKIN_RAID40MOUSE]     = nUI_L[nUI_UNITMODE_RAID40]..": Piel para mostrar los datos de unidad al pasar el ratón";
	
	nUI_L[nUI_UNITPANEL_PLAYER]      		= "Panel de unidad : Modo de juego individual";
	nUI_L[nUI_UNITPANEL_PLAYER.."Label"]	= "Jugador";
	
	nUI_L[nUI_UNITPANEL_PARTY]       		= "Panel de unidad : Modo de juego en grupo";
	nUI_L[nUI_UNITPANEL_PARTY.."Label"] 	= "Grupo";
	
	nUI_L[nUI_UNITPANEL_RAID10]      		= "Panel de unidad : Modo de banda de 10 jugadores";
	nUI_L[nUI_UNITPANEL_RAID10.."Label"]	= "Banda 10";
	
	nUI_L[nUI_UNITPANEL_RAID15]      		= "Panel de unidad : Modo de banda de 15 jugadores";
	nUI_L[nUI_UNITPANEL_RAID15.."Label"]	= "Banda 15";
	
	nUI_L[nUI_UNITPANEL_RAID20]      		= "Panel de unidad : Modo de banda de 20 jugadores";
	nUI_L[nUI_UNITPANEL_RAID20.."Label"]	= "Banda 20";
	
	nUI_L[nUI_UNITPANEL_RAID25]      		= "Panel de unidad : Modo de banda de 25 jugadores";
	nUI_L[nUI_UNITPANEL_RAID25.."Label"]	= "Banda 25";
	
	nUI_L[nUI_UNITPANEL_RAID40]      		= "Panel de unidad : Modo de banda de 40 jugadores";
	nUI_L[nUI_UNITPANEL_RAID40.."Label"]	= "Banda 40";
	
	nUI_L["Click to change unit frame panels"] = "Clic para cambiar los paneles de la ventana de la unidad";
	
	nUI_L["<unnamed frame>"]    = "<ventana sin nombre>";
	nUI_L["unit change"]        = "cambio de unidad";
	nUI_L["unit class"]         = "clase de unidad";
	nUI_L["unit label"]         = "etiqueta de unidad";
	nUI_L["unit level"]         = "nivel de unidad";
	nUI_L["unit reaction"]      = "reacción de unidad";
	nUI_L["unit health"]        = "salud de unidad";
	nUI_L["unit power"]         = "poder de unidad";
	nUI_L["unit portrait"]      = "retrato de unidad";
	nUI_L["raid group"]         = "grupo de banda";
	nUI_L["unit PvP"]           = "unidad PvP";
	nUI_L["raid target"]        = "objetivo de banda";
	nUI_L["casting bar"]        = "barra de lanzamiento";
	nUI_L["ready check"]        = "listos";
	nUI_L["unit status"]        = "estado de unidad";
	nUI_L["unit aura"]          = "aura de unidad";
	nUI_L["unit combat"]        = "combate de unidad";
	nUI_L["unit resting"]       = "descanso de unidad";
	nUI_L["unit role"]          = "rol de unidad";
	nUI_L["unit runes"]         = "runas de unidad";
	nUI_L["unit feedback"]      = "información de unidad";
	nUI_L["unit combo points"]  = "puntos de combo de unidad";
	nUI_L["unit range"]         = "rango de unidad";
	nUI_L["unit spec"]          = "especificación de unidad";
	nUI_L["unit threat"]        = "amenza de unidad";
	
	nUI_L["Talent Build: <build name> (<talent points>)"] = "Talentos: |cFF00FFFF%s|r (%s)";
	nUI_L["passed unit id is <nil> in callback table for %s"] = "id de unidad pasado es <nil> en tabla de callback de %s";
	nUI_L["nUI: Warning.. anchoring %s to %s -- anchor point has a <nil> value."] = "nUI: Atención.. anclando %s a %s -- punto de anclaje tiene valor <nil>.";
	nUI_L["nUI: Cannot register %s for scaling... frame does not have a applyScale() method"] = "nUI: No puedo registrar %s del escalado... ventana no tiene un metodo de applyScale()";
	nUI_L["nUI: Cannot register %s for scaling... frame does not have a applyAnchor() method"] = "nUI: No puedo registrar %s del escalado... ventana no tiene un metodo de applyAnchor()";
	nUI_L["nUI: %s %s callback %s does not have a newUnitInfo() method."] = "nUI: %s %s callback %s no tiene un método newUnitInfo() .";
	nUI_L["nUI_UnitClass.lua: unhandled unit class [%s] for [%s]"] = "nUI_UnitClass.lua: clase de unidad no manejada [%s] para [%s]";
	nUI_L["nUI: click-casting registration is %s"] = "nUI: El registro para click-casting es %s";
	nUI_L["nUI: must pass a valid parent frame to nUI_Unit:createFrame() for unit id [%s (%s)]"] = "nUI: debe pasar un frame padre de nUI_Unit:createFrame() para el id de unidad [%s (%s)]";
	nUI_L["nUI says: Gratz for reaching level %d %s!"] = "nUI dice: ¡Enhorabuena por alcanzar el nivel %d %s!";
	nUI_L["nUI_Unit: [%s] is not a valid unit frame element type!"] = "nUI_Unit: ¡[%s] no es un tipo de ventana de unidad válido!";
	nUI_L["nUI_Unit: [%s] is not a known unit skin name!"] = "nUI_Unit: [%s] no es una piel de nombre conocida!";
    nUI_L["nUI_Unit: [%s] is not a valid raid sorting target frame, it does not have a setUnitID() method"] = "nUI_Unit: [%s] no es un marco objetivo de ordenamiento de banda valido, no tiene un metodo de setUnitID()"; -- new
	nUI_L["nUI_Unit: [%d] is not a valid raid ID... the raid ID must be between 1 and 40"] = "nUI_Unit: [%d] no es una ID de banda valido... el ID de banda debe ser entre 1 y 40"; -- new
	
    -- cadenas de mascota de cazador de nUI_Unit
	
	nUI_L["Your pet"] = "Tu mascota";
	nUI_L["quickly"] = "rápidamente";
	nUI_L["slowly"] = "lentamente";
	nUI_L["nUI: %s is happy."] = "nUI: %s es feliz.";
	nUI_L["nUI: %s is unhappy... time to feed!"] = "nUI: %s es infeliz... ¡hora de alimentarle!";
	nUI_L["nUI: Warning! %s is |cFFFFFFFFNOT|r happy! Better feed soon."] = "nUI: ¡Atención! ¡%s |cFFFFFFFFNO|r es feliz! Mejor alimentarle pronto.";
	nUI_L["nUI: Warning... %s is %s losing loyalty "] = "nUI: Atención... %s está perdiendo fidelidad %s";
	nUI_L["nUI: %s is %s gaining loyalty"] = "nUI: %s está ganando fidelidad %s";
	nUI_L["nUI: %s has stopped gaining loyalty"] = "nUI: %s ha parado de ganar fidelidad";
	nUI_L["nUI: %s has stopped losing loyalty"] = "nUI: %s ha parado de perder fidelidad";
	nUI_L["Your pet's current damage bonus is %d%%"] = "El bonus de daño de tu actual mascota es %+d%%";
	nUI_L["Your pet's current damage penalty is %d%%"] = "La penalización de daño de tu actual mascota es %+d%%";
	nUI_L["nUI: It looks to me like you're a little busy... maybe you should try feeding %s AFTER you leave combat?"] = "nUI: Me parece que estas algo ocupado... quizás deberías de intentar de alimentar a %sdespués del combatet?";
	nUI_L["nUI: I looked everywhere, but I couldn't find a pet to feed. Perhaps he's in your backpack?"] = "nUI: He buscado por todas partes, pero no encontrado una mascota que alimentar. Quizás este en tu mochila?";
	nUI_L["nUI: You know, I could be wrong, but I don't think feeding %s is a very good idea... it doesn't look to me like what you have in your bags is what %s is thinking about eating."] = "nUI: Sabes, puedo estar equivocado, pero pienso que alimentar a %s es una muy buena idea... me parece que lo que tienes en tus bolsas es lo que %s ista pensando en comerse.";
	
	-- miscelaneous strings
	
	nUI_L["Version"]                     = "nUI Version |cFF00FF00%s|r";
	nUI_L["Copyright"]                   = "Copyright (C) 2008 por K. Scott Piel";
	nUI_L["Rights"]                      = "Todos los derechos reservados";
	nUI_L["Off Hand Weapon:"]            = "Arma de mano izquierda :";
	nUI_L["Main Hand Weapon:"]           = "Arma de mano derecha :";
	nUI_L["Group %d"]                    = "Grupo %d";
	nUI_L["MS"]                          = "mS";
	nUI_L["FPS"]				         = "FPS";
	nUI_L["Minimap Button Bag"]          = "Botones del minimapa";
	nUI_L["System Performance Stats..."] = "Estadisticas del Rendimiento del Sistema...";
	nUI_L["PvP Time Remaining: <time_left>"] = "Tiempo de JcJ Restante: |cFF50FF50%s|r";
	
	nUI_L["Cursor: <cursor_x,cursor_y>  /  Player: <player_x,player_y>"] = "Cursor: |cFF00FFFF<%0.1f, %0.1f>|r  /  Jugador: |cFF00FFFF<%0.1f, %0.1f>|r";
	nUI_L["nUI has disabled the plugin 'nui_AuraBars' as it is now incorporated in nUI 5.0 -- Please use '/nui rl' to reload the UI. You should uninstall nUI_AuraBars as well."] = "nUI ha desactivado el plugin 'nui_AuraBars' ya que está contenido dentro de nUI 5.0 -- Por favor usa '/nui rl' para recargar el UI. Deberias desinstalar nUI_AuraBars también.";
	
	-- key binding strings
	
	nUI_L["HUD Layout"]                  = "Diseño del HUD";
	nUI_L["Unit Panel Mode"]             = "Modo Panel de Unidad";
	nUI_L["Info Panel Mode"]             = "Modo Panel de Información";
	nUI_L["Key Binding"]                 = "Asociación de Teclas";
	nUI_L["Miscellaneous Bindings"]      = "Asosiaciones de teclas Varias";
	nUI_L["No key bindings found"]       = "No se han encontrado teclas asociadas";
	nUI_L["<ctrl-alt-right click> to change bindings"] = "<ctrl-alt-clic derecho> para cambiar asignación de teclas";

	-- rare spotting strings
	
	nUI_L["You have spotted a rare mob: |cFF00FF00<mob name>|r<location>"] = "Has encontrato un bicho raro: |cFF00FF00%s|r%s";
	nUI_L["You have spotted a rare elite mob: |cFF00FF00<mob name>|r<location>"] = "Has encontrado un bicho elite raro: |cFF00FF00%s|r%s";
	
	-- faction / reputation bar strings
	
	nUI_L["Unknown"]    = "Desconocida";
	nUI_L["Hated"]      = "Odiado";
	nUI_L["Hostile"]    = "Hostil";
	nUI_L["Unfriendly"] = "Enemigo";
	nUI_L["Neutral"]    = "Neutral";
	nUI_L["Friendly"]   = "Amistoso";
	nUI_L["Honored"]    = "Honorable";
	nUI_L["Revered"]    = "Venerado";
	nUI_L["Exalted"]    = "Exaltado";
	
	nUI_L["Faction: <faction name>"]    = "Facción: |cFF00FFFF%s|r";
	nUI_L["Reputation: <rep level>"]    = "Reputación: |cFF00FFFF%s|r";
	nUI_L["Current Rep: <number>"]      = "Rep. Actual: |cFF00FFFF%d|r";
	nUI_L["Required Rep: <number>"]     = "Rep. Necesaria: |cFF00FFFF%d|r";
	nUI_L["Remaining Rep: <number>"]    = "Rep. Faltante: |cFF00FFFF%d|r";
	nUI_L["Percent Complete: <number>"] = "Porcentaje Completado: |cFF00FFFF%0.1f%%|r";
	nUI_L["<faction name> (<reputation>) <current rep> of <required rep> (<percent complete>)"] = "%s (%s) %d de %d (%0.1f%%)";
	
	nUI_L[nUI_FACTION_UPDATE_START_STRING]    = "Reputación con ";
	nUI_L[nUI_FACTION_UPDATE_END_STRING]      = " incrementada";
	nUI_L[nUI_FACTION_UPDATE_INCREASE_STRING] = "incrementada";
	
	-- player experience bar strings
	
	nUI_L["Current level: <level>"]                         = "Nivel Actual: |cFF00FFFF%d|r";
	nUI_L["Current XP: <experience points>"]                = "Exp. Actual: |cFF00FFFF%d|r";
	nUI_L["Required XP: <XP required to reach next level>"] = "Exp. Necesaria: |cFF00FFFF%d|r";
	nUI_L["Remaining XP: <XP remaining to level>"]          = "Exp. Faltante: |cFF00FFFF%d|r";
	nUI_L["Percent complete: <current XP / required XP>"]   = "Porcentaje completado: |cFF00FFFF%0.1f%%|r";
	nUI_L["Rested XP: <total rested experience> (percent)"] = "Exp. de descanso: |cFF00FFFF%d|r (%0.1f%%)";
	nUI_L["Rested Levels: <levels>"]                        = "Niveles de Descanso: |cFF00FFFF%0.2f|r";
	nUI_L["Level <player level>: <experience> of <max experience> (<percent of total>), <rested xp> rested XP"] = "Nivel %d: %d de %d (%0.1f%%), %d Exp de descanso";
	
	-- health race bar tooltip strings
	
	nUI_L["nUI Health Race Stats..."] = "Estadísticas de salud de nUI..";
	nUI_L["No current advantage to <player> or <target>"] = "No hay ventaja para %s o %s";
	nUI_L["<unit name>'s Health: <current>/<maximum> (<percent>)"] = "Salud de %s' : |cFF00FF00%d/%d|r (|cFFFFFFFF%0.1f%%|r)";
	nUI_L["Advantage to <player>: <pct>"] = "Ventaja para %s: (|cFF00FF00%+0.1f%%|r)";
	nUI_L["Advantage to <target>: <pct>"] = "Ventaja para %s: (|cFFFFC0C0%0.1f%%|r)";
	
	-- skinning system messages
	
	nUI_L["nUI could not load the currently selected skin [ %s ]... perhaps you have it disabled? Switching to the default nUI skin."] = "nUI no puede cargar la piel actualmente selecionada [ |cFFFFC0C0%s|r ]... ¿quizás la has desabilitado? Cambiando a piel por defecto de nUI.";
	nUI_L["nUI: Cannot register %s for skinning... frame does not have a applySkin() method"] = "nUI: No puedo registrar |cFFFFC0C0%s|r para poner piel... ventana no tiene metodo de a applySkin()";
	
	-- frame mover messages
	
	nUI_L["Left click and drag to move <frame label>"] = "Clic izquierdo y arrastre para mover |cFF00FFFF%s|r";
	nUI_L["Right click to reset to the default location"] = "Clic derecho para restablecer a la ubicación por defecto";
	nUI_L["Left-click and drag to move this frame"] = "Clic izquierdo y arrastre para mover este marco";
    
    -- names of the various frames that nUI allows the user to move on the screen
	
	nUI_L["Micro-Menu"]                = "Micro-Menu";
	nUI_L["Capture Bar"]               = "Barra de Captura";
	nUI_L["Watched Quests"]            = "Oberservador de Misiones";
	nUI_L["Quest Timer"]               = "Tiempo de Misión";
	nUI_L["Equipment Durability"]      = "Durabilidad de equipo";
	nUI_L["PvP Objectives"]            = "Objetivos JcJ";
	nUI_L["Watched Achievments"]       = "Logros observados";
	nUI_L["In-Game Tooltips"]          = "Ayuda In-Game";
	nUI_L["Bag Bar"]                   = "Barra de Bolsas";
	nUI_L["Group Loot Frame"]          = "Ventana de despojos de Grupo";
	nUI_L["nUI_ActionBar"]             = "Barra Principal / Página de Acción 1";
	nUI_L["nUI_BottomLeftBar"]         = "Barra inferior Izquierda / Página de Acción 2";
	nUI_L["nUI_LeftUnitBar"]           = "Barra izquierda de Ventana de Unidad / Página de Acción 3";
	nUI_L["nUI_RightUnitBar"]          = "Barra derecha de Ventana de Unidad / Página de Acción 4";
	nUI_L["nUI_TopRightBar"]           = "Barra superior Derecha / Página de Acción 5";
	nUI_L["nUI_TopLeftBar"]            = "Barra superior Izquierda / Página de Acción 6";
	nUI_L["nUI_BottomRightBar"]        = "Barra inferior derecha";
	nUI_L["Pet/Stance/Shapeshift Bar"] = "Barra de Mascota/Estancia/Cambio de Forma";
	nUI_L["Vehicle Seat Indicator"]    = "Indicador de asiento del vehículo";
	nUI_L["Voice Chat Talkers"]        = "Indicadores del Chat de Voz";
	nUI_L["Dungeon Completion Alert Frame"] = "Marco de aviso de finalización de Mazmorra"; -- new
	nUI_L["Achievement Alert Frame"]   = "Marco de aviso de Logro"; -- new
    nUI_L["Timer Bar"]                 = "Barra temporizadora";
	
	-- slash command processing	
	
	nUI_SlashCommands =
	{
		[nUI_SLASHCMD_HELP] =
		{
			command = "help",
			options = "{command}",
			desc    = "Muestra la lista de todos los comandos de consola disponibles si no se proporciona {command} o, si se proporciona {command} , muestra información del comando específico",
			message = nil,
		},
		[nUI_SLASHCMD_RELOAD] =
		{
			command = "rl",
			options = nil,
			desc    = "Recarga la interfaz de usuario y todos los mods habilitados (es igual a /console reloadui)",
			message = nil,
		},
		[nUI_SLASHCMD_BUTTONBAG] =
		{
			command = "bb",
			options = nil,
			desc    = "Este comando conmuta la visualización de la bolsa de botones de minimapa entre activado o desactivado.",
			message = nil,
		},
		[nUI_SLASHCMD_MOVERS] =
		{
			command = "movers",
			options = nil,
			desc    = "Habilita y deshabilita el movimiento de los marcos de la interfaz de Blizzard , como las ayudas,  durabilidad, contadores de misiones y otros.",
			message = "nUI: Movimientos de ventana de Blizzard han sido %s", -- enabled or disabled
		},
		[nUI_SLASHCMD_CONSOLE] =
		{
			command = "console",
			options = "{on|off|mouseover}",
			desc    = "Establece las opciones de visibilidad de la consola superior donde 'on' siempre muestra la consola, 'off' siempre oculta la consola y 'mouseover' muestra la consola cuendo pasas el ratón sobre ella.",
			message = "nUI: Visibilidad de consola superior ha sido establecida como %s", -- "on", "off" or "mouseover"
		},
		[nUI_SLASHCMD_TOOLTIPS] =
		{
			command = "tooltips",
			options = "{owner|mouse|fixed|default}",
			desc    = "Esta opción establece la ubicación de los cuadros de diálogo donde 'owner' muestra el cuadro de diálogo cerca de la pantalla que lo posee, 'mouse' muestra el cuadro de diálogo en la posición actual del ratón, 'fixed' muestra todos los cuadros de diálogo en una posición marcada en la 'default' no gestiona los cuadros de diálogo",
			message = "nUI: Modo de mostrar caudros de diálogo cambiado a |cFF00FFFF%s|r", -- the chosen tooltip mode
		},
		[nUI_SLASHCMD_COMBATTIPS] =
		{
			command = "combattips",
			options = nil,
			desc    = "Esta opción cambia entre activados y desactivados el mostrar los cuadros de diálogo de los botones de acción mientras estas en combate. Por defecto se ocultan los cuadros de diálogo en tu barra de acción mientras estás en combate.",
			message = "nUI: Mostrar cuadros de diálogo durante el combate ha sido %s", -- enabled or disabled
		},
		[nUI_SLASHCMD_BAGSCALE] =
		{
			command = "bagscale",
			options = "{n}",
			desc    = "Esta opción incrementa y decrementa el tamaño de tus bolsas, donde {n} es un número entre  0.5 y 1.5 -- 1 es el valor por defecto",
			message = "nUI: La escala de tu bolsa ha sido cambiada a |cFF00FFFF%0.2f|r", -- the chosen scale
		},
		[nUI_SLASHCMD_BAGBAR] =
		{
			command = "bagbar",
			options = "{on|off|mouseover}",
			desc    = "Esta opción establece el mostrar la barra de las bolsas en activa, desactivada o solo visible si pasas el ratón.Por defecto está siempre activo.",
			message = "nUI: El mostrar la barra de bolsas ha sido establecida como |cFF00FFFF%s|r", -- on, off or mouseover
		},
		[nUI_SLASHCMD_CALENDAR] =
		{
			command = "calendar",
			options = nil,
			desc    = "Por defecto, nUI mueve el calendario de hermandad del minimapa a la bolsa de botones. Esta opción cambia entre permitir o no que el botón del calendario de hermandad se muestre en el minimapa",
			message = "nUI: La gestión del botón del calaendario de hermandad ha sido %s", -- ENABLED or DISABLED
		},
		[nUI_SLASHCMD_FRAMERATE] =
		{
			command = "framerate",
			options = "{n}",
			desc    = "Esta opción cambia el ritmo de refresco máximo de las animaciones de las barra y de las ventanas de unidad. Increase {n} para suavidad, decrease {n} para rendimiento. Por defecto es "..nUI_DEFAULT_FRAME_RATE.." fotograma por segundo.",
			message = "nUI: Tu ritmo de refresco de fotogramas se ha cambiado a |cFF00FFFF%0.0fFPS|r", -- the chosen rate in frames per second... change FPS if you need a different abreviation!
		},
		[nUI_SLASHCMD_FEEDBACK] =
		{
			command = "feedback",
			options = "{curse|disease|magic|poison}",
			desc    = "nUI provee el resaltar las ventandas de unidad que tengan una maldición (curse), enfermedad (disease), magia (magic) o veneno (poison) en ellos. Por defecto, los cuatro tipos serán resaltados. Esta opción te deja encender o apagarlos individualmente para que solo muestre las auras que puedes usar.",
			message = "nUI: El resaltar las ventanas de unidad para |cFF00FFFF%s debuffs|r ha sido %s", -- aura type and enabled or disabled
		},
		[nUI_SLASHCMD_SHOWHITS] =
		{
			command = "showhits",
			options = nil,
			desc    = "Nui resalta el fondo de las ventanas de unidad n rojo y verde para mostrar cuando te produzcan daño o te beneficien curandote. Esta opción puede estar encendida o apagada. Por defecto está encendida.",
			message = "nUI: El mostrar daño y sanación en vantanas de unidad ha sido %s", -- enabled or disabled
		},
		[nUI_SLASHCMD_MAXAURAS] =
		{
			command = "maxauras",
			options = "{1-40}",
			desc    = "Por defecto nUI mostrará 40 auras máximas posibles en cada juego de unidad: jugador, mascota, vehículo y objetivo. Esta opción te dejará establecer el máximo número de auras a un valor inferior que esté entre el 0 y 40 40. Estableciendo maxauras a(0) desactivará el mostrar las auras.",
			message = "nUI: El máximo número de auras ha sido establecido a |cFF00FFFF%d|r", -- a number from 0 to 40
		},
		[nUI_SLASHCMD_AUTOGROUP] =
		{
			command = "autogroup",
			options = nil,
			desc    = "Por defecto nUI automaticamente cambiará tu panel de unidad al mejor panel de lucha cuando accedas o dejes un grupo o banda. Esta opción puede estar encendida o apagada.",
			message = "nUI: Cambio automático de paneles de ventana de unidad cuando dejes o accedas a grupo o banda ha sido %s",
		},
		[nUI_SLASHCMD_RAIDSORT] =
		{
			command = "raidsort",
			options = "{unit|group|class|name}",
			desc    = "Establece el orden de clasificación usado para mostrar las ventanas de unidad cuando estes en banda. La opción 'unit' clasifica las ventanas de unidad por el tipo de ID desde raid1 a raid40. La opción 'group' clasifica las ventanas de unidad por el número de grupo de bandas, la opción 'class' clasifica según la clase de cada jugador y la opción 'name' clasifica por el nombre del jugador. La opción por defecto es clasificar las ventanas por el grupo de raid.",
			message = "nUI: Clasificación de grupo de banda ha sido establecido |cFF00FF00%s|r", -- sort option: group, unit or class
		},
		[nUI_SLASHCMD_SHOWANIM] =
		{
			command = "anim",
			options = nil,
			desc    = "Esta opción cambia entre activar y desactivar el mostrar la animaciones de los retratos de unidades y las barras de unidad",
			message = "nUI: Mostrar animación de los retratos de unidad ha sido %s", -- enabled or disabled
		},
		[nUI_SLASHCMD_HPLOST] =
		{
			command = "hplost",
			options = nil,
			desc    = "Esta opción cambia el mostrar la sauld del jugador en las ventanas de unidad de HP restante a HP perdida. Esto es un valor particular para curadores.",
			message = "nUI: Mostrar los valores de salud ha sido cambiado a %s", -- "health remaining" or "health lost"
		},
		[nUI_SLASHCMD_HUD] =
		{
			command  = "hud",
			options  = nil,
			desc     = "Este comando proporciona acceso a un conjunto de comandos usado para controlar el comportamiento del HUD de nUI. Usa el comando '/nui hud' para una lista de subcomandos disponibles.",
			message  = nil,
			sub_menu =
			{
				[nUI_SLASHCMD_HUD_SCALE] =
				{
					command = "scale",
					options = "{n}",
					desc    = "Esta opción establece la escala del HUD entre 0.25 <= {n} <= 1.75. Valores menores que {n} reduce el tamaño del HUD y valores mayores aumenta el tamaño. Por defecto {n} = 1",
					message = "nUI: La escala del HUD ha sido establecida en |cFF00FFFF%0.2f|r", -- a number
				},
				[nUI_SLASHCMD_HUD_SHOWNPC] =
				{
					command = "shownpc",
					options = nil,
					desc    = "Esta opción cambia el mostrar las barras del HUD para objetivos de PNJ no atacables entre activado y desactivado cuando estas fuera de combate",
					message = "nUI: Mosrar bjetivos de PNJ no atacable ha sido %s", -- enabled or disabled
				},
				[nUI_SLASHCMD_HUD_FOCUS] =
				{
					command = "focus",
					options = nil,
					desc    = "Por defecto, el HUD no muestra información del focu del jugador. Activando esta opción el HUD del objetivo y del OdO será reemplazado por el foco o el objetivo del foco cuando sea seleccionado un foco.",
					message = "nUI: Mostrar el focus de jugador o de objetivo esta %s", -- enabled or disabled
				},
				[nUI_SLASHCMD_HUD_HEALTHRACE] =
				{
					command = "healthrace",
					options = nil,
					desc    = "Esta opción cambia el mostrar las barras de carrera de salud en HUD entre activado y desactivado",
					message = "nUI: Mostrar barras de carrera de salud en HUD ha sido %s", -- enabled or disabled
				},
				[nUI_SLASHCMD_HUD_COOLDOWN] =
				{
					command = "cooldown",
					options = nil,
					desc    = "Esta opción cambia el mostrar en el HUD la barra de reutilización de habilidades, mensajes de alerta de reutilización y efectos de sonido de reutilización de activado a desactivado.",
					message = "nUI: El mostrar la barra de cuenta atrs del HUD ha sido %s",
				},
				[nUI_SLASHCMD_HUD_CDALERT] =
				{
					command = "cdalert",
					options = nil,
					desc    = "Cuando la barra de cuenta atrás del in-HUD está activa, esta opción enciende o apaga el mostrar mensajes de estar listo.",
					message = "nUI: El mostrar los mensajes de estar listo de cuenta atrás ha sido %s",
				},
				[nUI_SLASHCMD_HUD_CDSOUND] =
				{
					command = "cdsound",
					options = nil,
					desc    = "Cuando la barra de cuenta atrás del in-HUD esta activa, esta opción enciende o apaga el tener sonido de aviso de estar listo.",
					message = "nUI: El mostrar los sonidos de cuenta atrás del HUD ha sido %s",
				},
				[nUI_SLASHCMD_HUD_CDMIN] =
				{
					command = "cdmin",
					options = "{n}",
					desc    = "Esto establece la cantidad mínima de tiempo requerida para que un hechizo se muestre en la barra de cuenta atrás cuando empiece la cuenta atrás. Si la cuenta atrás es menor que {n}, no se mostrará. El valor por defecto es '/nui hud cdmin 2'",
					message = "nUI: El tiempo mínimo de cuenta atrás de HUD ha sido establecido a |cFF00FFFF%d|r segundos", -- time in seconds.
				},
				[nUI_SLASHCMD_HUD_HGAP] =
				{
					command = "hgap",
					options = "{n}",
					desc    = "Esta opción establece la brecha horizontal entre el lado derecho e izquierdo del HUD donde {n} es un número mayor que 0. Incrementar {n} para incrementar la brecha entre lado izquierdo y derecho del HUD. El valor por defecto de {n} es 400",
					message = "nUI: La brecha horizontal del HUD se ha establecido en |cFF00FFFF%0.0f|r", -- a number greater than zero
				},
				[nUI_SLASHCMD_HUD_VOFS] =
				{
					command = "vofs",
					options = "{n}",
					desc    = "Esta opción establece la compensación del HUD desde el centro del punto de visión. Por defecto es '/nui hud vofs 0' que situa el HUD en el centro del punto de visión. Valores menosres de 0 bajan el HUD, mayores que 0 suben el HUD.",
					message = "nUI: The vertical HUD offset has been set to |cFF00FFFF%0.0f|r", -- a number
				},
				[nUI_SLASHCMD_HUD_IDLEALPHA] =
				{
					command = "idlealpha",
					options = "{n}",
					desc    = "Esa opción establece la transparencia del HUD cuando estas completamente inactivo donde {n} = 0 por un HUd invisible y {n} = 1 para un HUd completamente opaco. Por defecto es {n} = 0",
					message = "nUI: El HUD alpha ha sido establecido en |cFF00FFFF%0.2f|r", -- a number between 0 and 1
				},
				[nUI_SLASHCMD_HUD_REGENALPHA] =
				{
					command = "regenalpha",
					options = "{n}",
					desc    = "Esta opción establece la transparencia del HUD cuando tu (o tu mascota) estás regenerando slud, regenerando poder o cuando estas con desventajas donde {n} = 0 para un HUD invisibleD y {n} = 1 para un HUD completamente opaco. Por defecto es {n} = 0.35",
					message = "nUI: El HUD de regeneración alpha ha sido establecido en |cFF00FFFF%0.2f|r", -- a number between 0 and 1
				},
				[nUI_SLASHCMD_HUD_TARGETALPHA] =
				{
					command = "targetalpha",
					options = "{n}",
					desc    = "Esta opción establece la transparencia del HUD cuando hayas selecionado un objetivo válido donde {n} = 0 para un HUD invisible y {n} = 1 por un HUD completamente opaco. Por defecto es {n} = 0.75",
					message = "nUI: El HUD de objetivo alpha ha sido establecido en |cFF00FFFF%0.2f|r", -- a number between 0 and 1
				},
				[nUI_SLASHCMD_HUD_COMBATALPHA] =
				{
					command = "combatalpha",
					options = "{n}",
					desc    = "Esta opción establece la transparencia del HUD cuando tu o tu mascota están en combate donde {n} = 0 para un HUD invisible y {n} = 1 para un HUD completamente opaco. Por defecto es {n} = 1",
					message = "nUI: El HUD de combate alpha ha sido establecido en |cFF00FFFF%0.2f|r", -- a number between 0 and 1
				},
			},
		},
		[nUI_SLASHCMD_BAR] =
		{
			command  = "bar",
			options  = nil,
			desc     = "Esta opción permite acceso a establecer una serie de comando usados para el control de comportamiento de la barra de acción de nUI. Usa el comando '/nui bar' para una lista de comandos disponibles.",
			message  = nil,
			sub_menu =
			{
				[nUI_SLASHCMD_BAR_COOLDOWN] =
				{
					command = "cooldown",
					options = nil,
					desc    = "Esta opción se usada para encender o apagar los temporizadores de reutilización (se muestran en amarillo en la barra de acción) Por defecto esta característica está activada.",
					message = "nUI: Temporizadores de reutilización estan %s", -- enabled or disabled
				},
				[nUI_SLASHCMD_BAR_DURATION] =
				{
					command = "duration",
					options = nil,
					desc    = "Por defecto, cuando lanzas un hechizo sobre un objetivo, el tiempo que queda del hechizo se muestra en azul sobre la barra de acción. Esta opción apaga esta característica.",
					message = "nUI: Temporizador de duración de hechizo de la barra de acción ha sido %s", -- enabled or disabled
				},
				[nUI_SLASHCMD_BAR_MACRO] =
				{
					command = "macro",
					options = nil,
					desc    = "Cuando situes una macro en la barra de acción, nUI muestra el nombre en el botón. Esta opción activará o desactivará esta función.",
					message = "nUI: Mostrar nombre de Macro en la barra de acción ha sido %s", -- enabled or disabled
				},
				[nUI_SLASHCMD_BAR_STACKCOUNT] =
				{
					command = "stackcount",
					options = nil,
					desc    = "nUI muestra normalmente la cuenta de pilas de los objetos de tu inventario de tu barra de acción en la esquina inferior derecha del botón. Esta opción se puede usar para activar o desactivar esta función.",
					message = "nUI: Mostrar cuenta de pilas en la barra de opción ha sido %s", -- enabled or disabled
				},
				[nUI_SLASHCMD_BAR_KEYBIND] =
				{
					command = "keybind",
					options = nil,
					desc    = "Cuando tienes una asociación de teclas en un botón de acción, el nombre de la tecla se muestra en la esquina superior izquierda del botón. Esta opción se puede usar para activar o desactivar esta función.",
					message = "nUI: Mostrar el nombre de las teclas asociadas ha sido %s", -- enabled or disabled
				},
				[nUI_SLASHCMD_BAR_DIMMING] = -- new
				{
					command = "dimming",
					options = nil,
					desc    = "Por defecto, mientras estés en combate, si alguna habilidad en tus barras está inutilizabe o activa en tu obtjetivo, esta es atenuada como indicativo de que usted no puede o no necesita usarla aún y se ilumina cuando proquea expira en el objetivo. Esta opción activa o desactiva este comportamiento.",
					message = "nUI: Dimming of actions on cooldown, or unusable, is %s", -- enabled or disabled
				},
				[nUI_SLASHCMD_BAR_DIMALPHA] = -- new
				{
					command = "dimalpha",
					options = "{n}",
					desc    = "Normalmente cuando un botón de habilidad está atenuado debido a que está inutilizable o se encuentra activo en el objetivo, este es mostradoal 30% de opacidad. Esta opción permite establecer una opacidad personalizada entre 0 para una transparencia total y 1 para totalmente opaco. El valor por defecto es '/nui dimalpha 0.30'",
					message = "nUI: Opacidad de atuenuación se ha establecido en |cFF00FFFF%0.1f%%|r", -- a number between 0% and 100%
				},
				[nUI_SLASHCMD_BAR_MOUSEOVER] = -- new
				{
					command = "mouseover",
					options = nil,
					desc    = "Por defecto, nUI muestra sus barras de acción en todo momento. Cuando la función '/nui mouseover' es activada, nUI esconderá las barras hasta que cursor del ratón se situe sobre la barra.",
					message = "nUI: Visualización de las barra de acción solo si el cursor del ratón está encima está %s", -- enabled or disabled
				},
				[nUI_SLASHCMD_BAR_TOTEMS] = -- new
				{
					command = "totems",
					options = nil,
					desc    = "nUI usa la barra de totems de Blizzard para Chamanes. Si prefiere usar un 'addon' alternativo para manejar los totems, la opción '/nui bar totems' puede ser usada para que nUI esconda la barra de totems de Blizzard.",
					message = "nUI: Ocultación de la barra de totems de Blizzard ha sido %s", -- enabled or disabled
				},
                [nUI_SLASHCMD_BAR_BOOMKIN] = -- new
				{
					command = "boomkin",
					options = nil,
					desc    = "Por defecto nUI no usa una barra de acción dedicada para la Forma de lechúcico lunar, en su lugar utiliza esa barra como barra de acción en la parte inferior derecha de la interfaz. la opción '/nui bar boomkin' activa o desactiva el uso de la barra inferior derecha como barra dedicada para la Forma de lechúcico lunar.",
					message = "nUI: la barra de acción dedicada para la Forma de lechúcico lunar ha sido %s", -- enabled or disabled
				},
			},
		},
		[nUI_SLASHCMD_MOUNTSCALE] =
		{
			command = "mountscale",
			options = "{n}",
			desc    = "Esta opción establece la escala para el indicador de asiento que se muestra arriba en el centro cuando montas una montura especial. Por defecto de nUI es '/nui mountscale 1' donde 0.5 < {n} < 1.5 -- valores menos que 1.0 causa que el indicador sea más pequeño, valores mayor {n} > 1.0 aumenta el tamaño.",
			message = "nUI: El escalado del indicador de la montura especial se ha establecido en |cFF00FFFF%s|r", -- a number between 0.5 and 1.5
		},
		[nUI_SLASHCMD_CLOCK] =
		{
			command = "clock",
			options = "{server|local|both}",
			desc    = "Esta opción establece el mostrar el reloj del salpicadero para o mostrar la hora local {local}, la hora actual del servidor {server} o ambas servidor y local juntas {both}. El ajusto por defecto es servidor {server}",
			message = "nUI: El modo de reloj del salpicadero ha sido establecido a |cFF00FFFF%s|r",
		},
		[nUI_SLASHCMD_MAPCOORDS] =
		{
			command = "mapcoords",
			options = nil,
			desc    = "Esta opción cambia entre activar y desactivar el mostrar las coordenadas del jugador y del cursor en el mapamundi. Esta encendido por defecto.",
			message = "nUI: Coordenadas de Mapa Mundi han sido %s", -- "ACTIVADAS" or "DESACTIVADAS"
		},
		[nUI_SLASHCMD_ROUNDMAP] =
		{
			command = "roundmap",
			options = nil,
			desc    = "Esta opción cambia el mostrar el minimapa entre cuadrado por defecto y un minimapa redondo",
			message = "nUI: La forma del minimapa ha sido establecida a |cFF00FFFF%s|r", -- "round" or "square"
		},
		[nUI_SLASHCMD_MINIMAP] =
		{
			command = "minimap",
			options = nil,
			desc    = "Esta opción cambia entre activado o desactivado la gestión de nUI sobre el minimapa. Si está activo, nUI intenará mover el minimapa al salpicadero, delo contrario el minimapa de Blizzard no será modificado por nUI (aunque los botones del minimapa si lo serán). Cambiando esta opción se verá forzado a una recarga del UI!",
			message = "nUI: Gestión del minimapa ha sido %s", -- enabled or disabled
		},
		[nUI_SLASHCMD_ONEBAG] =
		{
			command = "onebag",
			options = nil,
			desc    = "Esta opción cambia el mostrar las bolsas de inventario de tu barra de dolsa a mostrar solo la mochila o las cinco bolsas. Esto no combina actualmente todas las bolsas a una sola de momento, siempre se puede hacer con mods de terceros como ArkInventory.",
			message = "nUI: Botón de bolsa simple ha sido %s", -- enabled or disabled
		},
		[nUI_SLASHCMD_WATCHFRAME] =
		{
			command = "watchframe",
			options = nil,
			desc    = "Este comando hace que nUI restablesca el tamaño y ubicación de la ventana de seguimiento avanzado de objetivos a la posición por defecto en el diseño actual de nUI.",
			message = "nUI: La ventana de seguimiento avanzado de objetivos ha sido restablecida",
		},
		[nUI_SLASHCMD_VIEWPORT] =
		{
			command = "viewport",
			options = nil,
			desc    = "Este comando activa o desactica el uso de un 'viewport' en nUI. Cuando se activa, el HUD y el personaje son centrados en el área de visualización disponible.",
			message = "nUI: El 'viewport' ha sido %s", -- enabled or disabled
		},
		[nUI_SLASHCMD_LASTITEM+1] =
		{
			command = "debug",
			options = "{n}",
			desc    = "Esta opción establece el nivel de depuración de mensajes de nUI . Por lo general deberías cambiar los niveles de depuración si se te pide por el autor del mod. Utiliza {n} = 0 para deshabilitar por completo la depuración  (por defecto).",
			message = "nUI: Tu nivel de depuración ha sido establecido a |cFF00FFFF%d|r", -- an integer value
		},
		[nUI_SLASHCMD_LASTITEM+2] =
		{
			command = "profile",
			options = nil,
			desc    = "Esta opción activa o desactiva el tiempo de ejecución perfiles de nUI. Ejecución de perfiles esta desactivado por defecto y activando esta caracteristica incrementa los generales. Ejecución de perfiles no se guarda entre sesiones de recarga de consola. No deberias activar la ejecución de perfiles hasta haber sido recomendado por algún autor de mods.",
			message = "nUI: Ejecución de perfiles ha sido %s", -- enabled or disabled
		},
	};
	
	nUI_L["round"]  = "redondo";
	nUI_L["square"] = "cuadrado";
	
	nUI_L["health remaining"] = "|cFF00FF00salud restante|r";
	nUI_L["health lost"]      = "|cFFFF0000salud perdida|r";
	
	-- these strings are the optional arguments to their respective commands and can be 
	-- translated to make sense in the local language
	
	nUI_L[nUI_SLASHCMD_OPTIONS( nUI_SLASHCMD_CLOCK, "server" )] = "server";
	nUI_L[nUI_SLASHCMD_OPTIONS( nUI_SLASHCMD_CLOCK, "local" )]  = "local";
	nUI_L[nUI_SLASHCMD_OPTIONS( nUI_SLASHCMD_CLOCK, "both" )]   = "both";
	
	nUI_L[nUI_SLASHCMD_OPTIONS( nUI_SLASHCMD_RAIDSORT, "unit" )]  = "unit";
	nUI_L[nUI_SLASHCMD_OPTIONS( nUI_SLASHCMD_RAIDSORT, "group" )] = "group";
	nUI_L[nUI_SLASHCMD_OPTIONS( nUI_SLASHCMD_RAIDSORT, "class" )] = "class";
	nUI_L[nUI_SLASHCMD_OPTIONS( nUI_SLASHCMD_RAIDSORT, "name" )]  = "name";
	
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
	
	nUI_L["The value [ %s ] is not a valid nUI slash command. Try [ /nui help ] for a list of commands"] = "El valor [ |cFFFFC000%s|r ] no es un comando de consola válido de nUI. Prueba [ |cFF00FFFF/nui help|r ] para obtener una lista de los comandos disponibles";
	nUI_L["nUI currently supports the following list of slash commands..."]	= "nUI actualmente soporta la siguiente lista de comandos de consola..."; 
	nUI_L["The '/nui %s' slash command currently supports the following list of sub-commands..."] = "El comando de consola '|cFF00FFFF/nui %s|r' actualmente soporta la siguiente lista de subcomandos...";
	nUI_L["nUI: [ %s ] is not a valid tooltip settings option... please choose from %s, %s, %s or %s"] = "nUI: [ |cFFFFC0C0%s|r ] no es una opción válida para la configuración del tooltip... por favor selecciona entre |cFF00FFFF%s|r, |cFF00FFFF%s|r, |cFF00FFFF%s|r o |cFF00FFFF%s|r";
	nUI_L["nUI: [ %s ] is not a valid console visibility option... please choose from %s, %s or %s"] = "nUI: [ |cFFFFC0C0%s|r ] no es un opción de visibilidad de consola válida... por favor escoje de |cFF00FFFF%s|r, |cFF00FFFF%s|r o |cFF00FFFF%s|r";
	nUI_L["nUI: [ %s ] is not a valid alpha value... please choose choose a number between 0 and 1 where 0 is fully transparent and 1 is fully opaque."] = "nUI: [ |cFFFFC0C0%s|r ] no es un valor alpha válido... por favor escoge un número entre 0 y 1 donde 0 es completamente transparente y 1 es completamente opaco.";
	nUI_L["nUI: [ %s ] is not a valid horizontal gap value... please choose choose a number between 1 and 1200 where 1 is very narrow and 1200 is very wide."] = "nUI: [ |cFFFFC0C0%s|r ] no es una valor de brecha horizontal válido... por favor escoge una valor entre 1 y 1200 donde 1 es muy estrecho y 1200 muy ancho.";
	nUI_L["nUI: [ %s ] is not a valid clock option... please choose either 'local' to display the local time, 'server' to display the server time or 'both' to display both times."] = "nUI: [ %s ] no es una opción válida de reloj... por favor escoje entre 'local' para ver hora local, 'server' para ver hora servidor o 'both' para ver ambas.";
	nUI_L["nUI: [ %s ] is not a valid feedback option... please choose either <curse>, <disease>, <magic> or <poison>"] = "nUI: [ %s ] no es una opción de reacción válida... por favor escoge entre '%s', '%s', '%s' o '%s'";
	nUI_L["nUI: [ %s ] is not a valid raid sorting option... please choose either <unit>, <group> or <class>"] = "nUI: [ %s ] is not a valid raid sorting option... please choose either '%s', '%s' or '%s'";
	nUI_L["nUI: [ %s ] is not a valid special mount indicator display scale. The scale must be a number between 0.5 and 1.5"] = "nUI: [ %s ] is not a valid special mount indicator display scale. The scale must be a number between 0.5 and 1.5";
	
end
