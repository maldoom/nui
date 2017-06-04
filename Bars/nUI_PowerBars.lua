
------------------------------------------------------------------------------------
-- Name : nUI_Plugin_TempMovers                                          
-- Copyright : Tina Kirby AKA Xrystal (C) 2009/2010 All Rights Reserved      
-- Contact : xrystal@swangen.co.uk                                           
-- Download Sites :                                                          
-- Version : 1.01.00 - New
-- Version : 1.02.00 - Added fake player frame functionality on target change
-- Version : 1.03.00 - also used fake player frame stuff on entering world
-- Version : 1.04.00 - Use Paladin and Warlock OnLoad and Update routines when initialising 
-- Version : 1.05.00 - Use Druid UpdateShown routine when initialising
-- Version : 1.06.00 - Hide Druid Eclipse Bar so as not to call OnShow too soon
-- Version : 1.07.00 - Make sure Druid Eclipse Bar is allowed to be moved
------------------------------------------------------------------------------------

--[[ Use Addon Wide Data Table ]]--
local addonName,addonData = ...

local PTM_Frame = CreateFrame("Frame","PTM_Frame",UIParent);
PTM_Frame.unit = "player";
PTM_Frame:SetParent(UIParent);
PTM_Frame:SetPoint( "TOP", nUI_TopBars, "BOTTOM", 0, 12 );

local function PTM_MonkPBInit()
	if MonkHarmonyBarFrame then
		MonkHarmonyBarFrame:SetParent(PTM_Frame);
		MonkHarmonyBarFrame:SetFrameStrata( "BACKGROUND" );
		MonkHarmonyBarFrame:SetFrameLevel( 0 );
		MonkHarmonyBarFrame:ClearAllPoints();
		MonkHarmonyBarFrame:SetPoint( "TOP", nUI_TopBars, "BOTTOM", 0, 28 );
		nUI_Movers:lockFrame( MonkHarmonyBarFrame, false, "nUI_XMonkHarmonyBar" );
	end
	if MonkStaggerBar then
		MonkStaggerBar:SetParent(PTM_Frame);
		MonkStaggerBar:SetFrameStrata( "BACKGROUND" );
		MonkStaggerBar:SetFrameLevel( 0 );
		MonkStaggerBar:ClearAllPoints();
		MonkStaggerBar:SetPoint( "TOP", nUI_TopBars, "BOTTOM", 0, 10 );
		nUI_Movers:lockFrame( MonkStaggerBar, false, "nUI_XMonkStaggerBar" );
	end
end

local function PTM_WarlockPBInit()
	if WarlockPowerFrame then
		WarlockPowerFrame:SetParent(PTM_Frame);
		WarlockPowerFrame:SetScale(		(40 * nUI.vScale) 
			/ (WarlockPowerFrame:GetTop()-WarlockPowerFrame:GetBottom()) 
			* 0.75
		);
		WarlockPowerFrame:SetFrameStrata( "BACKGROUND" );
		WarlockPowerFrame:SetFrameLevel( 0 );
		WarlockPowerFrame:ClearAllPoints();
		WarlockPowerFrame:SetPoint( "TOP", nUI_TopBars, "BOTTOM", 0, 12 );
		nUI_Movers:lockFrame( WarlockPowerFrame, false, "nUI_XWarlockPowerFrame" );
	end
end

local function PTM_PaladinPBInit()
	if PaladinPowerBarFrame then 
		PaladinPowerBarFrame:SetParent(PTM_Frame);
		PaladinPowerBarFrame:SetScale( 
			(40 * nUI.vScale) 
			/ (PaladinPowerBarFrame:GetTop()-PaladinPowerBarFrame:GetBottom()) 
			* 1.2
		);
		PaladinPowerBarFrame:SetFrameStrata( "BACKGROUND" );
		PaladinPowerBarFrame:SetFrameLevel( 0 );
		PaladinPowerBarFrame:ClearAllPoints();
		PaladinPowerBarFrame:SetPoint( "TOP", nUI_TopBars, "BOTTOM", 0, 20 );
		nUI_Movers:lockFrame( PaladinPowerBarFrame, true, "nUI_XPaladinPowerBar" ); 		
	end	
end

local function PTM_MagePBInit()
	if MageArcaneChargesFrame then 
		MageArcaneChargesFrame:SetParent(PTM_Frame);
		MageArcaneChargesFrame:SetScale( 
			(40 * nUI.vScale) 
			/ (MageArcaneChargesFrame:GetTop()-MageArcaneChargesFrame:GetBottom()) 
			* 1.2
		);
		MageArcaneChargesFrame:SetFrameStrata( "BACKGROUND" );
		MageArcaneChargesFrame:SetFrameLevel( 0 );
		MageArcaneChargesFrame:ClearAllPoints();
		MageArcaneChargesFrame:SetPoint( "TOP", nUI_TopBars, "BOTTOM", 0, 20 );
		nUI_Movers:lockFrame( MageArcaneChargesFrame, true, "nUI_XMagePowerBar" ); 		
	end	
end

local function PTM_AlternateManaPBInit()
	if PlayerFrameAlternateManaBar then 
		PlayerFrameAlternateManaBar:SetParent(PTM_Frame);
		PlayerFrameAlternateManaBar:SetScale( 
			(40 * nUI.vScale) 
			/ (PlayerFrameAlternateManaBar:GetTop()-PlayerFrameAlternateManaBar:GetBottom()) 
			* 0.5
		);
		PlayerFrameAlternateManaBar:SetFrameStrata( "BACKGROUND" );
		PlayerFrameAlternateManaBar:SetFrameLevel( 0 );
		PlayerFrameAlternateManaBar:ClearAllPoints();
		PlayerFrameAlternateManaBar:SetPoint( "TOP", nUI_TopBars, "BOTTOM", 0, 10 );
		nUI_Movers:lockFrame( PlayerFrameAlternateManaBar, true, "nUI_XAlternatePowerBar" ); 		
	end	
end

local function PTM_Events(self,event,...)

	local arg1,arg2,arg3,arg4,arg5,arg6 = ...;
	
	if ( event == "ADDON_LOADED" and arg1 == addonName ) then
	
		self.unit = PlayerFrame.unit;		
		
	elseif ( event == "PLAYER_ENTERING_WORLD" ) then

		local emptyVar, class = UnitClass("player");

		self.unit = PlayerFrame.unit;	

		if     class == "MONK" then PTM_MonkPBInit();
		elseif class == "PALADIN" then PTM_PaladinPBInit(); 
		elseif class == "WARLOCK" then PTM_WarlockPBInit(); 
		elseif class == "MAGE" then PTM_MagePBInit(); 
		elseif class == "DRUID" then PTM_AlternateManaPBInit();
		end
		
		PTM_AlternateManaPBInit();
		self:UnregisterEvent(event);
		
	end
end

--[[ Register the events we want to watch ]]--
PTM_Frame:SetScript( "OnEvent", PTM_Events );
PTM_Frame:RegisterEvent( "ADDON_LOADED" );
PTM_Frame:RegisterEvent( "PLAYER_ENTERING_WORLD" );

