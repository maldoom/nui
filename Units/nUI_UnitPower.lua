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

if not ClickCastFrames then	ClickCastFrames = {};end
if not nUI then nUI = {}; end
if not nUI_Unit then nUI_Unit = {}; end
if not nUI_UnitOptions then nUI_UnitOptions = {}; end
if not nUI_DefaultConfig then nUI_DefaultConfig = {}; end
if not nUI_DefaultConfig.BarColors then nUI_DefaultConfig.BarColors = {}; end
if not nUI_Profile then nUI_Profile = {}; end;

local CreateFrame    = CreateFrame;
local IsAddOnLoaded  = IsAddOnLoaded;
local UnitPower      = UnitPower;
local UnitPowerMax   = UnitPowerMax;
local UnitPowerType  = UnitPowerType;

nUI_UnitOptions.BarColors = nUI_DefaultConfig.BarColors;

-------------------------------------------------------------------------------
-- default colors for unit power bars

nUI_PowerNameMap =
{
	[0]  = nUI_L["MANA"];
	[1]  = nUI_L["RAGE"];
	[2]  = nUI_L["FOCUS"];
	[3]  = nUI_L["ENERGY"];
	[4]  = nUI_L["CHI"];
	[5]  = nUI_L["RUNES"];
	[6]  = nUI_L["RUNIC_POWER"];
	[7]  = nUI_L["SOUL_SHARDS"];
	[8]  = nUI_L["LUNAR_POWER"];
	[9]  = nUI_L["HOLY_POWER"];
	[11] = nUI_L["MAELSTROM"];
	[13] = nUI_L["INSANITY"];
	[17] = nUI_L["FURY"];
	[18] = nUI_L["PAIN"];
};

-------------------------------------------------------------------------------
-- unit power event management

if not nUI_Unit.Drivers then 
	nUI_Unit.Drivers = CreateFrame( "Frame", "nUI_UnitDrivers", WorldFrame ); 
end

nUI_Profile.nUI_UnitPower       = {};
nUI_Profile.nUI_UnitPower.Frame = {};

local ProfileCounter      = nUI_Profile.nUI_UnitPower;
local FrameProfileCounter = nUI_Profile.nUI_UnitPower.Frame;

local frame = CreateFrame( "Frame", "$parent_Power", nUI_Unit.Drivers )

local PowerCallbacks    = {};
local PowerUnits        = {};
local UpdateQueue       = {};
local NewUnitInfo       = {};
local queue_timer       = 1 / nUI_DEFAULT_FRAME_RATE;
local power_timer       = 0;

nUI_Unit.Drivers.Power  = frame;

-------------------------------------------------------------------------------
-- variables used in methods within this module are declared here to eliminate
-- the use of dynamic memory and the garbage collector

local unit_id;
local unit_info;
local list;
local modified;
local prior_state;
local power_type;
local power_token;
local altR;
local altG;
local altB;
local cur_power;
local max_power;
local pct_power;
local color;
local txt_color;
local r, g, b, a;
local color_set;
local range, color1, color2;

-------------------------------------------------------------------------------

local function onPowerEvent( who, event, arg1 )
	
--	nUI_ProfileStart( ProfileCounter, "onPowerEvent", event );
	
	if event == "ADDON_LOADED" and arg1 == "nUI" then
		
		nUI:patchConfig();
		nUI:registerSkinnedFrame( frame );
		
	end
	
--	nUI_ProfileStop();
	
end

frame:SetScript( "OnEvent", onPowerEvent );
frame:RegisterEvent( "ADDON_LOADED" );

-------------------------------------------------------------------------------

local function onPowerUpdate( who, elapsed )

--	nUI_ProfileStart( ProfileCounter, "onPowerUpdate" );
			
	queue_timer = queue_timer - elapsed;
	
	if queue_timer <= 0 then -- process the update queue at the user selected frame rate
	
		queue_timer = nUI_Unit.frame_rate;

		-- spin the list of watchers and update everyone's health data
		
		for unit_id in pairs( PowerCallbacks ) do				
			if #PowerCallbacks[unit_id] then	
				NewUnitInfo[unit_id] = nUI_Unit:getUnitInfo( unit_id );
				UpdateQueue[unit_id] = NewUnitInfo[unit_id] ~= nil;
			end
		end
		
		for unit_id in pairs( UpdateQueue ) do
		
			if UpdateQueue[unit_id] then
			
				UpdateQueue[unit_id] = false;
				unit_info = NewUnitInfo[unit_id];
								
				nUI_Unit:notifyCallbacks( 
					nUI_L["unit power"], PowerCallbacks, PowerUnits, 
					unit_info, unit_id, nUI_Unit:updatePowerInfo( unit_id, unit_info ) 
				);

			end
		end
	end	
		
--	nUI_ProfileStop();
	
end

frame:SetScript( "OnUpdate", onPowerUpdate );

-------------------------------------------------------------------------------
-- unless the skin spefically defined bar colors, we'll default to the nUI set

frame.applySkin = function( skin )

--	nUI_ProfileStart( ProfileCounter, "applySkin" );
	
	local skin = skin and skin.BarColors or nUI_DefaultConfig.BarColors;
	nUI_UnitOptions.BarColors = skin;
	
--	nUI_ProfileStop();
	
end
	
-------------------------------------------------------------------------------
-- this callback method is called when one of the unit IDs we are monitoring
-- for unit power changes GUID or fires an event we care about

frame.newUnitInfo = function( unit_id, unit_info )

--	nUI_ProfileStart( ProfileCounter, "newUnitInfo" );
	
	UpdateQueue[unit_id] = true;
	NewUnitInfo[unit_id] = unit_info;
	
--	nUI_ProfileStop();
	
end

-------------------------------------------------------------------------------
-- initialize configuration for the unit power bar colors
-- 
-- this method is called when the mod's saved variables have been loaded by Bliz and
-- may be called again whenever the unit bar color configuration has been changed
-- by the player or programmatically. Passing true or a non-nil value for "use_default"
-- will cause the player's current power color configuration to be replaced with
-- the default settings defined at the top of this file (which cannot be undone!)

function nUI_Unit:configPower( use_default )
	
--	nUI_ProfileStart( ProfileCounter, "configPower" );
	
	if not nUI_UnitOptions then nUI_UnitOptions = {}; end
	if not nUI_UnitOptions.BarColors then nUI_UnitOptions.BarColors = {}; end
	if not nUI_UnitOptions.BarColors.Power then nUI_UnitOptions.BarColors.Power = {}; end

	for power_type in pairs( nUI_DefaultConfig.BarColors.Power ) do
			
		print(power_type)

		local config  = nUI_UnitOptions.BarColors.Power[power_type] or {};
		local default = nUI_DefaultConfig.BarColors.Power[power_type];
		
		for range in pairs( default ) do
	
			local source = default[range];
			local target = config[range] or {};
			
			if use_default then
				
				target.r = source.r;
				target.g = source.g;
				target.b = source.b;
				target.a = source.b;
	
			else
				
				target.r = tonumber( target.r or source.r );
				target.g = tonumber( target.g or source.g );
				target.b = tonumber( target.b or source.b );
				target.a = tonumber( target.a or source.a );
				
			end
			
			config[range] = target;
			
		end
	
		nUI_UnitOptions.BarColors.Power[power_type] = config;
	end
	
	nUI_Unit:refreshPowerCallbacks();
	
--	nUI_ProfileStop();
	
end

-------------------------------------------------------------------------------
-- add and remove callbacks from the list of unit power listeners we manage
--
-- calling this method will return the current unit_info structure for this 
-- unit if it exists or nil if the unit does not exist at this time
--
-- Note: these callbacks will be notified both when the underlying GUID for the
--		 unit changes or when the power info of the underlying GUID changes. 
--       If the underlying unit does not exist, the callback will be passed a 
--       nil unit_info structure

function nUI_Unit:registerPowerCallback( unit_id, callback )
	
--	nUI_ProfileStart( ProfileCounter, "registerPowerCallback" );
	
	unit_info = nil;
	
	if unit_id and callback then
		
		-- get the list of callbacks for this unit id and add this callback
		
		list = PowerCallbacks[unit_id] or {};
		
		nUI:TableInsertByValue( list, callback );
		
		-- if this is a new unit id, add it to the callback list
		
		if not PowerCallbacks[unit_id] then
			PowerCallbacks[unit_id] = list;
		end
		
		-- if this is the first callback for the unit id, then register our
		-- event driver to receive notice when the GUID changes on this id
		
		if #list == 1 then
			nUI_Unit:registerUnitChangeCallback( unit_id, nUI_Unit.Drivers.Power );
		end
		
		-- collect power information for this unit as we know it at this time
	
		unit_info = nUI_Unit:getUnitInfo( unit_id );
		
		if unit_info then
			nUI_Unit:updatePowerInfo( unit_id, unit_info );
		end
	end
	
--	nUI_ProfileStop();
	
	return unit_info;
	
end

function nUI_Unit:unregisterPowerCallback( unit_id, callback )
	
--	nUI_ProfileStart( ProfileCounter, "unregisterPowerCallback" );
	
	if unit_id and callback then
		
		-- get the list of current callbacks for this unit ud and remove this callback
		
		list = PowerCallbacks[unit_id] or {};
		
		nUI:TableRemoveByValue( list, callback );
		
		-- if that's the last callback in the list, then remove our event handler of
		-- the list of unit change callbacks for that unit it
		
		if #list == 0 then
			nUI_Unit:unregisterUnitChangeCallback( unit_id, nUI_Unit.Drivers.Power );
		end
	end

--	nUI_ProfileStop();
	
end

-------------------------------------------------------------------------------
-- update the power information for this unit
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

local count = 1;

function nUI_Unit:updatePowerInfo( unit_id, unit_info )

--	nUI_ProfileStart( ProfileCounter, "updatePowerInfo" );
	
	modified  = false;
	
	if unit_info then

		-- check the unit's current power data
		power_type, power_token, altR, altG, altB = UnitPowerType(unit_id);
		cur_power = UnitPower( unit_id, power_type );
		max_power = UnitPowerMax( unit_id, power_type );
		pct_power = nil;

		if cur_power and max_power and max_power > 0 then
			pct_power = min( 1.0, max( cur_power / max_power, 0.0 ));
		end
		
		-- if it has changed, then update the cache
		
		if unit_info.power_type  ~= power_type
		or unit_info.power_token ~= power_token
		or unit_info.cur_power   ~= cur_power
		or unit_info.max_power   ~= max_power
		or unit_info.pct_power   ~= pct_power
		or unit_info.altR        ~= altR
		or unit_info.altG        ~= altG
		or unit_info.altB        ~= altB
		then
			
			modified              = true;
			unit_info.modified    = true;
			unit_info.last_change = GetTime();
			unit_info.power_type  = power_type;
			unit_info.power_token = power_token;
			unit_info.power_name  = nUI_L[power_token] or nUI_PowerNameMap[power_type] or nUI_L["POWER"];
			unit_info.cur_power   = cur_power;
			unit_info.max_power   = max_power;
			unit_info.pct_power   = pct_power;
			unit_info.altR        = altR;
			unit_info.altG        = altG;
			unit_info.altB        = altB;

		end

		-- fetch the color set to use, or no color if we don't know about the unit's power

		if pct_power then
			color_set = PowerBarColor[power_token] or PowerBarColor[power_type] or PowerBarColor["MANA"];
		else
			color_set = { r = 0, g = 0, b = 0, a = 0 };
		end

		-- if the color for the power bar has changed, update the cache
		
		if not unit_info.power_color
		or unit_info.power_color.r ~= color_set.r
		or unit_info.power_color.g ~= color_set.g
		or unit_info.power_color.b ~= color_set.b
		or unit_info.power_color.a ~= color_set.a
		then
			
			modified                = true;
			unit_info.modified      = true;
			unit_info.last_change   = GetTime();
			
			if not unit_info.power_color then			
				unit_info.power_color   = {};
			end
			
			unit_info.power_color.r = color_set.r or 1;
			unit_info.power_color.g = color_set.g or 1;
			unit_info.power_color.b = color_set.b or 1;
			unit_info.power_color.a = color_set.a or 1;

		end
	end

--	nUI_ProfileStop();
	return modified and unit_info or nil;
	
end

-------------------------------------------------------------------------------
-- update all of the registered unit power listeners, even if there's no 
-- change in data... typically used when the power color options change
-- or entering the world

function nUI_Unit:refreshPowerCallbacks()

--	nUI_ProfileStart( ProfileCounter, "refreshPowerCallbacks" );
	
	for unit_id in pairs( PowerCallbacks ) do
		if PowerCallbacks[unit_id] and #PowerCallbacks[unit_id] > 0 then
			UpdateQueue[unit_id] = true;
			NewUnitInfo[unit_id] = nUI_Unit:getUnitInfo( unit_id );
		end
	end

--	nUI_ProfileStop();
	
end

-------------------------------------------------------------------------------
-- create a new unit power frame

function nUI_Unit:createPowerFrame( parent, unit_id, id, options )

--	nUI_ProfileStart( ProfileCounter, "createPowerFrame" );
	
	local frame  = nUI_Unit:createFrame( "$parent_Power"..(id or ""), parent, unit_id, options and options.clickable );	
	frame.bar    = nUI_Bars:createStatusBar( "$parentBar", frame );	
	frame.cur    = frame:CreateFontString( "$parentCurrent", "OVERLAY" );	-- shows current power as text
	frame.max    = frame:CreateFontString( "$parentMaximum", "OVERLAY" );	-- shows maximum power as text
	frame.pct    = frame:CreateFontString( "$parentPercent", "OVERLAY" );	-- shows percent power as text
	frame.mix    = frame:CreateFontString( "$parentMixed", "OVERLAY" );		-- shows current and maximum power as text
	frame.Super  = {};

	frame.bar:SetPoint( "CENTER", frame, "CENTER", 0, 0 );
	
	-- called when the underlying GUID for the unit changes or when the
	-- content of the GUID is updated
	
	frame.Super.newUnitInfo = frame.newUnitInfo;
	frame.newUnitInfo       = function( list_unit, unit_info )
		
--		nUI_ProfileStart( FrameProfileCounter, "newUnitInfo" );
		
		frame.Super.newUnitInfo( list_unit, unit_info );
		
		if frame.enabled then
			nUI_Unit:updatePowerFrame( frame );
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
				frame.unit_info = nUI_Unit:registerPowerCallback( frame.unit, frame );
				frame.bar.setEnabled( frame.options.bar and frame.options.bar.enabled or false );
				nUI_Unit:updatePowerFrame( frame );
			else
				nUI_Unit:unregisterPowerCallback( frame.unit, frame );
				frame.bar.setEnabled( false );
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
		
		frame.configText( frame.cur, frame.options.cur_power );
		frame.configText( frame.max, frame.options.max_power );
		frame.configText( frame.pct, frame.options.pct_power );
		frame.configText( frame.mix, frame.options.mix_power );

		if frame.bar.hSize  ~= frame.hSize 
		or frame.bar.vSize  ~= frame.vSize 
		or frame.bar.width  ~= frame.width
		or frame.bar.height ~= frame.height 
		or frame.bar.hInset ~= frame.hInset
		or frame.bar.vInset ~= frame.vInset
		then
			
			frame.bar.hSize  = frame.hSize;
			frame.bar.vSize  = frame.vSize;
			frame.bar.width  = frame.width;
			frame.bar.height = frame.height;
			frame.bar.hInset = frame.hInset;
			frame.bar.vInset = frame.vInset;
			
			frame.bar:SetWidth( (frame.hSize or frame.width) - frame.hInset );
			frame.bar:SetHeight( (frame.vSize or frame.height) - frame.vInset );

		end		

--		nUI_ProfileStop();
		
	end
	
	-- applies the set of frame options to this frame. Typically called when the frame 
	-- is first created or when the user changes options via config.
	
	frame.Super.applyOptions = frame.applyOptions;
	frame.applyOptions       = function( options )

--		nUI_ProfileStart( FrameProfileCounter, "applyOptions" );
		
		frame.Super.applyOptions( options );
		
		-- extra frame level work
		
		frame.bar:SetFrameStrata( frame:GetFrameStrata() );
		frame.bar:SetFrameLevel( frame:GetFrameLevel() );
		
		-- enable or disable the display of a graphic bar
		
		frame.bar.setEnabled( options.bar and options.bar.enabled or false );

		if not frame.bar.enabled then
			
			frame.bar:SetAlpha( 0 );
			
		else
			
			frame.bar:SetAlpha( 1 );
			frame.bar.setOrientation( options.bar.orient or "LEFT" );
			frame.bar.setBar( options.bar.texture, options.bar.min_offset, options.bar.max_offset );
			frame.bar.setOverlay( options.bar.overlay );
			
		end
		
		-- special options for allowing the use of bar colors for text colors
		
		frame.max.barcolor = options.max_power and options.max_power.barcolor;
		frame.max.maxcolor = options.max_power and options.max_power.maxcolor;
		
		frame.cur.barcolor = options.cur_power and options.cur_power.barcolor;
		frame.cur.maxcolor = options.cur_power and options.cur_power.maxcolor;
		
		frame.pct.barcolor = options.pct_power and options.pct_power.barcolor;
		frame.pct.maxcolor = options.pct_power and options.pct_power.maxcolor;
		
		frame.mix.barcolor = options.mix_power and options.mix_power.barcolor;
		frame.mix.maxcolor = options.mix_power and options.mix_power.maxcolor;
		
		-- and refresh the frame

		nUI_Unit:updatePowerFrame( frame );
		
--		nUI_ProfileStop();
		
	end
	
	-- initiate the frame
	
	frame.unit_info = nUI_Unit:registerPowerCallback( frame.unit, frame );
		
	frame.applyOptions( options );
	
--	nUI_ProfileStop();
	
	return frame;
	
end

-------------------------------------------------------------------------------
-- remove a unit power frame

function nUI_Unit:deletePowerFrame( frame )

--	nUI_ProfileStart( ProfileCounter, "deletePowerFrame" );
	
	frame.bar.deleteBar();
	
	nUI_Unit:unregisterPowerCallback( frame.unit, frame );
	nUI_Unit:deleteFrame( frame );
	
--	nUI_ProfileStop();
	
end

-------------------------------------------------------------------------------
-- update the power text and power bar as required
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

local pct;
local max;
local cur;
local mix;

function nUI_Unit:updatePowerFrame( frame )
	
--	nUI_ProfileStart( ProfileCounter, "updatePowerFrame" );
	
	unit_info = frame.unit_info;
	
	-- if there is no unit or we don't know it's power, then hide the bar elements

	if not unit_info or 
	not unit_info.pct_power 
	or unit_info.max_power <= 0 then

		if frame.active then

			frame.active = false;
			
			frame.bar:SetAlpha( 0 );
			frame.cur:SetAlpha( 0 );
			frame.max:SetAlpha( 0 );
			frame.pct:SetAlpha( 0 );
			frame.mix:SetAlpha( 0 );
			
		end
	
	-- otherwise, update the power bar elements
	
	else

		pct   = ("%0.1f%%"):format( unit_info.pct_power * 100 );
		max   = ("%0.0f"):format( unit_info.max_power );
		cur   = ("%0.0f"):format( unit_info.cur_power );
		mix   = cur.." / "..max;
		
		-- if the power bar elements are hidden, show them
		
		if not frame.active then
			
			frame.active = true;
			
			frame.bar:SetAlpha( frame.bar.enabled and 1 or 0 );
			frame.cur:SetAlpha( frame.cur.enabled and 1 or 0 );
			frame.max:SetAlpha( frame.max.enabled and 1 or 0 );
			frame.pct:SetAlpha( frame.pct.enabled and 1 or 0 );
			frame.mix:SetAlpha( frame.mix.enabled and 1 or 0 );
			
		end

		-- if the power bar is active, update it
	
		if frame.bar.enabled then
			frame.bar.updateBar( unit_info.pct_power, unit_info.power_color );
		end
		
		-- if we're showing current power text, update it
		
		if frame.cur.enabled then
			
			if frame.cur.value ~= cur then
				
				frame.cur.value = cur;
				frame.cur:SetText( cur );
				
			end
	
			if frame.cur.maxcolor then txt_color = unit_info.power_color;
			elseif frame.cur.barcolor then txt_color = unit_info.power_color;
			else txt_color = nil;
			end
			
			if txt_color 
			and (frame.cur.r ~= txt_color.r or frame.cur.g ~= txt_color.g or frame.cur.b ~= txt_color.b)
			then
				
				frame.cur.r = txt_color.r;
				frame.cur.g = txt_color.g;
				frame.cur.b = txt_color.b;
				
				frame.cur:SetTextColor( txt_color.r, txt_color.g, txt_color.b, 1 );
				
			end
		end
		
		-- if we're showing maximum power text, update it
		
		if frame.max.enabled then
			
			if frame.max.value ~= max then
				
				frame.max.value = max;
				frame.max:SetText( max );
				
			end
	
			if frame.max.maxcolor then txt_color = unit_info.power_color;
			elseif frame.max.barcolor then txt_color = unit_info.power_color;
			else txt_color = nil;
			end
			
			if txt_color 
			and (frame.max.r ~= txt_color.r or frame.max.g ~= txt_color.g or frame.max.b ~= txt_color.b)
			then
				
				frame.max.r = txt_color.r;
				frame.max.g = txt_color.g;
				frame.max.b = txt_color.b;
				
				frame.max:SetTextColor( txt_color.r, txt_color.g, txt_color.b, 1 );
				
			end
		end
		
		-- if we're showing percent power text, update it
		
		if frame.pct.enabled then
			
			if frame.pct.value ~= pct then
				
				frame.pct.value = pct;
				frame.pct:SetText( pct );
				
			end
	
			if frame.pct.maxcolor then txt_color = unit_info.power_color;
			elseif frame.pct.barcolor then txt_color = unit_info.power_color;
			else txt_color = nil;
			end
			
			if txt_color 
			and (frame.pct.r ~= txt_color.r or frame.pct.g ~= txt_color.g or frame.pct.b ~= txt_color.b)
			then
				
				frame.pct.r = txt_color.r;
				frame.pct.g = txt_color.g;
				frame.pct.b = txt_color.b;
				
				frame.pct:SetTextColor( txt_color.r, txt_color.g, txt_color.b, 1 );
				
			end
		end
		
		-- if we're showing mixed current/maximum power text, update it
		
		if frame.mix.enabled then
			
			if frame.mix.value ~= mix then
				
				frame.mix.value = mix;
				frame.mix:SetText( mix );
				
			end		
	
			if frame.mix.maxcolor then txt_color = unit_info.power_color;
			elseif frame.mix.barcolor then txt_color = unit_info.power_color;
			else txt_color = nil;
			end
			
			if txt_color 
			and (frame.mix.r ~= txt_color.r or frame.mix.g ~= txt_color.g or frame.mix.b ~= txt_color.b)
			then
				
				frame.mix.r = txt_color.r;
				frame.mix.g = txt_color.g;
				frame.mix.b = txt_color.b;
				
				frame.mix:SetTextColor( txt_color.r, txt_color.g, txt_color.b, 1 );
				
			end
		end
	end
	
--	nUI_ProfileStop();
	
end