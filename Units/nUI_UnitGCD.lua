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
if not nUI_Profile then nUI_Profile = {}; end;

local CreateFrame    = CreateFrame;

-------------------------------------------------------------------------------
-- unit global cooldown (GCD) management

if not nUI_Unit.Drivers then 
	nUI_Unit.Drivers = CreateFrame( "Frame", "nUI_UnitDrivers", WorldFrame ); 
end

nUI_Profile.nUI_UnitGCD       = {};
nUI_Profile.nUI_UnitGCD.Frame = {};

local ProfileCounter      = nUI_Profile.nUI_UnitGCD;
local FrameProfileCounter = nUI_Profile.nUI_UnitGCD.Frame;

local frame = CreateFrame( "Frame", "$parent_GCD", nUI_Unit.Drivers )

local GCDCallbacks    = {};
local GCDUnits        = {};
local duration        = 0;
local endTime         = 0;

nUI_Unit.Drivers.GCD  = frame;

-------------------------------------------------------------------------------

local pctRemains;

local function onGCDUpdate( who, elapsed )

--	nUI_ProfileStart( ProfileCounter, "onGCDUpdate" );
	
	if duration > 0 then
		
		pctRemains = (endTime - GetTime()) / duration;
		
		if pctRemains <= 0 then
			duration   = 0;
			pctRemains = 0;
		end
		
		nUI_Unit.PlayerInfo.gcdRemains = pctRemains;
		
		for i,callback in ipairs( GCDCallbacks ) do
			callback.newUnitInfo( "player", nUI_Unit.PlayerInfo );
		end
		
	end
	
--	nUI_ProfileStop();
	
end

frame:SetScript( "OnUpdate", onGCDUpdate );

-------------------------------------------------------------------------------
-- start a new global cooldown timer of the indicated length expiring at the
-- current time plus the length of the global cooldown

function nUI_Unit:startGCD( length )
	
--	nUI_ProfileStart( ProfileCounter, "startGCD" );
	
	if duration == 0 then
		endTime = GetTime() + length;
		duration = length;
	end
	
--	nUI_ProfileStop();
	
end

-------------------------------------------------------------------------------
-- add and remove callbacks from the list of unit GCD listeners we manage
--
-- calling this method will return the current unit_info structure for this 
-- unit if it exists or nil if the unit does not exist at this time
--
-- Note: these callbacks will be notified both when the underlying GUID for the
--		 unit changes or when the GCD info of the underlying GUID changes. 
--       If the underlying unit does not exist, the callback will be passed a 
--       nil unit_info structure

function nUI_Unit:registerGCDCallback( unit_id, callback )
	
--	nUI_ProfileStart( ProfileCounter, "registerGCDCallback" );
	
	local unit_info = nil;
	
	if callback then		
		nUI:TableInsertByValue( GCDCallbacks, callback );
	end
	
--	nUI_ProfileStop();
	
	return nUI_Unit.PlayerInfo;
	
end

function nUI_Unit:unregisterGCDCallback( unit_id, callback )	
	
--	nUI_ProfileStart( ProfileCounter, "unregisterGCDCallback" );	
	nUI:TableRemoveByValue( GCDCallbacks, callback );	
--	nUI_ProfileStop();
	
end

-------------------------------------------------------------------------------
-- create a new unit GCD frame

local prior_state;

function nUI_Unit:createGCDFrame( parent, unit_id, id, options )

--	nUI_ProfileStart( ProfileCounter, "createGCDFrame" );
	
	local frame  = nUI_Unit:createFrame( "$parent_GCD"..(id or ""), parent, unit_id, options and options.clickable );	
	frame.bar    = frame:CreateTexture( "$parent_Bar", "BACKGROUND" );
	frame.spark  = frame:CreateTexture( "$parent_Spark", "OVERLAY" );
	frame.active = false;
	frame.Super  = {};

	frame:SetAlpha( 0 );
	frame.bar:SetAllPoints( frame );
	frame.spark:SetTexture( "Interface\\AddOns\\nUI\\Layouts\\Default\\Art\\nUI_Spark" );
	frame.spark:SetTexCoord( 0, 0, 0, 1, 1, 0, 1, 1 );
	
	-- called when the underlying GUID for the unit changes or when the
	-- content of the GUID is updated
	
	frame.Super.newUnitInfo = frame.newUnitInfo;
	frame.newUnitInfo       = function( list_unit, unit_info )
		
--		nUI_ProfileStart( FrameProfileCounter, "newUnitInfo" );
	
		frame.Super.newUnitInfo( list_unit, unit_info );
		
		if frame.enabled then
			nUI_Unit:updateGCDFrame( frame );
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
				frame.unit_info = nUI_Unit:registerGCDCallback( frame.unit, frame );
				nUI_Unit:updateGCDFrame( frame );
			else
				nUI_Unit:unregisterGCDCallback( frame.unit, frame );
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
		
		if frame.spark.hSize  ~= frame.hSize 
		or frame.spark.vSize  ~= frame.vSize 
		or frame.spark.height ~= frame.height 
		then
			
			frame.spark.hSize  = frame.vSize;
			frame.spark.vSize  = frame.hSize;
			frame.spark.height = frame.height;
			
			frame:SetWidth( frame.width or (frame.hSize * 10) );
			frame:SetHeight( (frame.vSize or frame.height) / 7 );
			
			frame.spark:SetHeight( frame.hSize or frame.height );
			frame.spark:SetWidth( frame.vSize or frame.height );

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
		
		if options.barColor then
			frame.bar:SetColorTexture( options.barColor.r, options.barColor.g, options.barColor.b );
		else
			frame.bar:SetColorTexture( 1, 1, 1, 1 );
		end
		
		if options.sparkColor then
			frame.spark:SetVertexColor( options.sparkColor.r, options.sparkColor.g, options.sparkColor.b, 1 );
		else
			frame.spark:SetVertexColor( 1, 1, 1, 1 );
		end
		
--		nUI_ProfileStop();
		
	end
	
	-- initiate the frame
	
	frame.unit_info = nUI_Unit:registerGCDCallback( frame.unit, frame );
		
	frame.applyOptions( options );
	
--	nUI_ProfileStop();
	
	return frame;
	
end

-------------------------------------------------------------------------------
-- remove a unit GCD frame

function nUI_Unit:deleteGCDFrame( frame )

--	nUI_ProfileStart( ProfileCounter, "deleteGCDFrame" );
	
	nUI_Unit:unregisterGCDCallback( frame.unit, frame );
	nUI_Unit:deleteFrame( frame );
	
--	nUI_ProfileStop();
	
end

-------------------------------------------------------------------------------
-- update the GCD bar as required
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

local unit_info;
local pct;

function nUI_Unit:updateGCDFrame( frame )
	
--	nUI_ProfileStart( ProfileCounter, "updateGCDFrame" );
	
	unit_info = frame.unit_info;
	
	-- if there is no unit or we don't know it's GCD, then hide the bar elements
	
	if not unit_info 
	or not unit_info.gcdRemains
	or unit_info.gcdRemains <= 0
	then
		
		if frame.active then
			
			frame.active = false;
			
			frame:SetAlpha( 0 );
			
		end
	
	-- otherwise, update the GCD elements
	
	else

		pct   = 1 - unit_info.gcdRemains;
		
		-- if the GCD elements are hidden, show them
		
		if not frame.active then
			
			frame.active = true;
			
			frame:SetAlpha( 1 );
			
		end
		
		frame.spark:SetPoint( "CENTER", frame, "LEFT", frame:GetWidth() * pct, 0 );
		
	end
	
--	nUI_ProfileStop();
	
end
