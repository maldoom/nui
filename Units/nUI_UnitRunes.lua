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
if not nUI_UnitOptions then nUI_UnitOptions = {}; end
if not nUI_DefaultConfig then nUI_DefaultConfig = {}; end
if not nUI_Profile then nUI_Profile = {}; end;

local GetRunes = GetRunes;

-- stolen directly from RuneFrame.lua for now -- need to nUIize this

local RUNETYPE_BLOOD  = 1;
local RUNETYPE_UNHOLY = 2;
local RUNETYPE_FROST  = 3;
local RUNETYPE_DEATH  = 4;

local iconTextures = 
{
	[RUNETYPE_BLOOD]  = "Interface\\PlayerFrame\\UI-PlayerFrame-Deathknight-Blood",
	[RUNETYPE_UNHOLY] = "Interface\\PlayerFrame\\UI-PlayerFrame-Deathknight-Unholy",
	[RUNETYPE_FROST]  = "Interface\\PlayerFrame\\UI-PlayerFrame-Deathknight-Frost",
	[RUNETYPE_DEATH]  = "Interface\\PlayerFrame\\UI-PlayerFrame-Deathknight-Death",
};

local runeColors = 
{
	[RUNETYPE_BLOOD]  = {1, 0, 0},
	[RUNETYPE_UNHOLY] = {0, 0.5, 0},
	[RUNETYPE_FROST]  = {0, 1, 1},
	[RUNETYPE_DEATH]  = {0.8, 0.1, 1},
};

local MAX_RUNE_CAPACITY = 7;

-------------------------------------------------------------------------------
-- unit runes event management

if not nUI_Unit.Drivers then 
	nUI_Unit.Drivers = CreateFrame( "Frame", "nUI_UnitDrivers", WorldFrame ); 
end

nUI_Profile.nUI_UnitRunes       = {};
nUI_Profile.nUI_UnitRunes.Frame = {};

local ProfileCounter      = nUI_Profile.nUI_UnitRunes;
local FrameProfileCounter = nUI_Profile.nUI_UnitRunes.Frame;

local frame = CreateFrame( "Frame", "$parent_Runes", nUI_Unit.Drivers )

local RunesCallbacks    = {};
local RunesUnits        = {};
local RunesStatus       = {};
local NewUnitInfo       = {};
local UpdateQueue       = {};
local queue_timer       = 1 / nUI_DEFAULT_FRAME_RATE;

nUI_Unit.Drivers.Runes  = frame;

-------------------------------------------------------------------------------
-- variables used in methods within this module are declared here to eliminate
-- the use of dynamic memory and the garbage collector

local unit_id;
local unit_info;
local list;
local modified;
local prior_state;
local has_runes;		
local runes;
local newRunes = {};
local proc_time;
local start, duration, ready;
local oldRune;
local newRune;
local button;
local rune;

-------------------------------------------------------------------------------

local UpdateRuneFrame = function(self,unit)
	if not unit then return end
	local class,key = UnitClass(unit)
	if key == "DEATHKNIGHT" and unit == "player" then
		self:Show()
	else
		self:Hide()
	end
end

local UpdateNumberOfShownRunes = function(self,unit)

	if not self then return end
	if not self.runes then return end	

	local numRunes = UnitPower(unit, SPELL_POWER_RUNES);

	if self.numRunes ~= numRunes
	then
		self.numRunes = numRunes;
		
		for i=1, MAX_RUNE_CAPACITY 
		do
			local runeButton = self.runes[i];
			
			if ( runeButton ) then
				if i <= numRunes then
					runeButton:Show();
				else
					runeButton:Hide();
				end
			
				-- Shrink the runes sizes if you have all 7
				if (numRunes == MAX_RUNE_CAPACITY) then
					runeButton.Border:SetSize(21, 21);
					runeButton.rune:SetSize(21, 21);
					runeButton.Textures.Shine:SetSize(52, 31);
					runeButton.energize.RingScale:SetFromScale(0.6, 0.7);
					runeButton.energize.RingScale:SetToScale(0.7, 0.7);
					runeButton:SetSize(15, 15);
				else
					runeButton.Border:SetSize(24, 24);
					runeButton.rune:SetSize(24, 24);
					runeButton.Textures.Shine:SetSize(60, 35);
					runeButton.energize.RingScale:SetFromScale(0.7, 0.8);
					runeButton.energize.RingScale:SetToScale(0.8, 0.8);
					runeButton:SetSize(18, 18);
				end
			end
		end
	end
end

local UpdateRunePower = function(self, runeIndex, isEnergize)
	if not self then return end
	if not self.runes then return end	
	if not self.numRunes then return end

	if runeIndex and self.numRunes and runeIndex >= 1 and runeIndex <= self.numRunes  then 
		local runeButton = self.runes[runeIndex];
	
		if not runeButton then return end

		local start, duration, runeReady = GetRuneCooldown(runeIndex)
		
		if not runeReady  then
			if start then
				runeButton.icon:SetVertexColor( 1, 0, 0, 1 );
			end
			runeButton.energize:Stop()
		else
			runeButton.icon:SetVertexColor( 0, 1, 0, 1 );
		end
		
		if isEnergize  then
			runeButton.energize:Play();
		end
	end
end

-------------------------------------------------------------------------------
-- update rune status and timers at the user selected frame rate

local runeTimer = 1 / nUI_DEFAULT_FRAME_RATE;

local function onRunesUpdate( who, elapsed )

	queue_timer = queue_timer - elapsed;
	
	if queue_timer <= 0 then -- process the update queue at the user selected frame rate
	
		queue_timer = nUI_Unit.frame_rate;

		for unit_id in pairs( UpdateQueue ) do
		
			if UpdateQueue[unit_id] then
			
				UpdateQueue[unit_id] = false;
				unit_info = NewUnitInfo[unit_id];
								
				if RunesCallbacks[unit_id] and #RunesCallbacks[unit_id] > 0 then
					nUI_Unit:notifyCallbacks( 
						nUI_L["unit runes"], RunesCallbacks, RunesUnits, 
						unit_info, unit_id, nUI_Unit:updateRunesInfo( unit_id, unit_info ) 
					);
				end
			end
		end
	end	

	runeTimer = runeTimer - elapsed;
	
	if runeTimer <= 0 then
		
		runeTimer = nUI_Unit.frame_rate;
		
		frame.newUnitInfo( "player", nUI_Unit.PlayerInfo );
		
	end
end

frame:SetScript( "OnUpdate", onRunesUpdate );

-------------------------------------------------------------------------------
-- this callback method is called when one of the unit IDs we are monitoring
-- for unit runes changes GUID

frame.newUnitInfo = function( unit_id, unit_info )

--	nUI_ProfileStart( ProfileCounter, "newUnitInfo" );	
	
	UpdateQueue[unit_id] = true;
	NewUnitInfo[unit_id] = unit_info;
	
--	nUI_ProfileStop();
	
end

-------------------------------------------------------------------------------
-- add and remove callbacks from the list of unit runes listeners we manage
--
-- calling this method will return the current unit_info structure for this 
-- unit if it exists or nil if the unit does not exist at this time
--
-- Note: these callbacks will be notified both when the underlying GUID for the
--		 unit changes or when the runes info of the underlying GUID to the
--		 player changes. If the underlying unit does not exist, the callback
--		 will be passed a nil unit_info structure

function nUI_Unit:registerRunesCallback( unit_id, callback )
	
--	nUI_ProfileStart( ProfileCounter, "registerRunesCallback" );	
	
	unit_info = nil;
	
	if unit_id and callback then
		
		-- get the list of callbacks for this unit id and add this callback
		
		list = RunesCallbacks[unit_id] or {};
		
		nUI:TableInsertByValue( list, callback );
		
		-- if this is a new unit id, add it to the callback list
		
		if not RunesCallbacks[unit_id] then
			RunesCallbacks[unit_id] = list;
		end
		
		-- if this is the first callback for the unit id, then register our
		-- event driver to receive notice when the GUID changes on this id
		
		if #list == 1 then
			nUI_Unit:registerUnitChangeCallback( unit_id, nUI_Unit.Drivers.Runes );
		end
		
		-- collect runes information for this unit as we know it at this time
	
		unit_info = nUI_Unit:getUnitInfo( unit_id );
		
		if unit_info then
			nUI_Unit:updateRunesInfo( unit_id, unit_info );
		end
	end
	
--	nUI_ProfileStop();
	
	return unit_info;
	
end

function nUI_Unit:unregisterRunesCallback( unit_id, callback )
	
--	nUI_ProfileStart( ProfileCounter, "unregisterRunesCallback" );	
	
	if unit_id and callback then
		
		-- get the list of current callbacks for this unit ud and remove this callback
		
		list = RunesCallbacks[unit_id] or {};
		
		nUI:TableRemoveByValue( list, callback );
		
		-- if that's the last callback in the list, then remove our event handler of
		-- the list of unit change callbacks for that unit it
		
		if #list == 0 then
			nUI_Unit:unregisterUnitChangeCallback( unit_id, nUI_Unit.Drivers.Runes );
		end
	end

--	nUI_ProfileStop();
	
end

-------------------------------------------------------------------------------
-- update the runes information for this unit
--
-- note: it is the caller's responsibility to ensure that the unit_info being
--       passed belongs to the unit_id that is passed. Generally third party
--       consumers of unit_info should not call this method, rather they 
--       should use the callback registration system to get change notices
--       and let the nUI unit driver engine do the updating. If you MUST call
--       this method, you should first test that the following condition 
--       evaluates as true: UnitGUID( unit_id ) == unit_info.guid
--
-- returns the updated unit information structure for the current GUID
-- if the data has changed, otherwise returns nil if nothing changed

function nUI_Unit:updateRunesInfo( unit_id, unit_info )

--	nUI_ProfileStart( ProfileCounter, "updateRunesInfo" );	
	
	modified  = false;
	
	if unit_info then

		has_runes = unit_info.class == "DEATHKNIGHT" and UnitIsUnit( unit_id, "player" );		
		runes     = has_runes and (unit_info.runes or {}) or nil;
		proc_time = GetTime();
		
		if has_runes and frame.numRunes then
				
			for i=1,frame.numRunes do
				
				if not newRunes[i] then newRunes[i] = {}; end
				
				start, duration, ready = GetRuneCooldown( i );

				newRunes[i].start    = start;
				newRunes[i].duration = duration;
				newRunes[i].ready    = ready;
				newRunes[i].remains  = (not ready and start and duration) and nUI_DurationText(start + duration - proc_time) or nil;
				newRunes[i].noflash  = true;

			end				
		end
		
		-- if we are adding or removing runes from the unit info then
		-- that's all we need to worry about
		
		if (unit_info.runes and not runes)
		or (not unit_info.runes and runes)
		then
			
			modified               = true;
			unit_info.modified     = true;
			unit_info.last_change  = GetTime();
			unit_info.runes        = runes;
			
		-- otherwise we need to loop through the runes if there are
		-- any and check each one for changes
		
		elseif runes then
			
			for i=1,#newRunes do
				
				oldRune = runes[i];
				newRune = newRunes[i];
				
				if oldRune.type     ~= newRune.type
				or oldRune.ready    ~= newRune.ready
				or oldRune.duration ~= newRune.duration
				or oldRune.start    ~= newRune.start
				or oldRune.remains  ~= newRune.remains
				then
					
					modified               = true;
					unit_info.modified     = true;
					unit_info.last_change  = GetTime();
					
				end
			end
		end
	end

	-- if we're updating the actual rune list, do it here
	
	if runes and modified then
	
		for i=1,#newRunes do

			if not runes[i] then runes[i] = {}; end
			
			oldRune = runes[i];
			newRune = newRunes[i];
			
			oldRune.type     = newRune.type;
			oldRune.ready    = newRune.ready;
			oldRune.duration = newRune.duration;
			oldRune.start    = newRune.start;
			oldRune.remains  = newRune.remains;
			oldRune.noflash  = newRune.noflash;			
		end
	end
		
--	nUI_ProfileStop();
	
	return modified and unit_info or nil;
	
end

-------------------------------------------------------------------------------
-- update all of the registered unit runes listeners, even if there's no 
-- change in data... typically used when entering the world

function nUI_Unit:refreshRunesCallbacks()

--	nUI_ProfileStart( ProfileCounter, "refreshRunesCallbacks" );	
	
	for unit_id in pairs( RunesCallbacks ) do
		if RunesCallbacks[unit_id] and #RunesCallbacks[unit_id] > 0 then
			UpdateQueue[unit_id] = true;
			NewUnitInfo[unit_id] = nUI_Unit:getUnitInfo( unit_id );
		end
	end

--	nUI_ProfileStop();
	
end

-------------------------------------------------------------------------------
-- create a new unit runes frame

function nUI_Unit:createRunesFrame( parent, unit_id, id, options )

--	nUI_ProfileStart( ProfileCounter, "createRunesFrame" );	
	
	local frame = nUI_Unit:createFrame( "$parent_Runes"..(id or ""), parent, unit_id, options and options.clickable );

	frame.runes = {};
	frame.Super = {};

	for i=1,MAX_RUNE_CAPACITY do
	
		local rune = CreateFrame( "Button", "$parent_Rune"..i, frame, "RuneButtonIndividualTemplate" );		
		local name = rune:GetName();

		rune.icon         = _G[name.."Rune"];
		rune.fill         = _G[name.."Fill"];
		rune.shine        = _G[name.."ShineTexture"];
		rune.text         = rune:CreateFontString( name.."_Text", "OVERLAY" );
		rune.text.enabled = false;
		
		rune.icon:Show();
		rune:EnableMouse( false );
		rune:SetScript( "OnLoad", nil );
		
		frame.runes[i] = rune;
	end

	UpdateNumberOfShownRunes( frame, unit_id );

	if frame.numRunes then
		for i=1,frame.numRunes do
			UpdateRunePower( frame, i, false );
		end
	end

	-- called when the underlying GUID for the unit changes or when the
	-- content of the GUID is updated

	frame.Super.newUnitInfo = frame.newUnitInfo;
	frame.newUnitInfo       = function( list_unit, unit_info )
		
--		nUI_ProfileStart( FrameProfileCounter, "newUnitInfo" );	
	
		frame.Super.newUnitInfo( list_unit, unit_info );
		
		if frame.enabled then
			nUI_Unit:updateRunesFrame( frame );
		end
		
--		nUI_ProfileStop();
		
	end

	-- called on rune related events so we can update the rune display
	
	frame.onRuneEvent = function(self, event, ...)

		UpdateQueue["player"] = true;
		NewUnitInfo["player"] = nUI_Unit.PlayerInfo;	

		if event == "PLAYER_ENTERING_WORLD" then

			UpdateNumberOfShownRunes(frame, "player");			

			if frame.numRunes then
				for i=1,frame.numRunes do
					UpdateRunePower(frame,i,false)
				end
			end

		elseif event == "ON_SHOW" then

			frame:RegisterEvent("RUNE_POWER_UPDATE");
			frame:RegisterEvent("RUNE_TYPE_UPDATE");
			frame:RegisterUnitEvent("UNIT_MAXPOWER","player");
			frame:RegisterEvent("PLAYER_ENTERING_WORLD");

			UpdateNumberOfShownRunes( frame, "player" );

			if frame.numRunes then
				for i=1,frame.numRunes do
					UpdateRunePower( frame, i, false );
				end
			end

		elseif event == "ON_HIDE" then

			frame:UnregisterEvent("RUNE_POWER_UPDATE");
			frame:UnregisterEvent("RUNE_TYPE_UPDATE");
			frame:UnregisterUnitEvent("UNIT_MAXPOWER","player");
			frame:UnregisterEvent("PLAYER_ENTERING_WORLD");

		elseif event == "UNIT_MAXPOWER" then

			UpdateNumberOfShownRunes(frame, "player");	
			if frame.numRunes then
				for i=1,frame.numRunes do
					UpdateRunePower(frame,i,false)
				end
			end

		elseif event == "RUNE_POWER_UPDATE" then
			local runeIndex,isEnergize = ...

			UpdateRunePower(frame, runeIndex, isEnergize);

		elseif event == "RUNE_TYPE_UPDATE" then
			local runeIndex = ...

			if ( runeIndex and frame.numRunes and runeIndex >= 1 and runeIndex <= frame.numRunes ) then
				RuneButton_Flash(frame.runes[i])
			end
		
		end
	end

	frame:SetScript( "OnEvent", frame.onRuneEvent );
	frame:RegisterEvent("ON_SHOW");
	frame:RegisterEvent("ON_HIDE");

	if frame:IsVisible() then
		frame:RegisterEvent("RUNE_POWER_UPDATE");
		frame:RegisterEvent("RUNE_TYPE_UPDATE");
		frame:RegisterUnitEvent("UNIT_MAXPOWER","player");
		frame:RegisterEvent("PLAYER_ENTERING_WORLD");
	end

	-- setting enabled to false will prevent the frame from updating when new
	-- unit information is received (saves framerate). Setting enabled true will
	-- call the frame to immediately update if its content has changed since it
	-- was disabled

	frame.Super.setEnabled = frame.setEnabled;	
	frame.setEnabled       = function( enabled )
		
--		nUI_ProfileStart( FrameProfileCounter, "setEnabled" );	
	
		prior_state = frame.enabled;
		
		frame.Super.setEnabled( enabled );
		
		if frame.enabled ~= prior_state then
		
			if frame.enabled then
				frame.unit_info = nUI_Unit:registerRunesCallback( frame.unit, frame );
				nUI_Unit:updateRunesFrame( frame );
			else
				nUI_Unit:unregisterRunesCallback( frame.unit, frame );
			end
		end

--		nUI_ProfileStop();
		
	end
	
	-- used to change the scale of the frame... rather than the Bliz widget frame:SetScale()
	-- this method actually recalculates the size of the frame and uses frame:SetHeight()
	-- and frame:SetWidth() to reflect the actual size of the frame.
	
	frame.Super.applyScale = frame.applyScale;	
	frame.applyScale       = function( scale )

--		nUI_ProfileStart( FrameProfileCounter, "applyScale" );	
	
		frame.Super.applyScale( scale );
		
		local hgap = (frame.options and frame.options.hgap or 0) * frame.hScale;
		local last_texture, first, left, right;
		
		if frame.runes[1].hSize  ~= frame.hSize 
		or frame.runes[1].vSize  ~= frame.vSize 
		or frame.runes[1].width  ~= frame.width
		or frame.runes[1].height ~= frame.height 
		or frame.runes[1].hInset ~= frame.hInset
		or frame.runes[1].vInset ~= frame.vInset
		or frame.runes[1].hgap   ~= hgap
		then
			
			frame.runes[1].hSize  = frame.hSize;
			frame.runes[1].vSize  = frame.vSize;
			frame.runes[1].width  = frame.width;
			frame.runes[1].height = frame.height;
			frame.runes[1].hInset = frame.hInset;
			frame.runes[1].vInset = frame.vInset;
			frame.runes[1].hgap   = hgap;
			
			for i=1, #frame.runes do
				
				local texture = frame.runes[i];
				local config  = frame.options.timer and 
				{
					relative_to = texture:GetName(),
					fontsize    = frame.options.fontsize,
					justifyH    = frame.options.justifyH,
					justifyV    = frame.options.justifyV,
					color       = frame.options.color,
					anchor_pt   = frame.options.timer.anchor_pt,
					relative_pt = frame.options.timer.relative_pt,
					xOfs        = frame.options.timer.xOfs,
					yOfs        = frame.options.timer.yOfs,
				};
				
				if frame.options.timer then 
					frame.configText( texture.text, config ); 
					texture.text.enabled = true; 
				end
				
				texture:ClearAllPoints();
				
				if options.orient == "RIGHT" then
					if i == 1 then texture:SetPoint( "RIGHT", frame, "RIGHT", 0, 0 );
					else texture:SetPoint( "RIGHT", last_texture, "LEFT", -hgap, 0 );
					end
				elseif options.orient == "CENTER" then
					if i == 1 then texture:SetPoint( "LEFT", frame, "CENTER", hgap/2, 0 ); first = texture;
					elseif (i % 2) == 0 then texture:SetPoint( "RIGHT", left or first, "LEFT", -hgap, 0 ); left = texture;
					else texture:SetPoint( "LEFT", right or first, "RIGHT", hgap, 0 ); right = texture;
					end
				elseif options.orient == "TOP" then
					if i == 1 then texture:SetPoint( "TOP", frame, "TOP", 0, 0 );
					else texture:SetPoint( "TOP", last_texture, "BOTTOM", 0, -hgap );
					end
				elseif options.orient == "BOTTOM" then
					if i == 1 then texture:SetPoint( "BOTTOM", frame, "BOTTOM", 0, 0 );
					else texture:SetPoint( "BOTTOM", last_texture, "TOP", 0, hgap );
					end
				elseif options.orient == "MIDDLE" then
					if i == 1 then texture:SetPoint( "BOTTOM", frame, "CENTER", 0, hgap/2 ); first = texture;
					elseif (i % 2) == 0 then texture:SetPoint( "TOP", left or first, "BOTTOM", 0, -hgap ); left = texture;
					else texture:SetPoint( "BOTTOM", right or last_first, "TOP", 0, hgap ); right = texture;
					end
				else
					if i == 1 then texture:SetPoint( "LEFT", frame, "LEFT", 0, 0 );
					else texture:SetPoint( "LEFT", last_texture, "RIGHT", hgap, 0 );
					end				
				end

				texture:SetScale( ((frame.vSize or frame.height) - frame.vInset) / texture:GetHeight() );

				last_texture = texture;
				
			end
		end		

--		nUI_ProfileStop();
		
	end
	
	-- applies the set of frame options to this frame. Typically called when the frame 
	-- is first created or when the user changes options via config.
	
	frame.Super.applyOptions = frame.applyOptions;
	frame.applyOptions       = function( options )

--		nUI_ProfileStart( FrameProfileCounter, "applyOptions" );	
	
		frame.Super.applyOptions( options );		
		
		for i=1,MAX_RUNE_CAPACITY do
			
			local rune   = frame.runes[i];
			local strata = frame:GetFrameStrata();
			local level  = frame:GetFrameLevel();
			
			rune:SetID( i );
			rune:SetFrameStrata( strata );
			rune:SetFrameLevel( level );
		end
			
		frame.applyScale( options.scale or frame.scale or 1 );
				
		nUI_Unit:updateRunesFrame( frame );
		
--		nUI_ProfileStop();
		
	end

	-- initiate the frame
	
	frame.unit_info = nUI_Unit:registerRunesCallback( frame.unit, frame );
	
	frame.applyOptions( options );
	
--	nUI_ProfileStop();
	
	return frame;
	
end

-------------------------------------------------------------------------------
-- remove a unit runes frame

function nUI_Unit:deleteRunesFrame( frame )

--	nUI_ProfileStart( ProfileCounter, "deleteRunesFrame" );

	nUI_Unit:unregisterRunesCallback( frame.unit, frame );
	nUI_Unit:deleteFrame( frame );
	
--	nUI_ProfileStop();
	
end

-------------------------------------------------------------------------------
-- display the appropriate icon for the unit's runes status
--
-- note: this method expends extra energy in state management... as in knowing
--       exactly what state it is currently in and only updating the frame text,
--       content, colors, alphas, etc. when a change in state occurs. The extra
--       effort is spent on state management in order to reduce impact to the
--       graphis engine so as to preserve frame rate. It costs far less to check
--		 a memory value that and burn through the graphics geometry. It does not
--       matter how many times the unit changes GUID or how many times this 
--       method will call, it will only alter the graphics elements when its
--       relative state changes.

function nUI_Unit:updateRunesFrame( frame )
	
--	nUI_ProfileStart( ProfileCounter, "updateRunesFrame" );

	unit_info = frame.unit_info;
	
	-- if there is no unit or we don't know it's runes status, then hide the icons
	
	if not unit_info 
	or not unit_info.runes
	then
		
		if frame.active then
			frame.active = false;
			frame:SetAlpha( 0 );
		end
	
	-- otherwise, show the icon
	
	else

		-- if the runes icon is hidden, show it
		
		if not frame.active then
			frame.active = true;
			frame:SetAlpha( 1 );
		end
		
		for i=1,#unit_info.runes do
			
			button = frame.runes[i];
			rune   = unit_info.runes[button:GetID()];

			if not button.icon:IsShown() 
			and not InCombatLockdown()
			then button.icon:Show();
			end
			
			if rune.type
			and rune.type ~= button.icon.type 
			then
			
				button.icon.type = type;
				
				if not rune.noflash then
					button.shine:SetVertexColor( unpack( runeColors[rune.type] ) );
					RuneButton_ShineFadeIn( button.shine );
				end
			
				button.icon:SetTexture( iconTextures[rune.type] );
				button.icon:SetAlpha( rune.ready and 1 or 0.5 );
				
				-- 5.0.4 Change Start
				--button.tooltipText = _G["COMBAT_TEXT_RUNE_"..runeMapping[rune.type]];
				-- Legion Change TJK
				--button.tooltipText = _G["COMBAT_TEXT_RUNE_"..RUNE_MAPPING[rune.type]];
				if runeMapping and runeMapping[rune.type] then
					button.tooltipText = _G["COMBAT_TEXT_RUNE_"..RUNE_MAPPING[rune.type]];
				end
				-- Legion Change TJK
				-- 5.0.4 Change End

				if button.text.active and button.text.value ~= rune.remains then
					button.text.value = rune.remains;
					button.text:SetText( rune.remains or "" );
				end
				
			elseif not rune.type then
				
				button.icon:SetAlpha( 0 );
				button.tooltipText = nil;

			end			
		end
	end
	
--	nUI_ProfileStop();
	
end
