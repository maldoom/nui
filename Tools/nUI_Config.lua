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

if not nUI then nUI = {}; end
if not nUI_Options then nUI_Options = {}; end;

-------------------------------------------------------------------------------
-- v2.00.06 Alpha added new slash commands, this patch sets their defaults

local function patch_v2_00_06()
	
	nUI_Options.version        = "2.00.06 (Alpha)";
	nUI_Options.hud_scale      = 1;
	nUI_Options.hud_healthrace = true;
	nUI_Options.hud_threatbar  = true;
	nUI_Options.bagbar         = true;
	
end

-------------------------------------------------------------------------------
-- v4.00.01 Alpha added change the clock slash command, this patch sets the
-- new default to display the current server time

local function patch_v4_00_01()
	
	nUI_Options.version = "4.00.01 (Alpha)";
	nUI_Options.clock   = nUI_L[nUI_SLASHCMD_OPTIONS( nUI_SLASHCMD_CLOCK, "server" )];
	nUI_Options.minimap = true;

end

-------------------------------------------------------------------------------
-- v4.01.00 Beta added a onebag slash command and fixed a bug in the German
-- localization file for the '/nui console {on|off|mouseover}' command

local function patch_v4_01_00()
	
	nUI_Options.version = "4.01.00 (Beta)";
	nUI_Options.onebag  = false;

	if nUI_Locale == "deDE" then
		
		if nUI_Options.console == "AN"
		or nUI_Options.console == "an"
		or nUI_Options.console == "on"
		then 
		
			nUI_Options.console = nUI_L[nUI_SLASHCMD_OPTIONS( nUI_SLASHCMD_CONSOLE, "on" )];
		
		elseif nUI_Options.console == "AUS"
		or nUI_Options.console == "aus"
		or nUI_Options.console == "off"
		then 
		
			nUI_Options.console = nUI_L[nUI_SLASHCMD_OPTIONS( nUI_SLASHCMD_CONSOLE, "off" )];
			
		else
			
			nUI_Options.console = nUI_L[nUI_SLASHCMD_OPTIONS( nUI_SLASHCMD_CONSOLE, "mouseover" )];
		
		end
				
	end
	
end

-------------------------------------------------------------------------------
-- v4.07.00 Beta changed how the bagbar slash command works from an on/off
-- toggle to a three state including mouseover

local function patch_v4_07_00()
	
	nUI_Options.version = "4.07.00 (Beta)";

	if not nUI_Options.bagbar then nUI_Options.bagbar = "off";
	else nUI_Options.bagbar = "on";
	end
	
end

-------------------------------------------------------------------------------
-- v4.12.00 Beta added a new slash command (defaulted on) which toggles auto
-- switching between unit panels when joining/leaving a group. In addition,
-- for some reason a lot of people never got the "minimap" toggle set properly
-- to this update forces it back on for everyone one time.

local function patch_v4_12_00()
	
	nUI_Options.version = "4.12.00 (Beta)";

	nUI_Options.auto_group = true;
	
	if not IsAddOnLoaded( "nUI_InfoPanel_Minimap" ) then
		nUI_Options.minimap = true;
	end	
end

-------------------------------------------------------------------------------
-- v4.15.00 Beta added a new slash command (defaulted on) which toggles display
-- of player and cursor map coordinates on and off in the world map in addition
-- to a set of options for a cooldown bar, alerts and sounds.

local function patch_v4_15_00()
	
	nUI_Options.version = "4.15.00 (Beta)";

	nUI_Options.hud_cooldown = true;
	nUI_Options.hud_cdalert  = true;
	nUI_Options.hud_cdsound  = true;
	nUI_Options.map_coords   = true;

end

-------------------------------------------------------------------------------
-- v4.17.00 Beta separated scaling into horizontal and vertical components

local function patch_v4_17_00()
	
	nUI_Options.version = "4.17.00 (Beta)";

	nUI_Options.hScale = nUI_Options.scale;
	nUI_Options.vScale = nUI_Options.scale;
	nUI_Options.scale  = nil;

end

-------------------------------------------------------------------------------
-- v4.20.00 Beta appears some people are having some legacy scaling issues, so
-- this patch makes sure they don't have old scaling data breaking the new
-- layout engine

local function patch_v4_20_00()
	
	nUI_Options.version = "4.20.00 (Beta)";

	nUI_Options.hScale = nil;
	nUI_Options.vScale = nil;
	nUI_Options.scale  = nil;

end

-------------------------------------------------------------------------------
-- v5.00.02 Alpha added the "showhits" option which is on by default

local function patch_v5_00_02()
	
	nUI_Options.version = "5.00.02 (Alpha)";

	nUI_Options.show_hits = true;

end

-------------------------------------------------------------------------------
-- v5.00.03 Alpha added the "feedback {poison|curse|magic|disease}" option 
-- which is on by default for all four feedback modes

local function patch_v5_00_03()
	
	nUI_Options.version = "5.00.03 (Alpha)";

	nUI_Options.feedback_magic   = true;
	nUI_Options.feedback_disease = true;
	nUI_Options.feedback_curse   = true;
	nUI_Options.feedback_poison  = true;

end

-------------------------------------------------------------------------------
-- v5.03.08 added a slew of new slash commands for the action bars.

local function patch_v5_03_08()
	
	nUI_Options.version        = nUI_SetVersion( "5.03.08" );	
	nUI_Options.barCooldowns   = true;
	nUI_Options.barDurations   = true;
	nUI_Options.barMacroNames  = true;
	nUI_Options.barStackCounts = true;
	nUI_Options.barKeyBindings = true;

end

-------------------------------------------------------------------------------
-- v5.03.12 added a new slash command for the action bars.

local function patch_v5_03_12()
	
	nUI_Options.version        = nUI_SetVersion( "5.03.12" );	
	nUI_Options.barDimming     = true;

end

-------------------------------------------------------------------------------
-- v5.07.07 unwinds the HUD vofs tweaks everyone else may have made due to the
-- lack of a viewport

local function patch_v5_07_07()
	
	nUI_Options.version  = nUI_SetVersion( "5.07.07" );	
	nUI_Options.hud_vOfs = 0;

end

-------------------------------------------------------------------------------
-- v5.07.08 pulled the viewport again due to Blizz graphics rendering bug with
-- water reflections and sky textures

local function patch_v5_07_08()
	
	nUI_Options.version  = nUI_SetVersion( "5.07.08" );	
	nUI_Options.hud_vOfs = 150;

end

-------------------------------------------------------------------------------
-- v5.07.13 unwinds the HUD vofs tweaks everyone else may have made due to the
-- lack of a viewport

local function patch_v5_07_13()
	
	nUI_Options.version  = nUI_SetVersion( "5.07.13" );	
	nUI_Options.hud_vOfs = 0;
	
	if nUI_Options.max_auras == 40 then
		nUI_Options.max_auras = nil;
	end

end

-------------------------------------------------------------------------------
-- apply all required patches to the user's saved variables file.

function nUI:patchConfig()

	if not nUI_Options.version then
		nUI_Options.minimap = true;
	end

	if nUI_Options.version ~= nUI_Version
	or nUI_Options.package ~= nUI_Package
	then 
		nUI_Options.show_splash = true;
		nUI_Options.package = nUI_Package;
	end
		
	while nUI_Options.version and nUI_Options.version < nUI_Version do
		
		if     nUI_Options.version < "2.00.06 (Alpha)" then patch_v2_00_06();	
		elseif nUI_Options.version < "4.00.01 (Alpha)" then patch_v4_00_01();
		elseif nUI_Options.version < "4.01.00 (Beta)"  then patch_v4_01_00();
		elseif nUI_Options.version < "4.07.00 (Beta)"  then patch_v4_07_00();
		elseif nUI_Options.version < "4.12.00 (Beta)"  then patch_v4_12_00();
		elseif nUI_Options.version < "4.15.00 (Beta)"  then patch_v4_15_00();
		elseif nUI_Options.version < "4.17.00 (Beta)"  then patch_v4_17_00();
		elseif nUI_Options.version < "4.20.00 (Beta)"  then patch_v4_20_00();
		elseif nUI_Options.version < "5.00.02 (Alpha)" then patch_v5_00_02();
		elseif nUI_Options.version < "5.00.03 (Alpha)" then patch_v5_00_03();
		elseif nUI_Options.version < "5.03.08"         then patch_v5_03_08();
		elseif nUI_Options.version < "5.03.12"         then patch_v5_03_12();
		elseif nUI_Options.version < "5.07.07"         then patch_v5_07_07();
		elseif nUI_Options.version < "5.07.08"         then patch_v5_07_08();
		elseif nUI_Options.version < "5.07.13"         then patch_v5_07_13();
		else   break;
		end
		
	end	
	
	nUI_Options.version = nUI_Version;
	
end
