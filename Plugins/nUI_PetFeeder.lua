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
if not nUI_Unit then nUI_Unit = {}; end
if not nUI_DefaultConfig then nUI_DefaultConfig = {}; end
if not nUI_Profile then nUI_Profile = {}; end;

local CreateFrame          = CreateFrame;
local GetContainerItemLink = GetContainerItemLink;
local GetContainerNumSlots = GetContainerNumSlots;
local GetItemCount         = GetItemCount;
local GetItemInfo          = GetItemInfo;
local GetNumSpellTabs      = GetNumSpellTabs;
local GetPetFoodTypes      = GetPetFoodTypes;
local GetSpellBookItemName = GetSpellBookItemName;
local GetSpellTabInfo      = GetSpellTabInfo;
local GetSpellTexture      = GetSpellTexture;
local GetTime              = GetTime;
local InCombatLockdown     = InCombatLockdown;

nUI_Profile.nUI_PetFeeder = {};

local ProfileCounter = nUI_Profile.nUI_PetFeeder;

-------------------------------------------------------------------------------

nUI_DefaultConfig.PetFeeder =
{
	size = 50,
	cols = 6,
	gap  = 2,
};

-------------------------------------------------------------------------------
-- create the pet feeder 

nUI_PetFeederEvents   = CreateFrame( "Frame", "nUI_PetFeederEvents", WorldFrame );
nUI_PetFeeder         = CreateFrame( "Frame", "nUI_PetFeeder", nUI_Dashboard.Anchor );
nUI_PetFeeder.Options = CreateFrame( "Frame", "$parentOptions", nUI_PetFeeder );
nUI_PetFeeder.Label   = nUI_PetFeeder:CreateFontString( nil, nil );
nUI_PetFeeder.Buttons = {};

nUI_PetFeeder.Label:SetPoint( "TOP", nUI_PetFeeder, "TOP", 0, -5 );
nUI_PetFeeder.Label:SetJustifyH( "CENTER" );
nUI_PetFeeder.Label:SetJustifyV( "TOP" );
nUI_PetFeeder.Label:SetTextColor( 1, 0.83, 0, 1 );

nUI_PetFeeder:SetBackdrop(
	{
		bgFile   = "Interface\\Tooltips\\UI-Tooltip-Background", 
		edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border", 
		tile     = true, 
		tileSize = 1, 
		edgeSize = 10, 
		insets   = {left = 2, right = 2, top = 2, bottom = 2},
	}
);

nUI_PetFeeder:SetFrameStrata( "HIGH" );
nUI_PetFeeder:SetFrameLevel( 0 );
nUI_PetFeeder:Hide();
nUI_PetFeeder:SetBackdropColor( 0, 0, 0, 0.75 );

nUI_PetFeeder.Options:SetFrameStrata( nUI_PetFeeder:GetFrameStrata() );
nUI_PetFeeder.Options:SetFrameLevel( nUI_PetFeeder:GetFrameLevel()+1 );

-------------------------------------------------------------------------------
-- ensures any buttons we have defined will not reappear the next time we go
-- to feed the pet unless they are needed at that time

nUI_PetFeeder:SetScript( "OnHide",

	function()		

--		nUI_ProfileStart( ProfileCounter, "OnHide" );
	
		if nUI_PetFeeder.ValidFoods then
			for i in pairs( nUI_PetFeeder.Buttons ) do
				nUI_PetFeeder.Buttons[i]:Hide();
			end
		end
		
--		nUI_ProfileStop();
		
	end
);

-------------------------------------------------------------------------------
-- sorts a list of foods by descending food level

local function nUI_SortFoodList( left, right )
	
--	nUI_ProfileStart( ProfileCounter, "nUI_SortFoodList" );
	
	if left.itemLevel > right.itemLevel then
		return true;
		
	elseif left.itemLevel == right.itemLevel then
		return left.itemName < right.itemName;
		
	end
	
--	nUI_ProfileStop();
	
	return false;
	
end

-------------------------------------------------------------------------------
-- given the current pet, what list of foods is that pet capable of eating?

local name, icon, offset, count;
local found_food;
local foodCache;
local petFoods;
local validFoods = {};
local useableFoods = {};
local petLevel;
local foodList;
local food;
local button;
local modified;

local function UpdateFoodList( pet_info )

--	nUI_ProfileStart( ProfileCounter, "UpdateFoodList" );
	
	-- if we don't already know it, discover the name of the feed pet spell

	if not nUI_PetFeeder.feedPetSpell then
			
		for i=1, MAX_SPELLS do
		
			local spellType, index = GetSpellBookItemInfo( i, BOOKTYPE_SPELL );
			local spellName = index and GetSpellInfo( index );
			local icon = spellName and GetSpellTexture( spellName );
			
			if icon and icon == "Interface\\Icons\\Ability_Hunter_BeastTraining" then
				nUI_PetFeeder.feedPetSpell = spellName;	
			end
		end
	end
	
	-- determine what type of foods this pet eats if we haven't yet
	
	if not pet_info.pet_foods then
		pet_info.modified    = true;
		pet_info.last_change = GetTime();
		pet_info.pet_foods   = { GetPetFoodTypes() };
		
		if #pet_info.pet_foods == 0 then
			pet_info.pet_foods = nil;
--			nUI:debug( "nUI_PetFeeder: GetPetFoodTypes() returned an empty food list for "..pet_info.name, 1 );
		else
--			for value in pairs( pet_info.pet_foods ) do
--				nUI:debug( ("nUI_PetFeeder: %s can eat %s"):format( pet_info.name, pet_info.pet_foods[value] ), 1 );
--			end
		end
	end

	-- build a list of foods this pet can and will eat
	
	found_food = false;
	foodCache  = nUI_PetFeeder.FoodList;
	petFoods   = pet_info.pet_foods;
	
	for itemID in pairs( validFoods ) do
		useableFoods[itemID] = false;
	end
	
	if petFoods and #petFoods > 0 then

		petLevel = pet_info.level;

		-- for each type of food this pet will eat...
		
		for i, foodType in ipairs( petFoods ) do
	
--			nUI:debug( "nUI_PetFeeder: processing food list for "..foodType.."...", 1 );
			
			foodList = foodCache[strlower(foodType)] or {};
		
			-- for each food item in the local cache...

			for itemId in pairs( foodList ) do
				
				food = validFoods[itemId] or foodList[itemId];

				-- if we don't know anything about the food item yet, get
				-- its details from the user's local data cache
				
				if not food.itemId then

					food.itemId = itemId;

					-- fetch info about the item
					
					food.itemName, food.itemLink, food.itemRarity, food.itemLevel, 
					food.itemMinLevel, food.itemType, food.itemSubType, food.itemCount, 
					food.itemEquipLoc, food.itemTexture = GetItemInfo( itemId );

					if food.itemName and not food.feedButton then
			
--						nUI:debug( "nUI_PetFeeder: creating a pet feeder button for "..food.itemName, 1 );
						
						-- create a button to use when feeding that item
						
						name   = nUI_PetFeeder:GetName().."_Button_"..itemId;						
						button = CreateFrame( "CheckButton", name, nUI_PetFeeder, "ActionBarButtonTemplate" );
								
						button:SetScript( "OnDragStart", nil );
						button:SetScript( "OnDragStop", nil );
						button:SetScript( "OnReceiveDrag", nil );
					
						button:SetScript( "PostClick", 
							function() 
								nUI_PetFeeder:Hide(); 
							end 
						);
						
						button:SetScript( "OnEnter", 
							function( self ) 
								GameTooltip:SetOwner( self );
								GameTooltip:SetBagItem( self:GetAttribute( "target-bag" ), self:GetAttribute( "target-slot" ) );
								GameTooltip:Show();
							end 
						);
						
						button:SetScript( "OnLeave", 
							function() 
								GameTooltip:Hide(); 
							end 
						);
								
						button:SetNormalTexture( "" );
						button:SetFrameStrata( nUI_PetFeeder.Options:GetFrameStrata() );
						button:SetFrameLevel( nUI_PetFeeder.Options:GetFrameLevel()+1 );

						button.SetNormalTexture = function() end;
						button.layers           = {};
						button.layers.icon      = _G[name.."Icon"];
						button.layers.count     = _G[name.."Count"];

						button.layers.icon:SetTexture( food.itemTexture );
						button.layers.icon.SetTexture = function() end;
						
						-- record the data and save the button
						
						food.foodType   = foodType;						
						food.feedButton = button;	
						
					end					
				end			
				
				-- if the user knows about this food item and the item's level is valid
				-- for this pet, then add it to the list of valid foods

				if not food.itemLevel then
				
--					nUI:debug( "nUI_PetFeeder: food item "..itemId.." has no data and cannot be added to the food list (uncached?)", 1 );
					
				elseif food.itemLevel < petLevel-30 then
				
--					nUI:debug( "nUI_PetFeeder: food item "..food.itemName.." is too low level for "..pet_info.name, 1 );
					
--				elseif food.itemMinLevel ~= 0 and food.itemMinLevel > petLevel then
					
--					nUI:debug( "nUI_PetFeeder: food item "..food.itemName.." is too high level for "..pet_info.name, 1 );
					
				else

--					nUI:debug( "nUI_PetFeeder: adding food item "..food.itemName.." to the list of valid foods", 1 );

					if not validFoods[food.itemId] then 
						validFoods[food.itemId] = food; 
					end

					useableFoods[food.itemId] = true;					
					found_food = true;
					
				end
			end
		end		
	end	
	
	-- if the food list has changed, update the unit_info
	
	modified = false;
	
	if not found_food then
		
--		nUI:debug( "nUI_PetFeeder: "..pet_info.name.."'s valid food list is empty", 1 );
		
		if pet_info.valid_foods then
			pet_info.modified    = true;
			pet_info.last_change = GetTime();
			pet_info.valid_foods = nil;
		end
		
	elseif not pet_info.valid_foods then
		
		modified = true;
		
	else
		
		for id in pairs( pet_info.valid_foods ) do
			if not validFoods[id]
			or pet_info.valid_foods[id] ~= validFoods[id] 
			or pet_info.valid_foods[id].useable ~= useableFoods[id] 
			then
				modified = true;
				break;
			end
		end
		
		if not modified then
			for id in pairs( validFoods ) do
				if not pet_info.valid_foods[id]
				or pet_info.valid_foods[id] ~= validFoods[id] 
				or pet_info.valid_foods[id].useable ~= useableFoods[id]
				then
					modified = true;
					break;
				end
			end
		end
	end
	
	if modified then 
		
--		nUI:debug( "nUI_PetFeeder: "..pet_info.name.." currently has valid foods in the food list", 1 );
		
		pet_info.modified    = true;
		pet_info.last_change = GetTime();
		pet_info.valid_foods = validFoods;
		
		for foodId in pairs( pet_info.valid_foods ) do
			pet_info.valid_foods[foodId].useable = useableFoods[foodId];
		end
	end	
	
--	nUI_ProfileStop();
	
end

-------------------------------------------------------------------------------
-- feeder event management

local function onPetFeederEvent( who, event, arg1 )

--	nUI_ProfileStart( ProfileCounter, "onPetFeederEvent", event );
	
	if event == "ADDON_LOADED" and arg1 == "nUI" then

		-- initialize the pet feeder configuration
		
		nUI:patchConfig();
		nUI_PetFeeder:configOptions( use_default );
		
		-- let us know when the player's pet changes or when the pet's level changes
		
--		nUI_Unit:registerUnitChangeCallback( "pet", nUI_PetFeeder );
--		nUI_Unit:registerLevelCallback( "pet", nUI_PetFeeder );
		
	end

--	nUI_ProfileStop();
	
end

nUI_PetFeederEvents:RegisterEvent( "ADDON_LOADED" );
nUI_PetFeederEvents:SetScript( "OnEvent", onPetFeederEvent );

-------------------------------------------------------------------------------
-- this callback method is executed when the player's pet changes

nUI_PetFeeder.newUnitInfo = function( list_unit, unit_info )

--	nUI_ProfileStart( ProfileCounter, "newUnitInfo" );
	
	if unit_info and unit_info.is_hunter_pet then
		UpdateFoodList( unit_info );
	end

--	nUI_ProfileStop();
	
end

-------------------------------------------------------------------------------

function nUI_PetFeeder:configOptions( use_default )
	
--	nUI_ProfileStart( ProfileCounter, "configOptions" );
	
	if not nUI_PetFeederOptions then nUI_PetFeederOptions = {}; end
	
	local config  = nUI_PetFeederOptions;
	local default = nUI_DefaultConfig.PetFeeder;
	
	if use_default then
		
		config.size = default.size;
		config.cols = default.cols;
		config.gap  = default.gap;
		
	else
		
		config.size = tonumber( config.size or default.size );
		config.cols = tonumber( config.cols or default.cols );
		config.gap  = tonumber( config.gap or default.gap );
	
	end

--	nUI_ProfileStop();
	
end

-------------------------------------------------------------------------------

local pet_info;
local validFoods;
local foods = {};
local numFoods = 0;
local i,j;
local itemId;
local itemLink;
local temp;
local button;
local width;
local height;
local labelWidth;
local labelHeight;
local hSize;
local vSize;
local hGap;
local vGap;
local got_food;
local last_row;
local last_col;
local buttonId;
local foodItem;
local left;
local right;
local matched;

function nUI_PetFeeder:FeedPet( caller )

--	nUI_ProfileStart( ProfileCounter, "FeedPet" );
	
	pet_info = nUI_Unit.PetInfo;
	
	if not pet_info then
			
		DEFAULT_CHAT_FRAME:AddMessage( nUI_L["nUI: I looked everywhere, but I couldn't find a pet to feed. Perhaps he's in your backpack?"], 1, 0.83, 0 );
		
	elseif not pet_info.is_hunter_pet then
		
		DEFAULT_CHAT_FRAME:AddMessage( nUI_L["nUI: You know, I could be wrong, but I don't think feeding %s is a very good idea... it doesn't look to me like what you have in your bags is what %s is thinking about eating."]:format( pet_info.name, pet_info.name ), 1, 0.83, 0 );
		
	elseif InCombatLockdown() then
			
		DEFAULT_CHAT_FRAME:AddMessage( nUI_L["nUI: It looks to me like you're a little busy... maybe you should try feeding %s AFTER you leave combat?"]:format( pet_info.name ), 1, 0.83, 0 );
		
	else

		-- toggle the pet feeder off if it is currently active
		
		if nUI_PetFeeder:IsShown() then
			
			nUI_PetFeeder:Hide();

		-- otherwise, prepare to show the feeder
		
		else
				
			numFoods   = 0;
			foods[1]   = nil;
	
			UpdateFoodList( pet_info );				
			validFoods = pet_info.valid_foods;
				
			if validFoods then
					
				-- build a list of foods in inventory for the current pet
				
				for i=0,4 do
					
					for j=0, GetContainerNumSlots( i ) do
						
						itemLink = GetContainerItemLink( i, j );
		
						if itemLink then
							
							itemId   = nUI_GetItemIdFromLink( itemLink );
							
							if itemId 
							and validFoods[itemId] 
							and validFoods[itemId].useable
							then
								numFoods = numFoods+1;
								foods[numFoods] = validFoods[itemId];
								foods[numFoods+1] = nil;
								validFoods[itemId].itemBag  = i;
								validFoods[itemId].itemSlot = j;
							end				
						end
					end
				end
		
				-- sort the list descending by food level
				
				for i=1, numFoods-1 do
					left = foods[i];
					for j=i+1, numFoods do
						right = foods[j];
						if not nUI_SortFoodList( left, right ) then
							food[i] = right;
							food[j] = left;
							left    = right;
						end
					end
				end
	
--				nUI:debug( ("nUI_PetFeeder: found %d item%s in your bags to feed %s"):format( #foods, #foods == 1 and "" or "s", pet_info.name ), 1 );
				
				-- label the feeder
				
				nUI_PetFeeder.Label:SetFont( nUI_L["font1"], 22 * nUI.vScale, "OUTLINE" );
				nUI_PetFeeder.Label:SetText( nUI_L["Click to feed %s"]:format( pet_info.name ) );
					
				-- start a new button list
				
				nUI_PetFeeder.Buttons = nUI_PetFeeder.Buttons or {};
				
				-- make sure all of the existing buttons in the feeder frame are hidden				
	
				for id in pairs( nUI_PetFeeder.Buttons ) do

					button = nUI_PetFeeder.Buttons[id];
								
					if not button.hidden then
						button:ClearAllPoints();
						button:Hide();
						button.hidden = true;
					end
				end
				
				-- lay the buttons out in the feed frame
				
				width       = 0;
				height      = 0;
				labelWidth  = nUI_PetFeeder.Label:GetStringWidth();
				labelHeight = nUI_PetFeeder.Label:GetStringHeight();
				hSize       = nUI_PetFeederOptions.size * nUI.hScale;
				vSize       = nUI_PetFeederOptions.size * nUI.vScale;
				hGap        = nUI_PetFeederOptions.gap * nUI.hScale;
				vGap        = nUI_PetFeederOptions.gap * nUI.vScale;
				got_food    = false;
				last_row    = nil;
				last_col    = nil;
				buttonId    = 0;
				
				for i=1,numFoods do
					
					foodItem = foods[i];
					button   = foodItem.feedButton;
					matched  = false;
	
					for j=1,buttonId do
						if nUI_PetFeeder.Buttons[j] == button then
							matched = true;
						end
					end
					
					if not matched then
						
						buttonId = buttonId+1;
						nUI_PetFeeder.Buttons[buttonId] = button;
										
						button:ClearAllPoints();				
						button:SetWidth( hSize );
						button:SetHeight( vSize );
						button:RegisterForClicks( "AnyUp" );
						button:SetAttribute( "type*",       "spell");
						button:SetAttribute( "spell*",      nUI_PetFeeder.feedPetSpell );
						button:SetAttribute( "target-bag",  foodItem.itemBag );
						button:SetAttribute( "target-slot", foodItem.itemSlot );
						button:Show();

						button.hidden = false;
							
						button.layers.count:SetText( GetItemCount( foodItem.itemLink, false ) );
						
						if not got_food then
							
							button:SetPoint( "TOPLEFT", nUI_PetFeeder.Options, "TOPLEFT", 0, 0 );
							height   = vSize;
							width    = hSize;
							last_row = button;
							got_food = true;
						
						elseif (i % nUI_PetFeederOptions.cols) == 0 then
							
							button:SetPoint( "TOPLEFT", last_row, "BOTTOMLEFT", 0, -vGap );
							height   = height + vSize + vGap;
							last_row = button;
							
						else
							
							button:SetPoint( "TOPLEFT", last_col, "TOPRIGHT", hGap, 0 );
							
							if i <= nUI_PetFeederOptions.cols then
								width = width + hSize + hGap;
							end
						end
						
						last_col = button;
					end	
				end
	
				nUI_PetFeeder.Options:ClearAllPoints();
				nUI_PetFeeder.Options:SetWidth( width );
				nUI_PetFeeder.Options:SetHeight( height );
				nUI_PetFeeder.Options:SetPoint( "BOTTOM", nUI_PetFeeder, "BOTTOM", 0, 5 );
	
				nUI_PetFeeder:ClearAllPoints();
				nUI_PetFeeder:SetHeight( height + labelHeight + 15 );
				nUI_PetFeeder:SetWidth( max( labelWidth, width ) + 10 );
				
				if caller then nUI_PetFeeder:SetPoint( "BOTTOMLEFT", caller, "TOPLEFT", 0, 0 );
				else nUI_PetFeeder:SetPoint( "CENTER", WorldFrame, "CENTER", 0, 0 );
				end
				
				nUI_PetFeeder:Show();			
			end			
		end
	end

--	nUI_ProfileStop();
	
end

-------------------------------------------------------------------------------

local PetFoods;
local foodList;
local lastFood;
local item;

function nUI_PetFeeder:PrintFoodTypes( r, g, b )

--	nUI_ProfileStart( ProfileCounter, "PrintFoodTypes" );
	
	pet_info = nUI_Unit.PetInfo;
	
	if pet_info 
	and pet_info.is_hunter_pet		
	and pet_info.pet_foods 
	and numFoods > 0 
	then
		
		foodList = "";
		lastFood = nil;			
		
		for i, type in ipairs( nUI_PetFeeder.PetFoods ) do

			item = "|cFF00FFFF"..type.."|r";
			
			if i == 1 then
				foodList = item;
			elseif i == #nUI_PetFeeder.PetFoods then  
				last_food = item;
			elseif i > 1 then
				foodList = foodList..", "..item;
			end
		end
		
		DEFAULT_CHAT_FRAME:AddMessage( nUI_L["nUI: %s can eat %s%s%s"]:format( pet_info.name or nUI_L["Your pet"], foodList, nUI_L[" or "], lastFood ), r, g, b );
			
	end

--	nUI_ProfileStop();
	
end

-------------------------------------------------------------------------------

function nUI_PetFeeder:PrintPetFoods()

--	nUI_ProfileStart( ProfileCounter, "PrintPetFoods" );
	
	pet_info = nUI_Unit.PetInfo;
	
	if pet_info and pet_info.is_hunter_pet then

		local validFoods = pet_info.valid_foods;
		local foodList = {};
		
		for i=0,4 do
			
			for j=0, GetContainerNumSlots( i ) do
				
				local itemLink = GetContainerItemLink( i, j );

				if itemLink then
					
					local itemId = nUI_GetItemIdFromLink( itemLink );
						
					if itemId and validFoods[itemId] then
						foodList[itemId] = validFoods[itemId];
					end				
				end
			end
		end
							
		nUI_PetFeeder:PrintFoodList( foodList );
	end	

--	nUI_ProfileStop();
	
end

-------------------------------------------------------------------------------

function nUI_PetFeeder:PrintFoodList( foodList, r, g, b )

--	nUI_ProfileStart( ProfileCounter, "PrintFoodList" );
	
	local pet_info = nUI_Unit.PetInfo;
	
	r = r or 1;
	g = g or 0.83;
	b = b or 0;
	
	if pet_info and pet_info.is_hunter_pet then
		
		if not foodList then
			
			foodList = pet_info.valid_foods;
			
		end
	
		if foodList then
	
			local foods = {};
			
			for itemId in pairs( foodList ) do
				nUI:TableInsertByValue( foods, foodList[itemId] );
			end
			
			nUI:TableSort( foods, nUI_SortFoodList );
			
			local got_food = false;
					
			for i in pairs( foods ) do
				
				local foodItem = foods[i];
	
				if not got_food then
					DEFAULT_CHAT_FRAME:AddMessage( nUI_L["nUI: You can feed %s the following...\n"]:format( pet_info.name ), r, g, b );
					got_food = true;
				end
	
				DEFAULT_CHAT_FRAME:AddMessage( "    "..foodItem.itemName.." -- "..foodItem.itemLevel.." "..foodItem.foodType.." ("..GetItemCount( foodItem.itemLink, false )..")", r, g, b );
	
			end
				
			if not got_food then
				
				DEFAULT_CHAT_FRAME:AddMessage( nUI_L["nUI: You have nothing you can feed %s in your current inventory"]:format( pet_info.name ), r, g, b );
	
			else
				
				DEFAULT_CHAT_FRAME:AddMessage( " ", r, g, b );
				
			end
		end
	else
		
		DEFAULT_CHAT_FRAME:AddMessage( nUI_L["nUI: You don't have a pet!"], r, g, b );
		
	end

--	nUI_ProfileStop();
	
end

-------------------------------------------------------------------------------
-- list of known foods by type and item id - this table is used to cache food
-- info during game play and limits which foods are presented as valid for 
-- the current hunter pet

nUI_PetFeeder.FoodList =
{
	[nUI_L[nUI_FOOD_FUNGUS]] = 
	{
		[3448]  = {},
		[4604]  = {},
		[4605]  = {},
		[4606]  = {},
		[4607]  = {},
		[4608]  = {},
		[8948]  = {},
		[24008] = {},		
		[24539] = {},
		[27676] = {},
		[27859] = {},
		[28112] = {},
		[29453] = {},
		[30355] = {},
		[33452] = {},
		[35947] = {},
		[41751] = {},
	},					
	[nUI_L[nUI_FOOD_FISH]] = 
	{
		[787]   = {},
		[1326]  = {},
		[2674]  = {},
		[2675]  = {},
		[2682]  = {},
		[4592]  = {},
		[4593]  = {},
		[4594]  = {},
		[4603]  = {},
		[4655]  = {},
		[5095]  = {},
		[5468]  = {},
		[5476]  = {},
		[5503]  = {},
		[5504]  = {},
		[5527]  = {},
		[6038]  = {},
		[6289]  = {},
		[6290]  = {},
		[6291]  = {},
		[6303]  = {},
		[6308]  = {},
		[6316]  = {},
		[6317]  = {},
		[6361]  = {},
		[6362]  = {},
		[6887]  = {},
		[7974]  = {},
		[8364]  = {},
		[8365]  = {},
		[8957]  = {},
		[8959]  = {},
		[12206] = {},
		[12216] = {},
		[12238] = {},
		[13546] = {},
		[13754] = {},
		[13755] = {},
		[13756] = {},
		[13758] = {},
		[13759] = {},
		[13760] = {},
		[13888] = {},
		[13889] = {},
		[13890] = {},
		[13893] = {},
		[13927] = {},
		[13928] = {},
		[13929] = {},
		[13930] = {},
		[13932] = {},
		[13933] = {},
		[13934] = {},
		[13935] = {},
		[15924] = {},
		[16766] = {},
		[16971] = {},
		[19996] = {},
		[21071] = {},
		[21072] = {},
		[21153] = {},
		[21217] = {},
		[21552] = {},
		[24477] = {},
		[27422] = {},
		[27425] = {},
		[27429] = {},
		[27435] = {},
		[27437] = {},
		[27438] = {},
		[27439] = {},
		[27515] = {},
		[27516] = {},
		[27661] = {},
		[27662] = {},
		[27663] = {},
		[27664] = {},
		[27665] = {},
		[27666] = {},
		[27667] = {},
		[27858] = {},
		[29452] = {},
		[30155] = {},
		[33048] = {},
		[33052] = {},
		[33053] = {},
		[33451] = {},
		[33823] = {},
		[33824] = {},
		[37452] = {},
		[33867] = {},
		[34759] = {},
		[34760] = {},
		[34761] = {},
		[34762] = {},
		[34763] = {},
		[34764] = {},
		[34765] = {},
		[34766] = {},
		[34767] = {},
		[34768] = {},
		[34769] = {},
		[35285] = {},
		[35951] = {},
		[36782] = {},
		[39691] = {},
		[41800] = {},
		[41801] = {},
		[41802] = {},
		[41803] = {},
		[41805] = {},
		[41806] = {},
		[41807] = {},
		[41808] = {},
		[41809] = {},
		[41810] = {},
		[41812] = {},
		[41813] = {},
		[41814] = {},
		[42942] = {},
		[42993] = {},
		[42996] = {},
		[42998] = {},
		[42999] = {},
		[43000] = {},
		[43268] = {},
		[43491] = {},
		[43492] = {},
		[43571] = {},
		[43572] = {},
		[43646] = {},
		[43647] = {},
		[43652] = {},
		[44049] = {},
		[44071] = {},	
	},					
	[nUI_L[nUI_FOOD_MEAT]] = 
	{		
		[117]   = {},
		[723]   = {},
		[729]   = {},
		[769]   = {},
		[1015]  = {},
		[1017]  = {},
		[1080]  = {},
		[1081]  = {},
		[2287]  = {},
		[2672]  = {},
		[2673]  = {},
		[2677]  = {},
		[2679]  = {},
		[2680]  = {},
		[2681]  = {},
		[2684]  = {},
		[2685]  = {},
		[2687]  = {},
		[2886]  = {},
		[2888]  = {},
		[2924]  = {},
		[3173]  = {},
		[3220]  = {},
		[3404]  = {},
		[3662]  = {},
		[3667]  = {},
		[3712]  = {},
		[3726]  = {},
		[3727]  = {},
		[3728]  = {},
		[3729]  = {},
		[3730]  = {},
		[3731]  = {},
		[3770]  = {},
		[3771]  = {},
		[4457]  = {},
		[4599]  = {},
		[4739]  = {},
		[5051]  = {},
		[5465]  = {},
		[5467]  = {},
		[5469]  = {},
		[5470]  = {},
		[5471]  = {},
		[5472]  = {},
		[5474]  = {},
		[5477]  = {},
		[5478]  = {},
		[5479]  = {},
		[5480]  = {},
		[6807]  = {},
		[6890]  = {},
		[7097]  = {},
		[8952]  = {},
		[9681]  = {},
		[11444] = {},
		[12037] = {},
		[12184] = {},
		[12202] = {},
		[12203] = {},
		[12204] = {},
		[12205] = {},
		[12208] = {},
		[12209] = {},
		[12210] = {},
		[12213] = {},
		[12223] = {},
		[12224] = {},
		[13851] = {},
		[17119] = {},
		[17222] = {},
		[17407] = {},
		[18045] = {},
		[19223] = {},
		[19224] = {},
		[19304] = {},
		[19305] = {},
		[19306] = {},
		[19995] = {},
		[20074] = {},
		[20424] = {},
		[21023] = {},
		[21024] = {},
		[21235] = {},
		[22644] = {},
		[23495] = {},
		[23676] = {},
		[24105] = {},
		[27635] = {},
		[27636] = {},
		[27651] = {},
		[27655] = {},
		[27657] = {},
		[27658] = {},
		[27660] = {},
		[27668] = {},
		[27669] = {},
		[27671] = {},
		[27674] = {},
		[27677] = {},
		[27678] = {},
		[27681] = {},
		[27682] = {},
		[27854] = {},
		[29292] = {},
		[29451] = {},
		[30610] = {},
		[31670] = {},
		[31671] = {},
		[31672] = {},
		[31673] = {},
		[33254] = {},
		[32685] = {},
		[32686] = {},
		[33120] = {},
		[33454] = {},
		[33872] = {},
		[34125] = {},
		[34410] = {},
		[34736] = {},
		[34747] = {},
		[34748] = {},
		[34749] = {},
		[34750] = {},
		[34751] = {},
		[34752] = {},
		[34754] = {},
		[34755] = {},
		[34756] = {},
		[34757] = {},
		[34758] = {},
		[35562] = {},
		[35563] = {},
		[35565] = {},
		[35794] = {},
		[35953] = {},
		[38706] = {},
		[40202] = {},
		[40358] = {},
		[40359] = {},
		[41729] = {},
		[42779] = {},
		[42994] = {},
		[42995] = {},
		[42997] = {},
		[43001] = {},
		[43009] = {},
		[43010] = {},
		[43011] = {},
		[43012] = {},
		[43013] = {},
		[43488] = {},
		[44072] = {},
	},					
	[nUI_L[nUI_FOOD_BREAD]] = 
	{
		[1113]  = {},
		[1114]  = {},
		[1487]  = {},
		[2683]  = {},
		[3666]  = {},
		[4540]  = {},
		[4541]  = {},
		[4542]  = {},
		[4544]  = {},
		[4601]  = {},
		[5349]  = {},
		[8075]  = {},
		[8076]  = {},
		[8950]  = {},
		[13724] = {},
		[16169] = {},
		[17197] = {},
		[19301] = {},
		[19696] = {},
		[20857] = {},
		[22019] = {},
		[22895] = {},
		[23160] = {},
		[24072] = {},
		[27855] = {},
		[28486] = {},
		[29394] = {},
		[29449] = {},
		[30816] = {},
		[33449] = {},
		[33924] = {},
		[34062] = {},
		[34780] = {},
		[35950] = {},
		[42428] = {},
		[42429] = {},
		[42430] = {},
		[42431] = {},
		[42432] = {},
		[42433] = {},
		[42434] = {},
		[42778] = {},
		[43490] = {},
		[43518] = {},
		[43523] = {},
		[44609] = {},
	},					
	[nUI_L[nUI_FOOD_CHEESE]] = 
	{
		[414]   = {},
		[422]   = {},
		[1707]  = {},
		[2070]  = {},
		[3665]  = {},
		[3927]  = {},
		[8932]  = {},
		[12218] = {},
		[17406] = {},
		[27857] = {},
		[29448] = {},
		[30458] = {},
		[33443] = {},
		[35952] = {},
		[44607] = {},
		[44608] = {},
		[44749] = {},
	},					
	[nUI_L[nUI_FOOD_FRUIT]] = 
	{
		[4536] = {},
		[4537] = {},
		[4538] = {},
		[4539] = {},
		[4602] = {},
		[8953] = {},
		[11950] = {},
		[13810] = {},
		[16168] = {},
		[19994] = {},
		[20031] = {},
		[20516] = {},
		[21030] = {},
		[21031] = {},
		[21033] = {},
		[22324] = {},
		[24009] = {},
		[27856] = {},
		[28112] = {},
		[29393] = {},
		[29450] = {},
		[32721] = {},
		[35948] = {},
		[35949] = {},
		[37252] = {},
		[40356] = {},
		[43087] = {},
	},					
};						
