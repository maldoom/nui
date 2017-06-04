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

Перевод на русский язык выполнил: Владислав Колосов, Ростов-на-Дону, Россия (2009).
Обновил: StingerSoft, Литва, Вильнюс

--]]---------------------------------------------------------------------------

if nUI_Locale == "ruRU" then

--	nUI_L["font1"] = "Interface\\AddOns\\nUI\\Layouts\\Default\\Fonts\\ABF.ttf";
--	nUI_L["font1"] = "Interface\\AddOns\\nUI\\Layouts\\Default\\Fonts\\Accidental Presidency.ttf";
--	nUI_L["font1"] = "Interface\\AddOns\\nUI\\Layouts\\Default\\Fonts\\Adventure.ttf";
--	nUI_L["font1"] = "Interface\\AddOns\\nUI\\Layouts\\Default\\Fonts\\Bazooka.ttf";
--	nUI_L["font1"] = "Interface\\AddOns\\nUI\\Layouts\\Default\\Fonts\\Emblem.ttf";
--	nUI_L["font1"] = "Interface\\AddOns\\nUI\\Layouts\\Default\\Fonts\\Enigma__2.ttf";
--	nUI_L["font1"] = "Interface\\AddOns\\nUI\\Layouts\\Default\\Fonts\\Tw_Cen_MT_Bold.ttf";
--	nUI_L["font1"] = "Interface\\AddOns\\nUI\\Layouts\\Default\\Fonts\\VeraSe.ttf";
	nUI_L["font1"] = "Fonts\\ARIALN.TTF";

	nUI_L["font2"] = "Fonts\\FRIZQT__.TTF";
--	nUI_L["font2"] = "Interface\\AddOns\\nUI\\Layouts\\Default\\Fonts\\Emblem.ttf";
	
	nUI_L["Welcome back to %s, %s..."] = "Добро пожаловать в %s, %s...";
	nUI_L["nUI %s version %s is loaded!"] = "nUI %s версия %s загружена!";
	nUI_L["Type '/nui' for a list of available nUI commands."] = "Наберите '/nui' для просмотра команд nUI.";

	-- splash frame strings

	nUI_L["splash title"] = "Данные |3-3(%s) обновлены до nUI %s %s";
	nUI_L["splash info"]  = "Для просмотра руководства пользователя, галерей, последних загрузок, часто задаваемых вопросов об nUI, форумов технической поддержки или для внесения добровольных пожертвований в поддержку nUI зайдите на |cFF00FFFFhttp://www.nUIaddon.com|r";
	nUI_L["plus info"]    = "У Вас функционирует nUI 'выпуск' версии ... Также существует 'nUI+' которая включает рейд на 15, 20, 25, 40 персонажей и другие возможности. Информация находится на |cFF00FFFFhttp://www.nUIaddon.com/plus.html|r.";

	-- clock strings

	nUI_L["am"] = "am";
	nUI_L["pm"] = "pm";
	nUI_L["<hour>:<minute><suffix>"] = "%d:%02d%s";
	nUI_L["<hour>:<minute>"] = "%02d:%02d";
	nUI_L["(S) <hour>:<minute><suffix> - <hour>:<minute><suffix> (L)"] = "(S) %d:%02d%s - %d:%02d%s (L)";
	nUI_L["(S) <hour>:<minute> - <hour>:<minute> (L)"] = "(S) %02d:%02d - %02d:%02d (L)";

	-- state strings

	nUI_L["|cFF00FF00ENABLED|r"]  = "|cFF00FF00ВКЛЮЧЕНО|r";
	nUI_L["|cFFFF0000DISABLED|r"] = "|cFFFF0000ВЫКЛЮЧЕНО|r";
	nUI_L["~INTERRUPTED~"]        = "~ПРЕРВАНО~";
	nUI_L["~FAILED~"]             = "~НЕУДАЧНО~";
	nUI_L["~MISSED~"]             = "~ОТСУТСТВ.~";
	nUI_L["OFFLINE"]              = "ВНЕ СЕТИ";
	nUI_L["DND"]                  = "ЗАНЯТ";
	nUI_L["AFK"]                  = "ОТОШЕЛ";
	nUI_L["DEAD"]                 = "МЁРТВ";
	nUI_L["GHOST"]                = "ПРИЗРАК";
	nUI_L["FD"]                   = "Притв.Мертв.";
	nUI_L["TAXI"]                 = "ТАКСИ";
	nUI_L["OOR"]				  = "ДАЛЕКО";
	
	-- power types

	nUI_L["HEALTH"]      = "Здоровье";	
	nUI_L["MANA"]        = "Мана";
	nUI_L["RAGE"]        = "Ярость";
	nUI_L["FOCUS"]       = "Тонус";
	nUI_L["ENERGY"]      = "Энергия";
	nUI_L["RUNES"]       = "Руны";
	nUI_L["RUNIC_POWER"] = "Сила рун";
	nUI_L["AMMO"]        = "Боеприпасы"; -- vehicles
	nUI_L["FUEL"]        = "Топливо"; -- vehicles

	-- time remaining (cooldowns, buffs, etc.)

	nUI_L["TimeLeftInHours"]   = "%0.0fh";
	nUI_L["TimeLeftInMinutes"] = "%0.0fm";
	nUI_L["TimeLeftInSeconds"] = "%0.0fs";
	nUI_L["TimeLeftInTenths"]  = "%0.1fs";

	-- raid and party role tooltip strings

	nUI_L["Party Role: |cFF00FFFF%s|r"] = "Групповой бросок костей: |cFF00FFFF%s|r";
	nUI_L["Raid Role: |cFF00FFFF%s|r"]  = "Рейд бросок костей: |cFF00FFFF%s|r";
	nUI_L["Raid Leader"]                = "Лидер рейда";
	nUI_L["Party Leader"]               = "Лидер группы";
	nUI_L["Raid Assistant"]             = "Помощник лидера";
	nUI_L["Main Tank"]                  = "Главный танк";
	nUI_L["Off-Tank"]                   = "Помощник танка";
	nUI_L["Master Looter"]              = "Делит добычу";

	-- hunter pet feeder strings

	nUI_L[nUI_FOOD_MEAT]   = "Мясо";   -- do not edit this line
	nUI_L[nUI_FOOD_FISH]   = "Рыба";   -- do not edit this line
	nUI_L[nUI_FOOD_BREAD]  = "Хлеб";   -- do not edit this line
	nUI_L[nUI_FOOD_CHEESE] = "Сыр";    -- do not edit this line
	nUI_L[nUI_FOOD_FRUIT]  = "Фрукты"; -- do NOT edit this line
	nUI_L[nUI_FOOD_FUNGUS] = "Грибы";  -- do NOT edit htis line

	nUI_L["Click to feed %s"]           = "Щёлкните, чтобы накормить |3-3(%s)";
	nUI_L["Click to cancel feeding"]    = "Щёлкните для отмены кормления";
	nUI_L["nUI: %s can eat %s%s%s"]     = "nUI: %s может есть %s%s%s";
	nUI_L[" or "]                       = " или ";
	nUI_L["nUI: You don't have a pet!"] = "nUI: У вас нет питомца!";

	nUI_L["nUI: You can feed %s the following...\n"] = "nUI: Вы можете кормить |3-3(%s) следующим...\n";
	nUI_L["nUI: You have nothing you can feed %s in your current inventory"] = "nUI: У Вас нет подходящего корма для |3-3(%s) в инвентаре";

	-- status bar strings

	nUI_L["nUI: Cannot change status bar config while in combat!"] = "nUI: Невозможно изменить конфигурацию строки состояния во время боя!";
	nUI_L["nUI: [%s] is not a valid option for orienting a status bar... use LEFT, RIGHT, TOP or BOTTOM"] = "nUI: [%s] не является верным для выбора положения строки состояния... Используйте ЛЕВО, ПРАВО, ВЕРХ или НИЗ";
	nUI_L["nUI: Can not change status bar overlays while in combat!"] = "nUI: Невозможно изменить оверлеи строки состояния во время боя!";
	nUI_L["nUI: The maximum value (%d) of a status bar must be greater than the minimum value (%d)"] = "nUI: Максимальное значение (%d) строки состояния должно быть больше, чем минимальное (%d)";

	-- information panel strings

	nUI_L["Minimap"] = "Мини-карта";

	nUI_L[nUI_INFOPANEL_COMBATLOG]      		= "Инфопанель: Режим отображения журнала сражения";
	nUI_L[nUI_INFOPANEL_COMBATLOG.."Label"]		= "Бой";

	nUI_L[nUI_INFOPANEL_BMM]		      		= "Инфопанель: Режим мини-карты ПоляБоя";
	nUI_L[nUI_INFOPANEL_BMM.."Label"]			= "Карта";

	nUI_L[nUI_INFOPANEL_RECOUNT]		   		= "Инфопанель: Режим дополнения Recount";
	nUI_L[nUI_INFOPANEL_RECOUNT.."Label"]		= "Recount";

	nUI_L[nUI_INFOPANEL_OMEN3]		      		= "Инфопанель: Режим дополнения Omen3";
	nUI_L[nUI_INFOPANEL_OMEN3.."Label"]			= "Omen3";
	
	nUI_L[nUI_INFOPANEL_SKADA]		      		= "Инфопанель: Режим дополнения Skada - урон/угроза";
	nUI_L[nUI_INFOPANEL_SKADA.."Label"]			= "Skada";

	nUI_L[nUI_INFOPANEL_OMEN3KLH]	      		= "Инфопанель: Omen3 + KLH";
	nUI_L[nUI_INFOPANEL_OMEN3KLH.."Label"]		= "Угроза";

	nUI_L[nUI_INFOPANEL_KLH]		      		= "Инфопанель: режим KLH Threat Meter";
	nUI_L[nUI_INFOPANEL_KLH.."Label"]			= "KTM";

	nUI_L[nUI_INFOPANEL_KLHRECOUNT]	      		= "Инфопанель: режим KLH Threat + Recount";
	nUI_L[nUI_INFOPANEL_KLHRECOUNT.."Label"]	= "KTM+";

	nUI_L["nUI: You need to go to the WoW Interface menu, select the 'Social' option and turn off the 'Simple Chat' menu option to enable integrated combat log support in nUI."] = "nUI: Вам нужно открыть главное меню, нажать кнопку 'Интерфейс', выбрать 'Общение' и отключить выбор 'Обычное общение', для включения поддержки интегрированного журнала боя модификацыей nUI.";
	nUI_L["The %s Info Panel plugin is a core plugin to nUI and cannot be disabled"] = "Расширение инфопанели %s является ключевой в nUI и не может быть отключена";
	nUI_L["Click to change information panels"] = "Щёлкните, чтобы изменить информационные панели";
	nUI_L["nUI: Cannot initialize the Info Panel plugin [ %s ] -- it does not have an initPanel() interface method"] = "nUI: Невозможно инициализировать Инфопанель [ |cFF00FFFF%s|r ] -- отсутствует метод интерфейса initPanel()";
	nUI_L["nUI: Cannot initialize the Info Panel plugin [ %s ] -- No global object by that name exists"] = "nUI: Невозможно инициализировать Инфопанель [ |cFF00FFFF%s|r ] -- Отсутствует глобальный объект с таким именем";
	nUI_L["nUI: Cannot select the Info Panel plugin [ %s ] -- it does not have a setSelected() interface method"] = "nUI: Невозможно выбрать расширение Инфопанели [ |cFF00FFFF%s|r ] -- отсутствует метод интерфейса  setSelected()";

	-- HUD layout strings (heads up display)

	nUI_L["Click to change HUD layouts"] = "Щелкните чтобы изменить компоновки HUD";

	nUI_L[nUI_HUDLAYOUT_PLAYERTARGET]	   		= "Компоновка HUD: Игрок слева / Цель справа";
	nUI_L[nUI_HUDLAYOUT_PLAYERTARGET.."Label"]	= "Игрок/Цель";

	nUI_L[nUI_HUDLAYOUT_HEALTHPOWER]	   		= "Компоновка HUD: Здоровье слева / Энергия справа";
	nUI_L[nUI_HUDLAYOUT_HEALTHPOWER.."Label"]	= "Здоровье/Энергия";

	nUI_L[nUI_HUDLAYOUT_SIDEBYSIDE]	   			= "Компоновка HUD: Бок о бок горизонтальные полосы";
	nUI_L[nUI_HUDLAYOUT_SIDEBYSIDE.."Label"]	= "Бок о бок";

	nUI_L[nUI_HUDLAYOUT_NOBARS]	   				= "Компоновка HUD: Простой HUD (без полос)";
	nUI_L[nUI_HUDLAYOUT_NOBARS.."Label"]		= "Простой HUD";

	nUI_L[nUI_HUDLAYOUT_NOHUD]		   			= "Компоновка HUD: Отключено (без HUD)";
	nUI_L[nUI_HUDLAYOUT_NOHUD.."Label"]			= "Без HUD";

	nUI_L[nUI_HUDMODE_PLAYERTARGET]         = "nUI режим HUD Игрок/Цель";
	nUI_L[nUI_HUDSKIN_PLAYERTARGET_PET]     = nUI_L[nUI_HUDMODE_PLAYERTARGET]..": обложка для отображения данных питомца";
	nUI_L[nUI_HUDSKIN_PLAYERTARGET_CASTBAR] = nUI_L[nUI_HUDMODE_PLAYERTARGET]..": обложка для отображения полоски заклинаний игрока";
	nUI_L[nUI_HUDSKIN_PLAYERTARGET_PLAYER]  = nUI_L[nUI_HUDMODE_PLAYERTARGET]..": обложка для отображения данных игрока";
	nUI_L[nUI_HUDSKIN_PLAYERTARGET_TARGET]  = nUI_L[nUI_HUDMODE_PLAYERTARGET]..": обложка для отображения данных цели";
	nUI_L[nUI_HUDSKIN_PLAYERTARGET_TOT]     = nUI_L[nUI_HUDMODE_PLAYERTARGET]..": обложка для отображения данных цель цели (ToT)";

	nUI_L[nUI_HUDMODE_HEALTHPOWER]         = "nUI режим HUD Здоровье/Энергия";
	nUI_L[nUI_HUDSKIN_HEALTHPOWER_PET]     = nUI_L[nUI_HUDMODE_HEALTHPOWER]..": обложка для отображения данных питомца";
	nUI_L[nUI_HUDSKIN_HEALTHPOWER_CASTBAR] = nUI_L[nUI_HUDMODE_HEALTHPOWER]..": обложка для отображения полоски заклинаний игрока";
	nUI_L[nUI_HUDSKIN_HEALTHPOWER_PLAYER]  = nUI_L[nUI_HUDMODE_HEALTHPOWER]..": обложка для отображения данных игрока";
	nUI_L[nUI_HUDSKIN_HEALTHPOWER_TARGET]  = nUI_L[nUI_HUDMODE_HEALTHPOWER]..": обложка для отображения данных цели";
	nUI_L[nUI_HUDSKIN_HEALTHPOWER_TOT]     = nUI_L[nUI_HUDMODE_HEALTHPOWER]..": обложка для отображения данных цель цели (ToT)";
	
	nUI_L[nUI_HUDMODE_SIDEBYSIDE]          = "nUI режим HUD Бок о бок";
	nUI_L[nUI_HUDSKIN_SIDEBYSIDE_PET]      = nUI_L[nUI_HUDMODE_SIDEBYSIDE]..": обложка для отображения данных питомца";
	nUI_L[nUI_HUDSKIN_SIDEBYSIDE_CASTBAR]  = nUI_L[nUI_HUDMODE_SIDEBYSIDE]..": обложка для отображения полоски заклинаний игрока";
	nUI_L[nUI_HUDSKIN_SIDEBYSIDE_PLAYER]   = nUI_L[nUI_HUDMODE_SIDEBYSIDE]..": обложка для отображения данных игрока";
	nUI_L[nUI_HUDSKIN_SIDEBYSIDE_TARGET]   = nUI_L[nUI_HUDMODE_SIDEBYSIDE]..": обложка для отображения данных цели";
	nUI_L[nUI_HUDSKIN_SIDEBYSIDE_TOT]      = nUI_L[nUI_HUDMODE_SIDEBYSIDE]..": обложка для отображения данных цель цели (ToT)";
	
	nUI_L[nUI_HUDMODE_NOBARS]              = "nUI Простой режим HUD";
	nUI_L[nUI_HUDSKIN_NOBARS_CASTBAR]      = nUI_L[nUI_HUDMODE_NOBARS]..": обложка для отображения полоски заклинаний игрока";
	nUI_L[nUI_HUDSKIN_NOBARS_PLAYER]       = nUI_L[nUI_HUDMODE_NOBARS]..": обложка для отображения данных игрока";
	nUI_L[nUI_HUDSKIN_NOBARS_TARGET]       = nUI_L[nUI_HUDMODE_NOBARS]..": обложка для отображения данных цели";

	-- nUI_Unit strings

	nUI_L["Pet"]        = "Питомец";
	nUI_L["Target"]     = "Цель";
	nUI_L["Range"]      = "До цели";
	nUI_L["MELEE"]      = "РУКОПАШНАЯ";
	nUI_L["Elite"]      = "Элита";    
	nUI_L["Rare"]       = "Редкий";    
	nUI_L["Rare Elite"] = "Редкий Элита";
	nUI_L["World Boss"] = "Мировой Босс";
	nUI_L["Vehicle"]    = "Транспорт";   

	nUI_L["unit: player"]             = "Игрок";
	nUI_L["unit: vehicle"]            = "Транспорт игрока";
	nUI_L["unit: pet"]		          = "Питомец игрока";
	nUI_L["unit: pettarget"]          = "Цель питомца игрока";
	nUI_L["unit: focus"]              = "Фокус игрока";
	nUI_L["unit: focustarget"]        = "Цель фокуса игрока";
	nUI_L["unit: target"]             = "Цель игрока";
	nUI_L["unit: %s-target"]          = "Цель %s";
	nUI_L["unit: mouseover"]          = "Под мышью";
	nUI_L["unit: targettarget"]       = "Цель цели (ToT)";
	nUI_L["unit: targettargettarget"] = "Цель ToT (ToTT)";
	nUI_L["unit: party%d"]            = "Участник группы %d";
	nUI_L["unit: party%dpet"]         = "Питомец участника группы %d";
	nUI_L["unit: party%dtarget"]      = "Цель участника группы %d";
	nUI_L["unit: party%dpettarget"]   = "Цель питомца участника группы %d";
	nUI_L["unit: raid%d"]             = "Участник рейда %d";
	nUI_L["unit: raid%dpet"]          = "Питомец участника рейда %d";
	nUI_L["unit: raid%dtarget"]       = "Цель участника рейда %d";
	nUI_L["unit: raid%dpettarget"]    = "Цель питомца участника рейда %d";

	nUI_L[nUI_UNITMODE_PLAYER]        = "nUI Режим одиночного игрока";
	nUI_L[nUI_UNITSKIN_SOLOFOCUS]     = nUI_L[nUI_UNITMODE_PLAYER]..": обложка фокуса игрока";
	nUI_L[nUI_UNITSKIN_SOLOMOUSE]     = nUI_L[nUI_UNITMODE_PLAYER]..": обложка цели под мышью";
	nUI_L[nUI_UNITSKIN_SOLOVEHICLE]   = nUI_L[nUI_UNITMODE_PLAYER]..": обложка транспорта";
	nUI_L[nUI_UNITSKIN_SOLOPET]       = nUI_L[nUI_UNITMODE_PLAYER]..": обложка питомца игрока";
	nUI_L[nUI_UNITSKIN_SOLOPETBUTTON] = nUI_L[nUI_UNITMODE_PLAYER]..": обложка кнопки нацеливания питомца... т.е. питомец игрока, питомец фокуса игрока и т.д.";
	nUI_L[nUI_UNITSKIN_SOLOPLAYER]    = nUI_L[nUI_UNITMODE_PLAYER]..": обложка игрока";
	nUI_L[nUI_UNITSKIN_SOLOTARGET]    = nUI_L[nUI_UNITMODE_PLAYER]..": обложка цели";
	nUI_L[nUI_UNITSKIN_SOLOTGTBUTTON] = nUI_L[nUI_UNITMODE_PLAYER]..": обложка кнопки нацеливания цели... т.е. цель фокуса игрока и т.д.";
	nUI_L[nUI_UNITSKIN_SOLOTOT]       = nUI_L[nUI_UNITMODE_PLAYER]..": обложка цель цели (ToT)";

	nUI_L[nUI_UNITMODE_PARTY]          = "nUI Режим группы";
	nUI_L[nUI_UNITSKIN_PARTYFOCUS]     = nUI_L[nUI_UNITMODE_PARTY]..": обложка фокуса игрока";
	nUI_L[nUI_UNITSKIN_PARTYMOUSE]     = nUI_L[nUI_UNITMODE_PARTY]..": обложка цели под мышью";
	nUI_L[nUI_UNITSKIN_PARTYVEHICLE]   = nUI_L[nUI_UNITMODE_PARTY]..": обложка транспорта";
	nUI_L[nUI_UNITSKIN_PARTYPLAYER]    = nUI_L[nUI_UNITMODE_PARTY]..": обложка игрока";
	nUI_L[nUI_UNITSKIN_PARTYPET]       = nUI_L[nUI_UNITMODE_PARTY]..": обложка питомца игрока";
	nUI_L[nUI_UNITSKIN_PARTYTARGET]    = nUI_L[nUI_UNITMODE_PARTY]..": обложка цели";
	nUI_L[nUI_UNITSKIN_PARTYTOT]       = nUI_L[nUI_UNITMODE_PARTY]..": обложка цель цели (ToT)";
	nUI_L[nUI_UNITSKIN_PARTYFOCUS]     = nUI_L[nUI_UNITMODE_PARTY]..": обложка фокуса игрока";
	nUI_L[nUI_UNITSKIN_PARTYLEFT]      = nUI_L[nUI_UNITMODE_PARTY]..": обложка участника группы слева";
	nUI_L[nUI_UNITSKIN_PARTYRIGHT]     = nUI_L[nUI_UNITMODE_PARTY]..": обложка участника группы справа";
	nUI_L[nUI_UNITSKIN_PARTYPETBUTTON] = nUI_L[nUI_UNITMODE_PARTY]..": обложка кнопки участника группы и питомца фокуса";
	nUI_L[nUI_UNITSKIN_PARTYTGTBUTTON] = nUI_L[nUI_UNITMODE_PARTY]..": обложка кнопки участника группы фокуса цели";
	nUI_L[nUI_UNITSKIN_PARTYMOUSE]     = nUI_L[nUI_UNITMODE_PARTY]..": обложка цели под мышью";

	nUI_L[nUI_UNITMODE_RAID10]          ="nUI Режим рейда х10";
	nUI_L[nUI_UNITSKIN_RAID10FOCUS]     = nUI_L[nUI_UNITMODE_RAID10]..": обложка фокуса игрока";
	nUI_L[nUI_UNITSKIN_RAID10MOUSE]     = nUI_L[nUI_UNITMODE_RAID10]..": обложка цели под мышью";
	nUI_L[nUI_UNITSKIN_RAID10VEHICLE]   = nUI_L[nUI_UNITMODE_RAID10]..": обложка транспорта";
	nUI_L[nUI_UNITSKIN_RAID10PLAYER]    = nUI_L[nUI_UNITMODE_RAID10]..": обложка игрока";
	nUI_L[nUI_UNITSKIN_RAID10PET]       = nUI_L[nUI_UNITMODE_RAID10]..": обложка питомца игрока";
	nUI_L[nUI_UNITSKIN_RAID10TARGET]    = nUI_L[nUI_UNITMODE_RAID10]..": обложка цели";
	nUI_L[nUI_UNITSKIN_RAID10TOT]       = nUI_L[nUI_UNITMODE_RAID10]..": обложка цель цели (ToT)";
	nUI_L[nUI_UNITSKIN_RAID10FOCUS]     = nUI_L[nUI_UNITMODE_RAID10]..": обложка фокуса игрока";
	nUI_L[nUI_UNITSKIN_RAID10LEFT]      = nUI_L[nUI_UNITMODE_RAID10]..": обложка участника рейда слева";
	nUI_L[nUI_UNITSKIN_RAID10RIGHT]     = nUI_L[nUI_UNITMODE_RAID10]..": обложка участника рейда справа";
	nUI_L[nUI_UNITSKIN_RAID10PETBUTTON] = nUI_L[nUI_UNITMODE_RAID10]..": обложка кнопки участника рейда и питомца фокуса";
	nUI_L[nUI_UNITSKIN_RAID10TGTBUTTON] = nUI_L[nUI_UNITMODE_RAID10]..": обложка кнопки участника рейда фокуса цели";
	nUI_L[nUI_UNITSKIN_RAID10MOUSE]     = nUI_L[nUI_UNITMODE_RAID10]..": обложка цели под мышью";

	nUI_L[nUI_UNITMODE_RAID15]          ="nUI Режим рейда х15";
	nUI_L[nUI_UNITSKIN_RAID15FOCUS]     = nUI_L[nUI_UNITMODE_RAID15]..": обложка фокуса игрока";
	nUI_L[nUI_UNITSKIN_RAID15MOUSE]     = nUI_L[nUI_UNITMODE_RAID15]..": обложка цели под мышью";
	nUI_L[nUI_UNITSKIN_RAID15VEHICLE]   = nUI_L[nUI_UNITMODE_RAID15]..": обложка транспорта";
	nUI_L[nUI_UNITSKIN_RAID15PLAYER]    = nUI_L[nUI_UNITMODE_RAID15]..": обложка игрока";
	nUI_L[nUI_UNITSKIN_RAID15PET]       = nUI_L[nUI_UNITMODE_RAID15]..": обложка питомца игрока";
	nUI_L[nUI_UNITSKIN_RAID15TARGET]    = nUI_L[nUI_UNITMODE_RAID15]..": обложка цели";
	nUI_L[nUI_UNITSKIN_RAID15TOT]       = nUI_L[nUI_UNITMODE_RAID15]..": обложка цель цели (ToT)";
	nUI_L[nUI_UNITSKIN_RAID15FOCUS]     = nUI_L[nUI_UNITMODE_RAID15]..": обложка фокуса игрока";
	nUI_L[nUI_UNITSKIN_RAID15LEFT]      = nUI_L[nUI_UNITMODE_RAID15]..": обложка участника рейда слева";
	nUI_L[nUI_UNITSKIN_RAID15RIGHT]     = nUI_L[nUI_UNITMODE_RAID15]..": обложка участника рейда справа";
	nUI_L[nUI_UNITSKIN_RAID15PETBUTTON] = nUI_L[nUI_UNITMODE_RAID15]..": обложка кнопки участника рейда и питомца фокуса";
	nUI_L[nUI_UNITSKIN_RAID15TGTBUTTON] = nUI_L[nUI_UNITMODE_RAID15]..": обложка кнопки участника рейда фокуса цели";
	nUI_L[nUI_UNITSKIN_RAID15MOUSE]     = nUI_L[nUI_UNITMODE_RAID15]..": обложка цели под мышью";

	nUI_L[nUI_UNITMODE_RAID20]          ="nUI Режим рейда х20";
	nUI_L[nUI_UNITSKIN_RAID20FOCUS]     = nUI_L[nUI_UNITMODE_RAID20]..": обложка фокуса игрока";
	nUI_L[nUI_UNITSKIN_RAID20MOUSE]     = nUI_L[nUI_UNITMODE_RAID20]..": обложка цели под мышью";
	nUI_L[nUI_UNITSKIN_RAID20VEHICLE]   = nUI_L[nUI_UNITMODE_RAID20]..": обложка транспорта";
	nUI_L[nUI_UNITSKIN_RAID20PLAYER]    = nUI_L[nUI_UNITMODE_RAID20]..": обложка игрока";
	nUI_L[nUI_UNITSKIN_RAID20PET]       = nUI_L[nUI_UNITMODE_RAID20]..": обложка питомца игрока";
	nUI_L[nUI_UNITSKIN_RAID20TARGET]    = nUI_L[nUI_UNITMODE_RAID20]..": обложка цели";
	nUI_L[nUI_UNITSKIN_RAID20TOT]       = nUI_L[nUI_UNITMODE_RAID20]..": обложка цель цели (ToT)";
	nUI_L[nUI_UNITSKIN_RAID20FOCUS]     = nUI_L[nUI_UNITMODE_RAID20]..": обложка фокуса игрока";
	nUI_L[nUI_UNITSKIN_RAID20LEFT]      = nUI_L[nUI_UNITMODE_RAID20]..": обложка участника рейда слева";
	nUI_L[nUI_UNITSKIN_RAID20RIGHT]     = nUI_L[nUI_UNITMODE_RAID20]..": обложка участника рейда справа";
	nUI_L[nUI_UNITSKIN_RAID20PETBUTTON] = nUI_L[nUI_UNITMODE_RAID20]..": обложка кнопки участника рейда и питомца фокуса";
	nUI_L[nUI_UNITSKIN_RAID20TGTBUTTON] = nUI_L[nUI_UNITMODE_RAID20]..": обложка кнопки участника рейда фокуса цели";
	nUI_L[nUI_UNITSKIN_RAID20MOUSE]     = nUI_L[nUI_UNITMODE_RAID20]..": обложка цели под мышью";

	nUI_L[nUI_UNITMODE_RAID25]          ="nUI Режим рейда х25";
	nUI_L[nUI_UNITSKIN_RAID25FOCUS]     = nUI_L[nUI_UNITMODE_RAID25]..": обложка фокуса игрока";
	nUI_L[nUI_UNITSKIN_RAID25MOUSE]     = nUI_L[nUI_UNITMODE_RAID25]..": обложка цели под мышью";
	nUI_L[nUI_UNITSKIN_RAID25VEHICLE]   = nUI_L[nUI_UNITMODE_RAID25]..": обложка транспорта";
	nUI_L[nUI_UNITSKIN_RAID25PLAYER]    = nUI_L[nUI_UNITMODE_RAID25]..": обложка игрока";
	nUI_L[nUI_UNITSKIN_RAID25PET]       = nUI_L[nUI_UNITMODE_RAID25]..": обложка питомца игрока";
	nUI_L[nUI_UNITSKIN_RAID25TARGET]    = nUI_L[nUI_UNITMODE_RAID25]..": обложка цели";
	nUI_L[nUI_UNITSKIN_RAID25TOT]       = nUI_L[nUI_UNITMODE_RAID25]..": обложка цель цели (ToT)";
	nUI_L[nUI_UNITSKIN_RAID25FOCUS]     = nUI_L[nUI_UNITMODE_RAID25]..": обложка фокуса игрока";
	nUI_L[nUI_UNITSKIN_RAID25LEFT]      = nUI_L[nUI_UNITMODE_RAID25]..": обложка участника рейда слева";
	nUI_L[nUI_UNITSKIN_RAID25RIGHT]     = nUI_L[nUI_UNITMODE_RAID25]..": обложка участника рейда справа";
	nUI_L[nUI_UNITSKIN_RAID25PETBUTTON] = nUI_L[nUI_UNITMODE_RAID25]..": обложка кнопки участника рейда и питомца фокуса";
	nUI_L[nUI_UNITSKIN_RAID25TGTBUTTON] = nUI_L[nUI_UNITMODE_RAID25]..": обложка кнопки участника рейда фокуса цели";
	nUI_L[nUI_UNITSKIN_RAID25MOUSE]     = nUI_L[nUI_UNITMODE_RAID25]..": обложка цели под мышью";

	nUI_L[nUI_UNITMODE_RAID40]          ="nUI Режим рейда х40";
	nUI_L[nUI_UNITSKIN_RAID40FOCUS]     = nUI_L[nUI_UNITMODE_RAID40]..": обложка фокуса игрока";
	nUI_L[nUI_UNITSKIN_RAID40MOUSE]     = nUI_L[nUI_UNITMODE_RAID40]..": обложка цели под мышью";
	nUI_L[nUI_UNITSKIN_RAID40VEHICLE]   = nUI_L[nUI_UNITMODE_RAID40]..": обложка транспорта";
	nUI_L[nUI_UNITSKIN_RAID40PLAYER]    = nUI_L[nUI_UNITMODE_RAID40]..": обложка игрока";
	nUI_L[nUI_UNITSKIN_RAID40PET]       = nUI_L[nUI_UNITMODE_RAID40]..": обложка питомца игрока";
	nUI_L[nUI_UNITSKIN_RAID40TARGET]    = nUI_L[nUI_UNITMODE_RAID40]..": обложка цели";
	nUI_L[nUI_UNITSKIN_RAID40TOT]       = nUI_L[nUI_UNITMODE_RAID40]..": обложка цель цели (ToT)";
	nUI_L[nUI_UNITSKIN_RAID40FOCUS]     = nUI_L[nUI_UNITMODE_RAID40]..": обложка фокуса игрока";
	nUI_L[nUI_UNITSKIN_RAID40LEFT]      = nUI_L[nUI_UNITMODE_RAID40]..": обложка участника рейда слева";
	nUI_L[nUI_UNITSKIN_RAID40RIGHT]     = nUI_L[nUI_UNITMODE_RAID40]..": обложка участника рейда справа";
	nUI_L[nUI_UNITSKIN_RAID40PETBUTTON] = nUI_L[nUI_UNITMODE_RAID40]..": обложка кнопки участника рейда и питомца фокуса";
	nUI_L[nUI_UNITSKIN_RAID40TGTBUTTON] = nUI_L[nUI_UNITMODE_RAID40]..": обложка кнопки участника рейда фокуса цели";
	nUI_L[nUI_UNITSKIN_RAID40MOUSE]     = nUI_L[nUI_UNITMODE_RAID40]..": обложка цели под мышью";

	nUI_L[nUI_UNITPANEL_PLAYER]      		= "Панель играков: Режим одиночного игрока";
	nUI_L[nUI_UNITPANEL_PLAYER.."Label"]	= "Игрок";

	nUI_L[nUI_UNITPANEL_PARTY]       		= "Панель играков: Режим группы";
	nUI_L[nUI_UNITPANEL_PARTY.."Label"] 	= "Группа";

	nUI_L[nUI_UNITPANEL_RAID10]      		= "Панель играков: Режим рейда x10";
	nUI_L[nUI_UNITPANEL_RAID10.."Label"]	= "Рейд x10";

	nUI_L[nUI_UNITPANEL_RAID15]      		= "Панель играков: Режим рейда x15";
	nUI_L[nUI_UNITPANEL_RAID15.."Label"]	= "Рейд x15";

	nUI_L[nUI_UNITPANEL_RAID20]      		= "Панель играков: Режим рейда x20";
	nUI_L[nUI_UNITPANEL_RAID20.."Label"]	= "Рейд x20";

	nUI_L[nUI_UNITPANEL_RAID25]      		= "Панель играков: Режим рейда x25";
	nUI_L[nUI_UNITPANEL_RAID25.."Label"]	= "Рейд x25";

	nUI_L[nUI_UNITPANEL_RAID40]      		= "Панель играков: Режим рейда x40";
	nUI_L[nUI_UNITPANEL_RAID40.."Label"]	= "Рейд x40";

	nUI_L["Click to change unit frame panels"] = "Щёлкните чтобы изменить панели играка";

	nUI_L["<unnamed frame>"]   = "<без имени>";
	nUI_L["casting bar"]       = "полоска заклинаний";
	nUI_L["raid group"]        = "рейд группа";
	nUI_L["raid target"]       = "цель рейда";
	nUI_L["ready check"]       = "готовность";
	nUI_L["unit aura"]         = "аура";
	nUI_L["unit change"]       = "изменить";
	nUI_L["unit class"]        = "класс";
	nUI_L["unit combat"]       = "бой";
	nUI_L["unit combo points"] = "длина серии приемов";
	nUI_L["unit feedback"]     = "подсветка";
	nUI_L["unit health"]       = "здоровье";
	nUI_L["unit label"]        = "ярлык";
	nUI_L["unit level"]        = "уровень";
	nUI_L["unit portrait"]     = "портрет";
	nUI_L["unit power"]        = "энергия";
	nUI_L["unit PvP"]          = "PvP";
	nUI_L["unit range"]        = "дистанция";
	nUI_L["unit reaction"]     = "реакция";
	nUI_L["unit resting"]      = "отдых";
	nUI_L["unit role"]         = "роль";
	nUI_L["unit runes"]        = "руны";
	nUI_L["unit spec"]         = "спецификация";
	nUI_L["unit status"]       = "состояние";
	nUI_L["unit threat"]       = "угроза";

	nUI_L["Talent Build: <build name> (<talent points>)"] = "Таланты: |cFF00FFFF%s|r (%s)";
	nUI_L["passed unit id is <nil> in callback table for %s"] = "полученный код персонажа <nil> в таблице обратных вызовов для %s";
	nUI_L["nUI: Warning.. anchoring %s to %s -- anchor point has a <nil> value."] = "nUI: Внимание... Прикрепление %s к %s -- точка прикрепления имеет значение <nil>.";
	nUI_L["nUI: Cannot register %s for scaling... frame does not have a applyScale() method"] = "nUI: Невозможно зарегистрировать %s для масштабирования... Отсутствует метод applyScale().";
	nUI_L["nUI: Cannot register %s for scaling... frame does not have a applyAnchor() method"] = "nUI: Невозможно зарегистрировать %s для масштабирования... Отсутствует метод applyAnchor().";
	nUI_L["nUI: %s %s callback %s does not have a newUnitInfo() method."] = "nUI: %s %s обратный вызов %s не содержит метода newUnitInfo().";
	nUI_L["nUI_UnitClass.lua: unhandled unit class [%s] for [%s]"] = "nUI_UnitClass.lua: класс [%s] не имеет дескриптора для [%s]";
	nUI_L["nUI: click-casting registration is %s"] = "nUI: click-casting регистрация %s";
	nUI_L["nUI: must pass a valid parent frame to nUI_Unit:createFrame() for unit id [%s (%s)]"] = "nUI: необходимо передать правильный фрейм родителя в nUI_Unit:createFrame() для кода персонажа [%s (%s)]";
	nUI_L["nUI says: Gratz for reaching level %d %s!"] = "nUI говорит: Поздравляю с получением уровня %d %s!";
	nUI_L["nUI_Unit: [%s] is not a valid unit frame element type!"] = "nUI_Unit: [%s] является недопустимым типом элемента панели персонажа!";
	nUI_L["nUI_Unit: [%s] is not a known unit skin name!"] = "nUI_Unit: [%s] является не найденным именем обложки!";
	nUI_L["nUI_Unit: [%s] is not a valid raid sorting target frame, it does not have a setUnitID() method"] = "nUI_Unit: [%s] является недопустимой сортировкой рамок целей рейда, в нём отсутствует метод setUnitID()";
	nUI_L["nUI_Unit: [%d] is not a valid raid ID... the raid ID must be between 1 and 40"] = "nUI_Unit: [%d] является недопустимым идентификатором (ID) рейда... рейд идентификатор должен быть от 1 до 40";
		
	-- nUI_Unit hunter pet strings

	nUI_L["Your pet"] = "Ваш питомец";
	nUI_L["quickly"] = "быстро";
	nUI_L["slowly"] = "медленно";
	nUI_L["nUI: %s is happy."] = "nUI: %s счастлив.";
	nUI_L["nUI: %s is unhappy... time to feed!"] = "nUI: %s несчастлив... Время покормить!";
	nUI_L["nUI: Warning! %s is |cFFFFFFFFNOT|r happy! Better feed soon."] = "nUI: Внимание! %s |cFFFFFFFFНЕ|rсчастлив! Покормите его как можно быстрее.";
	nUI_L["nUI: Warning... %s is %s losing loyalty "] = "nUI: Внимание... %s, %s понижается преданность ";
	nUI_L["nUI: %s is %s gaining loyalty"] = "nUI: %s, %s повышается преданность";
	nUI_L["nUI: %s has stopped gaining loyalty"] = "nUI: %s перестал повышаеть преданность";
	nUI_L["nUI: %s has stopped losing loyalty"] = "nUI: %s перестал терять преданность";
	nUI_L["Your pet's current damage bonus is %d%%"] = "Прибавка к ударам питомца %+d%%";
	nUI_L["Your pet's current damage penalty is %d%%"] = "Удары питомца ослаблены на %+d%%";
	nUI_L["nUI: It looks to me like you're a little busy... maybe you should try feeding %s AFTER you leave combat?"] = "nUI: Похоже, что Вы немного заняты... Может, Вы покормите питомца %s ПОСЛЕ сражения?";
	nUI_L["nUI: I looked everywhere, but I couldn't find a pet to feed. Perhaps he's in your backpack?"] = "nUI: Несмотря на тщательные поиски, питомец для кормления рядом не обнаружен. Может быть, он спрятался в рюкзаке?";
	nUI_L["nUI: You know, I could be wrong, but I don't think feeding %s is a very good idea... it doesn't look to me like what you have in your bags is what %s is thinking about eating."] = "nUI: Накормить питомца, несмотря на намерения, не очень хорошая идея... Не похоже, что то, что лежит у Вас в сумках, %s принимает за пищу.";
	
	-- miscelaneous strings

	nUI_L["Version"]                         = "Версия nUI |cFF00FF00%s|r";
	nUI_L["Copyright"]                       = "Авторское право (C) 2008 K. Scott Piel";
	nUI_L["Rights"]                          = "Все права защищены";
	nUI_L["Off Hand Weapon:"]                = "Левая рука:";
	nUI_L["Main Hand Weapon:"]               = "Правая рука:";
	nUI_L["Group %d"]                        = "Группа %d";
	nUI_L["MS"]                              = "МС";
	nUI_L["FPS"]				             = "КВС";
	nUI_L["Minimap Button Bag"]              = "Сумка кнопок мини-карты";
	nUI_L["System Performance Stats..."]     = "Счетчики производительности системы...";
	nUI_L["PvP Time Remaining: <time_left>"] = "Осталось времени PvP: |cFF50FF50%s|r";

	nUI_L["Cursor: <cursor_x,cursor_y>  /  Player: <player_x,player_y>"] = "Курсор: |cFF00FFFF<%0.1f, %0.1f>|r  /  Игрок: |cFF00FFFF<%0.1f, %0.1f>|r";
	nUI_L["nUI has disabled the plugin 'nui_AuraBars' as it is now incorporated in nUI 5.0 -- Please use '/nui rl' to reload the UI. You should uninstall nUI_AuraBars as well."] = "nUI запретил работу дополнения 'nui_AuraBars' поскольку он теперь включен в nUI 5.0 -- Воспользуйтесь '/nui rl' для перезапуска UI. Также Вы должны удалить nUI_AuraBars.";

	-- key binding strings

	nUI_L["HUD Layout"]                  = "Компоновка HUD";
	nUI_L["Unit Panel Mode"]             = "Режим Перспанели";
	nUI_L["Info Panel Mode"]             = "Режим Инфопанели";
	nUI_L["Key Binding"]                 = "Назначение кнопок";
	nUI_L["Miscellaneous Bindings"]      = "Различные назначения";
	nUI_L["No key bindings found"]       = "Не найдено назначений";
	nUI_L["<ctrl-alt-right click> to change bindings"] = "<ctrl-alt-щелчок правой кнопкой> для изменения назначений";

	-- rare spotting strings

	nUI_L["You have spotted a rare mob: |cFF00FF00<mob name>|r<location>"] = "Вы заметили редкое существо: |cFF00FF00%s|r%s";
	nUI_L["You have spotted a rare elite mob: |cFF00FF00<mob name>|r<location>"] = "Вы заметили редкое элитное существо: |cFF00FF00%s|r%s";

	-- faction / reputation bar strings

	nUI_L["Unknown"]    = "Неизвестно";
	nUI_L["Hated"]      = "Ненависть";
	nUI_L["Hostile"]    = "Враждебность";
	nUI_L["Unfriendly"] = "Неприязнь";
	nUI_L["Neutral"]    = "Равнодушие";
	nUI_L["Friendly"]   = "Дружелюбие";
	nUI_L["Honored"]    = "Уважение";
	nUI_L["Revered"]    = "Почтение";
	nUI_L["Exalted"]    = "Превознесение";

	nUI_L["Faction: <faction name>"]    = "Фракция: |cFF00FFFF%s|r";
	nUI_L["Reputation: <rep level>"]    = "Репутация: |cFF00FFFF%s|r";
	nUI_L["Current Rep: <number>"]      = "Текущая реп.: |cFF00FFFF%d|r";
	nUI_L["Required Rep: <number>"]     = "Требуется реп.: |cFF00FFFF%d|r";
	nUI_L["Remaining Rep: <number>"]    = "Осталось реп.: |cFF00FFFF%d|r";
	nUI_L["Percent Complete: <number>"] = "Процент выполнения: |cFF00FFFF%0.1f%%|r";
	nUI_L["<faction name> (<reputation>) <current rep> of <required rep> (<percent complete>)"] = "%s (%s) %d - %d (%0.1f%%)";

	nUI_L[nUI_FACTION_UPDATE_START_STRING]    = "Отношение ";
	nUI_L[nUI_FACTION_UPDATE_END_STRING]      = " к вам улучшилось";
	nUI_L[nUI_FACTION_UPDATE_INCREASE_STRING] = "к вам улучшилось";

	-- player experience bar strings

	nUI_L["Current level: <level>"]                         = "Текущий уровень: |cFF00FFFF%d|r";
	nUI_L["Current XP: <experience points>"]                = "Текущий опыт: |cFF00FFFF%d|r";
	nUI_L["Required XP: <XP required to reach next level>"] = "Требуется опыта: |cFF00FFFF%d|r";
	nUI_L["Remaining XP: <XP remaining to level>"]          = "Осталось опыта: |cFF00FFFF%d|r";
	nUI_L["Percent complete: <current XP / required XP>"]   = "Процент выполнения: |cFF00FFFF%0.1f%%|r";
	nUI_L["Rested XP: <total rested experience> (percent)"] = "Опыта за отдых: |cFF00FFFF%d|r (%0.1f%%)";
	nUI_L["Rested Levels: <levels>"]                        = "Уровней за отдых: |cFF00FFFF%0.2f|r";
	nUI_L["Level <player level>: <experience> of <max experience> (<percent of total>), <rested xp> rested XP"] = "Уровень %d: %d - %d (%0.1f%%), %d опыта за отдых";

	-- health race bar tooltip strings

	nUI_L["nUI Health Race Stats..."] = "nUI статистика здоровья...";
	nUI_L["No current advantage to <player> or <target>"] = "Нет преимущества к %s или %s";
	nUI_L["<unit name>'s Health: <current>/<maximum> (<percent>)"] = "Здоровье |3-1(%s): |cFF00FF00%d/%d|r (|cFFFFFFFF%0.1f%%|r)";
	nUI_L["Advantage to <player>: <pct>"] = "Преимущество к |3-2(%s): (|cFF00FF00%+0.1f%%|r)";
	nUI_L["Advantage to <target>: <pct>"] = "Преимущество к |3-2(%s): (|cFFFFC0C0%0.1f%%|r)";

	-- skinning system messages

	nUI_L["nUI could not load the currently selected skin [ %s ]... perhaps you have it disabled? Switching to the default nUI skin."] = "nUI не может загрузить выбранную обложку [ |cFFFFC0C0%s|r ]... может быть она отключена? Переключение nUI на обложку по умолчанию.";
	nUI_L["nUI: Cannot register %s for skinning... frame does not have a applySkin() method"] = "nUI: Невозможно зарегистрировать |cFFFFC0C0%s|r для обложки... отсутствует метод applySkin()";

	-- frame mover messages
	
	nUI_L["Left click and drag to move <frame label>"] = "Для перемещения нажмите [Левый-клик] и тащите |cFF00FFFF%s|r";
	nUI_L["Right click to reset to the default location"] = "Для сброса на размещение по умолчанию нажмите [Правый-клик]";
	nUI_L["Left-click and drag to move this frame"] = "Для перемещения данного окошка нажмите [Левый-клик] и тащите";
	
	-- names of the various frames that nUI allows the user to move on the screen

	nUI_L["Micro-Menu"]                = "Микроменю";
	nUI_L["Capture Bar"]               = "Панель захвата";
	nUI_L["Watched Quests"]            = "Отслеживаемые задания";
	nUI_L["Quest Timer"]               = "Таймер задания";
	nUI_L["Equipment Durability"]      = "Прочность снаряжения";
	nUI_L["PvP Objectives"]            = "Задачи PvP";
	nUI_L["Watched Achievments"]       = "Отслеживаемые достижения";
	nUI_L["In-Game Tooltips"]          = "Игровые подсказки";
	nUI_L["Bag Bar"]                   = "Панель сумок";
	nUI_L["Group Loot Frame"]          = "Окно групповой добычи";
	nUI_L["nUI_ActionBar"]             = "Главная панель / Страница действий 1";
	nUI_L["nUI_BottomLeftBar"]         = "Нижняя левая панель / Страница действий 2";
	nUI_L["nUI_LeftUnitBar"]           = "Левая панель персонажа / Страница действий 3";
	nUI_L["nUI_RightUnitBar"]          = "Правая панель персонажа / Страница действий 4";
	nUI_L["nUI_TopRightBar"]           = "Верхняя правая панель / Страница действий 5";
	nUI_L["nUI_TopLeftBar"]            = "Верхняя левая панель / Страница действий 6";
	nUI_L["nUI_BottomRightBar"]        = "Нижняя правая панель";
	nUI_L["Pet/Stance/Shapeshift Bar"] = "Панель питомца/стоек/форм";
	nUI_L["Vehicle Seat Indicator"]    = "Индикатор транспорта";
	nUI_L["Voice Chat Talkers"]        = "Говорящий в голос. чат";
	nUI_L["Timer Bar"]                 = "Таймер";

	-- slash command processing

	nUI_SlashCommands =
	{
		[nUI_SLASHCMD_HELP] =
		{
			command = "help",
			options = "{command}",
			desc    = "Отображает список всех доступных команд, если {command} не указать или отображает подробную информацию, если {command} указать",
			message = nil,
		},
		[nUI_SLASHCMD_RELOAD] =
		{
			command = "rl",
			options = nil,
			desc    = "Перезапускает графическую часть WoW и все дополнения (дублирует /console reloadui)",
			message = nil,
		},
		[nUI_SLASHCMD_BUTTONBAG] =
		{
			command = "bb",
			options = nil,
			desc    = "Эта команда включает и выключает отображение сумки кнопок мини-карты.",
			message = nil,
		},
		[nUI_SLASHCMD_MOVERS] =
		{
			command = "movers",
			options = nil,
			desc    = "Разрешает и запрещает перемещение стандартных панелей интерфейса Blizzard, например, подсказки, состояние снаряжения, таймер заданий и прочее.",
			message = "nUI: Перемещение панелей Blizzard было %s", -- enabled or disabled
		},
		[nUI_SLASHCMD_CONSOLE] =
		{
			command = "console",
			options = "{on|off|mouseover}",
			desc    = "Устанавливает режим показа верхней консоли: 'on' всегда отображает, 'off' всегда прячет и 'mouseover' отображает при движении мыши над консолью.",
			message = "nUI: Отображение верхней консоли установлено в %s", -- "on", "off" or "mouseover"
		},
		[nUI_SLASHCMD_TOOLTIPS] =
		{
			command = "tooltips",
			options = "{owner|mouse|fixed|default}",
			desc    = "Это команда устанавливает расположение подсказок, 'owner' отображает подсказку возле панели под указателем, 'mouse' отображает подсказку возле указателя мыши, 'fixed' отображает все подсказки в постоянном месте экрана, 'default' вообще не управляет подсказками",
			message = "nUI: Режим отображения подсказок изменён на |cFF00FFFF%s|r", -- the chosen tooltip mode
		},
		[nUI_SLASHCMD_COMBATTIPS] =
		{
			command = "combattips",
			options = nil,
			desc    = "Эта команда включает и отключает отображение подсказок кнопок действия во время сражения. По умолчания подсказки спрятаны в боевом режиме.",
			message = "nUI: Отображение подсказок во время боевого режима было %s", -- enabled or disabled
		},
		[nUI_SLASHCMD_BAGSCALE] =
		{
			command = "bagscale",
			options = "{n}",
			desc    = "Эта команда изменяет размер содержимого сумок, {n} является числом между 0.5 и 1.5, 1 по умолчанию",
			message = "nUI: Масштаб отображения сумок составляет |cFF00FFFF%0.2f|r", -- the chosen scale
		},
		[nUI_SLASHCMD_BAGBAR] =
		{
			command = "bagbar",
			options = "{on|off|mouseover}",
			desc    = "Эта команда управляет отображением панели сумок (включено, выключено и под мышью). По умолчанию всегда включено (on).",
			message = "nUI: Отображение сумок было изменено на |cFF00FFFF%s|r", -- on, off or mouseover
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
			desc    = "Эта команда изменяет максимальное значение частоты обновления анимированных портретов и панелей персонажа. Большее {n} соответствует лучшему качеству, меньшее - производительности. Значение по умолчанию "..nUI_DEFAULT_FRAME_RATE.." обновлений в секунду.",
			message = "nUI: Частота обновлений изображения была изменена на |cFF00FFFF%0.0fFPS|r", -- the chosen rate in frames per second... change FPS if you need a different abbreviation!
		},
		[nUI_SLASHCMD_FEEDBACK] =
		{
			command = "feedback",
			options = "{curse|disease|magic|poison}",
			desc    = "nUI подсвечивает панель персонажа в случае, если на него действует проклятие, болезнь, магия или яд. По умолчанию на все четыре типа срабатывает подсветка. Эта команда позволяет Вам включать или выключать подсветку в зависимости от типа воздействия, так что Вы обратите внимание на тот тип воздействия, который можете нейтрализовать.",
			message = "nUI: Панель персонажа, подсветка |cFF00FFFF%s |r была %s", -- aura type and enabled or disabled
		},
		[nUI_SLASHCMD_SHOWHITS] =
		{
			command = "showhits",
			options = nil,
			desc    = "nUI's подсвечивает панели персонажей красным и зеленым, чтобы показать, когда персонажу наносятся повреждения или производится лечение. Эта команда включает или выключает подсветку такого типа. По умолчанию включено.",
			message = "nUI: Подсветка повреждений и лечений была %s", -- enabled or disabled
		},
		[nUI_SLASHCMD_MAXAURAS] =
		{
			command = "maxauras",
			options = "{1-40}",
			desc    = "По умолчанию nUI будет отображать 40 аур максимум на каждом из ключевых персонажей: игроке, питомце, транспорте и цели. Эта команда позволяем Вам установить максимальное количество аур между 0 и 40. Значение 0 отключает отображение аур.",
			message = "nUI: Максимальное количество аур было установлено в |cFF00FFFF%d|r", -- a number from 0 to 40
		},
		[nUI_SLASHCMD_AUTOGROUP] =
		{
			command = "autogroup",
			options = nil,
			desc    = "По умолчанию, nUI автоматически изменяет панель персонажа так, чтобы она лучше всего размещалась, когда Вы присоединяетесь к группе/рейду или покидаете её или когда изменяется список рейда. Эта команда включает и отключает такое поведение.",
			message = "nUI: Автоматическое переключение панели персонажа %s для групп или рейдов.",
		},
		[nUI_SLASHCMD_RAIDSORT] = -- new
		{
			command = "raidsort",
			options = "{unit|group|class|name}",
			desc    = "Выберите используемый порядок сортировки рамок игроков в рейде. Параметр 'unit', сортирует рейд по идентификатору игрока начиная с рейд1 до рейд40. Параметр 'group', сортирует рейд по номерам группы. Параметр 'class', сортирует рейд по классу участников и параметр 'name' сортирует по имени участника. По умолчанию рейд сортируется по группам.",
			message = "nUI: Сортировка груп рейда установлена на |cFF00FF00%s|r", -- sort option: group, unit or class
		},
		[nUI_SLASHCMD_SHOWANIM] =
		{
			command = "anim",
			options = nil,
			desc    = "Эта команда включает и отключает анимацию портретов персонажей.",
			message = "nUI: Анимация портретов персонажей была %s", -- enabled or disabled
		},
		[nUI_SLASHCMD_HPLOST] =
		{
			command = "hplost",
			options = nil,
			desc    = "Эта команда переключает отображение между оставшимися пунктами здоровья и потерянными на панели персонажа. Имеет специфическую ценность для целителей.",
			message = "nUI: Отображение значений здоровья было изменено на %s", -- "health remaining" or "health lost"
		},
		[nUI_SLASHCMD_HUD] =
		{
			command  = "hud",
			options  = nil,
			desc     = "Эта команда предоставляет доступ к набору команд, которые используются для управления поведением nUI HUD. Используйте команду '/nui hud' для получения списка подкоманд.",
			message  = nil,
			sub_menu =
			{
				[nUI_SLASHCMD_HUD_SCALE] =
				{
					command = "scale",
					options = "{n}",
					desc    = "Эта команда устанавливает масштаб HUD, где  0.25 <= {n} <= 1.75. Меньшее значение {n} уменьшает размер HUD, большее - увеличивает. По умолчанию {n} = 1",
					message = "nUI: Масштаб HUD был установлен в |cFF00FFFF%0.2f|r", -- a number
				},
				[nUI_SLASHCMD_HUD_SHOWNPC] =
				{
					command = "shownpc",
					options = nil,
					desc    = "Эта команда включает и выключает отображение индикаторов HUD для не атакуемых целей, когда персонаж находится вне битвы.",
					message = "nUI: Отображение индикаторов HUD при выборе не атакуемой цели было %s", -- enabled or disabled
				},
				[nUI_SLASHCMD_HUD_FOCUS] =
				{
					command = "focus",
					options = nil,
					desc    = "По умолчанию, HUD не отображает информацию о фокусе игрока. Включение этой настройки изменяет отображение цели и цель цели HUD фокусом игрока и цели фокуса, когда выбирают фокус.",
					message = "nUI: Отображение на HUD фокуса игрока и цели фокуса %s", -- enabled or disabled
				},
				[nUI_SLASHCMD_HUD_HEALTHRACE] =
				{
					command = "healthrace",
					options = nil,
					desc    = "Эта команда включает и выключает отображение индикатора здоровья в HUD.",
					message = "nUI: Индикатор здоровья HUD был %s", -- enabled or disabled
				},
				[nUI_SLASHCMD_HUD_COOLDOWN] =
				{
					command = "cooldown",
					options = nil,
					desc    = "Эта команда включает и выключает в HUD отображение индикатора восстановления заклинаний, текстовых сообщений и звуков.",
					message = "nUI: Отображение индикатора восстановления заклинаний HUD было %s",
				},
				[nUI_SLASHCMD_HUD_CDALERT] =
				{
					command = "cdalert",
					options = nil,
					desc    = "При включенном индикаторе восстановления заклинаний эта команда включает и выключает отображение текстовых сообщений о восстановлении.",
					message = "nUI: Текстовые сообщения о восстановлении заклинаний в HUD были %s",
				},
				[nUI_SLASHCMD_HUD_CDSOUND] =
				{
					command = "cdsound",
					options = nil,
					desc    = "При включенном индикаторе восстановления заклинаний эта команда включает и выключает воспроизведение звуков восстановления.",
					message = "nUI: Звуковые сигналы о восстановлении заклинаний в HUD были %s",
				},
				[nUI_SLASHCMD_HUD_CDMIN] =
				{
					command = "cdmin",
					options = "{n}",
					desc    = "Данная команда установит минимальное значение требуемого времени для заклинания, чтобы оно отображалось на панели восстановления, когда она впервые восстанавливается. 	Если начальный период восстановления ниже чем {n}, то оно не будет отображаться. Значение по умолчанию '/nui hud cdmin 2'",
					message = "nUI: HUD минимальное время восстановления способности установлено на |cFF00FFFF%d|r seconds", -- time in seconds.
				},
				[nUI_SLASHCMD_HUD_HGAP] =
				{
					command = "hgap",
					options = "{n}",
					desc    = "Эта команда устанавливает ширину HUD, где {n} - это число больше 0. Чем больше {n}, тем больше промежуток между левой и правой частью HUD. По умолчанию значение {n} равно 400.",
					message = "nUI: Горизонтальный размер HUD был установлен в |cFF00FFFF%0.0f|r", -- a number greater than zero
				},
				[nUI_SLASHCMD_HUD_VOFS] =
				{
					command = "vofs",
					options = "{n}",
					desc    = "Эта команда устанавливает вертикальное смещение HUD от цетра область просмотра. По умолчанию '/nui hud vofs 0' которая ставит HUD в центр по вертекали области просмотра. Значения меньше 0, переместит HUD вниз, больше 0, переместит HUD вверх.",
					message = "nUI: Вертикальное смещение HUDа установлено на |cFF00FFFF%0.0f|r", -- a number
				},
				[nUI_SLASHCMD_HUD_IDLEALPHA] =
				{
					command = "idlealpha",
					options = "{n}",
					desc    = "Эта команда устанавливает прозрачность HUD, когда Вы находитесь в спокойном состоянии, при {n} = 0 HUD невидим, а при {n} = 1 HUD  совершенно непрозрачен. По умолчанию {n} = 0",
					message = "nUI: Прозрачность HUD в спокойном состоянии была установлена в |cFF00FFFF%0.2f|r", -- a number between 0 and 1
				},
				[nUI_SLASHCMD_HUD_REGENALPHA] =
				{
					command = "regenalpha",
					options = "{n}",
					desc    = "Эта команда устанавливает прозрачность HUD, когда Вы (или Ваш питомец) восстанавливаете здоровье, энергию или находитесь под воздействием негативных заклинаний. При {n} = 0 HUD невидим, при {n} = 1 HUD совершенно непрозрачен. По умолчанию {n} = 0.35",
					message = "nUI: Прозрачность HUD в режиме восстановления была установлена в |cFF00FFFF%0.2f|r", -- a number between 0 and 1
				},
				[nUI_SLASHCMD_HUD_TARGETALPHA] =
				{
					command = "targetalpha",
					options = "{n}",
					desc    = "Эта команда устанавливает прозрачность HUD, когда Вы выбираете игровую цель, при {n} = 0 HUD невидим, при {n} = 1 HUD непрозрачен. По умолчанию {n} = 0.75",
					message = "nUI: Прозрачность HUD при выборе игровой цели была установлена в |cFF00FFFF%0.2f|r", -- a number between 0 and 1
				},
				[nUI_SLASHCMD_HUD_COMBATALPHA] =
				{
					command = "combatalpha",
					options = "{n}",
					desc    = "Эта команда устанавливает прозрачность HUD, когда Вы или Ваш питомец находится в бою, при {n} = 0 HUD невидим, а при {n} = 1 HUD полностью непрозрачен. По умолчанию {n} = 1",
					message = "nUI: Прозрачность HUD в бою была установлена в |cFF00FFFF%0.2f|r", -- a number between 0 and 1
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
		[nUI_SLASHCMD_MOUNTSCALE] =
		{
			command = "mountscale",
			options = "{n}",
			desc    = "Эта команда устанавливает масштаб индикатора, в верхней центральной части дисплея, который отображается после того когда вы оседлаете спец. транспорт. По умолчанию '/nui mountscale 1' где 0.5 < {n} < 1.5 -- 	значения меньшее 1.0 уменьшит индикатор, значения {n} > 1.0 увеличит размер.",
			message = "nUI: Масштаб индикатора транспорта установлен на |cFF00FFFF%s|r", -- a number between 0.5 and 1.5
		},
		[nUI_SLASHCMD_CLOCK] =
		{
			command = "clock",
			options = "{server|local|both}",
			desc    = "Эта команда устанавливает отображение времени на серверное {server}, местное {local} или оба варианта {both}. По умолчанию время {server}",
			message = "nUI: Часы были переключены в режим |cFF00FFFF%s|r",
		},
		[nUI_SLASHCMD_MAPCOORDS] = 
		{
			command = "mapcoords",
			options = nil,
			desc    = "Эта команда включает и выключает отображение координат курсора и игрока на карте мира. По умолчанию включено.",
			message = "nUI: Отображение координат на карте мира %s", -- "ENABLED" or "DISABLED"
		},
		[nUI_SLASHCMD_ROUNDMAP] = 
		{
			command = "roundmap",
			options = nil,
			desc    = "Эта команда переключает отображение мини-карты между кругом и квадратом.",
			message = "nUI: Форма мини-карты была изменена на |cFF00FFFF%s|r", -- "round" or "square"
		},
		[nUI_SLASHCMD_MINIMAP] = 
		{
			command = "minimap",
			options = nil,
			desc    = "Эта команда включает и выключает управление мини-картой с помощью nUI. Во включенном состоянии nUI пытается переместить мини-карту в соответствующую панель, иначе мини-карта Blizzard не изменяется nUI (хотя nUI влияет на кнопки мини-карты). Применение этой команды вызывает перезагрузку интерфейса!",
			message = "nUI: Управление мини-картой %s", -- enabled or disabled
		},
		[nUI_SLASHCMD_ONEBAG] = 
		{
			command = "onebag",
			options = nil,
			desc    = "Эта команда включает и выключает отображение либо только основного рюкзака, либо всех пяти сумок. Команда НЕ комбинирует содержимое всех сумок в одном изображении в настоящее время, она предусмотрена для поддержки дополнений третьей стороны, например ArkInventory.",
			message = "nUI: Режим отображении одиночной сумки %s", -- enabled or disabled
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
			desc    = "Эта команда включает и выключает уровень отладочных сообщений nUI. Как правило, Вы должны применять эту команду лишь по просьбе автора этого дополнения (nUI). При {n} = 0 отладочный режим выключен (по умолчанию).",
			message = "nUI: Ваш уровень отладки был установлен в |cFF00FFFF%d|r", -- an integer value
		},
		[nUI_SLASHCMD_LASTITEM+2] = 
		{
			command = "profile",
			options = nil,
			desc    = "Эта команда включает и выключает профили nUI. Профилирование выключено по умолчанию, его включение увеличивает нагрузку. Состояние профилирования не сохраняется между сессиями или перезагрузками интерфейса. Вы не должны включать профилирование, кроме как за исключением просьбы автора nUI.",
			message = "nUI: Профилирование %s", -- enabled or disabled
		},
	};

	nUI_L["round"]  = "круг"; 
	nUI_L["square"] = "квадрат"; 

	nUI_L["health remaining"] = "|cFF00FF00остаток здоровья|r"; 
	nUI_L["health lost"]      = "|cFFFF0000потеряно здоровья|r";

	-- these strings are the optional arguments to their respective commands and can be
	-- translated to make sense in the local language

	nUI_L[nUI_SLASHCMD_OPTIONS( nUI_SLASHCMD_CLOCK, "server" )] = "server"; 
	nUI_L[nUI_SLASHCMD_OPTIONS( nUI_SLASHCMD_CLOCK, "local" )]  = "local";
	nUI_L[nUI_SLASHCMD_OPTIONS( nUI_SLASHCMD_CLOCK, "both" )]   = "both";

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

	nUI_L["The value [ %s ] is not a valid nUI slash command. Try [ /nui help ] for a list of commands"] = "Значение [ |cFFFFC000%s|r ] является недопустимым для команды nUI. Воспользуйтесь [ |cFF00FFFF/nui help|r ] для получения списка команд.";
	nUI_L["nUI currently supports the following list of slash commands..."]	= "nUI в настоящий момент поддерживает следующий список команд...";
	nUI_L["The '/nui %s' slash command currently supports the following list of sub-commands..."] = "Команда '|cFF00FFFF/nui %s|r' в настоящий момент поддерживает следующий список подкоманд...";
	nUI_L["nUI: [ %s ] is not a valid tooltip settings option... please choose from %s, %s, %s or %s"] = "nUI: [ |cFFFFC0C0%s|r ] не является правильным параметром настройки подсказки... Выберите, пожалуйста, из |cFF00FFFF%s|r, |cFF00FFFF%s|r, |cFF00FFFF%s|r или |cFF00FFFF%s|r.";
	nUI_L["nUI: [ %s ] is not a valid console visibility option... please choose from %s, %s or %s"] = "nUI: [ |cFFFFC0C0%s|r ] не является правильным параметром видимости интерфейса... Выберите, пожалуйста, из |cFF00FFFF%s|r, |cFF00FFFF%s|r or |cFF00FFFF%s|r.";
	nUI_L["nUI: [ %s ] is not a valid alpha value... please choose a number between 0 and 1 where 0 is fully transparent and 1 is fully opaque."] = "nUI: [ |cFFFFC0C0%s|r ] не является правильным параметром прозрачности... Выберите, пожалуйста, число между 0 и 1, где 0 невидимый и 1 полностью непрозрачный.";
	nUI_L["nUI: [ %s ] is not a valid horizontal gap value... please choose a number between 1 and 1200 where 1 is very narrow and 1200 is very wide."] = "nUI: [ |cFFFFC0C0%s|r ] не является правильным параметром ширины... Выберите, пожалуйста, число между 1 и 1200 где 1 - это очень узкая, 1200 - очень широкая.";
	nUI_L["nUI: [ %s ] is not a valid clock option... please choose either 'local' to display the local time, 'server' to display the server time or 'both' to display both times."] = "nUI: [ %s ] не является правильным параметром настройки часов... Выберите, пожалуйста, 'local' для отображения местного времени, 'server' для отображения серверного времени или 'both' для отображения и того и другого."; 
	nUI_L["nUI: [ %s ] is not a valid feedback option... please choose either <curse>, <disease>, <magic> or <poison>"] = "nUI: [ %s ] не является правильным параметром отображения подсветки... Выберите, пожалуйста, из '%s', '%s', '%s' или '%s'."; 
	nUI_L["nUI: [ %s ] is not a valid raid sorting option... please choose either <unit>, <group> or <class>"] = "nUI: [ %s ] не является правильным параметром сортировки рейда... Пожалуйста, выберите либо '%s', '%s' или '%s'";
	nUI_L["nUI: [ %s ] is not a valid special mount indicator display scale. The scale must be a number between 0.5 and 1.5"] = "nUI: [ %s ] не является правильным масштабом индикатора спец средства передвижения. Масштаб должен быть числом между 0,5 и 1,5"; -- new

end
