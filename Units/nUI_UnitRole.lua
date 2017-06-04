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

-------------------------------------------------------------------------------
-- unit role event management

if not nUI_Unit.Drivers then 
	nUI_Unit.Drivers = CreateFrame( "Frame", "nUI_UnitDrivers", WorldFrame ); 
end

nUI_Profile.nUI_UnitRole       = {};
nUI_Profile.nUI_UnitRole.Frame = {};

local ProfileCounter      = nUI_Profile.nUI_UnitRole;
local FrameProfileCounter = nUI_Profile.nUI_UnitRole.Frame;

local frame = CreateFrame( "Frame", "$parent_Role", nUI_Unit.Drivers )

local RoleCallbacks    = {};
local RoleUnits        = {};
local LeaderStatus     = {};
local RaidRoleStatus   = {};
local MLStatus         = {};
local NewUnitInfo      = {};
local UpdateQueue      = {};
local queue_timer      = 1 / nUI_DEFAULT_FRAME_RATE;

nUI_Unit.Drivers.Role  = frame;

-------------------------------------------------------------------------------
-- variables used in methods within this module are declared here to eliminate
-- the use of dynamic memory and the garbage collector

local unit_id;
local unit_info;
local list;
local modified;
local prior_state;
local role;
local role_info;
local raid_info;
local in_raid;
local is_leader;
local is_assist;
local is_tank;
local is_offtank;
local is_ml;
local role_tank;
local role_healer;
local role_damage;
local shown = {};
local hidden = {};
local numShown;
local numHidden;
local texture;
local xOfs, yOfs;
local last_icon;

-------------------------------------------------------------------------------

local function onRoleEvent( who, event, arg1 )
	
--	nUI_ProfileStart( ProfileCounter, "onRoleEvent", event );	
	if event == "PLAYER_ENTERING_WORLD" then
		nUI_Unit:refreshRoleCallbacks();
	elseif arg1 ~= nil then
		NewUnitInfo[arg1] = nUI_Unit:getUnitInfo( arg1 );
		UpdateQueue[arg1] = true;
	end
	
--	nUI_ProfileStop();
	
end

frame:SetScript( "OnEvent", onRoleEvent );
frame:RegisterEvent( "PLAYER_ENTERING_WORLD" );
frame:RegisterEvent( "PLAYER_ROLES_ASSIGNED" );

-------------------------------------------------------------------------------

local function onQueueUpdate( who, elapsed )

	queue_timer = queue_timer - elapsed;
	
	if queue_timer <= 0 then -- process the update queue at the user selected frame rate
	
		queue_timer = nUI_Unit.frame_rate;

		for unit_id in pairs( UpdateQueue ) do
		
			if UpdateQueue[unit_id] then
			
				UpdateQueue[unit_id] = false;
				unit_info = NewUnitInfo[unit_id];
								
				if RoleCallbacks[unit_id] and #RoleCallbacks[unit_id] > 0 then
					nUI_Unit:notifyCallbacks( 
						nUI_L["unit role"], RoleCallbacks, RoleUnits, 
						unit_info, unit_id, nUI_Unit:updateRoleInfo( unit_id, unit_info ) 
					);
				end
			end
		end
	end	
end

frame:SetScript( "OnUpdate", onQueueUpdate );

-------------------------------------------------------------------------------
-- this callback method is called when one of the unit IDs we are monitoring
-- for unit role changes GUID

frame.newUnitInfo = function( unit_id, unit_info )

--	nUI_ProfileStart( ProfileCounter, "newUnitInfo" );
	
	UpdateQueue[unit_id] = true;
	NewUnitInfo[unit_id] = unit_info;
	
--	nUI_ProfileStop();
	
end

-------------------------------------------------------------------------------
-- add and remove callbacks from the list of unit role listeners we manage
--
-- calling this method will return the current unit_info structure for this 
-- unit if it exists or nil if the unit does not exist at this time
--
-- Note: these callbacks will be notified both when the underlying GUID for the
--		 unit changes or when the role info of the underlying GUID to the
--		 player changes. If the underlying unit does not exist, the callback
--		 will be passed a nil unit_info structure

function nUI_Unit:registerRoleCallback( unit_id, callback )
	
--	nUI_ProfileStart( ProfileCounter, "registerRoleCallback" );
	
	unit_info = nil;
	
	if unit_id and callback then
		
		-- get the list of callbacks for this unit id and add this callback
		
		list = RoleCallbacks[unit_id] or {};
		
		nUI:TableInsertByValue( list, callback );
		
		-- if this is a new unit id, add it to the callback list
		
		if not RoleCallbacks[unit_id] then
			RoleCallbacks[unit_id] = list;
		end
		
		-- if this is the first callback for the unit id, then register our
		-- event driver to receive notice when the GUID changes on this id
		
		if #list == 1 then
			nUI_Unit:registerStatusCallback( unit_id, nUI_Unit.Drivers.Role );
			nUI_Unit:registerRaidGroupCallback( unit_id, nUI_Unit.Drivers.Role );
		end
		
		-- collect role information for this unit as we know it at this time
	
		unit_info = nUI_Unit:getUnitInfo( unit_id );
		
		if unit_info then
			nUI_Unit:updateRoleInfo( unit_id, unit_info );
		end
	end
	
--	nUI_ProfileStop();
	
	return unit_info;
	
end

function nUI_Unit:unregisterRoleCallback( unit_id, callback )
	
--	nUI_ProfileStart( ProfileCounter, "unregisterRoleCallback" );
	
	if unit_id and callback then
		
		-- get the list of current callbacks for this unit ud and remove this callback
		
		list = RoleCallbacks[unit_id] or {};
		
		nUI:TableRemoveByValue( list, callback );
		
		-- if that's the last callback in the list, then remove our event handler of
		-- the list of unit change callbacks for that unit it
		
		if #list == 0 then
			nUI_Unit:unregisterStatusCallback( unit_id, nUI_Unit.Drivers.Role );
			nUI_Unit:unregisterRaidGroupCallback( unit_id, nUI_Unit.Drivers.Role );
		end
	end

--	nUI_ProfileStop();
	
end

-------------------------------------------------------------------------------
-- update the role information for this unit
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

function nUI_Unit:updateRoleInfo( unit_id, unit_info )

--	nUI_ProfileStart( ProfileCounter, "updateRoleInfo" );
	
	modified  = false;
	
--	nUI:debug( "nUI_UnitRole: checking "..unit_id..", unit_info = "..( unit_info and unit_info.name or "<nil>"), 1 );
	
	if unit_info then

		-- if the unit is not in a party or a raid, then there is no role
		
		if not unit_info.in_party and not unit_info.in_raid then
			
			if unit_info.role_info then
					
--				nUI:debug( "nUI_UnitRole: "..unit_id.." is no longer in a party or raid", 1 );
				
				modified = true;
				unit_info.modified = true;
				unit_info.last_change = GetTime();
				
				if unit_info.role_info then
					unit_info.role_info.active = false;
				end
			end
			
		-- otherwise see what the role is, if any
		
		else

			local role_assigned = UnitGroupRolesAssigned( unit_id );
			
			role       = nil;
			role_info  = unit_info.role_info or {};
			raid_info  = unit_info.raid_info;
			in_raid    = unit_info.in_raid and raid_info and raid_info.active or false;
			is_leader  = unit_info.status_info and unit_info.status_info.is_leader or false;
			is_assist  = in_raid and raid_info.rank == 1 or false;
			is_tank    = in_raid and raid_info.role == "maintank" or false;
			is_offtank = in_raid and raid_info.role == "mainassist" or false;
			is_ml      = in_raid and raid_info.is_ml or false;
		
			role_tank     = role_assigned == 'TANK';
			role_healer   = role_assigned == 'HEALER';
			role_damage   = role_assigned == 'DAMAGER';		
			
			if is_leader then
				role = ("%s%s%s"):format( role or "", role and "," or "", unit_info.in_raid and nUI_L["Raid Leader"] or nUI_L["Party Leader"] );
			end
			
			if is_assist then
				role = ("%s%s%s"):format( role or "", role and "," or "", nUI_L["Raid Assistant"] );
			end
			
			if is_tank then
				role = ("%s%s%s"):format( role or "", role and "," or "", nUI_L["Main Tank"] );
			end
			
			if is_offtank then
				role = ("%s%s%s"):format( role or "", role and "," or "", nUI_L["Off-Tank"] );
			end
			
			if is_ml then
				role = ("%s%s%s"):format( role or "", role and "," or "", nUI_L["Master Looter"] );
			end
			
			
--			nUI:debug( "nUI_UnitRole: "..unit_id.." role status check: leader="..(is_leader and "true" or "false")..", assist="..(is_assist and "true" or "false")..", tank="..(is_tank and "true" or "false")..", offtank="..(is_offtank and "true" or "false")..", ml="..(is_ml and "true" or "false"), 1 );
			
			if not role_info.active
			or role_info.is_leader   ~= is_leader
			or role_info.is_assist   ~= is_assist
			or role_info.is_tank     ~= is_tank
			or role_info.is_offtank  ~= is_offtank
			or role_info.is_ml       ~= is_ml
			or role_info.role        ~= role
			or role_info.role_tank   ~= role_tank
			or role_info.role_healer ~= role_healer
			or role_info.role_damage ~= role_damage
			then
			
				role_info.active      = true;	
				role_info.role        = role;
				role_info.is_leader   = is_leader;
				role_info.is_assist   = is_assist;
				role_info.is_tank     = is_tank;
				role_info.is_offtank  = is_offtank;
				role_info.is_ml       = is_ml;
				role_info.role_tank   = role_tank;
				role_info.role_healer = role_healer;
				role_info.role_damage = role_damage;
				
				modified              = true;
				unit_info.modified    = true;
				unit_info.last_change = GetTime();
				unit_info.role_info   = role_info;
	
			end
		end
	end
	
--	nUI_ProfileStop();
	
	return modified and unit_info or nil;
	
end

-------------------------------------------------------------------------------
-- update all of the registered unit role listeners, even if there's no 
-- change in data... typically used when  entering the world

function nUI_Unit:refreshRoleCallbacks()

--	nUI_ProfileStart( ProfileCounter, "refreshRoleCallbacks" );
	
	for unit_id in pairs( RoleCallbacks ) do
		if RoleCallbacks[unit_id] and #RoleCallbacks[unit_id] > 0 then
			UpdateQueue[unit_id] = true;
			NewUnitInfo[unit_id] = nUI_Unit:getUnitInfo( unit_id );
		end
	end

--	nUI_ProfileStop();
	
end

-------------------------------------------------------------------------------
-- create a new unit role frame

function nUI_Unit:createRoleFrame( parent, unit_id, id, options )

--	nUI_ProfileStart( ProfileCounter, "createRoleFrame" );
	
	local frame      = nUI_Unit:createFrame( "$parent_Role"..(id or ""), parent, unit_id, options and options.clickable );	
	frame.leader     = frame:CreateTexture( "$parentLeader" );
	frame.assist     = frame:CreateTexture( "$parentAssistant" );
	frame.tank       = frame:CreateTexture( "$parentTank" );
	frame.offtank    = frame:CreateTexture( "$parentOffTank" );
	frame.tankRole   = frame:CreateTexture( "$parentTankRole" );
	frame.healerRole = frame:CreateTexture( "$parentHealerRole" );
	frame.damageRole = frame:CreateTexture( "$parentDamageRole" );
	frame.ml         = frame:CreateTexture( "$parentMasterLooter" );
	frame.Super      = {};
	
	frame.leader:SetTexture( "Interface\\GroupFrame\\UI-Group-LeaderIcon" );
	frame.leader:SetTexCoord( 0, 0, 0, 1, 1, 0, 1, 1 );
	frame.leader:SetAlpha( 0 );
	
	frame.assist:SetTexture( "Interface\\GroupFrame\\UI-GROUP-ASSISTANTICON" );
	frame.assist:SetTexCoord( 0, 0, 0, 1, 1, 0, 1, 1 );
	frame.assist:SetAlpha( 0 );
	
	frame.tank:SetTexture( "Interface\\GroupFrame\\UI-GROUP-MAINTANKICON" );
	frame.tank:SetTexCoord( 0, 0, 0, 1, 1, 0, 1, 1 );
	frame.tank:SetAlpha( 0 );
	
	frame.offtank:SetTexture( "Interface\\GroupFrame\\UI-GROUP-MAINASSISTICON" );
	frame.offtank:SetTexCoord( 0, 0, 0, 1, 1, 0, 1, 1 );
	frame.offtank:SetAlpha( 0 );
	
	frame.ml:SetTexture( "Interface\\GroupFrame\\UI-Group-MasterLooter" );
	frame.ml:SetTexCoord( 0, 0, 0, 1, 1, 0, 1, 1 );
	frame.ml:SetAlpha( 0 );
		
	frame.tankRole:SetTexture( "Interface\\LFGFrame\\UI-LFG-ICON-PORTRAITROLES" );
	frame.tankRole:SetTexCoord( 0, 19/64, 22/64, 41/64 );
	frame.tankRole:SetAlpha( 0 );
		
	frame.healerRole:SetTexture( "Interface\\LFGFrame\\UI-LFG-ICON-PORTRAITROLES" );
	frame.healerRole:SetTexCoord( 20/64, 39/64, 1/64, 20/64 );
	frame.healerRole:SetAlpha( 0 );
		
	frame.damageRole:SetTexture( "Interface\\LFGFrame\\UI-LFG-ICON-PORTRAITROLES" );
	frame.damageRole:SetTexCoord( 20/64, 39/64, 22/64, 41/64 );
	frame.damageRole:SetAlpha( 0 );
		
	-- called when the underlying GUID for the unit changes or when the
	-- content of the GUID is updated

	frame.Super.newUnitInfo = frame.newUnitInfo;
	frame.newUnitInfo       = function( list_unit, unit_info )
		
--		nUI_ProfileStart( FrameProfileCounter, "newUnitInfo" );
		
		frame.Super.newUnitInfo( list_unit, unit_info );
		
		if frame.enabled then
			nUI_Unit:updateRoleFrame( frame );
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
				frame.unit_info = nUI_Unit:registerRoleCallback( frame.unit, frame );
				nUI_Unit:updateRoleFrame( frame );
			else
				nUI_Unit:unregisterRoleCallback( frame.unit, frame );
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

		local icon_hSize = frame.options.icon_size * frame.hScale;
		local icon_vSize = frame.options.icon_size * frame.vScale;
		
		if frame.leader.icon_hSize ~= icon_hSize 
		or frame.leader.icon_vSize ~= icon_vSize 
		or frame.leader.hInset     ~= frame.hInset
		or frame.leader.vInset     ~= frame.vInset
		then
			
			frame.leader.icon_hSize = icon_hSize;
			frame.leader.icon_vSize = icon_vSize;
			frame.leader.hInset     = frame.hInset;
			frame.leader.vInset     = frame.vInset;
			
			frame.leader:SetWidth( icon_hSize - frame.hInset );
			frame.leader:SetHeight( icon_vSize - frame.vInset );
			
			frame.assist:SetWidth( icon_hSize - frame.hInset );
			frame.assist:SetHeight( icon_vSize - frame.vInset );
			
			frame.tank:SetWidth( icon_hSize - frame.hInset );
			frame.tank:SetHeight( icon_vSize - frame.vInset );
			
			frame.offtank:SetWidth( icon_hSize - frame.hInset );
			frame.offtank:SetHeight( icon_vSize - frame.vInset );
			
			frame.tankRole:SetWidth( icon_hSize - frame.hInset );
			frame.tankRole:SetHeight( icon_vSize - frame.vInset );
			
			frame.healerRole:SetWidth( icon_hSize - frame.hInset );
			frame.healerRole:SetHeight( icon_vSize - frame.vInset );
			
			frame.damageRole:SetWidth( icon_hSize - frame.hInset );
			frame.damageRole:SetHeight( icon_vSize - frame.vInset );
			
		end		

		-- determine how many icons are active at this time
		
		local icons  = 0;
		
		if frame.leader.active  then icons = icons+1; end			
		if frame.assist.active  then icons = icons+1; end
		if frame.tank.active    then icons = icons+1; end
		if frame.offtank.active then icons = icons+1; end
		if frame.ml.active      then icons = icons+1; end

		-- resize the main frame
			
		if frame.horizontal then				
			frame:SetWidth( icon_hSize * icons );
		else
			frame:SetHeight( icon_vSize * icons );
		end
		
--		nUI_ProfileStop();
		
	end
	
	-- applies the set of frame options to this frame. Typically called when the frame 
	-- is first created or when the user changes options via config.
	
	frame.Super.applyOptions = frame.applyOptions;
	frame.applyOptions       = function( options )

--		nUI_ProfileStart( FrameProfileCounter, "applyOptions" );
		
		-- set up the frame orientation
		
		if options.orient == "TOP" then
			frame.anchor_pt1 = "TOP";
			frame.anchor_pt2 = "BOTTOM";
			frame.horizontal = false;
		elseif options.orient == "BOTTOM" then
			frame.anchor_pt1 = "BOTTOM";
			frame.anchor_pt2 = "TOP";
			frame.horizontal = false;
		elseif options.orient == "RIGHT" then
			frame.anchor_pt1 = "RIGHT";
			frame.anchor_pt2 = "LEFT";
			frame.horizontal = true;
		else
			frame.anchor_pt1 = "LEFT";
			frame.anchor_pt2 = "RIGHT";
			frame.horizontal = true;
		end

--		nUI:debug( "nUI_UnitRole: set anchor_pt1 = "..frame.anchor_pt1..", anchor_pt = "..frame.anchor_pt2, 1 );

		frame.Super.applyOptions( options );

		-- and refresh the frame
		
		nUI_Unit:updateRoleFrame( frame );
		
--		nUI_ProfileStop();
		
	end

	-- initiate the frame
	
	frame.unit_info = nUI_Unit:registerRoleCallback( frame.unit, frame );
	
	frame.applyOptions( options );
	
--	nUI_ProfileStop();
	
	return frame;
	
end

-------------------------------------------------------------------------------
-- remove a unit role frame

function nUI_Unit:deleteRoleFrame( frame )

--	nUI_ProfileStart( ProfileCounter, "deleteRoleFrame" );
		
	nUI_Unit:unregisterRoleCallback( frame.unit, frame );
	nUI_Unit:deleteFrame( frame );
	
--	nUI_ProfileStop();
	
end

-------------------------------------------------------------------------------
-- display the appropriate icon for the unit's role
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

function nUI_Unit:updateRoleFrame( frame )
	
--	nUI_ProfileStart( ProfileCounter, "updateRoleFrame" );
		
	unit_info = frame.unit_info;
	
	-- if there is no unit or we don't know it's role, then hide the icon
	
	if not frame.options 
	or not unit_info 
	or not unit_info.role_info 
	or not unit_info.role_info.active
	then
		
		if frame.active then

--			nUI:debug( "hiding role panel for "..frame.unit.." -- no unit or no role", 1 );
			
			frame.active = false;
			frame:SetAlpha( 0 );
			frame:EnableMouse( false );
			
		end
	
	-- otherwise, show the icons as required
	
	else

		-- which icons are we going to show?
		
		role_info   = unit_info.role_info;
		role        = role_info.role;
		is_leader   = role_info.is_leader;
		is_assist   = role_info.is_assist;
		is_tank     = role_info.is_tank;
		is_offtank  = role_info.is_offtank;
		is_ml       = role_info.is_ml;
		role_tank   = role_info.role_tank;
		role_healer = role_info.role_healer;
		role_damage = role_info.role_damage;		
		numShown    = 0;
		numHidden   = 0;
		
		-- if there has been a change in role, then we need to update the role icons
		
		if frame.is_leader   ~= is_leader
		or frame.is_assist   ~= is_assist
		or frame.is_tank     ~= is_tank
		or frame.role_tank   ~= role_tank
		or frame.role_healer ~= role_healer
		or frame.role_damage ~= role_damage
		or frame.is_offtank  ~= is_offtank
		or frame.is_ml       ~= is_ml
		or frame.role        ~= role
		then

			frame.is_leader   = is_leader;
			frame.is_assist   = is_assist;
			frame.is_tank     = is_tank;
			frame.role_tank   = role_tank;
			frame.role_healer = role_healer;
			frame.role_damage = role_damage;
			frame.is_offtank  = is_offtank;
			frame.is_ml       = is_ml;
			frame.role        = role;
			
			if is_leader then
				numShown = numShown+1;
				shown[numShown] = frame.leader;
			else
				numHidden = numHidden+1;
				hidden[numHidden] = frame.leader;
			end
			
			if is_assist then
				numShown = numShown+1;
				shown[numShown] = frame.assist;
			else
				numHidden = numHidden+1;
				hidden[numHidden] = frame.assist;
			end
			
			if is_tank then
				numShown = numShown+1;
				shown[numShown] = frame.tank;
			else
				numHidden = numHidden+1;
				hidden[numHidden] = frame.tank;
			end
			
			if is_offtank then
				numShown = numShown+1;
				shown[numShown] = frame.offtank;
			else
				numHidden = numHidden+1;
				hidden[numHidden] = frame.offtank;
			end
			
			if is_ml then
				numShown = numShown+1;
				shown[numShown] = frame.ml;
			else
				numHidden = numHidden+1;
				hidden[numHidden] = frame.ml;
			end
			
			if role_tank then
				numShown = numShown+1;
				shown[numShown] = frame.tankRole;
			else
				numHidden = numHidden+1;
				hidden[numHidden] = frame.tankRole;
			end
			
			if role_healer then
				numShown = numShown+1;
				shown[numShown] = frame.healerRole;
			else
				numHidden = numHidden+1;
				hidden[numHidden] = frame.healerRole;
			end
			
			if role_damage then
				numShown = numShown+1;
				shown[numShown] = frame.damageRole;
			else
				numHidden = numHidden+1;
				hidden[numHidden] = frame.damageRole;
			end
			
			-- make sure all of the inactive icons are hidden
			
			for i=1,numHidden do
				
				texture = hidden[i];
				
				if texture.active then
					
					texture.active = false;
					texture:ClearAllPoints();
					texture:SetAlpha( 0 );
					
				end
			end
			
			-- if there are active icons, then make sure the frame is visible and
			-- make sure we have tooltip support enabled and size the frame
			
			if numShown > 0 then
				
				-- make sure all active icons are shown
			
				last_icon = nil;
				
				for i=1,numShown do
				
					texture = shown[i];
				
					if not texture.active then
					
						texture.active = true;
						texture:SetAlpha( 1 );
					
					end
				
					xOfs = last_icon and horizontal and (frame.hSize * 0.1 * (frame.options.orient == "LEFT" and 1 or -1)) or 0;
					yOfs = last_icon and vertical and (frame.vSize * 0.1 * (frame.options.orient == "TOP" and -1 or 1)) or 0;
				
--					nUI:debug( "nUI_UnitRole: setting "..texture:GetName().." icon #"..i.." anchor for "..frame.unit.." at ( "..(frame.anchor_pt1 or "<nil>")..", "..(last_icon and last_icon:GetName() or frame:GetName())..", "..(frame.anchor_pt2 or frame.anchor_pt1 or "<nil>")..", "..xOfs..", "..yOfs.." )", 1 );
				
					texture:ClearAllPoints();
					texture:SetPoint( frame.anchor_pt1, last_icon or frame, last_icon and frame.anchor_pt2 or frame.anchor_pt1, xOfs, yOfs );
				
					last_icon = texture;
					
				end

				if not frame.active then
					
					frame.active = true;
					frame:SetAlpha( 1 );
					frame:EnableMouse( frame.clickable );
					
				end
				
				if frame.horizontal then
					frame:SetWidth( frame.hSize * #shown );
				else
					frame:SetHeight( frame.vSize * #shown );
				end
					
			-- otherwise, make sure the frame is hidden and there are no tooltips
			
			elseif frame.active then

--				nUI:debug( "nUI_UnitRole: hiding role icons -- none apply for "..frame.unit, 1 );
				
				frame.active = false;
				frame:SetAlpha( 0 );
				frame:EnableMouse( false );
				
			end
		end		
	end
	
--	nUI_ProfileStop();
	
end
