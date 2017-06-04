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

local CommandMethods = {};

-------------------------------------------------------------------------------

local function onSlashCommand( msg )

	local command, arg1, arg2 = strsplit( " ", (msg or "") );
	local sub_menu            = false;
	
	-- which command are we executing?
	
	command = command and strlower( command ) or nil;
		
	if not msg or not command or command == "" then
		command = nUI_SlashCommands[nUI_SLASHCMD_HELP].command;
		arg1    = nil;
	end

	-- and the argument to it?
	
	arg1 = arg1 and strlower( arg1 ) or nil;
	
	if CommandMethods[command] and CommandMethods[command].sub_menu then
				
		if not arg1 or arg1 == "" then
			arg1     = command;
			command  = nUI_SlashCommands[nUI_SLASHCMD_HELP].command;
		else
			sub_menu = true;
		end
	end
	
	-- execute the command
	
	if not sub_menu and not CommandMethods[command] then
		
		DEFAULT_CHAT_FRAME:AddMessage( nUI_L["The value [ %s ] is not a valid nUI slash command. Try [ /nui help ] for a list of commands"]:format( "/nui "..command ) );
		
	elseif sub_menu and not CommandMethods[command].sub_menu[arg1] then
		
		DEFAULT_CHAT_FRAME:AddMessage( nUI_L["The value [ %s ] is not a valid nUI slash command. Try [ /nui help ] for a list of commands"]:format( "/nui "..command.." "..arg1 ) );
		
	elseif not sub_menu then
		
		CommandMethods[command].method( msg, arg1, arg2 );
		
	else
		
		CommandMethods[command].sub_menu[arg1].method( msg, arg2 and strlower( arg2 ) or nil );
		
	end
end

-------------------------------------------------------------------------------
		
SlashCmdList["NUI"] = onSlashCommand;
SLASH_NUI1          = "/nui";

-------------------------------------------------------------------------------
		
local function ShowSlashCommandHelp( msg, arg1, arg2 )
	
	DEFAULT_CHAT_FRAME:AddMessage( nUI_L["Version"]:format( nUI_Version ), 1, 0.83, 0 );
	DEFAULT_CHAT_FRAME:AddMessage( nUI_L["Copyright"], 1, 0.83, 0 );
	DEFAULT_CHAT_FRAME:AddMessage( nUI_L["Rights"], 1, 0.83, 0 );
	
	if not arg1 or arg1 == "" then

		DEFAULT_CHAT_FRAME:AddMessage( nUI_L["nUI currently supports the following list of slash commands..."], 1, 0.83, 0 );
			
		for i=1,#nUI_SlashCommands do
			
			local item = nUI_SlashCommands[i];
			
			DEFAULT_CHAT_FRAME:AddMessage( ("    |cFF00FFFF/nui %s%s|r -- %s"):format( strlower(item.command), item.options and " "..item.options or "", item.desc ), 1, 0.83, 0 );
			
		end
	
	elseif not CommandMethods[arg1] then

		DEFAULT_CHAT_FRAME:AddMessage( nUI_L["The value [ %s ] is not a valid nUI slash command. Try [ /nui help ] for a list of commands"]:format( "/nui "..arg1 ) );
		
	elseif not CommandMethods[arg1].sub_menu then
		
		item = nUI_SlashCommands[CommandMethods[arg1].master_key];
		
		DEFAULT_CHAT_FRAME:AddMessage( ("    |cFF00FFFF/nui %s%s|r -- %s"):format( strlower(item.command), item.options and " "..item.options or "", item.help or item.desc ), 1, 0.83, 0 );
		
	elseif arg2 and arg2 ~= "" and not CommandMethods[arg1].sub_menu[arg2] then
		
		DEFAULT_CHAT_FRAME:AddMessage( nUI_L["The value [ %s ] is not a valid nUI slash command. Try [ /nui help ] for a list of commands"]:format( "/nui "..arg1.." "..arg2 ) );

	elseif arg2 and arg2 ~= "" then
		
		item = nUI_SlashCommands[CommandMethods[arg1].master_key].sub_menu[CommandMethods[arg1].sub_menu[arg2].sub_key];
		
		DEFAULT_CHAT_FRAME:AddMessage( ("    |cFF00FFFF/nui %s%s|r -- %s"):format( arg1.." "..strlower(item.command), item.options and " "..item.options or "", item.help or item.desc ), 1, 0.83, 0 );

 	else

		DEFAULT_CHAT_FRAME:AddMessage( nUI_L["The '/nui %s' slash command currently supports the following list of sub-commands..."]:format( arg1 ), 1, 0.83, 0 );
			
		for i=1,#nUI_SlashCommands[CommandMethods[arg1].master_key].sub_menu do
			
			local item = nUI_SlashCommands[CommandMethods[arg1].master_key].sub_menu[i];
			
			DEFAULT_CHAT_FRAME:AddMessage( ("    |cFF00FFFF/nui %s%s|r -- %s"):format( arg1.." "..strlower(item.command), item.options and " "..item.options or "", item.desc ), 1, 0.83, 0 );
			
		end
	
	end
	
end

-------------------------------------------------------------------------------
-- initialize the slash command system

local event_frame = CreateFrame( "Frame", "nUI_SlashCommandEvents", WorldFrame );

local function onSlashCommandEvent( who, event, arg1 )

	if event == "ADDON_LOADED" and arg1 == "nUI" then
		
		-- request for help	

		local option = nUI_SlashCommands[nUI_SLASHCMD_HELP];
		
		nUI_SlashCommands:setHandler( option.command, ShowSlashCommandHelp );
		
		-- request to reload the user interface
		
		option = nUI_SlashCommands[nUI_SLASHCMD_RELOAD];
		
		nUI_SlashCommands:setHandler( option.command, ReloadUI );
		
		-- console visibility mode
		
		option = nUI_SlashCommands[nUI_SLASHCMD_CONSOLE];
		
		nUI_SlashCommands:setHandler( option.command, 
		
			function( cmd, arg1 ) 
			
				local mode;
				
				if arg1 == nUI_L[nUI_SLASHCMD_OPTIONS( nUI_SLASHCMD_CONSOLE, "on" )] then mode = "on"
				elseif arg1 == nUI_L[nUI_SLASHCMD_OPTIONS( nUI_SLASHCMD_CONSOLE, "off" )] then mode = "off"
				elseif arg1 == nUI_L[nUI_SLASHCMD_OPTIONS( nUI_SLASHCMD_CONSOLE, "mouseover" )] then mode = "mouseover"
				else
					
					DEFAULT_CHAT_FRAME:AddMessage( 
						nUI_L["nUI: [ %s ] is not a valid console visibility option... please choose from %s, %s or %s"]:format( 
						arg1 or "", nUI_L[nUI_SLASHCMD_OPTIONS( nUI_SLASHCMD_CONSOLE, "on" )], nUI_L[nUI_SLASHCMD_OPTIONS( nUI_SLASHCMD_CONSOLE, "off" )],
						nUI_L[nUI_SLASHCMD_OPTIONS( nUI_SLASHCMD_CONSOLE, "mouseover" )] ), 1, 0.83, 0
					);
				end
				
				if mode and mode ~= nUI_Options.console then

					nUI:setConsoleVisibility( mode ); 

					DEFAULT_CHAT_FRAME:AddMessage( (option.message):format( "|cFF00FFFF"..arg1.."|r" ), 1, 0.83, 0 );
					
				end
			end 
		);
		
		-- debug messaging level

		local option = nUI_SlashCommands[nUI_SLASHCMD_LASTITEM+1];
		
		nUI_SlashCommands:setHandler( option.command, 
			
			function( cmd, arg1 )
				
				if nUI_Options.debug ~= tonumber( arg1 or "0" ) then
					
					nUI_Options.debug = tonumber( arg1 or "0" );
					
					DEFAULT_CHAT_FRAME:AddMessage( (option.message):format( nUI_Options.debug ), 1, 0.83, 0 );
					
				end
			end
		);
	end		
end

event_frame:SetScript( "OnEvent", onSlashCommandEvent );
event_frame:RegisterEvent( "ADDON_LOADED" );

-------------------------------------------------------------------------------
-- add a command to the list of known commands

function nUI_SlashCommands:setHandler( command, handler )
	
	local command = strlower( command );
	
	CommandMethods[command]        = {};
	CommandMethods[command].method = handler;

	for i=1,#nUI_SlashCommands do
		if strlower( nUI_SlashCommands[i].command ) == command then
			CommandMethods[command].master_key = i;
			break;
		end
	end
end

-------------------------------------------------------------------------------
-- add a sub-command to the list of known commands

function nUI_SlashCommands:setSubHandler( master, command, handler )
	
	local master  = strlower( master );
	local command = strlower( command );

	if not CommandMethods[master] then
		CommandMethods[master] = {};
	end
	
	if not CommandMethods[master].sub_menu then
		CommandMethods[master].sub_menu = {};
	end
	
	CommandMethods[master].sub_menu[command]        = {};
	CommandMethods[master].sub_menu[command].method = handler;
	
	for i=1,#nUI_SlashCommands do
		if strlower( nUI_SlashCommands[i].command ) == master then
			CommandMethods[master].master_key = i;
			break;
		end
	end

	local sub_menu = nUI_SlashCommands[CommandMethods[master].master_key].sub_menu;
	
	for i=1,#sub_menu do
		if strlower( sub_menu[i].command ) == command then
			CommandMethods[master].sub_menu[command].sub_key = i;
			break;
		end
	end
	
end
