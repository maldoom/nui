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

if not nUI_Profile then nUI_Profile = {}; end;

local CreateFrame = CreateFrame;

nUI_Profile.nUI_ButtonBag = {};

local ProfileCounter = nUI_Profile.nUI_ButtonBag;

-------------------------------------------------------------------------------

local BUTTONBAG_COLS = 7;

local ButtonBagConfig = 
{	
	-- transient minimap buttons we want on the top row
	
	TopRow =
	{
		["MiniMapMeetingStoneFrame"] = true,
		["MiniMapVoiceChatFrame"] = true,
		["MiniMapRecordingButton"] = true,
	},
	
	-- buttons we want to force ignore of
	
	Excludes = 
	{		
		["MiniMapMailFrame"] = true,

		-- 5.0.1 Change Start - Frame name changes
		--["MiniMapBattlefieldFrame"] = true,	
		--["MiniMapLFGFrame"] = true,		
		["QueueStatusMinimapButton"] = true,	
		-- 5.0.1 change End

		["MinimapBackdrop"] = true,
		["MiniMapPing"] = true,
		["MiniMapCompassRing"] = true,
		["MinimapZoomIn"] = true,
		["MinimapZoomOut"] = true,
		["MiniMapTracking"] = true,
		["MiniMapWorldMapButton"] = true,
		["GatherMiniNoteUpdateFrame"] = true,
		["TimeManagerClockButton"] = true,
		["FishingBuddyMinimapMenuButton"] = true,
		["PoisonerMinimapButton"] = true,
		["GameTimeFrame"] = false,
	},	
	
	-- buttons we want to force inclusion of
	
	Includes = 
	{		
		["WIM_IconFrame"] = true,
		["CTMod2_MinimapButton"] = true,
		["PoisonerMinimapButton"] = true,
		["GameTimeFrame"] = true,
		["MobMapMinimapButtonFrame"] = true,
		["BaudGearMinimapButton"] = true,
	},
	
	-- button name patterns to be excluded (mostly Minimap POI's)
	
	ExcludePatterns =
	{
		[1] = "GatherNote.",
		[2] = "CartographerNotes.",
		[3] = "GatherMatePin.",
		[4] = "FishingExtravaganza.",
		[5] = "RecipeRadarMinimapIcon.",
	},
	
	-- for a table of unnamed buttons we have to locate by object instance
	
	Unnamed =
	{
	},
	
	-- fixed button sizes for buttons that misreport their width (for scaling)
	
	ButtonSize =
	{
		["Enchantrix"] = 36,
		["FeedbackUIButton"] = 31,
	},
};

-------------------------------------------------------------------------------

local name             = "nUI_ButtonBag";
local bag_list         = {};
local anchor           = CreateFrame( "Frame", name.."Events", WorldFrame );
local frame            = CreateFrame( "Frame", name, nUI_Dashboard.Anchor, "SecureFrameTemplate" );

-- make sure the button bag strata is the same is the rest of the bags

frame:SetFrameStrata( "DIALOG" );

-- the "close" button that appears in the actual button bag itself used to close the bag when it's open

frame.close_btn = CreateFrame( "Button", "$parent_CloseButton", frame, "UIPanelCloseButton" );

-- the button that appears on the bag bar, used to open/close the button bag

local bag_button       = CreateFrame( "CheckButton", name.."Button", nUI_Dashboard.Anchor, "SecureHandlerClickTemplate" );

bag_button:SetFrameRef( name, frame );

bag_button:Execute( 
	[[
		ButtonBag = self:GetFrameRef( "nUI_ButtonBag" );
	]]
);

bag_button.test = frame.close_btn;

bag_button:SetAttribute( 
	"_onclick",
	[[
		local visibility = ButtonBag:GetAttribute( "nUI_Visibility" );
		
		if visibility then
			ButtonBag:Hide();
		else
			ButtonBag:Show();
		end
		
		if visibility then visibility = false;
		else visibility = true;
		end
		
		ButtonBag:SetAttribute( "nUI_Visibility", visibility );
	]]
);

frame.close_btn:SetAttribute( "clickbutton", bag_button );
frame.close_btn:SetAttribute( "type", "click" );

frame.label     = frame:CreateFontString( "$parent_Label", "ARTWORK" );
frame.top       = frame:CreateTexture( "$parent_Top", "BORDER" );
frame.middle    = frame:CreateTexture( "$parent_Middle", "BACKGROUND" );
frame.bottom    = frame:CreateTexture( "$parent_Bottom", "BORDER" );
frame.buttons   = {};

frame.label:SetJustifyH( "LEFT" );
frame.label:SetJustifyV( "MIDDLE" );
frame.label:SetFont( nUI_L["font2"], 10, "OUTLINE" );
frame.label:SetPoint( "TOPLEFT", frame, "TOPLEFT", 47, -10 );
frame.label:SetText( nUI_L["Minimap Button Bag"] );

frame.close_btn:SetPoint( "TOPRIGHT", frame, "TOPRIGHT", 0, -1 );

frame.top:SetPoint( "TOPLEFT", frame, "TOPLEFT", 0, 0 );
frame.top:SetPoint( "TOPRIGHT", frame, "TOPRIGHT", 0, 0 );
frame.top:SetTexture( "Interface\\AddOns\\nUI\\Layouts\\Default\\Art\\nUI_ButtonBag_Top" );
frame.top:SetTexCoord( 0.25, 0, 0.25, 1, 1, 0, 1, 1 );
frame.top:SetWidth( CONTAINER_WIDTH );
frame.top:SetHeight( CONTAINER_WIDTH / 192 * 64 );

frame.bottom:SetPoint( "BOTTOMLEFT", frame, "BOTTOMLEFT", 0, 0 );
frame.bottom:SetPoint( "BOTTOMRIGHT", frame, "BOTTOMRIGHT", 0, 0 );
frame.bottom:SetTexture( "Interface\\AddOns\\nUI\\Layouts\\Default\\Art\\nUI_ButtonBag_Bottom" );
frame.bottom:SetTexCoord( 0.25, 0, 0.25, 1, 1, 0, 1, 1 );
frame.bottom:SetWidth( CONTAINER_WIDTH );
frame.bottom:SetHeight( CONTAINER_WIDTH / 192 * 16 );

frame.middle:SetPoint( "TOPLEFT", frame.top, "BOTTOMLEFT", 0, 0.5 );
frame.middle:SetPoint( "BOTTOMRIGHT", frame.bottom, "TOPRIGHT", 0, -0.5 );
frame.middle:SetTexture( "Interface\\AddOns\\nUI\\Layouts\\Default\\Art\\nUI_ButtonBag_Middle" );
frame.middle:SetWidth( CONTAINER_WIDTH );
frame.middle:SetHeight( 6 );
frame.middle:SetTexCoord( 0.25, 0, 0.25, 6/256, 1, 0, 1, 6/256 );

frame.box_height = frame.top:GetHeight() + frame.bottom:GetHeight() + 1;

bag_button:SetHeight( 64 );
bag_button:SetWidth( 64 );
bag_button:SetNormalTexture( "Interface\\AddOns\\nUI\\Layouts\\Default\\Art\\nUI_LogoButton" );

bag_button.checked_texture = bag_button:CreateTexture();
bag_button.checked_texture:SetAllPoints( bag_button );
bag_button.checked_texture:SetTexture( "Interface\\AddOns\\nUI\\Layouts\\Default\\Art\\nUI_LogoButton" );
bag_button:SetCheckedTexture( bag_button.checked_texture );

frame:Hide();
frame:SetAttribute( "nUI_Visibility", false );
frame:SetHeight( frame.box_height );
frame:SetWidth( CONTAINER_WIDTH );

-- 5.0.4 change start - function name change
--frame:SetScript( "OnShow", function() frame.shown = true; updateContainerFrameAnchors(); end );
--frame:SetScript( "OnHide", function() frame.shown = false; updateContainerFrameAnchors(); bag_button:SetChecked( false ); end );

frame:SetScript( "OnShow", function() frame.shown = true; UpdateContainerFrameAnchors(); end );
frame:SetScript( "OnHide", function() frame.shown = false; UpdateContainerFrameAnchors(); bag_button:SetChecked( false ); end );
-- 5.0.4 change end


-------------------------------------------------------------------------------

bag_button:SetScript( "OnEnter",

	function()
		
--		nUI_ProfileStart( ProfileCounter, "OnEnter" );
		
		GameTooltip:SetOwner( bag_button );
		GameTooltip:SetText( nUI_L["Minimap Button Bag"] );
		GameTooltip:Show();
		
--		nUI_ProfileStop();
		
	end
);

bag_button:SetScript( "OnLeave", 

	function() 
--		nUI_ProfileStart( ProfileCounter, "OnLeave" );
		GameTooltip:Hide(); 
--		nUI_ProfileStop();		
	end 
);

-------------------------------------------------------------------------------

local function testMinimapButton( button )

--	nUI_ProfileStart( ProfileCounter, "testMinimapButton" );
	
	local result = nil;
	
	if button then
			
		local button_name  = button:GetName();	
		local hasClick     = false;
		local hasMouseUp   = false;
		local hasMouseDown = false;
		
		-- test the current button to see if it is one we can/should/will move
		
		if button_name then
		
			-- the Gatherer and Cartographer mod minimap notes are misinterpreted as 
			-- minimap buttons. This forces us to ignore all their note nodes
			
			for i in pairs( ButtonBagConfig.ExcludePatterns ) do
				
				if button_name:match( ButtonBagConfig.ExcludePatterns[i] ) then
--					nUI_ProfileStop();
					return nil;
				end
			end
			
			-- otherwise, determine what to do with the button
			
			if ButtonBagConfig.Excludes[button_name] then
				nUI_DebugLog["ButtonBag"][button_name] = "skipped forced ignore button";
--				nUI_ProfileStop();
				return nil;
				
			elseif ButtonBagConfig.Includes[button_name] then
				
				nUI_DebugLog["ButtonBag"][button_name] = "moved forced include button";
--				nUI_ProfileStop();
				return button;
				
			elseif button.HasScript then
	
				if button:HasScript( "OnClick" ) and button:GetScript( "OnClick" ) then 
					hasClick = true;
				end
				
				if button:HasScript( "OnMouseUp" ) and button:GetScript( "OnMouseUp" ) then
					hasMouseUp = true;
				end
				
				if button:HasScript( "OnMouseDown" ) and button:GetScript( "OnMouseDown" ) then
					hasMouseDown = true; 
				end
	
				if hasClick or hasMouseUp or hasMouseDown then
				
					nUI_DebugLog["ButtonBag"][button_name] = "autodetected and moved button";
--					nUI_ProfileStop();
					return button;
					
				else
							
					nUI_DebugLog["ButtonBag"][button_name] = "does not appear to be a button";
					
				end				
				
			else				
				nUI_DebugLog["ButtonBag"][button_name] = "does not support \"HasScript()\"";
			end					
		end
		
		-- if we didn't find a button, try diving the children of this frame
		-- recursion ftw
		
		if not result then
			-- 5.0.4 start
			-- for _,child in ipairs( { button:GetChildren() } ) do
			for emptyVar,child in ipairs( { button:GetChildren() } ) do
			-- 5.0.4 end

				result = testMinimapButton( child );
				
				if result then 
					child.is_embedded = true;
					break; 
				end
			end
		end
	end

--	nUI_ProfileStop();
	
	return result;
end

-------------------------------------------------------------------------------

local function compressButtonBag()
	
--	nUI_ProfileStart( ProfileCounter, "compressButtonBag" );
	
	local new_bag = {};
	local row     = 1;
	local col     = 1;
	local old_bag = frame.buttons;
	
	if old_bag then
		
		for i=1,(frame.last_row or 0) do
			
			if old_bag[i] then
					
				for j=1,BUTTONBAG_COLS do
					
					if old_bag[i][j] then
						
						local button = old_bag[i][j];
						
						if not new_bag[row] then 
							new_bag[row] = {}; 
						end
			
						new_bag[row][col] = button;
						button.row = row;
						button.col = col;

						if col == BUTTONBAG_COLS then 
							col = 1;
							row = row+1;
						else
							col = col+1;
						end
					end
				end
			end
		end
	end
	
	frame.buttons  = new_bag;
	frame.last_row = row;

--	nUI_ProfileStop();
	
end

-------------------------------------------------------------------------------

local function buttonBagInsert( bag, button, row, col )

--	nUI_ProfileStart( ProfileCounter, "buttonBagInsert" );
	
	button.row = row;
	button.col = col;
	
	if not bag[row] then bag[row] = {}; end
	
	bag[row][col] = button;
	
	if not frame.last_row 
	or row > frame.last_row then
		frame.last_row = row;
	end
	
--	nUI_ProfileStop();
	
end

-------------------------------------------------------------------------------
-- this routine adds a button to the button bag. If the new button does not
-- have a row or a column, then we look for an empty spot in the table to
-- locate it

local function addButtonBagButton( new_button )

--	nUI_ProfileStart( ProfileCounter, "addButtonBagButton" );
	
	local row = new_button.row;
	local col = new_button.col;
	local bag = frame.buttons;

	new_button.frame:SetFrameStrata( nUI_ButtonBag:GetFrameStrata() );
	new_button.frame:SetFrameLevel( nUI_ButtonBag:GetFrameLevel()+1 );
	
	-- make sure the column is a valid number
	
	if col and (col < 1 or col > BUTTNBAG_COLS) then col = nil; end
	
	-- if the button has a row and a column then see if that spot is
	-- still open in the button bag. If not.. then bump the button
	
	if row and col then
		
		if not bag[row] then 
			buttonBagInsert( bag, new_button, row, col );
		elseif not bag[row][col] then 
			buttonBagInsert( bag, new_button, row, col );
		elseif bag[row][col].name == new_button.name then
			buttonBagInsert( bag, new_button, row, col );
		else
			row = nil;
		end		
	end

	-- if the new button has not been placed, then look for
	-- the first unused spot in the bag to place it in
	
	if not row or not col then
		
		local new_row = 1;
		local new_col = 1;
		
		while bag[new_row] do
						
			while bag[new_row][new_col] and new_col <= BUTTONBAG_COLS do
				new_col = new_col+1;
			end

			if new_col <= BUTTONBAG_COLS then
				break;
			end			
			
			new_row = new_row+1;
			new_col = 1;
		end
		
		buttonBagInsert( bag, new_button, new_row, new_col );
		
	end
	
--	nUI_ProfileStop();
	
end

-------------------------------------------------------------------------------

local set_top_row  = false;

local function buttonBagFix()

--	nUI_ProfileStart( ProfileCounter, "buttonBagFix" );
	
	-- build a list of children in the minimap
	
	local children    = { Minimap:GetChildren() };
	local children2   = { MinimapBackdrop:GetChildren() };
	local new_buttons = {};
	local top_row     = {};

	-- 5.0.4 Start
	-- for _, child in ipairs( children2 ) do 
	for emptyVar, child in ipairs( children2 ) do 
	-- 5.0.4 End
		table.insert(children, child); 
	end

	-- check the buttons we are forcing into the top row

	if not set_top_row then
		
		for i in pairs( ButtonBagConfig.TopRow ) do

			local move_button = _G[i];
			
			if move_button then
	
				local button_name = move_button:GetName();
	
				if not bag_list[button_name] then
				
					-- make sure we don't pick this same button up in another scan
					
					if not move_button.cached_SetParent then
						move_button.cached_SetParent = move_button.SetParent;
					end

					move_button:SetParent( frame );
					move_button.SetParent        = function() end;
					
					-- moving a new button
					
					top_row[button_name] = 
					{
						name  = button_name,
						row   = nil,
						col   = nil,
						frame = move_button,
					}				
					
				end
			end
		end
	end
	
	-- check the buttons that are unnamed, where we have to look for the objects

	ButtonBagConfig.Unnamed["Enchantrix"] = Enchantrix and Enchantrix.MiniIcon or nil;
	
	for i in pairs( ButtonBagConfig.Unnamed ) do
		
		local button_name = i;
		local move_button = ButtonBagConfig.Unnamed[i];
		
		if move_button and move_button:IsShown() then
			
			if not bag_list[button_name] then
			
				-- make sure we don't pick this same button up in another scan
				
				if not move_button.cached_SetParent then
					move_button.cached_SetParent = move_button.SetParent;
				end

				move_button:SetParent( frame );
				move_button.SetParent        = function() end;
				
				new_buttons[button_name] = 
				{
					name  = button_name,
					row   = nil,
					col   = nil,
					frame = move_button,
				}				
				
			end
		end			
	end
	
	-- check the buttons we are forcing a move for
	
	for i in pairs( ButtonBagConfig.Includes ) do
		
		local move_button = ButtonBagConfig.Includes[i] and testMinimapButton( _G[i] );
		
		if move_button and move_button:IsShown() then

			local button_name = move_button:GetName();

			if not bag_list[button_name] then
			
				-- make sure we don't pick this same button up in another scan
				
				if not move_button.cached_SetParent then
					move_button.cached_SetParent = move_button.SetParent;
				end

				move_button:SetParent( frame );
				move_button.SetParent        = function() end;
				
				-- moving a new button
				
				new_buttons[button_name] = 
				{
					name  = button_name,
					row   = nil,
					col   = nil,
					frame = move_button,
				}				
				
			end
		end
	end
	
	-- parse the list of minimap children and see who might be a button
	-- so we can prepare to move it

	-- 5.0.4 Start	
	-- for _, child in ipairs( children ) do
	for emptyVar, child in ipairs( children ) do
	-- 5.0.4 End
		
		local move_button = testMinimapButton( child );

		if move_button and move_button:IsShown() then
		
			local button_name = move_button:GetName();
	
			if not bag_list[button_name] then
					
				-- make sure we don't pick this same button up in another scan
				
				if not move_button.cached_SetParent then
					move_button.cached_SetParent = move_button.SetParent;
				end

				move_button:SetParent( frame );
				move_button.SetParent        = function() end;
				
				-- moving a new button
				
				new_buttons[button_name] = 
				{
					name  = button_name,
					row   = nil,
					col   = nil,
					frame = move_button,
				}				
					
			end
		end
	end

	-- now add all of the unknown buttons in the button bag
	
	for i in pairs( new_buttons ) do
	
		addButtonBagButton( new_buttons[i] );
		bag_list[i] = true;
		
	end
	
	-- now compress the button bag and lay out the buttons
	
	compressButtonBag();
	
	local bag           = frame.buttons;
	local button_size   = (CONTAINER_WIDTH - 32) / BUTTONBAG_COLS;
	local middle_height = (#bag-1) * button_size + 6;
	local y2            = middle_height / 256;
	
	frame.containers = {};
	frame:SetHeight( middle_height + frame.box_height );
	frame.middle:SetHeight( middle_height );
	frame.middle:SetTexCoord( 0.25, 0, 0.25, y2, 1, 0, 1, y2 );

	for i=1,#bag do
		
		frame.containers[i] = {};
		
		for j=1, #bag[i] do
			
			local button    = bag[i][j];
			local scale     = button_size / (ButtonBagConfig.ButtonSize[button.name] or button.frame:GetWidth());
			local container = button.container or CreateFrame( "Button", "$parent_Button_"..i.."_"..j, frame );			

			button.container       = container;
			frame.containers[i][j] = container;
			
			container:SetWidth( button_size );
			container:SetHeight( button_size );
			
			--5.0.4 Change Start
			--container:SetNormalTexture( "Interface\\Icons\\Buttons\\UI-PageButton-Background" );
			container:SetNormalTexture( "" );
			--5.0.4 Change End
			
			container:SetFrameStrata( button.frame:GetFrameStrata() );
			container:SetFrameLevel( button.frame:GetFrameLevel()+1 );
			container:EnableMouse( false );
			
			if i == 1 and j == 1 then
				container:SetPoint( "LEFT", frame.middle, "TOPLEFT", 20, -4 );
			elseif j == 1 then
				container:SetPoint( "TOPLEFT", frame.containers[i-1][1], "BOTTOMLEFT", 0, 0 );
			else
				container:SetPoint( "LEFT", frame.containers[i][j-1], "RIGHT", 0, 0 );
			end
			
			button.frame:SetScale( scale );
			button.frame:ClearAllPoints();
			button.frame:SetPoint( "CENTER", container, "CENTER", 0, 0 );
			button.frame:RegisterForDrag();
			
		end
	end	
	
	-- set the top row buttons

	if not set_top_row then
		
		set_top_row = true;
			
		for i in pairs( top_row ) do
			
			local button    = top_row[i];
			local scale     = button_size / (ButtonBagConfig.ButtonSize[button.name] or button.frame:GetWidth());
			local container = button.container or CreateFrame( "Button", "$parent_Button_"..i, frame );			
	
			button.container = container;
			
			container:SetWidth( button_size );
			container:SetHeight( button_size );
			
			--5.0.4 Change Start
			--container:SetNormalTexture( "Interface\\Icons\\Buttons\\UI-PageButton-Background" );
			container:SetNormalTexture( "" );
			--5.0.4 Change End
			
			container:SetFrameStrata( button.frame:GetFrameStrata() );
			container:SetFrameLevel( button.frame:GetFrameLevel()+1 );
			container:EnableMouse( false );
			
			button.frame:SetScale( scale );
			button.frame:ClearAllPoints();
			button.frame:SetPoint( "CENTER", container, "CENTER", 0, 0 );
			button.frame:RegisterForDrag();
			
		end
		
		local fix_buttons = {};
		
		if top_row["MiniMapMailFrame"] then table.insert( fix_buttons, top_row["MiniMapMailFrame"] ); end
		
		-- 5.0.1 Change Start
		-- if top_row["MiniMapBattlefieldFrame"] then table.insert( fix_buttons, top_row["MiniMapBattlefieldFrame"] ); end		
		-- 5.0.4 Change Start -Battlefield and LFG same icon so don't put in bag, display on minimapinstead
		-- if top_row["QueueStatusMinimapButton"] then table.insert( fix_buttons, top_row["QueueStatusMinimapButton"] ); end		
		-- 5.0.4 Change End
		-- 5.0.1 Change End

		if top_row["MiniMapMeetingStoneFrame"] then table.insert( fix_buttons, top_row["MiniMapMeetingStoneFrame"] ); end
		if top_row["MiniMapVoiceChatFrame"] then table.insert( fix_buttons, top_row["MiniMapVoiceChatFrame"] ); end
		if top_row["MiniMapRecordingButton"] then table.insert( fix_buttons, top_row["MiniMapRecordingButton"] ); end

		for i=1,#fix_buttons do
			
			local button = fix_buttons[i];
			
			if i == 1 then button.container:SetPoint( "LEFT", frame.middle, "TOPLEFT", 20 + button_size * 2, button_size - 4 );
			else button.container:SetPoint( "LEFT", fix_buttons[i-1].container, "RIGHT", 0, 0 );
			end
			
		end
	end	
	
--	nUI_ProfileStop();
	
end		

-------------------------------------------------------------------------------

local timer      = 6;
local loop_count = 0;

local function onButtonBagUpdate( who, elapsed )
	
--	nUI_ProfileStart( ProfileCounter, "onButtonBagUpdate" );
	
	-- check for new minimap buttons every five seconds for the first thirty seconds
	-- as a new load and then every 30 seconds thereafter... unfortunately, we have
	-- no way of knowing when mods post their minimap buttons or LOD mods add a new
	-- button.
	
	timer = timer - elapsed;
		
	if timer <= 0 and not InCombatLockdown() then
		
		if loop_count < 6 then 
			timer      = 6;
			loop_count = loop_count+1; 
		else
			timer = 30;
		end;
		
		buttonBagFix();
		
	end	

--	nUI_ProfileStop();
	
end

-------------------------------------------------------------------------------

local function onButtonBagEvent( who, event, arg1 )

--	nUI_ProfileStart( ProfileCounter, "onButtonBagEvent", event );
	
	if event == "ADDON_LOADED" and arg1 == "nUI" then

		_G["BINDING_HEADER_nUI_MISCKEYS"] = "nUI: "..nUI_L["Miscellaneous Bindings"];		
		_G["BINDING_NAME_CLICK nUI_ButtonBagButton:LeftButton"] = nUI_L["Minimap Button Bag"];
		
		if not nUI_DebugLog then nUI_DebugLog = {}; end
		nUI_DebugLog["ButtonBag"] = {};

		if nUI_Options.showCalendar then
			ButtonBagConfig.Excludes["GameTimeFrame"] = true;
			ButtonBagConfig.Includes["GameTimeFrame"] = false;
		end
		
		-- request to toggle the minimap button bag
		
		local option = nUI_SlashCommands[nUI_SLASHCMD_BUTTONBAG];
		
		nUI_SlashCommands:setHandler( option.command, 
			function() 
			
				if nUI_ButtonBag:IsShown() then nUI_ButtonBag:Hide();
				else nUI_ButtonBag:Show();
				end
				
				nUI_ButtonBag:SetAttribute( "nUI_Visibility", nUI_ButtonBag:IsShown() and true or false );
			end 
		);		

		-- request to toggle display of the guild calendar button
		
		option = nUI_SlashCommands[nUI_SLASHCMD_CALENDAR];
		
		nUI_SlashCommands:setHandler( option.command, 
			function() 
			
				nUI_Options.showCalendar = (nUI_Options.showCalendar ~= true) and true or false;
			
				if nUI_Options.showCalendar then
					ButtonBagConfig.Includes["GameTimeFrame"] = false;	
					ButtonBagConfig.Excludes["GameTimeFrame"] = true;
				else
					ButtonBagConfig.Includes["GameTimeFrame"] = true;	
					ButtonBagConfig.Excludes["GameTimeFrame"] = false;
				end
			
				if nUI_Options.showCalendar then

					for i in pairs( frame.buttons ) do
						for j in pairs( frame.buttons[i] ) do
							local button = frame.buttons[i][j];
							if button.frame == GameTimeFrame then
								frame.buttons[i][j] = nil;
							end
						end
					end

					if GameTimeFrame.cached_SetParent then
						GameTimeFrame.SetParent = GameTimeFrame.cached_SetParent;
						GameTimeFrame.cached_SetParent = nil;
					end
					
					GameTimeFrame.row = nil;
					GameTimeFrame.col = nil;
					
					bag_list["GameTimeFrame"] = nil;
					nUI_MinimapManager.setGameTimeFrame();
					
				end
				
				DEFAULT_CHAT_FRAME:AddMessage( (option.message):format( not nUI_Options.showCalendar and nUI_L["|cFF00FF00ENABLED|r"] or nUI_L["|cFFFF0000DISABLED|r"] ), 1, 0.83, 0 );
				
				buttonBagFix();
			end 
		);		

	elseif event == "PLAYER_LOGIN" then
		
		anchor:SetScript( "OnUpdate", onButtonBagUpdate );
		
	end
	
--	nUI_ProfileStop();
	
end

anchor:SetScript( "OnEvent", onButtonBagEvent );
anchor:RegisterEvent( "ADDON_LOADED" );
anchor:RegisterEvent( "PLAYER_LOGIN" );


