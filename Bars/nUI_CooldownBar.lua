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

if not nUI_Unit then nUI_Unit = {}; end
if not nUI_Bars then nUI_Bars = {}; end
if not nUI_Options then nUI_Options = {}; end

local BarList    = {}; -- List of defined cooldown bars
local SpellTable = {}; -- All non-passive spells in the player's spellbook
local EquipTable = {}; -- All equipment slots
local Cooldowns  = {}; -- Spells that are actively being processed at this time
local ActiveList = {}; -- spells that have gone on cooldown at some point and have not yet been noted as ready
local ReadyList  = {}; -- spells that the cooldown has expired on and are ready
local FlagList   = {}; -- spells that are ready and have been noted as ready
local ProcTable  = {}; -- used to track all of the procs we care about

local lastSpellID       = 0;
local numCooldowns      = 0;
local LastAudioCueTime  = GetTime();

nUI_Options.minCooldown = 2;

-------------------------------------------------------------------------------

local function SortCooldowns( left, right )
	
	if not left.remains and right.remains then
		return false;
	elseif not right.remains then
		return true;
	end

	return left.remains < right.remains;
end

-------------------------------------------------------------------------------

local procTime;
local cooldownList = {};
local sortList = {};
local spell;
local index;
local listLength;
local cooldown;
local matched;
local sortLength;
local sort;
local item;
local i,j;

local function BuildCooldownTable( spellTable )
	
	procTime   = GetTime();
	listLength = 0;
	sortLength = 0;
	
	-- process the list of player spells
	
	for i=1, #spellTable do
		
		spell        = spellTable[i];
		index        = spell.index;
		ProcTable[i] = spell;
		if ( spell.flyout == nil ) then
			spell.startTime, spell.duration, spell.enabled = GetSpellCooldown( spell.index, BOOKTYPE_SPELL );
		else
			spell.startTime, spell.duration, spell.enabled = GetSpellCooldown(spell.flyout);
		end
	end

	-- process the player's list of equipped inventory
	
	index = #spellTable;
	
	for i=0,19 do
	
		if not EquipTable[i] then EquipTable[i] = {}; end
		
		item = EquipTable[i];
		ProcTable[index+i+1] = item;
		
		if item.link then		
			item.startTime, item.duration, item.enable = GetInventoryItemCooldown( "player", i );
		else
			item.startTime = 0;
			item.duration  = 0;
			item.enable    = nil;			
		end		
	end
	
	-- process the list of proc items we're watchin
	
	for i=1,#spellTable+20 do
	
		spell = ProcTable[i];
		index = spell.index;
		
		-- if the spell is active, ready and has been flagged, reset it for the next time
		
		if ActiveList[index] 
		and ReadyList[index]
		and FlagList[index]
		then
			
			ActiveList[index] = false;
			ReadyList[index]  = false;
			FlagList[index]   = false;
			
			-- also make sure any other entries by the same name are cleared -- since
			-- they are filtered out of the rest of the processing loop and thus
			-- will have partial flag states we clear all of their flags as well
			
			if not spell.isEquip then
				
				for j=index+1, #spellTable do
					
					if spellTable[index].name == spellTable[j].name 
					then
							
						ActiveList[j] = false;
						ReadyList[j]  = false;
						FlagList[j]   = false;
					end
				end
			end
		end
		
		-- and what is the state of the spell now?
		
		-- 5.0.1 Change Start - validate spell.duration before using it
		-- and spell.duration > (nUI.GCD or 2)
		if spell.duration
		and spell.duration > (nUI.GCD or 2)
		-- 5.0.1 Change End
		and spell.duration > (nUI_Options.minCooldown or 2)
		then

			spell.remains     = max( (spell.startTime + spell.duration - procTime), 0 );
			ReadyList[index]  = ReadyList[index] or (ActiveList[index] and ((spell.remains == 0) and not FlagList[index]));
			ActiveList[index] = spell.enabled ~= 0 and (spell.remains > 0 or ReadyList[index]);

		end				

		-- if it's an active spell, add it to the cooldown list
		
		if ActiveList[index] then 
			listLength = listLength+1;
			cooldownList[listLength] = spell;
		end
	end
	
	-- parse the list of active cooldowns and for every given spell name
	-- in the list, only report the spellbook entry on cooldown with the 
	-- highest rank for that spell name
	
	for i=1,listLength do
		
		cooldown   = cooldownList[i];
		matched    = false;
		
		for j=1,sortLength do
			
			sort = sortList[j];
			
			if sort.name == cooldown.name
			then

				matched = true;
				
				if sort.rank < cooldown.rank
				then				
					sortList[j] = cooldown;
				end
			
				break;
			end
		end
		
		if not matched then
			sortLength = sortLength+1;
			sortList[sortLength] = cooldown;
		end		
	end
	
	if sortLength > 0 then
		nUI:TableSort( sortList, SortCooldowns, sortLength );
	end
	
	Cooldowns = sortList;
	numCooldowns = sortLength;
	
end

-------------------------------------------------------------------------------

local function BuildSpellTable()
	
	-- 5.0.4 Change - recoded this section to stop invalid spell slot errors

	-- reset the spell table	
	local newSpellTable = {};

	-- Get Specialization Spell Tab Info
	local tabName, tabTexture, tabOffset, tabSlots, tabIsGuild, tabOffSpecID = GetSpellTabInfo(2);

	-- Cycle through specialization spell tab and extra spells for cooldown usage
	for i = tabOffset+1, tabSlots+tabOffset do
		local spellType, spellID = GetSpellBookItemInfo( i, BOOKTYPE_SPELL );
		local name, rank, icon, castTime, minRange, maxRange = GetSpellInfo( i, BOOKTYPE_SPELL );

		if ( name ~= nil ) then
			--if not IsPassiveSpell( i ) then
				local entry = 
				{
					index = i,
					name  = name,
					rank  = rank,
					icon  = icon,
					flyout = nil
				};
				
				table.insert( newSpellTable, entry );
				
			--end
		end
	end

	local flyoutCount = 0;
	for i = tabOffset+1, tabSlots+tabOffset do
		local spellType, spellID = GetSpellBookItemInfo( i, BOOKTYPE_SPELL );
		if (spellType == "FLYOUT") then
			local flyoutID = spellID;
			local _,_,nSlots, isKnown = GetFlyoutInfo(flyoutID);
			if isKnown then
				for j = 1, nSlots do
					local spellID, overrideSpellID, isKnown = GetFlyoutSlotInfo(flyoutID, j);
					if isKnown then
						local name, rank, icon, castTime, minRange, maxRange = GetSpellInfo( spellID );
						flyoutCount = flyoutCount + 1;
						
						local entry =
						{
							index = tabSlots+tabOffset+flyoutCount,
							name = name,
							rank = rank,
							icon = icon,
							flyout = spellID
						};
						
						table.insert( newSpellTable, entry );
					end
				end
			end
		end
	end


	
	
	--[[ 5.0.4 Change Start - Latest build hates this block of code
	local idx  = 1;
	local stop = false;
	
	-- reset the spell table
	
	local newSpellTable = {};
	
	-- scan the player's spellbook end to end
	
	lastSpellID = 0;
	
	while not stop do
		
		-- 5.0.4 Change Start - pcall this as it errors out second time around
		--local name, rank, icon, cost, isFunnel, powerType, castTime, minRange, maxRange = GetSpellInfo( idx, BOOKTYPE_SPELL );
		local retOK, name, rank, icon, cost, isFunnel, powerType, castTime, minRange, maxRange = pcall(GetSpellInfo, idx, BOOKTYPE_SPELL );
		if not retOK then stop = false end
	
		-- if there's no spell name, we hit the end of the book
		
		stop = name == nil;
		
		if not stop then
		
			lastSpellID = idx;
			
			-- passive spells don't have cooldowns, so we only want to spend time scanning
			-- castable spells
			
			if not IsPassiveSpell( idx ) then
				
				local entry = 
				{
					index = idx,
					name  = name,
					rank  = rank,
					icon  = icon,
				};
				
				table.insert( newSpellTable, entry );
				
			end
			
			-- next spell
			
			idx  = idx + 1;
			
		end				
	end	
	--]]
	
	BuildCooldownTable( newSpellTable );
	
	SpellTable = newSpellTable;
	
end

-------------------------------------------------------------------------------

local function BuildEquipmentTable()

	local emptyVar -- 5.0.4 Attempt to get rid of addon blocked message when using glyphs

	for i=0,19 do
	
		if not EquipTable[i] then EquipTable[i] = {}; end
		
		local item = EquipTable[i];
		
		item.link    = GetInventoryItemLink( "player", i );
		item.isEquip = true;
		item.index   = 1000+i;
		item.rank    = "";
		
		if item.link then
			-- 5.0.4 Start
			--item.name, _, item.rarity, item.level, item.minLevel, item.type, item.subType, 
			item.name, emptyVar, item.rarity, item.level, item.minLevel, item.type, item.subType, 
			-- 5.0.4 End
			item.stackCount, item.equipLoc, item.icon = GetItemInfo( item.link );
		else
			item.name = "";
		end		
	end	
end

-------------------------------------------------------------------------------

local frame = CreateFrame( "Frame", "nUI_CooldownEvents", WorldFrame );

local function onCooldownEvent( who, event, arg1 )
	
	if event == "PLAYER_LOGIN" 
	then
	
		BuildSpellTable();
		BuildEquipmentTable();
		
	elseif event == "LEARNED_SPELL_IN_TAB"
	or     event == "PLAYER_SPECIALIZATION_CHANGED"			-- 5.0.4 Change
	or     event == "EQUIPMENT_SETS_CHANGED" 
	or     event == "PLAYER_TALENT_UPDATE" 
	or    (event == "UNIT_INVENTORY_CHANGED" and arg1 == "player")
	then
					
		numCooldowns = 0;
		
		for i=1,#SpellTable+20 do
			
			if ProcTable[i] then
				
				index = ProcTable[i].index;
				
				if ActiveList[index] 
				then
		
					ActiveList[index] = false;
					ReadyList[index]  = false;
					FlagList[index]   = false;
											
				end		
			end
		end
		
		for i=1,#BarList do
			BarList[i].updateBar( Cooldowns, numCooldowns );
		end
		
		BuildSpellTable();
		BuildEquipmentTable();
		
	end	
end

frame:SetScript( "OnEvent", onCooldownEvent );
frame:RegisterEvent( "PLAYER_LOGIN" );
frame:RegisterEvent( "LEARNED_SPELL_IN_TAB" );
frame:RegisterEvent( "PLAYER_TALENT_UPDATE" );
frame:RegisterEvent( "EQUIPMENT_SETS_CHANGED" );
frame:RegisterEvent( "UNIT_INVENTORY_CHANGED" );
frame:RegisterEvent("PLAYER_SPECIALIZATION_CHANGED");		-- 5.0.4 Change

-------------------------------------------------------------------------------

local updateTimer = 0;
local procTime;
local cooldown;
local index;

local function onCooldownUpdate( who, elapsed )
	
	updateTimer = updateTimer - elapsed;

	-- scan the list of spell for new spells
	
	if updateTimer <= 0 then

		procTime = GetTime();
		
		updateTimer = nUI_Unit.frame_rate or (1 / nUI_DEFAULT_FRAME_RATE);

		-- there's no need to do cooldown parsing unless we have an active
		-- bar to show it in
		
		if #BarList then
				
			BuildCooldownTable( SpellTable );
			
			for i = numCooldowns, 1, -1 do
				
				cooldown = Cooldowns[i];
				index    = cooldown.index;
				
				if cooldown.remains then
					cooldown.remains = cooldown.startTime + cooldown.duration - procTime;
					
					if cooldown.remains <= 0 or cooldown.duration == 0 then
						ReadyList[index] = true;
					end
				end
	
				cooldown.ready  = ReadyList[index] and not FlagList[index];
				FlagList[index] = ReadyList[index];
				
			end
						
			for i=1,#BarList do
				BarList[i].updateBar( Cooldowns, numCooldowns );
			end
			
		-- otherwise, if we're not doing cooldown parsing, then make
		-- sure we don't leave any artifacts in the state tables
		
		else
			
			numCooldowns = 0;
			
			for i=1,#SpellTable+20 do
				
				if ProcTable[i] then
					
					index = ProcTable[i].index;
					
					if ActiveList[index] 
					then
			
						ActiveList[index] = false;
						ReadyList[index]  = false;
						FlagList[index]   = false;
						
					end		
				end
			end
		end
	end
end

frame:SetScript( "OnUpdate", onCooldownUpdate );

-------------------------------------------------------------------------------

local num_cooldowns;
local procTime;
local cooldown;
local button;
local label;
local remains;
local alpha;
local bar_width;
local bar_height;

function nUI_Bars:createCooldownBar( name, parent, options )
	
	local frame      = CreateFrame( "Frame", name, parent );	
	frame.background = CreateFrame( "Frame", name.."_Background", parent );		
	frame.overlay    = CreateFrame( "Frame", name.."_Overlay", frame );
	frame.message    = frame.overlay:CreateFontString( "$parent_Message", "OVERLAY" );
	frame.Buttons    = {};	

	frame.background:SetAllPoints( frame );
	frame:SetFrameLevel( frame.background:GetFrameLevel()+1 );
	
	frame.overlay:SetAllPoints( frame );
	frame.overlay:SetFrameLevel( frame:GetFrameLevel()+1 );

	frame:SetScript( "OnShow", 
	
		function()
			frame.setEnabled( true );
		end
	);
	
	frame:SetScript( "OnHide", 
	
		function()
			frame.setEnabled( false );
		end
	);

	-- notify the bar it is no longer needed
	
	frame.deleteBar = function()

--		nUI_ProfileStart( ProfileCounter, "deleteBar" );	
	
		frame.setEnabled( false );
		frame:SetAlpha( 0 );
		
		if not InCombatLockdown() then frame:Hide(); end
		
--		nUI_ProfileStop();
		
	end
	
	-- set the enabled state of the bar...
	
	frame.setEnabled = function( enabled )
	
--		nUI_ProfileStart( ProfileCounter, "setEnabled" );	
	
		if frame.enabled ~= enabled then
			
			frame.enabled = enabled;
			
			if enabled then 

				nUI:TableInsertByValue( BarList, frame );
				
				frame:SetAlpha( 1 );
			
			elseif not enabled then 	
				
				nUI:TableRemoveByValue( BarList, frame );
						
				frame:SetAlpha( 0 );				
			end
			
		end
		
--		nUI_ProfileStop();
		
	end

	-- set the scale of the bar
	
	frame.applyScale = function( scale )
		
--		nUI_ProfileStart( ProfileCounter, "applyScale" );	
	
		local anchor   = scale and frame.anchor or nil;
		local scale    = scale or frame.scale or 1;
		local options  = frame.options;
		
		if options then
				
			local rows      = options.rows or 1;
			local cols      = options.cols or 10;
			local btn_hSize = options.btn_size * scale * nUI.hScale;
			local btn_vSize = options.btn_size * scale * nUI.vScale;
			local hGap      = (options.hGap or 0) * scale * nUI.hScale;
			local vGap      = (options.vGap or 0) * scale * nUI.vScale;

			frame.configText( frame.message, options.message, scale );
	
			if frame.btn_hSize ~= btn_hSize
			or frame.btn_vSize ~= btn_vSize
			or frame.rows      ~= rows
			or frame.cols      ~= cols
			or frame.hGap      ~= hGap
			or frame.vGap      ~= vGap
			then
				
				frame.btn_hSize = btn_hSize;
				frame.btn_vSize = btn_vSize;
				frame.rows      = rows;
				frame.cols      = cols;
				frame.hGap      = hGap;
				frame.vGap      = vGap;
							
				frame:SetWidth( (btn_hSize * cols) + (hGap * (cols-1)) );
				frame:SetHeight( (btn_vSize * rows) + (vGap * (rows-1)) );
			end
			
			local origin     = options.origin or "TOPLEFT";
			local left       = origin == "TOPLEFT" or origin == "BOTTOMLEFT";
			local top        = origin == "TOPLEFT" or origin == "TOPRIGHT";
			local horizontal = options.horizontal;
			local row        = 0;
			local col        = 0;
			local last_button;
			local row_start;
			local next_button;
			local next_line;
			
			-- builing auras starting from the top left
			
			if top and left then
			
				if horizontal then
					next_button = { pt1 = "LEFT", pt2 = "RIGHT", xOfs = hGap, yOfs = 0 };
					next_line = { pt1 = "TOPLEFT", pt2 = "BOTTOMLEFT", xOfs = 0, yOfs = -vGap };
				else
					next_button = { pt1 = "TOP", pt2 = "BOTTOM", xOfs = 0, yOfs = -vGap };
					next_line = { pt1 = "TOPLEFT", pt2 = "TOPRIGHT", xOfs = hGap, yOfs = 0 };
				end
	
			-- building auras starting from the top right
			
			elseif top then
				
				if horizontal then
					next_button = { pt1 = "RIGHT", pt2 = "LEFT", xOfs = -hGap, yOfs = 0 };
					next_line = { pt1 = "TOPRIGHT", pt2 = "BOTTOMRIGHT", xOfs = 0, yOfs = -vGap };
				else
					next_button = { pt1 = "TOP", pt2 = "BOTTOM", xOfs = 0, yOfs = -vGap };
					next_line = { pt1 = "TOPRIGHT", pt2 = "TOPLEFT", xOfs = -hGap, yOfs = 0 };
				end
	
			-- building auras starting from the bottom left
			
			elseif left then			
			
				if horizontal then
					next_button = { pt1 = "LEFT", pt2 = "RIGHT", xOfs = hGap, yOfs = 0 };
					next_line = { pt1 = "BOTTOMLEFT", pt2 = "TOPLEFT", xOfs = 0, yOfs = vGap };
				else
					next_button = { pt1 = "BOTTOM", pt2 = "TOP", xOfs = 0, yOfs = vGap };
					next_line = { pt1 = "BOTTOMLEFT", pt2 = "BOTTOMRIGHT", xOfs = hGap, yOfs = 0 };
				end
				
			-- building auras starting from the bottom right
			
			else
			
				if horizontal then
					next_button = { pt1 = "RIGHT", pt2 = "LEFT", xOfs = -hGap, yOfs = 0 };
					next_line = { pt1 = "BOTTOMRIGHT", pt2 = "TOPRIGHT", xOfs = 0, yOfs = vGap };
				else
					next_button = { pt1 = "BOTTOM", pt2 = "TOP", xOfs = 0, yOfs = vGap };
					next_line = { pt1 = "BOTTOMRIGHT", pt2 = "BOTTOMLEFT", xOfs = -hGap, yOfs = 0 };
				end
				
			end					
			
			for i=1,#frame.Buttons do
				
				local button = frame.Buttons[i];
				local anchor;
				local anchor_frame;
				
				button:SetWidth( btn_hSize );
				button:SetHeight( btn_vSize );

				-- first button on the frame
				
				if i == 1 then
					
					button:ClearAllPoints();				
					button:SetPoint( origin, frame, origin, 0, 0 );
					
					row         = 1;
					row_start   = button;
	
				-- start a new line of aura buttons 
				
				elseif col > cols then 
					
					anchor_frame = row_start;
					anchor       = next_line;
					row_start    = button;
					row          = row+1;
					col          = 1;
	
					button:ClearAllPoints();
					button:SetPoint( anchor.pt1, anchor_frame, anchor.pt2, anchor.xOfs, anchor.yOfs );
	
				-- otherwise, just place this button after the last one on the line
				
				else
					
					anchor_frame = last_button;
					anchor       = next_button;
				
					button:ClearAllPoints();
					button:SetPoint( anchor.pt1, anchor_frame, anchor.pt2, anchor.xOfs, anchor.yOfs );
	
				end
					
				last_button = button;
									
			end
		end
		
		if anchor then frame.applyAnchor(); end
		
--		nUI_ProfileStop();
		
	end
	
	-- set the bar's anchor point
	
	frame.applyAnchor = function( anchor )
		
--		nUI_ProfileStart( ProfileCounter, "applyAnchor" );	
	
		local anchor      = anchor or frame.anchor or {};
		local anchor_pt   = anchor.anchor_pt or "CENTER";
		local relative_to = anchor.relative_to or frame.parent:GetName();
		local relative_pt = anchor.relative_pt or anchor_pt;
		local xOfs        = (anchor.xOfs or 0) * nUI.hScale;
		local yOfs        = (anchor.yOfs or 0) * nUI.vScale;
		
		frame.anchor = anchor;
		
		if frame.xOfs ~= xOfs
		or frame.yOfs ~= yOfs
		or frame.anchor_pt ~= anchor_pt
		or frame.relative_to ~= relative_to
		or frame.relative_pt ~= relative_pt
		then
			
			frame.anchor_pt   = anchor_pt;
			frame.relative_to = relative_to;
			frame.relative_pt = relative_pt;
			frame.xOfs        = xOfs;
			frame.yOfs        = yOfs;
			
			frame:ClearAllPoints();
			frame:SetPoint( anchor_pt, relative_to, relative_pt, xOfs, yOfs );
			
		end

		if options.message then
				
			anchor_pt   = options.message.anchor_pt or "CENTER";
			relative_to = options.message.relative_to or frame:GetName();
			relative_pt = options.message.relative_pt or anchor_pt;
			xOfs        = (options.message.xOfs or 0) * nUI.hScale;
			yOfs        = (options.message.yOfs or 0) * nUI.vScale;
			
			frame.message:ClearAllPoints();
			frame.message:SetPoint( anchor_pt, relative_to, relative_pt, xOfs, yOfs );
			
		end

		if options.timer then
				
			anchor_pt   = options.timer.anchor_pt or "CENTER";
			xOfs        = (options.timer.xOfs or 0) * nUI.hScale;
			yOfs        = (options.timer.yOfs or 0) * nUI.vScale;
			
			for i=1,#frame.Buttons do
				relative_to = options.timer.relative_to or frame.Buttons[i]:GetName();
				relative_pt = options.timer.relative_pt or anchor_pt;				
				frame.Buttons[i].timer:ClearAllPoints();
				frame.Buttons[i].timer:SetPoint( anchor_pt, relative_to, relative_pt, xOfs, yOfs );
			end
		end

		if options.label then
				
			anchor_pt   = options.label.anchor_pt or "CENTER";
			xOfs        = (options.label.xOfs or 0) * nUI.hScale;
			yOfs        = (options.label.yOfs or 0) * nUI.vScale;
			
			for i=1,#frame.Buttons do
				relative_to = options.label.relative_to or frame.Buttons[i]:GetName();
				relative_pt = options.label.relative_pt or anchor_pt;				
				frame.Buttons[i].label:ClearAllPoints();
				frame.Buttons[i].label:SetPoint( anchor_pt, relative_to, relative_pt, xOfs, yOfs );
			end
		end
		
--		nUI_ProfileStop();
		
	end
	
	-- set the bar's options
	
	frame.applyOptions = function( options )
		
--		nUI_ProfileStart( ProfileCounter, "applyOptions" );	
	
		frame.options = options;
		
		if not options or not options.enabled then
			
			frame.setEnabled( false );
			
		else
			
			local buttons    = {};
			local rows       = options.rows or 1;
			local cols       = options.cols or 10;
			local index      = 1;

			for i=1,#frame.Buttons do
				frame.Buttons[i]:Hide();
				frame.Buttons[i]:ClearAllPoints();
			end			
			
			for i=1,rows do
				for j=1,cols do
					
					local button = frame.Buttons[index];
					
					if not button then
						
						button       = CreateFrame( "Button", "$parent_Button"..index, frame );
						button.icon  = button:CreateTexture( "$parent_Icon", "ARTWORK" );
						button.timer = button:CreateFontString( "$parent_Timer", "OVERLAY" );
						button.label = button:CreateFontString( "$parent_Label", "OVERLAY" );
						
						button.icon:SetAllPoints( button );
						
						button:SetScript( "OnEnter", 
							function() 

								GameTooltip:SetOwner( button, "ANCHOR_RIGHT" );
								if button.cooldown.flyout == nil then
									GameTooltip:SetSpell( button.cooldown.index, BOOKTYPE_SPELL );
								else
									GameTooltip:SetSpell( flyout );
								end
								
							end
						);
						
						button:SetScript( "OnLeave", 
							function() 
								GameTooltip:Hide(); 
							end 
						);
					end

					button:Show();
					button:SetAlpha( 0 );
					button:EnableMouse( false );
					button.active = false;
					
					frame.configText( button.timer, options.timer, options.scale or 1 );
					frame.configText( button.label, options.label, options.scale or 1 );
					
					table.insert( buttons, button );
					
					index = index+1;
					
				end
			end
			
			frame.Buttons = buttons;
			
			-- if there's a frame border, set it (frame border hides when the frame hides
			
			if options.border then
					
				local border_color = options.border.color.border;
				local backdrop_color = options.border.color.backdrop;
				
				frame:SetBackdrop( options.border.backdrop );
				frame:SetBackdropBorderColor( border_color.r, border_color.g, border_color.b, border_color.a );
				frame:SetBackdropColor( backdrop_color.r, backdrop_color.g, backdrop_color.b, backdrop_color.a );
		
			else 
				
				frame:SetBackdrop( nil );
				
			end
			
			-- if there's a frame background, set it (background does not hide when the frame hides
			
			if options.background then
					
				local border_color = options.background.color.border;
				local backdrop_color = options.background.color.backdrop;
				
				frame.background:SetBackdrop( options.border.backdrop );
				frame.background:SetBackdropBorderColor( border_color.r, border_color.g, border_color.b, border_color.a );
				frame.background:SetBackdropColor( backdrop_color.r, backdrop_color.g, backdrop_color.b, backdrop_color.a );
		
			else 
				
				frame.background:SetBackdrop( nil );
				
			end
			
			frame.applyScale( options.scale or frame.scale or 1 );	
			frame.setEnabled( frame:IsShown() );
	
		end
		
--		nUI_ProfileStop();
		
	end

	-- method for sizing and anchoring text labels
	
	frame.configText = function( text, config, scale )

--		nUI_ProfileStart( FrameProfileCounter, "configText" );

		local scale       = (scale or frame.scale or 1) * nUI.vScale;
		local font_size   = (config and config.fontsize or 12) * scale * 1.75;
		local justifyH    = config and config.justifyH or "CENTER";
		local justifyV    = config and config.justifyV or "MIDDLE";
		local r           = config and config.color and config.color.r or 1;
		local g           = config and config.color and config.color.g or 1;
		local b           = config and config.color and config.color.b or 1;
		local a           = config and config.color and config.color.a or 1;			

		-- set the text font size
					
		if text.font_size ~= font_size
		then
			
			-- first time here?
			
			if not text.font_size then 
				text.active  = true;
			end
	
			text.font_size = font_size;
			text:SetFont( nUI_L["font1"], font_size, config and config.outline or "OUTLINE" );

		end

		-- show or hide the text based on whether or not there is a config for it
		
		text.enabled = config and config.enabled or false;
		
		if not config and text.active then

			text.active = false;
			text.value  = nil;				
			text:SetAlpha( 0 );
			text:SetText( "" );				
			
		elseif config then

			text.active = true;
			text:SetAlpha( 1 );
			
		end
		
		-- set text justification
		
		if text.justifyH ~= justifyH then
			text.justifyH = justifyH;
			text:SetJustifyH( justifyH );
		end
		
		if text.justigyV ~= justifyV then
			text.justifyV = justifyV;
			text:SetJustifyV( justifyV );
		end
		
		-- set text color
		
		if text.r ~= r
		or text.g ~= g
		or text.b ~= b
		or text.a ~= a
		then
			
			text.r = r;
			text.g = g;
			text.b = b;
			text.a = a;
			
			text:SetTextColor( r, g, b, a );
			
		end
		
--		nUI_ProfileStop();
		
	end
	
	-- update the bar with the current cooldown list
	
	frame.updateBar = function( cooldowns, tableLength )
		
		-- update any changes in the active cooldown buttons
		
		num_cooldowns = 0;
		procTime = GetTime();
		
		for i=1,tableLength or #frame.Buttons do

			cooldown = cooldowns[i];
			button   = frame.Buttons[i];
			
			if button then
						
				label    = cooldown.name..(cooldown.rank and (" ("..cooldown.rank..")") or "");
				remains  = cooldown.remains and cooldown.remains > 0 and nUI_SecondsLeftToString( cooldown.remains ) or "";
				
				button.cooldown = cooldown;
				num_cooldowns   = num_cooldowns+1;
	
				-- when a cooldown ends and the spell is now ready, present an alert to the
				-- user if so configured
				
				if cooldown.ready then
					
					if frame.message.active 
					and nUI_Options.hud_cdalert then					
						frame.message:SetText( "~ "..cooldown.name.." ~" );
						frame.message.startTimer = GetTime();
					end
					
					if frame.options.sound 
					and nUI_Options.hud_cdsound 
					and (GetTime() - LastAudioCueTime) >= 2
					then
						LastAudioCueTime = GetTime();
						PlaySoundFile( frame.options.sound );
					end								
				end
		
				-- update the button icon if required
				
				if button.icon.texture ~= cooldown.icon then
					button.icon.text = cooldown.icon;
					button.icon:SetTexture( cooldown.icon );
					button.icon:SetTexCoord( 0, 0, 0, 1, 1, 0, 1, 1 );
				end
	
				-- display the updated remaining time as required
				
				if button.timer 
				and button.timer.active
				and button.timer.value ~= remains
				then
					button.timer.value = remains;
					button.timer:SetText( remains );
				end
				
				-- if there's a spell label, update it as required
				
				if button.label
				and button.label.active
				and button.label.value ~= label
				then
					button.label.value = label;
					button.label:SetText( label );
				end
	
				-- if the button we've assigned this cooldown to is inactive, 
				-- bring it back online
				
				if not button.active then
					button.active = true;
					button:SetAlpha( 1 );
					button:EnableMouse( frame.options.clickable and true or false );
				end
				
			end
		end
		
		-- hide any buttons that are active but no longer needed
		
		for i=num_cooldowns+1,#frame.Buttons do
			
			button = frame.Buttons[i];
			
			if button.active then
				button.active = false;
				button:SetAlpha( 0 );
				button:EnableMouse( false );
			end
		end

		-- when a new spell goes ready, we display it at full alpha for one second,
		-- then fade it out over one second then leave it hidden until the next time
		
		if frame.message.startTimer then
			
			alpha = procTime - frame.message.startTimer;
			
			if alpha < 1 then
				alpha = 1;
			elseif alpha > 2 then
				alpha = 0;
				frame.message.startTimer = nil;
			else
				alpha = 1 - (alpha - 1);
			end
			
			frame.message:SetAlpha( alpha );
			
		end
		
		-- if we're not using a fixed size cooldown bar, then resize the
		-- bar according to its content
		
		if frame.options.dynamic_size then
			
			bar_width  = tableLength >= frame.cols and frame.cols or tableLength;
			bar_height = math.floor( tableLength / frame.cols ) + ((tableLength % frame.cols) > 0 and 1 or 0);

			bar_height = max( 1, frame.btn_vSize * bar_height + (frame.vGap * (bar_height-1)));
			bar_width  = max( 1, frame.btn_hSize * bar_width + (frame.hGap * (bar_width-1)));
			
			if frame.bar_height ~= bar_height
			or frame.bar_width  ~= bar_width
			then
	
				frame.bar_height = bar_height;
				frame.bar_width  = bar_width;
				
				frame:SetHeight( bar_height );
				frame:SetWidth( bar_width );
			end
		end
	end
	
	-- initialize the bar
	
	nUI:registerScalableFrame( frame );
	
	frame.applyOptions( options );
	
--	nUI_ProfileStop();
	
	return frame;
end