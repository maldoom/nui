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
local UnitHealth     = UnitHealth;
local UnitHealthMax  = UnitHealthMax;

nUI_UnitOptions.BarColors = nUI_DefaultConfig.BarColors;

-------------------------------------------------------------------------------
-- default colors for unit health bars

nUI_DefaultConfig.BarColors.Health =
{
	["min"] = { r = 1, g = 0, b = 0, a = 1 },	-- empty bar color
	["mid"] = { r = 1, g = 1, b = 0, a = 1 },	-- bar color at 50%
	["max"] = { r = 0, g = 1, b = 0, a = 1 },	-- full bar color
};

-------------------------------------------------------------------------------
-- unit health event management

if not nUI_Unit.Drivers then 
	nUI_Unit.Drivers = CreateFrame( "Frame", "nUI_UnitDrivers", WorldFrame ); 
end

nUI_Profile.nUI_UnitHealth       = {};
nUI_Profile.nUI_UnitHealth.Frame = {};

local ProfileCounter      = nUI_Profile.nUI_UnitHealth;
local FrameProfileCounter = nUI_Profile.nUI_UnitHealth.Frame;

local frame = CreateFrame( "Frame", "$parent_Health", nUI_Unit.Drivers )

local HealthCallbacks       = {};
local HealthUnits           = {};
local HelperHealthMethod    = nil;
local NewUnitInfo           = {};
local UpdateQueue           = {};
local queue_timer           = 1 / nUI_DEFAULT_FRAME_RATE;
local health_timer          = 0;

nUI_Unit.Drivers.Health     = frame;

-------------------------------------------------------------------------------
-- variables used in methods within this module are declared here to eliminate
-- the use of dynamic memory and the garbage collector

local unit_id;
local unit_info;
local list;
local modified;
local cur_health;
local max_health;
local pct_health;
local color;
local prior_state;

-------------------------------------------------------------------------------

local function onHealthEvent( who, event, arg1 )

--	nUI_ProfileStart( ProfileCounter, "onHealthEvent", event );
	
	if event == "ADDON_LOADED" and arg1 == "nUI" then
		
		nUI:patchConfig();
		nUI:registerSkinnedFrame( frame );
		
		-- set up a slash command handler for choosing the type of health display... remaining or lost
		
		local option = nUI_SlashCommands[nUI_SLASHCMD_HPLOST];
		
		nUI_SlashCommands:setHandler( option.command,
			
			function( msg, arg1 )
				
				nUI_Options.hplost = not nUI_Options.hplost;
				
				DEFAULT_CHAT_FRAME:AddMessage( (option.message):format( nUI_Options.hplost and nUI_L["health lost"] or nUI_L["health remaining"] ), 1, 0.83, 0 );

			end
		);				
		
	end

--	nUI_ProfileStop();
	
end

frame:SetScript( "OnEvent", onHealthEvent );
frame:RegisterEvent( "ADDON_LOADED" );

-------------------------------------------------------------------------------

local function onHealthUpdate( who, elapsed )

--	nUI_ProfileStart( ProfileCounter, "onHealthUpdate" );
		
	queue_timer = queue_timer - elapsed;
	
	if queue_timer <= 0 then -- process the update queue at the user selected frame rate
	
		queue_timer = nUI_Unit.frame_rate;

		-- spin the list of watchers and update everyone's health data
		
		for unit_id in pairs( HealthCallbacks ) do				
			if #HealthCallbacks[unit_id] then	
				NewUnitInfo[unit_id] = nUI_Unit:getUnitInfo( unit_id );
				UpdateQueue[unit_id] = NewUnitInfo[unit_id] ~= nil;
			end
		end
		
		for unit_id in pairs( UpdateQueue ) do
		
			if UpdateQueue[unit_id] then
			
				UpdateQueue[unit_id] = false;
				unit_info = NewUnitInfo[unit_id];
								
				nUI_Unit:notifyCallbacks( 
					nUI_L["unit health"], HealthCallbacks, HealthUnits, 
					unit_info, unit_id, nUI_Unit:updateHealthInfo( unit_id, unit_info ) 
				);
				
			end
		end
	end	
		
--	nUI_ProfileStop();
	
end

frame:SetScript( "OnUpdate", onHealthUpdate );

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
-- for unit health changes GUID or fires an event we care about

frame.newUnitInfo = function( unit_id, unit_info )

--	nUI_ProfileStart( ProfileCounter, "newUnitInfo" );
	
	NewUnitInfo[unit_id] = unit_info;
	UpdateQueue[unit_id] = true;
	
--	nUI_ProfileStop();
	
end

-------------------------------------------------------------------------------
-- initialize configuration for the unit health bar colors
-- 
-- this method is called when the mod's saved variables have been loaded by Bliz and
-- may be called again whenever the unit bar color configuration has been changed
-- by the player or programmatically. Passing true or a non-nil value for "use_default"
-- will cause the player's current health color configuration to be replaced with
-- the default settings defined at the top of this file (which cannot be undone!)

function nUI_Unit:configHealth( use_default )
	
--	nUI_ProfileStart( ProfileCounter, "configHealth" );
	
	if not nUI_UnitOptions then nUI_UnitOptions = {}; end
	if not nUI_UnitOptions.BarColors then nUI_UnitOptions.BarColors = {}; end
	if not nUI_UnitOptions.BarColors.Health then nUI_UnitOptions.BarColors.Health = {}; end
	
	local config  = nUI_UnitOptions.BarColors.Health;
	local default = nUI_DefaultConfig.BarColors.Health;
	
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
		
		nUI_UnitOptions.BarColors.Health[range] = target;
		
	end
	
	nUI_Unit:refreshHealthCallbacks();
	
--	nUI_ProfileStop();
	
end

-------------------------------------------------------------------------------
-- add and remove callbacks from the list of unit health listeners we manage
--
-- calling this method will return the current unit_info structure for this 
-- unit if it exists or nil if the unit does not exist at this time
--
-- Note: these callbacks will be notified both when the underlying GUID for the
--		 unit changes or when the health info of the underlying GUID changes. 
--       If the underlying unit does not exist, the callback will be passed a 
--       nil unit_info structure

function nUI_Unit:registerHealthCallback( unit_id, callback )
	
--	nUI_ProfileStart( ProfileCounter, "registerHealthCallback" );
	
	unit_info = nil;
	
	if unit_id and callback then
		
		-- get the list of callbacks for this unit id and add this callback
		
		list = HealthCallbacks[unit_id] or {};
		
		nUI:TableInsertByValue( list, callback );
		
		-- if this is a new unit id, add it to the callback list
		
		if not HealthCallbacks[unit_id] then
			HealthCallbacks[unit_id] = list;
		end
		
		-- collect health information for this unit as we know it at this time
	
		unit_info = nUI_Unit:getUnitInfo( unit_id );
		
		if unit_info then
			nUI_Unit:updateHealthInfo( unit_id, unit_info );
		end
	end
	
--	nUI_ProfileStop();
	
	return unit_info;
	
end

function nUI_Unit:unregisterHealthCallback( unit_id, callback )
	
--	nUI_ProfileStart( ProfileCounter, "unregisterHealthCallback" );
	
	if unit_id and callback then
		
		-- get the list of current callbacks for this unit ud and remove this callback
		
		list = HealthCallbacks[unit_id] or {};
		
		nUI:TableRemoveByValue( list, callback );
		
	end

--	nUI_ProfileStop();
	
end

-------------------------------------------------------------------------------
-- update the health information for this unit
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

function nUI_Unit:updateHealthInfo( unit_id, unit_info )

--	nUI_ProfileStart( ProfileCounter, "updateHealthInfo" );
	
	modified  = false;
	
	if unit_info then

		-- check the unit's current health data
		
		cur_health = UnitHealth( unit_id );
		max_health = UnitHealthMax( unit_id );
		
		if nUI_Options.hplost then
			cur_health = max_health - cur_health;
		end
		
		if cur_health and max_health then
			pct_health = max( 0, min( cur_health / max_health, 1 ));
		end
		
		-- if it has changed, then update the cache
		
		if unit_info.cur_health  ~= cur_health
		or unit_info.max_health  ~= max_health
		or unit_info.pct_health  ~= pct_health
		then
			
			modified              = true;
			unit_info.modified    = true;
			unit_info.last_change = GetTime();
			unit_info.cur_health  = cur_health;
			unit_info.max_health  = max_health;
			unit_info.pct_health  = pct_health;
		end
		
		-- if we don't know the unit's health status, there should be no health bar

		local r, g, b, a;
		
		if not cur_health
		or not max_health
		or not pct_health
		then
		
			r = 0;
			g = 0;
			b = 0;
			a = 0;

		-- if the unit has been tapped by someone other than the player, the color is always gray
		elseif UnitIsTapDenied(unit_id)
		then
			
			r = 0.5;
			g = 0.5;
			b = 0.5;
			a = 1;
			
		-- otherwise, select a color for the health bar based on the current health level
		
		else
			
			local range, color1, color2;
			
			-- select the color set we are going to use
			
			if pct_health > 0.5 then
				
				range  = (pct_health - 0.5) * 2;
				
				if nUI_Options.hplost then
					color1 = nUI_UnitOptions.BarColors.Health["mid"] or nUI_DefaultConfig.BarColors.Health["mid"];
					color2 = nUI_UnitOptions.BarColors.Health["min"] or nUI_DefaultConfig.BarColors.Health["min"];
				else
					color1 = nUI_UnitOptions.BarColors.Health["mid"] or nUI_DefaultConfig.BarColors.Health["mid"];
					color2 = nUI_UnitOptions.BarColors.Health["max"] or nUI_DefaultConfig.BarColors.Health["max"];
				end
			else
				
				range  = pct_health * 2;
				
				if nUI_Options.hplost then
					color1 = nUI_UnitOptions.BarColors.Health["max"] or nUI_DefaultConfig.BarColors.Health["max"];
					color2 = nUI_UnitOptions.BarColors.Health["mid"] or nUI_DefaultConfig.BarColors.Health["mid"];
				else
					color1 = nUI_UnitOptions.BarColors.Health["min"] or nUI_DefaultConfig.BarColors.Health["min"];
					color2 = nUI_UnitOptions.BarColors.Health["mid"] or nUI_DefaultConfig.BarColors.Health["mid"];
				end
			end

			r = (color2.r - color1.r) * range + color1.r;
			g = (color2.g - color1.g) * range + color1.g;
			b = (color2.b - color1.b) * range + color1.b;
			a = (color2.a - color1.a) * range + color1.a;
			
		end

		-- if the color for the health bar has changed, update the cache
		
		if not unit_info.health_color
		or unit_info.health_color.r ~= r
		or unit_info.health_color.g ~= g
		or unit_info.health_color.b ~= b
		or unit_info.health_color.a ~= a
		then
			
			modified                 = true;
			unit_info.modified       = true;
			unit_info.last_change    = GetTime();
			
			if not unit_info.health_color then
				unit_info.health_color   = {};
			end
			
			unit_info.health_color.r = r;
			unit_info.health_color.g = g;
			unit_info.health_color.b = b;
			unit_info.health_color.a = a;
			
		end
	end
	
--	nUI_ProfileStop();
	
	return modified and unit_info or nil;
	
end

-------------------------------------------------------------------------------
-- update all of the registered unit health listeners, even if there's no 
-- change in data... typically used when the health color options change
-- or entering the world

function nUI_Unit:refreshHealthCallbacks()

--	nUI_ProfileStart( ProfileCounter, "refreshHealthCallbacks" );
	
	for unit_id in pairs( HealthCallbacks ) do
		if HealthCallbacks[unit_id] and #HealthCallbacks[unit_id] > 0 then
			UpdateQueue[unit_id] = true;
			NewUnitInfo[unit_id] = nUI_Unit:getUnitInfo( unit_id );
		end
	end
	
--	nUI_ProfileStop();
	
end

-------------------------------------------------------------------------------
-- create a new unit health frame

function nUI_Unit:createHealthFrame( parent, unit_id, id, options )

--	nUI_ProfileStart( ProfileCounter, "createHealthFrame" );
	
	local frame  = nUI_Unit:createFrame( "$parent_Health"..(id or ""), parent, unit_id, options and options.clickable );	
	frame.bar    = nUI_Bars:createStatusBar( "$parentBar", frame );	
	frame.cur    = frame:CreateFontString( "$parentCurrent", "OVERLAY" );	-- shows current health as text
	frame.max    = frame:CreateFontString( "$parentMaximum", "OVERLAY" );	-- shows maximum health as text
	frame.pct    = frame:CreateFontString( "$parentPercent", "OVERLAY" );	-- shows percent health as text
	frame.mix    = frame:CreateFontString( "$parentMixed", "OVERLAY" );		-- shows current and maximum health as text
	frame.Super  = {};

	frame.bar:SetPoint( "CENTER", frame, "CENTER", 0, 0 );
	
	-- called when the underlying GUID for the unit changes or when the
	-- content of the GUID is updated
	
	frame.Super.newUnitInfo = frame.newUnitInfo;
	frame.newUnitInfo       = function( list_unit, unit_info )

--		nUI_ProfileStart( FrameProfileCounter, "newUnitInfo" );
		
		frame.Super.newUnitInfo( list_unit, unit_info );
		
		if frame.enabled then
			nUI_Unit:updateHealthFrame( frame );
		end
		
--		nUI_ProfileStop();
		
	end;
	
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
				frame.unit_info = nUI_Unit:registerHealthCallback( frame.unit, frame );
				frame.bar.setEnabled( frame.options.bar and frame.options.bar.enabled or false );
				nUI_Unit:updateHealthFrame( frame );
			else
				nUI_Unit:unregisterHealthCallback( frame.unit, frame );
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
		
		frame.configText( frame.cur, frame.options.cur_health );
		frame.configText( frame.max, frame.options.max_health );
		frame.configText( frame.pct, frame.options.pct_health );
		frame.configText( frame.mix, frame.options.mix_health );

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
		
		frame.max.barcolor = options.max_health and options.max_health.barcolor;
		frame.max.maxcolor = options.max_health and options.max_health.maxcolor;
		
		frame.cur.barcolor = options.cur_health and options.cur_health.barcolor;
		frame.cur.maxcolor = options.cur_health and options.cur_health.maxcolor;
		
		frame.pct.barcolor = options.pct_health and options.pct_health.barcolor;
		frame.pct.maxcolor = options.pct_health and options.pct_health.maxcolor;
		
		frame.mix.barcolor = options.mix_health and options.mix_health.barcolor;
		frame.mix.maxcolor = options.mix_health and options.mix_health.maxcolor;
		
--		nUI_ProfileStop();
		
	end
	
	-- initiate the frame
	
	frame.unit_info = nUI_Unit:registerHealthCallback( frame.unit, frame );
		
	frame.applyOptions( options );
	
--	nUI_ProfileStop();
	
	return frame;
	
end

-------------------------------------------------------------------------------
-- remove a unit health frame

function nUI_Unit:deleteHealthFrame( frame )

--	nUI_ProfileStart( ProfileCounter, "deleteHealthFrame" );
	
	frame.bar.deleteBar();
	
	nUI_Unit:unregisterHealthCallback( frame.unit, frame );
	nUI_Unit:deleteFrame( frame );
	
--	nUI_ProfileStop();
	
end

-------------------------------------------------------------------------------
-- update the health text and health bar as required
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
local txt_color;

function nUI_Unit:updateHealthFrame( frame )
	
--	nUI_ProfileStart( ProfileCounter, "updateHealthFrame" );
	
	unit_info = frame.unit_info;
	
	-- if there is no unit or we don't know it's health, then hide the bar elements
	
	if not unit_info or 
	not unit_info.pct_health 
	or unit_info.max_health <= 0 then
		
		if frame.active then
			
			frame.active = false;
			
			frame.bar:SetAlpha( 0 );
			frame.cur:SetAlpha( 0 );
			frame.max:SetAlpha( 0 );
			frame.pct:SetAlpha( 0 );
			frame.mix:SetAlpha( 0 );
			
		end
	
	-- otherwise, update the health bar elements
	
	else

		pct   = ("%0.1f%%"):format( unit_info.pct_health * 100 );
		max   = ("%0.0f"):format( unit_info.max_health );
		cur   = ("%0.0f"):format( unit_info.cur_health );
		mix   = cur.." / "..max;
		
		-- if the health bar elements are hidden, show them
		
		if not frame.active then
			
			frame.active = true;
			
			frame.bar:SetAlpha( frame.bar.enabled and 1 or 0 );
			frame.cur:SetAlpha( frame.cur.enabled and 1 or 0 );
			frame.max:SetAlpha( frame.max.enabled and 1 or 0 );
			frame.pct:SetAlpha( frame.pct.enabled and 1 or 0 );
			frame.mix:SetAlpha( frame.mix.enabled and 1 or 0 );
			
		end

		-- if the health bar is active, update it
		
		if frame.bar.enabled then

			frame.bar.updateBar( unit_info.pct_health, unit_info.health_color );
			
		end
		
		-- if we're show current health text, update it
		
		if frame.cur.enabled then
			
			if frame.cur.value ~= cur then
				
				frame.cur.value = cur;
				frame.cur:SetText( cur );
				
			end
	
			if frame.cur.maxcolor then txt_color = nUI_UnitOptions.BarColors.Health.max;
			elseif frame.cur.barcolor then txt_color = unit_info.health_color;
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
		
		-- if we're show maximum health text, update it
		
		if frame.max.enabled then
			
			if frame.max.value ~= max then
			
				frame.max.value = max;
				frame.max:SetText( max );
				
			end
	
			if frame.max.maxcolor then txt_color = nUI_UnitOptions.BarColors.Health.max;
			elseif frame.max.barcolor then txt_color = unit_info.health_color;
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
		
		-- if we're show percent health text, update it
		
		if frame.pct.enabled then
			
			if frame.pct.value ~= pct then
				
				frame.pct.value = pct;
				frame.pct:SetText( pct );
				
			end
	
			if frame.pct.maxcolor then txt_color = nUI_UnitOptions.BarColors.Health.max;
			elseif frame.pct.barcolor then txt_color = unit_info.health_color;
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
		
		-- if we're show mixed current/maximum health text, update it
		
		if frame.mix.enabled then
			
			if frame.mix.value ~= mix then
				
				frame.mix.value = mix;
				frame.mix:SetText( mix );
				
			end		
	
			if frame.mix.maxcolor then txt_color = nUI_UnitOptions.BarColors.Health.max;
			elseif frame.mix.barcolor then txt_color = unit_info.health_color;
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
