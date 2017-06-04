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
local UnitClass = UnitClass;

-------------------------------------------------------------------------------
-- default options for the unit class colors

nUI_DefaultConfig.ClassColors =
{
	["UNKNOWN"]     = { r = 1, g = 1, b = 1, },
	["WARRIOR"]     = { r = RAID_CLASS_COLORS["WARRIOR"].r, g = RAID_CLASS_COLORS["WARRIOR"].g, b = RAID_CLASS_COLORS["WARRIOR"].b },
	["MAGE"]        = { r = RAID_CLASS_COLORS["MAGE"].r, g = RAID_CLASS_COLORS["MAGE"].g, b = RAID_CLASS_COLORS["MAGE"].b },
	["ROGUE"]       = { r = RAID_CLASS_COLORS["ROGUE"].r, g = RAID_CLASS_COLORS["ROGUE"].g, b = RAID_CLASS_COLORS["ROGUE"].b },
	["DRUID"]       = { r = RAID_CLASS_COLORS["DRUID"].r, g = RAID_CLASS_COLORS["DRUID"].g, b = RAID_CLASS_COLORS["DRUID"].b },
	["HUNTER"]      = { r = RAID_CLASS_COLORS["HUNTER"].r, g = RAID_CLASS_COLORS["HUNTER"].g, b = RAID_CLASS_COLORS["HUNTER"].b },
	["SHAMAN"]      = { r = RAID_CLASS_COLORS["SHAMAN"].r, g = RAID_CLASS_COLORS["SHAMAN"].g, b = RAID_CLASS_COLORS["SHAMAN"].b },
	["PRIEST"]      = { r = RAID_CLASS_COLORS["PRIEST"].r, g = RAID_CLASS_COLORS["PRIEST"].g, b = RAID_CLASS_COLORS["PRIEST"].b },
	["WARLOCK"]     = { r = RAID_CLASS_COLORS["WARLOCK"].r, g = RAID_CLASS_COLORS["WARLOCK"].g, b = RAID_CLASS_COLORS["WARLOCK"].b },
	["PALADIN"]     = { r = RAID_CLASS_COLORS["PALADIN"].r, g = RAID_CLASS_COLORS["PALADIN"].g, b = RAID_CLASS_COLORS["PALADIN"].b },
	["DEATHKNIGHT"] = { r = RAID_CLASS_COLORS["DEATHKNIGHT"].r, g = RAID_CLASS_COLORS["DEATHKNIGHT"].g, b = RAID_CLASS_COLORS["DEATHKNIGHT"].b },

	-- Legion Change Start - TJK
	["DEMONHUNTER"] = { r = RAID_CLASS_COLORS["DEMONHUNTER"].r, g = RAID_CLASS_COLORS["DEMONHUNTER"].g, b = RAID_CLASS_COLORS["DEMONHUNTER"].b },
	-- Legion Change End - TJK

	-- 5.0.1 Change Start - new Class
	["MONK"]     = { r = RAID_CLASS_COLORS["MONK"].r, g = RAID_CLASS_COLORS["MONK"].g, b = RAID_CLASS_COLORS["MONK"].b },			
	-- 5.0.1 Change end

};

-------------------------------------------------------------------------------
-- pre-calculated locations for class information

local ClassInfo =
{
	["UNKNOWN"] = 
	{ 
		color = nUI_DefaultConfig.ClassColors["UNKNOWN"],
		row   = 2,
		col   = 3,
		x1    = 0.75,
		x2    = 1,
		y1    = 0.5,
		y2    = 0.75,
	},
	["WARRIOR"] = 	
	{ 
		color = nUI_DefaultConfig.ClassColors["WARRIOR"],
		row   = 0,
		col   = 0,
		x1    = 0,
		x2    = 0.25,
		y1    = 0,
		y2    = 0.25,
	},
	["MAGE"] = 
	{ 
		color = nUI_DefaultConfig.ClassColors["MAGE"],
		row   = 0,
		col   = 1,
		x1    = 0.25,
		x2    = 0.5,
		y1    = 0,
		y2    = 0.25,
	},
	["ROGUE"] = 
	{ 
		color = nUI_DefaultConfig.ClassColors["ROGUE"],
		row   = 0,
		col   = 2,
		x1    = 0.5,
		x2    = 0.75,
		y1    = 0,
		y2    = 0.25,
	},
	["DRUID"]   = 
	{ 
		color = nUI_DefaultConfig.ClassColors["DRUID"],
		row   = 0,
		col   = 3,
		x1    = 0.75,
		x2    = 1,
		y1    = 0,
		y2    = 0.25,
	},
	["HUNTER"]  = 
	{ 
		color = nUI_DefaultConfig.ClassColors["HUNTER"],
		row   = 1,
		col   = 0,
		x1    = 0,
		x2    = 0.25,
		y1    = 0.25,
		y2    = 0.5,
	},
	["SHAMAN"]  = 
	{ 
		color = nUI_DefaultConfig.ClassColors["SHAMAN"],
		row   = 1,
		col   = 1,
		x1    = 0.25,
		x2    = 0.5,
		y1    = 0.25,
		y2    = 0.5,
	},
	["PRIEST"]  = 
	{ 
		color = nUI_DefaultConfig.ClassColors["PRIEST"],
		row   = 1,
		col   = 2,
		x1    = 0.5,
		x2    = 0.75,
		y1    = 0.25,
		y2    = 0.5,
	},
	["WARLOCK"] = 
	{ 
		color = nUI_DefaultConfig.ClassColors["WARLOCK"],
		row   = 1,
		col   = 3,
		x1    = 0.75,
		x2    = 1,
		y1    = 0.25,
		y2    = 0.5,
	},
	["PALADIN"] = 
	{ 
		color = nUI_DefaultConfig.ClassColors["PALADIN"],
		row   = 2,
		col   = 0,
		x1    = 0,
		x2    = 0.25,
		y1    = 0.5,
		y2    = 0.75,
	},
	["DEATHKNIGHT"] = 
	{ 
		color = nUI_DefaultConfig.ClassColors["DEATHKNIGHT"],
		row   = 2,

		-- 5.0.1 Change Start - Suspected code error
		--col   = 0,
		col   = 1,	
		-- 5.0.1 Change end

		x1    = 0.25,
		x2    = 0.5,
		y1    = 0.5,
		y2    = 0.75,
	},

	-- 5.0.1 Change Start
	["MONK"]	= 
	{
		color = nUI_DefaultConfig.ClassColors["MONK"],
		row = 2,
		col = 2,
		x1 = 0.5, 
		x2 = 0.75, 
		y1 = 0.25, 
		y2 = 0.5
	},
	-- 5.0.1 Change end

	-- Legion Change Start
	["DEMONHUNTER"]	= 
	{
		color = nUI_DefaultConfig.ClassColors["DEMONHUNTER"],
		row = 2,
		col = 3,
		x1 = 0.75, 
		x2 = 1.0, 
		y1 = 0.25, 
		y2 = 0.5
	},
	-- Legion Change end

};

-------------------------------------------------------------------------------
-- unit class event management

if not nUI_Unit.Drivers then 
	nUI_Unit.Drivers = CreateFrame( "Frame", "nUI_UnitDrivers", WorldFrame ); 
end

nUI_Profile.nUI_UnitClass       = {};
nUI_Profile.nUI_UnitClass.Frame = {};

local ProfileCounter      = nUI_Profile.nUI_UnitClass;
local FrameProfileCounter = nUI_Profile.nUI_UnitClass.Frame;

local frame = CreateFrame( "Frame", "$parent_Class", nUI_Unit.Drivers )

local NewUnitInfo       = {};
local UpdateQueue       = {};
local ClassCallbacks    = {};
local ClassUnits        = {};
local queue_timer       = 1 / nUI_DEFAULT_FRAME_RATE;

nUI_Unit.Drivers.Class  = frame;

-------------------------------------------------------------------------------
-- variables used in methods within this module are declared here to eliminate
-- the use of dynamic memory and the garbage collector

local unit_info;
local unit_id;
local list;
local modified;
local class_name;
local class;
local color;
local color2;
local prior_state;
local data;
local x1;
local x2;
local y1;
local y2;

-------------------------------------------------------------------------------

local function onClassEvent( who, event, arg1 )
	
--	nUI_ProfileStart( ProfileCounter, "onClassEvent", event );
	
	if event == "ADDON_LOADED" and arg1 == "nUI" then
		
		nUI:registerSkinnedFrame( frame );
		
	-- for these events, we don't know which units are affected, so
	-- we span the list of all known interested units to see who is watching
		
	elseif event == "PLAYER_ENTERING_WORLD" then
		
		for unit_id in pairs( ClassCallbacks ) do
			if ClassCallbacks[unit_id] and #ClassCallbacks[unit_id] > 0 then
				UpdateQueue[unit_id] = true;
				NewUnitInfo[unit_id] = nUI_Unit:getUnitInfo( unit_id );
			end
		end		
	end

--	nUI_ProfileStop();

end

frame:SetScript( "OnEvent", onClassEvent );
frame:RegisterEvent( "ADDON_LOADED" );
frame:RegisterEvent( "PLAYER_ENTERING_WORLD" );

-------------------------------------------------------------------------------

local function onClassUpdate( who, elapsed )

	queue_timer = queue_timer - elapsed;
	
	if queue_timer <= 0 then -- process the update queue at the user selected frame rate
	
		queue_timer = nUI_Unit.frame_rate;

		for unit_id in pairs( UpdateQueue ) do
		
			if UpdateQueue[unit_id] then
			
				UpdateQueue[unit_id] = false;
				unit_info = NewUnitInfo[unit_id];
								
				if ClassCallbacks[unit_id] and #ClassCallbacks[unit_id] > 0 then
					nUI_Unit:notifyCallbacks( 
						nUI_L["unit class"], ClassCallbacks, ClassUnits, 
						unit_info, unit_id, nUI_Unit:updateClassInfo( unit_id, unit_info ) 
					);
				end
			end
		end
	end	
end	

frame:SetScript( "OnUpdate", onClassUpdate );

-------------------------------------------------------------------------------
-- this callback method is called when one of the unit IDs we are monitoring
-- for unit class changes GUID

frame.newUnitInfo = function( unit_id, unit_info )

--	nUI_ProfileStart( ProfileCounter, "newUnitInfo" );

	UpdateQueue[unit_id] = true;
	NewUnitInfo[unit_id] = unit_info;
	
--	nUI_ProfileStop();

end

-------------------------------------------------------------------------------

frame.applySkin = function( skin )

--	nUI_ProfileStart( ProfileCounter, "applySkin" );
	
	nUI_UnitOptions.ClassColors = skin.ClassColors or nUI_Default_Config.ClassColors;
	
--	nUI_ProfileStop();

end

-------------------------------------------------------------------------------
-- initialize configuration for the unit class color indicators
-- 
-- this method is called when the mod's saved variables have been loaded by Bliz and
-- may be called again whenever the unit class configuration has been changed
-- by the player or programmatically. Passing true or a non-nil value for "use_default"
-- will cause the player's current class color configuration to be replaced with
-- the default settings defined at the top of this file (which cannot be undone!)

function nUI_Unit:configClass( use_default )
	
--	nUI_ProfileStart( ProfileCounter, "configClass" );
	
	if not nUI_UnitOptions then nUI_UnitOptions = {}; end
	if not nUI_UnitOptions.ClassColors then nUI_UnitOptions.ClassColors = {}; end
	
	local config  = nUI_UnitOptions.ClassColors;
	local default = nUI_DefaultConfig.ClassColors;
	
	for class in pairs( default ) do
		nUI_Unit:configClassColor( class, use_default );
	end

--	nUI_ProfileStop();

end

function nUI_Unit:configClassColor( class, use_default )
	
--	nUI_ProfileStart( ProfileCounter, "configClassColor" );
	
	local config  = nUI_UnitOptions.ClassColors[class] or {};
	local default = nUI_DefaultConfig.ClassColors[class] or {};
	
	if use_default then
			
		config.r = default.r;
		config.g = default.g;
		config.b = default.b;

	else
			
		config.r = tonumber( config.r or default.r );
		config.g = tonumber( config.g or default.g );
		config.b = tonumber( config.b or default.b );

	end
	
	nUI_UnitOptions.ClassColors[class] = config;
	ClassInfo[class].color = config;
		
	nUI_Unit:refreshClassCallbacks();
	
--	nUI_ProfileStop();

end

-------------------------------------------------------------------------------
-- add and remove callbacks from the list of unit class listeners we manage
--
-- calling this method will return the current unit_info structure for this 
-- unit if it exists or nil if the unit does not exist at this time
--
-- Note: these callbacks will be notified both when the underlying GUID for the
--		 unit changes or when the class info of the underlying GUID to the
--		 player changes. If the underlying unit does not exist, the callback
--		 will be passed a nil unit_info structure

function nUI_Unit:registerClassCallback( unit_id, callback )
	
--	nUI_ProfileStart( ProfileCounter, "registerClassCallback" );
	
	unit_info = nil;
	
	if unit_id and callback then
		
		-- get the list of callbacks for this unit id and add this callback
		
		list = ClassCallbacks[unit_id] or {};
		
		nUI:TableInsertByValue( list, callback );
		
		-- if this is a new unit id, add it to the callback list
		
		if not ClassCallbacks[unit_id] then
			ClassCallbacks[unit_id] = list;
		end
		
		-- if this is the first callback for the unit id, then register our
		-- event driver to receive notice when the GUID changes on this id
		
		if #list == 1 then
			nUI_Unit:registerUnitChangeCallback( unit_id, nUI_Unit.Drivers.Class );
		end
		
		-- collect class information for this unit as we know it at this time
	
		unit_info = nUI_Unit:getUnitInfo( unit_id );
		
		if unit_info then
			nUI_Unit:updateClassInfo( unit_id, unit_info );
		end
	end
	
--	nUI_ProfileStop();

	return unit_info;
	
end

function nUI_Unit:unregisterClassCallback( unit_id, callback )
	
--	nUI_ProfileStart( ProfileCounter, "unregisterClassCallback" );
	
	if unit_id and callback then
		
		-- get the list of current callbacks for this unit ud and remove this callback
		
		list = ClassCallbacks[unit_id] or {};
		
		nUI:TableRemoveByValue( list, callback );
		
		-- if that's the last callback in the list, then remove our event handler of
		-- the list of unit change callbacks for that unit it
		
		if #list == 0 then
			nUI_Unit:unregisterUnitChangeCallback( unit_id, nUI_Unit.Drivers.Class );
		end
	end

--	nUI_ProfileStop();

end

-------------------------------------------------------------------------------
-- update the class information for this unit
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

function nUI_Unit:updateClassInfo( unit_id, unit_info )

--	nUI_ProfileStart( ProfileCounter, "updateClassInfo" );
	
	modified  = false;
	
	if unit_info then
		
		class_name, class = UnitClass( unit_id );
		
		if unit_info.class      ~= class 
		or unit_info.class_name ~= class_name
		then
			
			modified              = true;
			unit_info.modified    = true;
			unit_info.last_change = GetTime();
			unit_info.class       = class;
			unit_info.class_name  = class;

			-- which icon applies to this class?
			
			if class == "WARRIOR" then 
				unit_info.class_info = ClassInfo["WARRIOR"];
			elseif class == "MAGE" then
				unit_info.class_info = ClassInfo["MAGE"];
			elseif class == "ROGUE" then
				unit_info.class_info = ClassInfo["ROGUE"];
			elseif class == "DRUID" then
				unit_info.class_info = ClassInfo["DRUID"];
			elseif class == "HUNTER" then
				unit_info.class_info = ClassInfo["HUNTER"];
			elseif class == "SHAMAN" then
				unit_info.class_info = ClassInfo["SHAMAN"];
			elseif class == "PRIEST" then
				unit_info.class_info = ClassInfo["PRIEST"];
			elseif class == "WARLOCK" then
				unit_info.class_info = ClassInfo["WARLOCK"];
			elseif class == "PALADIN" then
				unit_info.class_info = ClassInfo["PALADIN"];
			elseif class == "DEATHKNIGHT" then
				unit_info.class_info = ClassInfo["DEATHKNIGHT"];
				
			-- 5.0.1 Change Start
			elseif class == "MONK" then
				unit_info.class_info = ClassInfo["MONK"];
			-- 5.0.1 Change End

			-- Legion Change TJK
			elseif class == "DEMONHUNTER" then
				unit_info.class_info = ClassInfo["DEMONHUNTER"];
			-- Legion Change TJK

				
			else
				unit_info.class_info = ClassInfo["UNKNOWN"];
				if class then DEFAULT_CHAT_FRAME:AddMessage( nUI_L["nUI_UnitClass.lua: unhandled unit class [%s] for [%s]"]:format( class, unit_id ), 1, 0.5, 0.5 ); end
			end
			
			color = unit_info.class_info.color;
			color2 = RAID_CLASS_COLORS["HUNTER"];
		end
	end
	
--	nUI_ProfileStop();

	return modified and unit_info or nil;
	
end

-------------------------------------------------------------------------------
-- update all of the registered unit class listeners, even if there's no 
-- change in data... typically used when the class color options change
-- or entering the world

function nUI_Unit:refreshClassCallbacks()

--	nUI_ProfileStart( ProfileCounter, "refreshClassCallbacks" );
	
	for unit_id in pairs( ClassCallbacks ) do
		if ClassCallbacks[unit_id] and #ClassCallbacks[unit_id] > 0 then
			UpdateQueue[unit_id] = true;
			NewUnitInfo[unit_id] = nUI_Unit:getUnitInfo( unit_id );
		end
	end

--	nUI_ProfileStop();

end

-------------------------------------------------------------------------------
-- create a new unit class frame

function nUI_Unit:createClassFrame( parent, unit_id, id, options )

--	nUI_ProfileStart( ProfileCounter, "createClassFrame" );
	
	local frame   = nUI_Unit:createFrame( "$parent_Class"..(id or ""), parent, unit_id, options and options.clickable );	
	frame.texture = frame:CreateTexture( "$parentTexture", "BORDER" );
	frame.Super   = {};
	
	frame.texture:SetPoint( "CENTER", frame, "CENTER", 0, 0 );
	frame.texture:SetTexture( "Interface\\AddOns\\nUI\\Layouts\\Default\\Art\\nUI_Icon_Classes.blp" );

	-- called when the underlying GUID for the unit changes or when the
	-- content of the GUID is updated
	
	frame.Super.newUnitInfo = frame.newUnitInfo;
	frame.newUnitInfo       = function( list_unit, unit_info )
		
--		nUI_ProfileStart( FrameProfileCounter, "newUnitInfo" );
	
		frame.Super.newUnitInfo( list_unit, unit_info );
		
		if frame.enabled then
			nUI_Unit:updateClassFrame( frame );
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
				frame.unit_info = nUI_Unit:registerClassCallback( frame.unit, frame );
				nUI_Unit:updateClassFrame( frame );
			else
				nUI_Unit:unregisterClassCallback( frame.unit, frame );
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
		
		if frame.texture.hSize  ~= frame.vSize 
		or frame.texture.vSize  ~= frame.hSize 
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
		nUI_Unit:updateClassFrame( frame );
		
--		nUI_ProfileStop();
	
	end

	-- initiate the frame
	
	frame.unit_info = nUI_Unit:registerClassCallback( frame.unit, frame );
	
	frame.applyOptions( options );
	
--	nUI_ProfileStop();
	
	return frame;
	
end

-------------------------------------------------------------------------------
-- remove a unit class frame

function nUI_Unit:deleteClassFrame( frame )

--	nUI_ProfileStart( ProfileCounter, "deleteClassFrame" );
		
	nUI_Unit:unregisterClassCallback( frame.unit, frame );
	nUI_Unit:deleteFrame( frame );
	
--	nUI_ProfileStop();
	
end

-------------------------------------------------------------------------------
-- display the appropriate icon for the unit's class
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

function nUI_Unit:updateClassFrame( frame )
	
--	nUI_ProfileStart( ProfileCounter, "updateClassFrame" );
		
	unit_info = frame.unit_info;
	
	-- if there is no unit or we don't know it's class, then hide the icon
	
	if not unit_info or not unit_info.class then
		
		if frame.active then
			frame.active = false;
			frame.texture:SetAlpha( 0 );
		end
	
	-- otherwise, show the icon and clip the appropriate region
	
	else

		-- if the class icon is hidden, show it
		
		if not frame.active then
			frame.active = true;
			frame.texture:SetAlpha( 1 );
		end

		-- if the class has changed from what we last knew, then update 
		
		if frame.class ~= unit_info.class then
			
			data = unit_info.class_info;
			
			if data then
				
				x1 = data.x1;
				x2 = data.x2;
				y1 = data.y1;
				y2 = data.y2;

				frame.class = unit_info.class;
				frame.texture:SetTexCoord( x1, y1, x1, y2, x2, y1, x2, y2 );
			end
		end
	end
	
--	nUI_ProfileStop();
	
end
