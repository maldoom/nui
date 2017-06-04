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

local GetTime   = GetTime;
local UnitLevel = UnitLevel;

-------------------------------------------------------------------------------
-- colors use to display level difficulty

local LevelColors =
{
	Normal    = { r = 1, g = 1, b = 1, },
	Trivial   = { r = 0.5, g = 0.5, b = 0.5, },
	Easy      = { r = 0, g = 1, b = 0, },
	Difficult = { r =1, g = 0.83, b = 0, },
	Hard      = { r = 1, g = 0, b = 0, },
};

-------------------------------------------------------------------------------
-- unit level event management

if not nUI_Unit.Drivers then 
	nUI_Unit.Drivers = CreateFrame( "Frame", "nUI_UnitDrivers", WorldFrame ); 
end

nUI_Profile.nUI_UnitLevel       = {};
nUI_Profile.nUI_UnitLevel.Frame = {};

local ProfileCounter      = nUI_Profile.nUI_UnitLevel;
local FrameProfileCounter = nUI_Profile.nUI_UnitLevel.Frame;

local frame = CreateFrame( "Frame", "$parent_Level", nUI_Unit.Drivers )

local LevelCallbacks    = {};
local LevelUnits        = {};
local NewUnitInfo       = {};
local UpdateQueue       = {};
local queue_timer       = 1 / nUI_DEFAULT_FRAME_RATE;

nUI_Unit.Drivers.Level  = frame;

-------------------------------------------------------------------------------
-- variables used in methods within this module are declared here to eliminate
-- the use of dynamic memory and the garbage collector

local unit_id;
local unit_info;
local list;
local modified;
local level;
local color;
local player_level;
local level_dx;
local prior_state;
local r;
local g;
local b;

-------------------------------------------------------------------------------

local function onLevelEvent( who, event, arg1 )

--	nUI_ProfileStart( ProfileCounter, "onLevelEvent", event );
	
	-- for these events, we don't know which units are affected, so
	-- we span the list of all known interested units to see who is watching
		
	if event == "PLAYER_ENTERING_WORLD" then

		nUI_Unit:refreshLevelCallbacks();
		
	-- player leveling is a special event... in this case, we cannot count on the
	-- UnitLevel() method returning the correct player level and have to use the
	-- value passed on arg1 so we have to bypass the usual level update method
	-- and directly modify the player unit info, then pass the word on from there
	
	elseif event == "PLAYER_LEVEL_UP" then

		arg1 = tonumber( arg1 );
		
		local unit_info = nUI_Unit.PlayerInfo;
		local callbacks = LevelCallbacks;
		local unitlist  = LevelUnits;
		
		if nUI_Locale == "zhTW"		-- Traditional Chinese
		or nUI_Locale == "zhCN" 	-- Simplified Chinese
		then
			DEFAULT_CHAT_FRAME:AddMessage( nUI_L["nUI says: Gratz for reaching level %d %s!"]:format( unit_info.name, arg1 ), 1, 0.83, 0 );
		else
			DEFAULT_CHAT_FRAME:AddMessage( nUI_L["nUI says: Gratz for reaching level %d %s!"]:format( arg1, unit_info.name ), 1, 0.83, 0 );
		end;
		
		unit_info.modified    = true;
		unit_info.last_change = GetTime();
		unit_info.level       = arg1;
	
		nUI_Unit:notifyCallbacks( nUI_L["unit level"], callbacks, unitlist, unit_info, "player", true );
		
	-- we're only going to look at the event if there's someone who cares about it
		
	elseif LevelCallbacks[arg1] and #LevelCallbacks[arg1] > 0 then
			
		UpdateQueue[arg1] = true;
		NewUnitInfo[arg1] = nUI_Unit:getUnitInfo( arg1 );
		
	end	

--	nUI_ProfileStop();
	
end

frame:SetScript( "OnEvent", onLevelEvent );
frame:RegisterEvent( "PLAYER_ENTERING_WORLD" );
frame:RegisterEvent( "UNIT_LEVEL" );
frame:RegisterEvent( "PLAYER_LEVEL_UP" );

-------------------------------------------------------------------------------

local function onQueueUpdate( who, elapsed )

	queue_timer = queue_timer - elapsed;
	
	if queue_timer <= 0 then -- process the update queue at the user selected frame rate
	
		queue_timer = nUI_Unit.frame_rate;

		for unit_id in pairs( UpdateQueue ) do
		
			if UpdateQueue[unit_id] then
			
				UpdateQueue[unit_id] = false;
				unit_info = NewUnitInfo[unit_id];
								
				if LevelCallbacks[unit_id] and #LevelCallbacks[unit_id] > 0 then
					nUI_Unit:notifyCallbacks( 
						nUI_L["unit level"], LevelCallbacks, LevelUnits, 
						unit_info, unit_id, nUI_Unit:updateLevelInfo( unit_id, unit_info ) 
					);
				end
			end
		end
	end	
end

frame:SetScript( "OnUpdate", onQueueUpdate );

-------------------------------------------------------------------------------
-- this callback method is called when one of the unit IDs we are monitoring
-- for unit level changes GUID or when the unit reaction information changes

frame.newUnitInfo = function( unit_id, unit_info )

--	nUI_ProfileStart( ProfileCounter, "newInitInfo" );
	
	UpdateQueue[unit_id] = true;
	NewUnitInfo[unit_id] = unit_info;
	
--	nUI_ProfileStop();
	
end

-------------------------------------------------------------------------------
-- add and remove callbacks from the list of unit level listeners we manage
--
-- calling this method will return the current unit_info structure for this 
-- unit if it exists or nil if the unit does not exist at this time
--
-- Note: these callbacks will be notified both when the underlying GUID for the
--		 unit changes or when the level info of the underlying GUID to the
--		 player changes. If the underlying unit does not exist, the callback
--		 will be passed a nil unit_info structure

function nUI_Unit:registerLevelCallback( unit_id, callback )
	
--	nUI_ProfileStart( ProfileCounter, "registerCallback" );
	
	unit_info = nil;
	
	if unit_id and callback then
		
		-- get the list of callbacks for this unit id and add this callback
		
		list = LevelCallbacks[unit_id] or {};
		
		nUI:TableInsertByValue( list, callback );
		
		-- if this is a new unit id, add it to the callback list
		
		if not LevelCallbacks[unit_id] then
			LevelCallbacks[unit_id] = list;
		end
		
		-- if this is the first callback for the unit id, then register our
		-- event driver to receive notice when the GUID changes on this id
		
		if #list == 1 then
			nUI_Unit:registerReactionCallback( unit_id, nUI_Unit.Drivers.Level );
			nUI_Unit:registerUnitChangeCallback( unit_id, nUI_Unit.Drivers.Level );
		end
		
		-- collect level information for this unit as we know it at this time
	
		unit_info = nUI_Unit:getUnitInfo( unit_id );
		
		if unit_info then
			nUI_Unit:updateLevelInfo( unit_id, unit_info );
		end
	end
	
--	nUI_ProfileStop();
	
	return unit_info;
	
end

function nUI_Unit:unregisterLevelCallback( unit_id, callback )
	
--	nUI_ProfileStart( ProfileCounter, "unregisterCallback" );
	
	if unit_id and callback then
		
		-- get the list of current callbacks for this unit ud and remove this callback
		
		list = LevelCallbacks[unit_id] or {};
		
		nUI:TableRemoveByValue( list, callback );
		
		-- if that's the last callback in the list, then remove our event handler of
		-- the list of unit change callbacks for that unit it
		
		if #list == 0 then
			nUI_Unit:unregisterReactionCallback( unit_id, nUI_Unit.Drivers.Level );
			nUI_Unit:unregisterUnitChangeCallback( unit_id, nUI_Unit.Drivers.Level );
		end
	end

--	nUI_ProfileStop();
	
end

-------------------------------------------------------------------------------
-- update the level information for this unit
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

function nUI_Unit:updateLevelInfo( unit_id, unit_info )

--	nUI_ProfileStart( ProfileCounter, "updateLevelInfo" );
	
	modified  = false;
	
	if unit_info then
		
		-- check to see if the level has changed
		
		level = UnitLevel( unit_id );

		if not unit_info.level 
		or unit_info.level < level then
			
			modified              = true;
			unit_info.last_change = GetTime();
			unit_info.level       = level;
			
		end
		
		-- regardless of whether or not the level changed, has
		-- the color we should apply to it changed due to changes
		-- in unit reaction
		
		color        = LevelColors.Normal;
		player_level = nUI_Unit.PlayerInfo and nUI_Unit.PlayerInfo.level or UnitLevel( "player" );
		level_dx     = player_level - level;
		
		if unit_info.attackable then

			if level == -1 then
				color = LevelColors.Hard;
			elseif unit_info.is_trivial then
				color = LevelColors.Trivial;
			elseif level_dx >= 3 then
				color = LevelColors.Easy;
			elseif level_dx >= -2 then
				color = LevelColors.Difficult;
			else
				color = LevelColors.Hard;
			end
		end

		-- if the color has changed, update the cache
		
		if unit_info.color ~= color then
			
			modified              = true;
			unit_info.last_change = GetTime();
			unit_info.level_color = color;
			
		end		
	end
	
--	nUI_ProfileStop();
	
	return modified and unit_info or nil;
	
end

-------------------------------------------------------------------------------
-- update all of the registered unit level listeners, even if there's no 
-- change in data.

function nUI_Unit:refreshLevelCallbacks()
	
--	nUI_ProfileStart( ProfileCounter, "refreshLevelCallbacks" );
	
	for unit_id in pairs( LevelCallbacks ) do
		if LevelCallbacks[unit_id] and #LevelCallbacks[unit_id] > 0 then
			UpdateQueue[unit_id] = true;
			NewUnitInfo[unit_id] = nUI_Unit:getUnitInfo( unit_id );
		end
	end

--	nUI_ProfileStop();
	
end

-------------------------------------------------------------------------------
-- create a new unit level frame

function nUI_Unit:createLevelFrame( parent, unit_id, id, options )

--	nUI_ProfileStart( ProfileCounter, "createLevelFrame" );
	
	local frame   = nUI_Unit:createFrame( "$parent_Level"..(id or ""), parent, unit_id, options and options.clickable );
	frame.text    = frame:CreateFontString( "$parentLabel", "OVERLAY" );
	frame.texture = frame:CreateTexture( "$parentTexture", "OVERLAY" );
	frame.is_boss = true;
	frame.Super   = {};
	
	frame.texture:SetPoint( "CENTER", frame, "CENTER", 0, 0 );
	frame.texture:SetTexture( "Interface\\TargetingFrame\\UI-TargetingFrame-Skull" );
	frame.texture:SetTexCoord( 0, 0, 0, 1, 1, 0, 1, 1 );

	-- called when the underlying GUID for the unit changes or when the
	-- content of the GUID is updated

	frame.Super.newUnitInfo = frame.newUnitInfo;
	frame.newUnitInfo       = function( list_unit, unit_info )

--		nUI_ProfileStart( FrameProfileCounter, "newInitInfo" );
	
--		nUI:debug( "nUI_UnitLevel: new unit info for "..list_unit.." on "..frame:GetName().." = "..(unit_info and unit_info.level or "<nil>"), 1 );
		
		frame.Super.newUnitInfo( list_unit, unit_info );
		
		if frame.enabled then
			nUI_Unit:updateLevelFrame( frame );
		end
		
--		nUI_ProfileStop();
		
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
				frame.unit_info = nUI_Unit:registerLevelCallback( frame.unit, frame );
				nUI_Unit:updateLevelFrame( frame );
			else
				nUI_Unit:unregisterLevelCallback( frame.unit, frame );
			end
		end

--		nUI_ProfileStop();
		
	end
	
	-- used to change the scale of the frame... rather than the Bliz widget frame:SetScale()
	-- this method actually recalculates the size of the frame and uses frame:SetHeight()
	-- and frame:SetWidth() to reflect the actual size of the frame. Is also recreates
	-- the font to present clear, sharp, readable text versus the blurred text you get
	-- as a result of frame:SetScale() or text:SetTextHeight()
	
	frame.Super.applyScale = frame.applyScale;
	frame.applyScale       = function( scale )
		
--		nUI_ProfileStart( FrameProfileCounter, "applyScale" );
	
		frame.Super.applyScale( scale );
		
		frame.configText( frame.text, frame.options.label );
		
		if frame.texture.hSize  ~= frame.hSize 
		or frame.texture.vSize  ~= frame.vSize 
		or frame.texture.width  ~= frame.width
		or frame.texture.height ~= frame.height 
		or frame.texture.hInset ~= frame.hInset
		or frame.texture.vInset ~= frame.vInset
		then
			
			frame.texture.hSize  = frame.hSize;
			frame.texture.vSize  = frame.vSize;
			frame.texture.width  = frame.width;
			frame.texture.height = frame.height;
			frame.texture.hInset = frame.hInset;
			frame.texture.vInset = frame.vInset;
			
			frame.texture:SetWidth( (frame.hSize or frame.width) - frame.hInset );
			frame.texture:SetHeight( (frame.vSize or frame.height) - frame.vInset );

		end		

--		nUI_ProfileStop();
		
	end
	
	-- applies the set of frame options to this frame. Typically called when the frame 
	-- is first created or when the user changes options via config.

	frame.Super.applyOptions = frame.applyOptions;
	frame.applyOptions       = function( options )

--		nUI_ProfileStart( FrameProfileCounter, "applyOptions" );
	
		frame.Super.applyOptions( options );
		nUI_Unit:updateLevelFrame( frame );
		
--		nUI_ProfileStop();
		
	end
	
	-- initiate the frame
	
	frame.unit_info = nUI_Unit:registerLevelCallback( frame.unit, frame );
	frame.applyOptions( options );
	
--	nUI_ProfileStop();
	
	return frame;
		
end

-------------------------------------------------------------------------------
-- remove a unit level frame

function nUI_Unit:deleteLevelFrame( frame )

--	nUI_ProfileStart( ProfileCounter, "deleteLevelFrame" );

	nUI_Unit:unregisterLevelCallback( frame.unit, frame );
	nUI_Unit:deleteFrame( frame );
	
--	nUI_ProfileStop();
	
end

-------------------------------------------------------------------------------
-- display the appropriate icon for the unit's level
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

function nUI_Unit:updateLevelFrame( frame )
	
--	nUI_ProfileStart( ProfileCounter, "updateLevelFrame" );

	unit_info = frame.unit_info;
	
	-- if there is no unit or we don't know it's level, then hide the panel
	
	if not unit_info or not unit_info.level then
		
		if frame.active then
			frame.active = false;
			frame:SetAlpha( 0 );
		end
	
	-- otherwise, show the level or boss icon as may be appropriate
	
	else

		-- if the level is hidden, show it
		
		if not frame.active then
			frame.active = true;
			frame:SetAlpha( 1 );
		end

		-- if the level has changed from what we last knew, then update 
		
		level = unit_info.level;
		
		if frame.level ~= level then

			frame.level = level;
			
			-- if this is a boss, then hide the level text and
			-- show the boss icon
			
			if level == -1 then
				
				if not frame.is_boss then
					
					frame.text:SetAlpha( 0 );
					frame.texture:SetAlpha( 1 );
					frame.is_boss = true;
					
				end
				
			-- otherwise display the level text
			
			else
				
				if frame.is_boss then
					
					frame.text:SetAlpha( 1 );
					frame.texture:SetAlpha( 0 );
					frame.is_boss = false;
					
				end
				
				frame.text:SetText( level );
				
			end
		end
		
		-- check and see if the difficulty color has changed
		
		if not frame.is_boss then
				
			r = unit_info.level_color.r and unit_info.level_color.r or LevelColors.Normal.r;
			g = unit_info.level_color.g and unit_info.level_color.g or LevelColors.Normal.g;
			b = unit_info.level_color.b and unit_info.level_color.b or LevelColors.Normal.b;
			
			if frame.r ~= r 
			or frame.g ~= g
			or frame.b ~= b
			then

				frame.r = r;
				frame.g = g;
				frame.b = b;
				
				frame.text:SetTextColor( r, g, b, 1 );
				
			end
		end
	end
	
--	nUI_ProfileStop();
	
end
