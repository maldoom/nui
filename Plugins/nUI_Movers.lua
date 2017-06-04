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

if not nUI_Data then nUI_Data = {}; end
if not nUI_Data.MoverAnchors then nUI_Data.MoverAnchors = {}; end
if not nUI_Profile then nUI_Profile = {}; end;

nUI_Profile.nUI_Movers = {};
nUI_Movers             = CreateFrame( "Frame", "nUI_MoverEvents", WorldFrame );

local ProfileCounter = nUI_Profile.nUI_Movers;
local MoverAnchors   = nUI_Data.MoverAnchors;

-- Disable Xrystal's temporary movers fix plugin if it is present

DisableAddOn( "nUI_Plugin_CustomMovers" );

-- list of frames that we allow the player to drag anytime they are displayed

nUI_Movers.movableFrames = 
{
	{ 
		frameName = "AchievementFrame",
		addOn = "Blizzard_AchievementUI", 
		parentName = nil 
	},
	{ 
		frameName = "AuctionFrame",
		addOn = "Blizzard_AuctionUI", 
		parentName = nil 
	},
	{ 
		frameName = "CalendarFrame",
		addOn = "Blizzard_Calendar", 
		parentName = nil 
	},
	{ 
		frameName = "CraftFrame",
		addOn = "Blizzard_CraftUI", 
		parentName = nil 
	},
	{ 
		frameName = "GuildBankFrame",
		addOn = "Blizzard_GuildBankUI", 
		parentName = nil 
	},
	{ 
		frameName = "InspectFrame", 
		addOn = "Blizzard_InspectUI", 
		parentName = nil 
	},
	{ 
		frameName = "TradeSkillFrame", 
		addOn = "Blizzard_TradeSkillUI", 
		parentName = nil 
	},		
	{ 
		frameName = "PlayerTalentFrame", 
		addOn = nil, 
		parentName = nil 
	},
	{ 
		frameName = "ArenaFrame", 
		addOn = nil, 
		parentName = nil 
	},
	{ 
		frameName = "BattlefieldFrame", 
		addOn = nil, 
		parentName = nil 
	},
	{ 
		frameName = "ChannelFrame", 
		addOn = nil, 
		parentName = "FriendsFrame" 
	},
	{ 
		frameName = "ChatConfigFrame", 
		addOn = nil, 
		parentName = nil 
	},
	{ 
		frameName = "FriendsFrame", 
		addOn = nil, 
		parentName = nil 
	},
	{ 
		frameName = "GossipFrame", 
		addOn = nil, 
		parentName = nil 
	},
	{ 
		frameName = "GuildRegistrarFrame", 
		addOn = nil, 
		parentName = nil 
	},
	{ 
		frameName = "HonorFrame", 
		addOn = nil, 
		parentName = "CharacterFrame" 
	},
	{ 
		frameName = "LFGParentFrame", 
		addOn = nil, 
		parentName = nil 
	},
	{ 
		frameName = "LFDParentFrame", 
		addOn = nil, 
		parentName = nil 
	},
	{ 
		frameName = "LFRParentFrame", 
		addOn = nil, 
		parentName = nil 
	},
	{ 
		frameName = "MailFrame", 
		addOn = nil, 
		parentName = nil 
	},
	{ 
		frameName = "WorldMapFrame", 
		addOn = nil, 
		parentName = nil 
	},
	{ 
		frameName = "MerchantFrame", 
		addOn = nil, 
		parentName = nil 
	},
	{ 
		frameName = "PaperDollFrame", 
		addOn = nil, 
		parentName = "CharacterFrame" 
	},
	{ 
		frameName = "PetitionFrame", 
		addOn = nil, 
		parentName = nil 
	},
	{ 
		frameName = "PetStableFrame", 
		addOn = nil, 
		parentName = nil 
	},
	{ 
		frameName = "PVPFrame", 
		addOn = nil, 
		parentName = nil 
	},
	{ 
		frameName = "QuestFrame", 
		addOn = nil, 
		parentName = nil 
	},
	{ 
		frameName = "QuestLogFrame", 
		addOn = nil, 
		parentName = nil 
	},
	{ 
		frameName = "RaidFrame", 
		addOn = nil, 
		parentName = "FriendsFrame" 
	},
	{ 
		frameName = "ReputationFrame", 
		addOn = nil, 
		parentName = "CharacterFrame" 
	},
	{ 
		frameName = "SendMailFrame", 
		addOn = nil, 
		parentName = "MailFrame" 
	},
	{ 
		frameName = "SkillFrame", 
		addOn = nil, 
		parentName = "CharacterFrame" 
	},
	{ 
		frameName = "SpellBookFrame", 
		addOn = nil, 
		parentName = nil 
	},
	{ 
		frameName = "TaxiFrame", 
		addOn = nil, 
		parentName = nil 
	},
	{ 
		frameName = "TradeFrame", 
		addOn = nil, 
		parentName = nil 
	},
}

-- list of frames that are managed by the '/nui movers' command so they are
-- only moveable when they have been unlocked

nUI_Movers.managedFrames =
{
	-- 6.0 WoD frames

	{
		frameName = "ArcheologyDigsiteProgressBar",
		labelText = "Digsite Progress Bar",
		parent = "UIParent",
		addOn = "Blizzard_ArchaeologyUI",
		exclusionFrames = nil,
		requiredFrames = nil,
		defaultPosition = 
		{
			anchorPt = "TOP",
			relativeTo = "nUI_TopBars",
			relativePt = "BOTTOM",
			xOfs = 0,
			yOfs = -6,
		},
	},

	-- 5.0.3 Change Start Adding PetBattleFrame to Mover System
--[[	{
		frameName = "PetBattleFrame",
		labelText = "Top PetBattle Frame",
		parent = "UIParent",
		addOn = "Blizzard_PetBattleUI",
		exclusionFrames = nil,
		requiredFrames = nil,
		defaultPosition = 
		{
			anchorPt = "TOPLEFT",
			relativeTo = "nUI_TopBars",
			relativePt = "BOTTOMLEFT",
			xOfs = -5,
			yOfs = 15,
		},
	}, ]]--

	-- 5.0.3 Change End

	{
		frameName = "TutorialFrameAlertButton",
		labelText = "Tutorial Frame Alert Button",
		parent = "UIParent",
		addOn = nil,
		exclusionFrames = nil,
		requiredFrames = nil,
		defaultPosition = 
		{
			anchorPt = "BOTTOMLEFT",
			relativeTo = "ActionBarDownButton",
			relativePt = "BOTTOMRIGHT",
			xOfs = -5,
			yOfs = 15
		},
	},
	{
		frameName = "PlayerPowerBarAlt",
		labelText = "Alternate Power Bar",
		parent = "UIParent",
		addOn = nil,
		exclusionFrames = nil,
		requiredFrames = nil,
		defaultPosition = 
		{
			anchorPt = "BOTTOM",
			relativeTo = "MultiCastActionBarFrame",
			relativePt = "TOP",
			xOfs = 0,
			yOfs = 5
		},
	},
	{
		frameName = "MirrorTimer1",
		labelText = "Timer Bar",
		parent = nil,
		addOn = nil,
		exclusionFrames = nil,
		requiredFrames = nil,
		defaultPosition = 
		{ 
			anchorPt = "TOP", 
			relativeTo = "nUI_TopBars", 
			relativePt = "BOTTOM", 
			xOfs = 0, 
			yOfs = -5 
		},
	},				
	{
		frameName = "GroupLootFrame1",
		labelText = "Group Loot Frame",
		parent = nil,
		addOn = nil,
		exclusionFrames = nil,
		requiredFrames = nil,
		defaultPosition = 
		{ 
			anchorPt = "TOP", 
			relativeTo = "MirrorTimer1", 
			relativePt = "BOTTOM", 
			xOfs = 0, 
			yOfs = -5 
		},
	},
	{
		frameName = "GroupLootFrame2",
		labelText = "Group Loot Frame",
		parent = nil,
		addOn = nil,
		exclusionFrames = nil,
		requiredFrames = nil,
		defaultPosition = 
		{ 
			anchorPt = "TOP", 
			relativeTo = "GroupLootFrame1", 
			relativePt = "BOTTOM", 
			xOfs = 0, 
			yOfs = -5 
		},
	},
	{
		frameName = "GroupLootFrame3",
		labelText = "Group Loot Frame",
		parent = nil,
		addOn = nil,
		exclusionFrames = nil,
		requiredFrames = nil,
		defaultPosition = 
		{ 
			anchorPt = "TOP", 
			relativeTo = "GroupLootFrame2", 
			relativePt = "BOTTOM", 
			xOfs = 0, 
			yOfs = -5 
		},
	},
	{
		frameName = "GroupLootFrame4",
		labelText = "Group Loot Frame",
		parent = nil,
		addOn = nil,
		exclusionFrames = nil,
		requiredFrames = nil,
		defaultPosition = 
		{ 
			anchorPt = "TOP", 
			relativeTo = "GroupLootFrame3", 
			relativePt = "BOTTOM", 
			xOfs = 0, 
			yOfs = -5 
		},
	},
	{
		frameName = "TutorialFrameAlertButton",
		textLabel = "Tutorial Alert Button",
		parent = nil,
		addOn = nil,
		exclusionFrames = nil,
		requiredFrames = nil,
		defaultPositon = 
		{ 
			anchorPt = "BOTTOM", 
			relativeTo = "VoiceChatTalkers", 
			relativePt = "TOP", 
			xOfs = 0, 
			yOfs = 5 
		},
	},		
	{
		frameName = "MultiCastActionBarFrame",
		textLabel = "Shaman Totem Bar",
		parent = nil,
		addOn = nil,
		exclusionFrames = nil,
		requiredFrames = nil,
		defaultPosition = 
		{ 
			anchorPt = "BOTTOM", 
			relativeTo = "nUI_Dashboard", 
			relativePt = "TOP", 
			xOfs = 0, 
			yOfs = -30 
		},
	},
	{
		frameName = "DungeonCompletionAlertFrame1",
		labelText = "Dungeon Completion Alert Frame",
		parent = nil,
		addOn = nil,
		exclusionFrames = nil,
		requiredFrames = nil,
		defaultPosition = 
		{ 
			anchorPt = "BOTTOM", 
			relativeFrames = 
			{ 
				[1] = "MultiCastActionBarFrame", 
				[2] = "nUI_SpecialBars" 
			}, 
			relativePt = "TOP", 
			xOfs = 0, 
			xOfs = 5 
		},
	},
	{
		frameName = "AlertFrame",
		labelText = "Achievement Alert Frame",
		parent = nil,
		addOn = nil,
		exclusionFrames = nil,
		requiredFrames = nil,
		defaultPosition =
		{
			anchorPt = "BOTTOM", 
			relativeFrames =
			{
				[1] = "DungeonCompletionAlertFrame1",
				[2] = "MultiCastActionBarFrame",
				[3] = "nUI_SpecialBars"
			},
			relativePt = "TOP", 
			xOfs = 0, 
			yOfs = 5 
		},
	},				
	{
		frameName = "QuestWatchFrame",
		labelText = "Watched Quests",
		parent = nil,
		addOn = nil,
		exclusionFrames = 
		{
			[1] = "WatchFrame"
		},
		requiredFrames = nil,
		defaultPosition = 
		{
			anchorPt = "TOPLEFT", 
			relativeTo = "nUI_TopBars", 
			relativePt = "BOTTOMLEFT", 
			xOfs = 50, 
			yOds = 120
		},
	},
	{
		frameName = "QuestTimerFrame",
		labelText = "Quest Timer",
		parent = nil,
		addOn = nil,
		exclusionFrames = 
		{
			[1] = "WatchFrame"
		},
		requiredFrames = nil,
		defaultPosition = 
		{
			anchorPt = "TOP", 
			relativeTo = "nUI_TopBars", 
			relativePt = "BOTTOM", 
			xOfs = 0, 
			yOfs = -5 
		},
	},
	{
		frameName = "AchievementWatchFrame",
		labelText = "Watched Achievments",
		parent = nil,
		addOn = "QuestHelper",
		exclusionFrames = nil,
		requiredFrames = 
		{
			[1] = "QuestWatchFrame",
			[2] = "AchievementWatchFrame"
		},
		defaultPosition = 
		{
			anchorPt = "TOPLEFT", 
			relativeTo = "QuestHelperQuestWatchFrame", 
			relativePt = "BOTTOMLEFT", 
			xOfs = 0, 
			yOfs = -10 
		},
	},
	{
		frameName = "AchievementWatchFrame",
		labelText = "Watched Achievments",
		parent = nil,
		addOn = nil,
		exclusionFrames = 
		{
			[1] = "QuestHelperQuestWatchFrame"
		},
		requiredFrames = nil,
		defaultPosition =
		{
			anchorPt = "TOPLEFT", 
			relativeTo = "QuestWatchFrame", 
			relativePt = "BOTTOMLEFT", 
			xOfs = 0, 
			yOfs = -10 
		},
	},			
	{
		frameName = "DurabilityFrame",
		labelText = "Equipment Durability",
		parent = nil,
		addOn = nil,
		exclusionFrames = nil,
		requiredFrames = nil,
		defaultPosition = 
		{
			anchorPt = "BOTTOMRIGHT", 
			relativeTo = "UIParent", 
			relativePt = "RIGHT", 
			xOfs = -5, 
			yOfs = 0 
		},
	},
	{
		frameName = "WorldStateAlwaysUpFrame",
		textLabel = "PvP Objectives",
		parent = nil,
		addOn = nil,
		exclusionFrames = nil,
		requiredFrames = nil,
		defaultPosition =
		{
			anchorPt = "TOPLEFT", 
			relativeTo = "nUI_CaptureBarMover", 
			relativePt = "BOTTOMLEFT", 
			xOfs = 0, 
			yOfs = -10
		},
	},
	{
		frameName = "VehicleSeatIndicator",
		labelText = "Vehicle Seat Indicator",
		parent = nil,
		addOn = nil,
		exclusionFrames = nil,
		requiredFrames = nil,
		defaultPosition = 
		{
			anchorPt = "BOTTOMRIGHT", 
			relativeTo = "DurabilityFrame", 
			relativePt = "TOPRIGHT", 
			xOfs = 0, 
			yOfs = 5 
		},
	},
	{	
		frameName = "VoiceChatTalkers",
		textLabel = "Voice Chat Talkers",
		parent = nil,
		addOn = nil,
		exclusionFrames = nil,
		requiredFrames = nil,
		defaultPosition =
		{
			anchorPt = "BOTTOMRIGHT", 
			relativeTo = "VehicleSeatIndicator", 
			relativePt = "TOPRIGHT", 
			xOfs = 0, 
			yOfs = 5 
		},
	},
	{
		frameName = "ExtraActionBarFrame",
		labelText = "Extra Action Bar Frame",
		parent = "UIParent",
		addOn = nil,
		exclusionFrames = nil,
		requiredFrames = nil,
		defaultPosition = 
		{
			anchorPt = "CENTER",
			relativeTo = "UIParent",
			relativePt = "CENTER",
			xOfs = 0,
			yOfs = 0,
		},
	},
	{
		frameName = "ZoneAbilityFrame",
		labelText = "Zone Ability Frame",
		parent = "UIParent",
		addOn = nil,
		exclusionFrames = nil,
		requiredFrames = nil,
		defaultPosition = 
		{
			anchorPt = "CENTER",
			relativeTo = "UIParent",
			relativePt = "CENTER",
			xOfs = 0,
			yOfs = 0,
		},
	},
--[[
	{
		frameName = "MonkHarmonyBarFrame",
		labelText = "Monk Harmony Bar",
		parent = "UIParent",
		addOn = nil,
		exclusionFrames = nil,
		requiredFrames = nil,
		defaultPosition = 
		{
			anchorPt = "CENTER",
			relativeTo = "UIParent",
			relativePt = "CENTER",
			xOfs = 0,
			yOfs = 0,
		},
	},
	{
		frameName = "MonkStaggerBar",
		labelText = "Monk Stagger Bar",
		parent = "UIParent",
		addOn = nil,
		exclusionFrames = nil,
		requiredFrames = nil,
		defaultPosition = 
		{
			anchorPt = "CENTER",
			relativeTo = "UIParent",
			relativePt = "CENTER",
			xOfs = 0,
			yOfs = 0,
		},
	},
	{
		frameName = "WarlockPowerFrame",
		labelText = "Warlock Shard Bar",
		parent = "UIParent",
		addOn = nil,
		exclusionFrames = nil,
		requiredFrames = nil,
		defaultPosition = 
		{
			anchorPt = "CENTER",
			relativeTo = "UIParent",
			relativePt = "CENTER",
			xOfs = 0,
			yOfs = 0,
		},
	},
	{
		frameName = "PaladinPowerBarFrame",
		labelText = "Paladin Power Bar",
		parent = "UIParent",
		addOn = nil,
		exclusionFrames = nil,
		requiredFrames = nil,
		defaultPosition = 
		{
			anchorPt = "CENTER",
			relativeTo = "UIParent",
			relativePt = "CENTER",
			xOfs = 0,
			yOfs = 0,
		},
	},
	{
		frameName = "MageArcaneChargesFrame",
		labelText = "Mage Arcane Charges Bar",
		parent = "UIParent",
		addOn = nil,
		exclusionFrames = nil,
		requiredFrames = nil,
		defaultPosition = 
		{
			anchorPt = "CENTER",
			relativeTo = "UIParent",
			relativePt = "CENTER",
			xOfs = 0,
			yOfs = 0,
		},
	},
	]]--
}

-------------------------------------------------------------------------------
-- frame mover event management

nUI_Movers.FrameList = {};
nUI_MoverFrames      = {};

local function onMoversEvent( who, event, arg1 )

--	nUI_ProfileStart( ProfileCounter, "onMoversEvent", event );
	
	if event == "PLAYER_LOGOUT" then
		
		for mover_name in pairs( nUI_Data.MoverAnchors ) do
			
			if not nUI_Data.MoverAnchors[mover_name].user_placed then
				nUI_Data.MoverAnchors[mover_name] = nil;
			end
		end
		
	elseif event == "ADDON_LOADED" and arg1 == "nUI" then

		if not nUI_Data.MoverAnchors then 
			nUI_Data.MoverAnchors = {}; 
		end		

		MoverAnchors = nUI_Data.MoverAnchors;

		VehicleSeatIndicator:SetScale( nUI_Options.mountScale or 1 );

	elseif event == "PET_BATTLE_OPENING_START" then

		nUI_TopBars:Hide();
		nUI_ActionBar:Hide();
		nUI_TopLeftBar:Hide();
		nUI_TopRightBar:Hide();
		nUI_UnitPanelBackground:Hide();

	elseif event == "PET_BATTLE_CLOSE" then

		nUI_TopBars:Show();
		nUI_ActionBar:Show();
		nUI_TopLeftBar:Show();
		nUI_TopRightBar:Show();
		nUI_UnitPanelBackground:Show();

	elseif event == "PLAYER_ENTERING_WORLD" then

		nUI_Movers:UnregisterEvent( "PLAYER_ENTERING_WORLD" );			
		
		nUI:setScale();
		
		-- initialize the slash command handler for selecting the mover state
		
		local option = nUI_SlashCommands[nUI_SLASHCMD_MOVERS];
		
		nUI_SlashCommands:setHandler( option.command,
		
			function()

				if not nUI_Movers.enabled then nUI_Movers.enabled = true;
				else nUI_Movers.enabled = false;
				end
			
				DEFAULT_CHAT_FRAME:AddMessage( (option.message):format(nUI_Movers.enabled and nUI_L["|cFF00FF00ENABLED|r"] or nUI_L["|cFFFF0000DISABLED|r"]), 1, 0.83, 0 );
				
				for i in pairs( nUI_Movers.FrameList ) do
					
					nUI_Movers:enableDrag( nUI_Movers.FrameList[i], nUI_Movers.enabled );
					
				end
			end
		);
		
		-- initialize the slash command handler for sizing the vehicle seat indicator
		
		local option = nUI_SlashCommands[nUI_SLASHCMD_MOUNTSCALE];
		
		nUI_SlashCommands:setHandler( option.command,
			
			function( msg, arg1 )
				
				local scale = tonumber( arg1 or "1" );
				
				if not scale or scale < 0.5 or scale > 1.5 then

					DEFAULT_CHAT_FRAME:AddMessage( nUI_L["nUI: [ %s ] is not a valid special mount indicator display scale. The scale must be a number between 0.5 and 1.5"]:format( arg1 or "<nil>" ), 1, 0.83, 0 );

				elseif nUI_Options.mountScale ~= scale then

					nUI_Options.mountScale = scale;
					VehicleSeatIndicator:SetScale( scale );
					
					DEFAULT_CHAT_FRAME:AddMessage( (option.message):format( scale ), 1, 0.83, 0 );

				end
			end
		);	
				
		-- create a mover for the capture bars
		
		local frame = WorldStateCaptureBar1;
		local mover = nUI_Data.MoverAnchors["nUI_CaptureBarMover"];
		
		nUI_CaptureBarMover = CreateFrame( "Frame", "nUI_CaptureBarMover", UIParent );
		nUI_CaptureBarMover:SetWidth( 173 );
		nUI_CaptureBarMover:SetHeight( 26 );
		
		if not mover then
			nUI_CaptureBarMover:SetPoint( "TOPRIGHT", UIParent, "TOPRIGHT", -10, -20 );
		else
			for i in pairs( mover.Point ) do
				local point = mover.Point[i];
				nUI_CaptureBarMover:SetPoint( point.anchor, point.relative_to, point.relative_pt, point.xOfs, point.yOfs );
			end
		end
		
		nUI_CaptureBarMover:SetScript( "OnEvent", 
			function( who, event )	

--				nUI_ProfileStart( ProfileCounter, "CaptureBarMover.OnEvent", event );
	
				if event == "UPDATE_WORLD_STATES" then
					local last_frame;
					
					for i=1,NUM_EXTENDED_UI_FRAMES do
						local frame = _G["WorldStateCaptureBar"..i];				
						
						if not nUI_MoverFrames[frame] then nUI_Movers:lockFrame( frame, true, nil ); end					
						
						nUI_MoverFrames[frame].ClearAllPoints( frame );
						
						if i == 1 then
							nUI_MoverFrames[frame].SetPoint( frame, "CENTER", nUI_CaptureBarMover, "CENTER", 0, 0 );
						else
							nUI_MoverFrames[frame].SetPoint( frame, "TOP", last_frame, "BOTTOM", 0, 0 );
						end
						
						last_frame = frame;
					end
				end
				
--				nUI_ProfileStop();
				
			end
		);
	
		nUI_Movers:lockFrame( nUI_CaptureBarMover, true, nUI_L["Capture Bar"] );
		nUI_CaptureBarMover:RegisterEvent( "UPDATE_WORLD_STATES" );	

		if WatchFrame then nUI_Movers:lockFrame( WatchFrame, true, OBJECTIVES_TRACKER_LABEL ); end
		
		-- Bliz frames we want the player to be able to move any time
	
		for i,detail in ipairs( nUI_Movers.movableFrames ) do
		
			-- if there's an addon associated with this frame, make sure it is loaded
			
			if detail.addOn and not IsAddOnLoaded( detail.addOn ) then
				LoadAddOn( detail.addOn );
			end

			-- get the frame and make it draggable
						
			local frame = _G[detail.frameName];
			local parent = detail.parentName and _G[detail.parentName] or nil;
			
			if frame then 
				nUI_Movers:movableFrame( frame, parent ); 
			end
		end
			
		-- standard Bliz frames we want to manage

		if MultiCastActionBarFrame then
			MultiCastActionBarFrame:SetParent( nUI_Options.noTotemBar and MainMenuBar or UIParent );
		end


		-- Set location of the pet battle frames so they don't overlap the UI

--[[	if ( PetBattleFrame ) then
			if ( PetBattleFrame.TopFrame ~= nil ) then 
				PetBattleFrame.TopFrame:SetPoint("TOP",nUI_TopBars, "BOTTOM",0,0)
			end
			if ( PetBattleFrame.BottomFrame ~= nil ) then
				PetBattleFrame.BottomFrame:SetPoint("BOTTOM", nUI_Dashboard, "CENTER", 0, 122 * nUI.vScale ); 
			end
			--PetBattleFrame:SetScale(nUI.hScale)
		end
]]--

		for i,detail in ipairs( nUI_Movers.managedFrames ) do
		
			-- if there's an addon associated with this frame, make sure it is loaded
			
			if detail.addOn and not IsAddOnLoaded( detail.addOn ) then
				LoadAddOn( detail.addOn );
			end
			
			-- get the frame we want and verify it exists before we try to do anything with it
			-- while ensuring none of the required associated frames are missing and none of
			-- the frames that would exclude this rule are present
			
			local frame = _G[detail.frameName];
			local excluded = false;
						
			if detail.requiredFrames then
				for i,requiredName in pairs( detail.requiredFrames ) do
					if not _G[requiredName] then
						excluded = true;
					end
				end
			end
								
			if detail.exclusionFrames then
				for i,exclusionName in pairs( detail.exclusionFrames ) do
					if _G[exclusionName] then
						excluded = true;
					end
				end
			end
								
			if not excluded and frame then
			
				local defaultPosition = detail.defaultPosition or {};

				-- reparent the frame
				
				if parent then frame:SetParent( parent ); end
				
				-- if there's a list of frames we can position ourselves relative to, then
				-- find the first one that exists and use that frame as the relative frame
								
				if defaultPosition.relativeFrames then
					for i,relativeTo in pairs( defaultPosition.relativeFrames ) do
						if _G[relativeTo] then
							defaultPosition.relativeTo = relativeTo;
							break;
						end
					end
				end
				
				-- set the frame position and lock it
				
				frame:SetMovable( true );
				frame:StartMoving();
				frame:ClearAllPoints();
				
				frame:SetPoint( 
					defaultPosition.anchorPt or "BOTTOMLEFT", 
					defaultPosition.relativeTo or UIParent, 
					defaultPosition.relativePt or "BOTTOMLEFT", 
					defaultPosition.xOfs and (defaultPosition.xOfs * nUI.hScale) or frame:GetLeft(), 
					defaultPosition.yOfs and (defaultPosition.yOfs * nUI.vScale) or frame:GetBottom()
				);
				
				frame:StopMovingOrSizing();
				
				nUI_Movers:lockFrame( frame, true, nUI_L[detail.labelText] or detail.labelText or detail.frameName.." Mover" );
			
			end
		end		
	end
	
--	nUI_ProfileStop();
	
end

nUI_Movers:SetScript( "OnEvent", onMoversEvent );
nUI_Movers:RegisterEvent( "PLAYER_ENTERING_WORLD" );
nUI_Movers:RegisterEvent( "ADDON_LOADED" );
nUI_Movers:RegisterEvent( "PLAYER_LOGOUT" );
nUI_Movers:RegisterEvent( "PET_BATTLE_OPENING_START" );
nUI_Movers:RegisterEvent( "PET_BATTLE_CLOSE" );

-------------------------------------------------------------------------------

function nUI_Movers:movableFrame( frame, parent )
	
--	nUI_ProfileStart( ProfileCounter, "movableFrame" );
	
	if frame then
		frame:EnableMouse( true );
		frame:SetMovable( true );
		frame:RegisterForDrag( "LeftButton" );
		
		frame:SetScript( "OnEnter", 
			function()
				if not InCombatLockdown() then
					GameTooltip:SetOwner( frame );
					GameTooltip:SetText( nUI_L["Left-click and drag to move this frame"] );
					GameTooltip:Show();
				end
			end
		);
		
		frame:SetScript( "OnLeave",
			function()
				GameTooltip:Hide();
			end
		);
		
		frame:SetScript( "OnDragStart",
			function()			
				if not InCombatLockdown() then
					frame.is_moving = true;
					if parent then parent:StartMoving() 
					else frame:StartMoving();
					end
				end
			end
		);
		
		frame:SetScript( "OnDragStop",
			function()
				if frame.is_moving then
					frame.is_moving = false;
					if parent then parent:StopMovingOrSizing();
					else frame:StopMovingOrSizing();
					end
				end
			end
		);
	end
					
--	nUI_ProfileStop();
	
end

-------------------------------------------------------------------------------

function nUI_Movers:lockFrame( frame, mode, overlay )

--	nUI_ProfileStart( ProfileCounter, "lockFrame" );
	
	local new_mover = false;
	
	-- if we don't already have a frame cache for this frame, initialize it
	
	if not nUI_MoverFrames[frame] then	

		new_mover                    = true;		
		nUI_MoverFrames[frame]                = {};		
		nUI_MoverFrames[frame].SetAllPoints   = frame.SetAllPoints;
		nUI_MoverFrames[frame].SetPoint       = frame.SetPoint;
		nUI_MoverFrames[frame].ClearAllPoints = frame.ClearAllPoints;

	end
	
	-- lock the frame to prevent anyone else from moving it
	
	if not nUI_MoverFrames[frame].locked and mode then
		
		nUI_MoverFrames[frame].locked  = true;
		frame.SetAllPoints    = function() end;
		frame.SetPoint        = function() end;
		frame.ClearAllPoints  = function() end;
	
	-- make the frame moveable again
	
	elseif nUI_MoverFrames[frame].locked and not mode then

		nUI_MoverFrames[frame].locked  = false;
		frame.SetAllPoints    = nUI_MoverFrames[frame].SetAllPoints;
		frame.SetPoint        = nUI_MoverFrames[frame].SetPoint;
		frame.ClearAllPoints  = nUI_MoverFrames[frame].ClearAllPoints;
		
	end

	-- if this is a new mover, set up the overlay for it
	
	if new_mover then
		
		if not nUI_Data then
			nUI_Data = {};
		end
		
		if not nUI_Data.MoverAnchors then
			nUI_Data.MoverAnchors = {};
		end
		
		local frame_name = frame:GetName();
		local mover      = nUI_Data.MoverAnchors[frame_name];		

		-- if this frame has a visible overlay, then add it to the list of 
		-- movers we enable/disable on the "/nui movers" slash command

		if overlay then
			if not nUI_Movers.FrameList[frame_name] then 
				nUI_Movers.FrameList[frame_name] = frame; 
			end
		end
		
		-- record the default location for the frame
		
		nUI_MoverFrames[frame].DefaultPoints = {};
		
		for i=1,frame:GetNumPoints() do
			
			local point = {};

			point.anchor, point.relative_to, point.relative_pt, point.xOfs, point.yOfs = frame:GetPoint( i );
			point.relative_to = point.relative_to and point.relative_to.GetName and point.relative_to:GetName() or point_relative_to;
			
			nUI_MoverFrames[frame].DefaultPoints[i] = point;
			
		end
		
		-- create a default mover in the config if we don't have one yet
		
		if not mover or not mover.user_placed then
			
			mover = {};
			mover.Point = {};
			mover.user_placed = false;
			
			for i in pairs( nUI_MoverFrames[frame].DefaultPoints ) do
				mover.Point[i] = nUI_MoverFrames[frame].DefaultPoints[i];
			end
			
			nUI_Data.MoverAnchors[frame_name] = mover;
			
		end

		nUI_MoverFrames[frame].label = overlay;	
		nUI_MoverFrames[frame].drag  = true;
		
		-- create an overlay mover frame to show the user and/or for dragging the frame
	
		nUI_MoverFrames[frame].overlay = CreateFrame( "Button", frame:GetName().."_MoverOverlay", UIParent ); -- frame:GetParent() );
		
		nUI_MoverFrames[frame].overlay:SetFrameStrata( "HIGH" );
		nUI_MoverFrames[frame].overlay:SetFrameLevel( frame:GetFrameLevel()+5 );
		
		nUI_MoverFrames[frame].overlay:SetScale( frame:GetScale() );
		nUI_MoverFrames[frame].overlay:SetWidth( max( frame:GetWidth(), 25 ) );
		nUI_MoverFrames[frame].overlay:SetHeight( max( frame:GetHeight(), 25 ) );

		for i in pairs( mover.Point ) do
			local point = mover.Point[i];
			nUI_MoverFrames[frame].overlay:SetPoint( point.anchor, point.relative_to, point.relative_pt, point.xOfs, point.yOfs );
		end
		
		nUI_MoverFrames[frame].overlay:EnableMouse( true );
		nUI_MoverFrames[frame].overlay:RegisterForDrag();
		nUI_MoverFrames[frame].overlay:RegisterForClicks();
		nUI_MoverFrames[frame].overlay:SetScript( "OnDragStart", 
			function() 
--				nUI_ProfileStart( ProfileCounter, "OnDragStart" ); 
				nUI_Movers:dragFrame( frame, true ); 
--				nUI_ProfileStop();
			end 
		);
		nUI_MoverFrames[frame].overlay:SetScript( "OnDragStop", 
			function() 
--				nUI_ProfileStart( ProfileCounter, "OnDragStop" ); 
				nUI_Movers:dragFrame( frame, false ); 
--				nUI_ProfileStop();
			end 
		);
		nUI_MoverFrames[frame].overlay:SetScript( "OnClick", 
			function() 
--				nUI_ProfileStart( ProfileCounter, "OnClick" ); 
				nUI_Movers:resetFrame( frame ); 
--				nUI_ProfileStop();
			end 
		);
		nUI_MoverFrames[frame].overlay:SetMovable( true );

		-- if we want the mover to be visible, creat a texture for it
		
		if overlay then
			
			nUI_MoverFrames[frame].overlay:SetBackdrop(
				{
					bgFile   = "Interface\\AddOns\\nUI\\Layouts\\Default\\Art\\nUI_BevelboxBg.blp", 
					edgeFile = "Interface\\AddOns\\nUI\\Layouts\\Default\\Art\\nUI_BevelboxBorder.blp", 
					tile     = true, 
					tileSize = 1, 
					edgeSize = 10, 
					insets   = {left = 0, right = 0, top = 0, bottom = 0},
				}
			);
		
			nUI_MoverFrames[frame].overlay:SetBackdropColor( 1, 0.75, 0.75, 1 );
			nUI_MoverFrames[frame].overlay:SetBackdropBorderColor( 1, 0.75, 0.75, 1 );
			
			nUI_MoverFrames[frame].overlay.texture = nUI_MoverFrames[frame].overlay:CreateTexture();
			nUI_MoverFrames[frame].overlay.texture:SetAllPoints( nUI_MoverFrames[frame].overlay );
			nUI_MoverFrames[frame].overlay.texture:SetColorTexture( 1, 0.5, 0.5, 0.5 );
		
		end

		-- lock the frame to the overlay
		
		nUI_MoverFrames[frame].ClearAllPoints( frame );
		
		for i in pairs( mover.Point ) do
			local point = mover.Point[i];
			nUI_MoverFrames[frame].SetPoint( frame, point.anchor, nUI_MoverFrames[frame].overlay, point.anchor, 0, 0 );
		end
		
		-- disable any other movers that may be attached to the frame
		
		frame:RegisterForDrag();
		frame:SetScript( "OnDragStart", nil );
		frame:SetScript( "OnDragStop", nil );

		-- disable dragging
		
		self:enableDrag( frame, false );
	end	
	
--	nUI_ProfileStop();
	
end

-------------------------------------------------------------------------------

function nUI_Movers:enableDrag( frame, mode )

	if mode then

		if not nUI_MoverFrames[frame].moving and not nUI_MoverFrames[frame].drag then
			
			nUI_MoverFrames[frame].drag = true;
			nUI_MoverFrames[frame].overlay:SetWidth( max( frame:GetWidth(), 25 ) );
			nUI_MoverFrames[frame].overlay:SetHeight( max( frame:GetHeight(), 25 ) );
			nUI_MoverFrames[frame].overlay:SetScale( frame:GetScale() );
			nUI_MoverFrames[frame].overlay:Show();
			nUI_MoverFrames[frame].overlay:RegisterForDrag( "LeftButton" );
			nUI_MoverFrames[frame].overlay:RegisterForClicks( "RightButtonUp" );
			
			nUI_MoverFrames[frame].overlay:SetScript( "OnEnter", 
				function() 
					
--					nUI_ProfileStart( ProfileCounter, "OnEnter" ); 
					
					GameTooltip:SetOwner( nUI_MoverFrames[frame].overlay ); 
					GameTooltip:SetText( nUI_L["Left click and drag to move <frame label>"]:format( nUI_MoverFrames[frame].label ), 1, 0.83, 0 ); 
					
					if nUI_Data.MoverAnchors[frame:GetName()].user_placed then
						GameTooltip:AddLine( nUI_L["Right click to reset to the default location"], 1, 0.83, 0 );
					end
					
					GameTooltip:Show();
					
--					nUI_ProfileStop();
				end 
			);
			
			nUI_MoverFrames[frame].overlay:SetScript( "OnLeave", 
				function() 
--					nUI_ProfileStart( ProfileCounter, "OnLeave" ); 
					GameTooltip:Hide(); 
--					nUI_ProfileStop();
				end 
			);
			
		end
			
	else
		
		if not nUI_MoverFrames[frame].moving and nUI_MoverFrames[frame].drag then
			
			nUI_MoverFrames[frame].drag = false;
			nUI_MoverFrames[frame].overlay:Hide();
			nUI_MoverFrames[frame].overlay:RegisterForClicks();
			nUI_MoverFrames[frame].overlay:RegisterForDrag();
			nUI_MoverFrames[frame].overlay:SetScript( "OnEnter", function() end );
			nUI_MoverFrames[frame].overlay:SetScript( "OnLeave", function() end );
		end		
	end
end

-------------------------------------------------------------------------------

function nUI_Movers:dragFrame( frame, mode )
	
--	nUI_ProfileStart( ProfileCounter, "dragFrame" ); 
	
	if mode and nUI_MoverFrames[frame].drag and not nUI_MoverFrames[frame].moving then
		
		nUI_MoverFrames[frame].overlay:StartMoving();
		nUI_MoverFrames[frame].moving = true;
		GameTooltip:Hide();
		
	elseif not mode and nUI_MoverFrames[frame].drag and nUI_MoverFrames[frame].moving then
		
		local mover   = nUI_Data.MoverAnchors[frame:GetName()];
		local overlay = nUI_MoverFrames[frame].overlay;
		
		overlay:StopMovingOrSizing();
		nUI_MoverFrames[frame].moving = false;

		mover.Point = {};
		mover.user_placed = true;
		
		for i=1,overlay:GetNumPoints() do
			
			local point = {};

			point.anchor, point.relative_to, point.relative_pt, point.xOfs, point.yOfs = overlay:GetPoint( i );
			point.relative_to = point.relative_to and point.relative_to:GetName() or point_relative_to;
			
			mover.Point[i] = point;
			
		end
	end
	
--	nUI_ProfileStop();
	
end

-------------------------------------------------------------------------------

function nUI_Movers:resetFrame( frame )
	
--	nUI_ProfileStart( ProfileCounter, "resetFrame" ); 
	
	local mover       = nUI_Data.MoverAnchors[frame:GetName()];
	local overlay     = nUI_MoverFrames[frame].overlay;

	for i in pairs( nUI_MoverFrames[frame].DefaultPoints ) do
		mover.Point[i] = nUI_MoverFrames[frame].DefaultPoints[i];
	end

	mover.user_placed = false;
	
	-- lock the frame to the overlay
	
	nUI_MoverFrames[frame].overlay:ClearAllPoints();
	
	for i in pairs( mover.Point ) do
		
		local point = mover.Point[i];						
		nUI_MoverFrames[frame].overlay:SetPoint( point.anchor, point.relative_to, point.relative_pt, point.xOfs, point.yOfs );
		
	end
	
--	nUI_ProfileStop();
	
end
