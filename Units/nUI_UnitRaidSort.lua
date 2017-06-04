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

if not nUI_Unit then nUI_Unit = {}; end
if not nUI_UnitOptions then nUI_UnitOptions = {}; end
if not nUI_DefaultConfig then nUI_DefaultConfig = {}; end
if not nUI_Profile then nUI_Profile = {}; end;
if not nUI_Options then nUI_Options = {}; end;

-------------------------------------------------------------------------------

if not nUI_Unit.Drivers then 
	nUI_Unit.Drivers = CreateFrame( "Frame", "nUI_UnitDrivers", WorldFrame ); 
end

nUI_Profile.nUI_RaidSort    = {};

local ProfileCounter = nUI_Profile.nUI_RaidSort;

local sortFrame                 = CreateFrame( "Frame", "$parent_RaidSort", nUI_Unit.Drivers );
local RaidSortAssignments   = {};
local RaidSortCallbacks     = {};
local RaidSortUnits         = {};
local SortMethod            = nil;
local sortTimer             = 1 / nUI_DEFAULT_FRAME_RATE;

nUI_Unit.Drivers.RaidSort   = sortFrame;

for i=1,40 do
	RaidSortAssignments[i] = "raid"..i;   
end

nUI_Options.raidSort = nUI_L[nUI_SLASHCMD_OPTIONS( nUI_SLASHCMD_RAIDSORT, "group" )];

-------------------------------------------------------------------------------
-- this method processes the current list of raid unit ID assignments, sorts it
-- according to the user's preference and then updates the active raid frames

local unitInfo    = {};
local currentUnit = {};

local function SortRaidFrames()

	-- initialize a new sort
		
	for raidID=1,40 do
	
		local unit_id               = "raid"..raidID;		
		RaidSortAssignments[raidID] = unit_id;
		unitInfo[raidID]            = UnitExists( unit_id ) and nUI_Unit:getGUIDInfo( UnitGUID( unit_id ) ) or nil;
		
	end

	-- sort the table

	if SortMethod then
		for leftID=1,39 do

			local leftInfo = unitInfo[leftID];
			
			for rightID=leftID+1,40 do
			
				local rightInfo = unitInfo[rightID];
				local swap      = false;
				
				-- if there's no unit for one of the frames, no need to sort
				
				if not leftInfo or not rightInfo then
				
					-- if there's a unit on the right, then shift it up one
					
					if not leftInfo and rightInfo then
						swap = true;
					end					
					
				-- if the left hand unit is the player, then shift them up one
				-- so the player is always the last unit displayed
				
				elseif UnitIsUnit( RaidSortAssignments[leftID], "player" ) then
   
					swap = true;
				
				-- otherwise if the right hand unit is not the player, sort on the criteria
					
				elseif not UnitIsUnit( RaidSortAssignments[rightID], "player" ) and SortMethod( leftInfo, rightInfo ) then
				
					swap = true;
					
				end
				
				-- if we need to swap the left and the right, do it here
				
				if swap then
				
					local scratch                = RaidSortAssignments[leftID];
					RaidSortAssignments[leftID]  = RaidSortAssignments[rightID];
					RaidSortAssignments[rightID] = scratch;
					unitInfo[leftID]             = rightInfo;
					unitInfo[rightID]            = leftInfo;
					leftInfo                     = rightInfo;
					swap                         = false;
					
				end
			end
		end
	end
	
	-- now notify any frames that have changed unit IDs as a result of the sort
	
	for frame in pairs( RaidSortCallbacks ) do
	
		local raidID = frame:GetAttribute( "raidID" );
		
		if raidID then frame.setUnitID( RaidSortAssignments[raidID] ); end
		
	end
end

-------------------------------------------------------------------------------
-- this method sorts two raid units by their raid group and unit name

local function SortByRaidGroup( left, right )

	-- make sure we have units on both the left and the right
	
	if not left and not right then
		return false;		
	elseif left and not right then
		return false;		
	elseif right and not left then
		return true;		
	end
	
	-- get the unit info and raid info structures for those units
	
	local leftInfo  = left;
	local rightInfo = right;
	local leftRaid  = leftInfo.raid_info;
	local rightRaid = rightInfo.raid_info;
	
	-- make sure we have raid information for both the left and the right units
	
	if not leftRaid and not rightRaid then
		return false;		
	elseif not leftRaid and rightRaid then
		return true;		
	elseif leftRaid and not rightRaid then
		return false;							
	end
	
	-- make sure we have raid groups for both the left and the right units
	
	if not leftRaid.subGroup and not rightRaid.subGroup then
		return false;
	elseif not leftRaid.subGroup and rightRaid.subGroup then
		return true;
	elseif leftRaid.subGroup and not rightRaid.subGroup then
		return false;
	end
	
	-- compare raid groups
	
	if leftRaid.subGroup > rightRaid.subGroup then
		return true;
	elseif leftRaid.subGroup < rightRaid.subGroup then
		return false;
	end
	
	-- both are in the same raid group, sort by unit name within the group
	
	if not leftInfo.name and not rightInfo.name then
		return false;
	elseif not leftInfo.name and rightInfo.name then
		return true;
	elseif leftInfo.name and not rightInfo.name then
		return false;
	elseif leftInfo.name > rightInfo.name then
		return true;
	end
	
	return false;
end

-------------------------------------------------------------------------------
-- this method sorts two raid units by their raid group and unit name

local function SortByClass( left, right )

	-- make sure we have units on both the left and the right
	
	if not left and not right then
		return false;		
	elseif left and not right then
		return false;		
	elseif right and not left then
		return true;		
	end
	
	-- get the unit info and raid info structures for those units
	
	local leftInfo  = left;
	local rightInfo = right;

	-- makes sure we have class information for both the left and the right
	
	if not leftInfo.class and not rightInfo.class then
		return false;
	elseif not leftInfo.class and rightInfo.class then
		return true;
	elseif leftInfo.class and not rightInfo.class then
		return false;
	elseif leftInfo.class < rightInfo.class then
		return false;
	elseif leftInfo.class > rightInfo.class then
		return true;
	end
	
	-- both units share the same class, sort by unit name
	
	if not leftInfo.name and not rightInfo.name then
		return false;
	elseif not leftInfo.name and rightInfo.name then
		return true;
	elseif leftInfo.name and not rightInfo.name then
		return false;
	elseif leftInfo.name > rightInfo.name then
		return true;
	end
	
	return false;	
end

-------------------------------------------------------------------------------
-- this method sorts two raid units by their raid group and unit name

local function SortByName( left, right )

	-- make sure we have units on both the left and the right
	
	if not left and not right then
		return false;		
	elseif left and not right then
		return false;		
	elseif right and not left then
		return true;		
	end
	
	-- get the unit info and raid info structures for those units
	
	local leftInfo  = left;
	local rightInfo = right;

	-- sort by unit name
	
	if not leftInfo.name and not rightInfo.name then
		return false;
	elseif not leftInfo.name and rightInfo.name then
		return true;
	elseif leftInfo.name and not rightInfo.name then
		return false;
	elseif leftInfo.name > rightInfo.name then
		return true;
	end
	
	return false;	
end

-------------------------------------------------------------------------------

local function onRaidSortEvent( who, event, arg1 )

	if event ~= "PLAYER_ENTERING_WORLD" then
	
		if event == "VARIABLES_LOADED" or arg1 == "nUI" then
			
			if nUI_Options.raidSort == nUI_L[nUI_SLASHCMD_OPTIONS( nUI_SLASHCMD_RAIDSORT, "unit" )] then
				SortMethod = nil;
			elseif nUI_Options.raidSort == nUI_L[nUI_SLASHCMD_OPTIONS( nUI_SLASHCMD_RAIDSORT, "class" )] then
				SortMethod = SortByClass;
			elseif nUI_Options.raidSort == nUI_L[nUI_SLASHCMD_OPTIONS( nUI_SLASHCMD_RAIDSORT, "name" )] then
				SortMethod = SortByName;
			else
				SortMethod = SortByRaidGroup;
				nUI_Options.raidSort = nUI_L[nUI_SLASHCMD_OPTIONS( nUI_SLASHCMD_RAIDSORT, "group" )];
			end
		end
				
	else
		
		for i=1,40 do
			nUI_Unit:registerRaidGroupCallback( "raid"..i, sortFrame );
		end
		
		-- set up a slash command handler for choosing whether or not nUI will highlight the various dispellable debuff types
		
		local option = nUI_SlashCommands[nUI_SLASHCMD_RAIDSORT];
		
		nUI_SlashCommands:setHandler( option.command,
			
			function( msg, arg1 )

				if arg1 ~= nUI_Options.raidSort and not InCombatLockdown() then
								
					if arg1 == nUI_L[nUI_SLASHCMD_OPTIONS( nUI_SLASHCMD_RAIDSORT, "unit" )] then
						SortMethod = nil;
						nUI_Options.raidSort = arg1;
						DEFAULT_CHAT_FRAME:AddMessage( (option.message):format( arg1 ), 1, 0.83, 0 );
					elseif arg1 == nUI_L[nUI_SLASHCMD_OPTIONS( nUI_SLASHCMD_RAIDSORT, "group" )] then
						SortMethod = SortByRaidGroup;
						nUI_Options.raidSort = arg1;
						DEFAULT_CHAT_FRAME:AddMessage( (option.message):format( arg1 ), 1, 0.83, 0 );
					elseif arg1 == nUI_L[nUI_SLASHCMD_OPTIONS( nUI_SLASHCMD_RAIDSORT, "class" )] then
						SortMethod = SortByClass;
						nUI_Options.raidSort = arg1;
						DEFAULT_CHAT_FRAME:AddMessage( (option.message):format( arg1 ), 1, 0.83, 0 );
					elseif arg1 == nUI_L[nUI_SLASHCMD_OPTIONS( nUI_SLASHCMD_RAIDSORT, "name" )] then
						SortMethod = SortByName;
						nUI_Options.raidSort = arg1;
						DEFAULT_CHAT_FRAME:AddMessage( (option.message):format( arg1 ), 1, 0.83, 0 );
					else
						DEFAULT_CHAT_FRAME:AddMessage( 
							nUI_L["nUI: [ %s ] is not a valid raid sorting option... please choose either <unit>, <group> or <class>"]:format( 
								(arg1 or "<nil>"),
								nUI_L[nUI_SLASHCMD_OPTIONS( nUI_SLASHCMD_RAIDSORT, "unit" )],
								nUI_L[nUI_SLASHCMD_OPTIONS( nUI_SLASHCMD_RAIDSORT, "group" )],
								nUI_L[nUI_SLASHCMD_OPTIONS( nUI_SLASHCMD_RAIDSORT, "class" )]
							), 1, 0.83, 0
						);
					end
					
					SortRaidFrames();
										
				end
			end
		);		
		
		sortFrame:UnregisterEvent( "PLAYER_ENTERING_WORLD" );
	end	
end

sortFrame:SetScript( "OnEvent", onRaidSortEvent );
sortFrame:RegisterEvent( "ADDON_LOADED" );
sortFrame:RegisterEvent( "VARIABLES_LOADED" );
sortFrame:RegisterEvent( "PLAYER_ENTERING_WORLD" );

-------------------------------------------------------------------------------
-- we only update the raid sort every five seconds as needed

local function onRaidSortUpdate( who, elapsed )

	sortTimer = sortTimer - elapsed;
	
	if sortTimer <= 0 then
	
		sortTimer = 5.0;
		
		if not InCombatLockdown() then 
			SortRaidFrames(); 
		end		
	end	
end

sortFrame:SetScript( "OnUpdate", onRaidSortUpdate );

-------------------------------------------------------------------------------
-- this method is triggered anytime a change in the raid groups occurs

sortFrame.newUnitInfo = function( unit_id, unit_info )
end

-------------------------------------------------------------------------------
-- add and remove callbacks from the list of listeners who want to know
-- when the underlying GUID / unit information of a unit changes
--
-- calling this method will return the current unit_info structure
-- for this unit id if it exists or nil if the unit does not exist
--
-- Note: this is NOT recommended for unit existence! Use RegisterUnitWatch()
--       or RegisterUnitWatchState() for that purpose (allows for a taint safe
--		 way to know when a unit does and does not exist including the ability
--		 to show and hide frames, move frames, etc.)

function nUI_Unit:registerRaidSortFrame( frame, raid_id )
	
--	nUI_ProfileStart( ProfileCounter, "registerRaidSort" );

	if raid_id then
		
		if raid_id < 1 or raid_id > 40 then
			DEFAULT_CHAT_FRAME:AddMessage( (nUI_L["nUI_Unit: [%d] is not a valid raid ID... the raid ID must be between 1 and 40"].." (%s)"):format( raid_id or 0, frame:GetName() or "<unknown frame>" ), 1, 0.83, 0 );
		elseif not frame or not frame.setUnitID then
			DEFAULT_CHAT_FRAME:AddMessage( nUI_L["nUI_Unit: [%s] is not a valid raid sorting target frame, it does not have a setUnitID() method"]:format( frame and frame:GetName() or "<unknown frame>" ), 1, 0.83, 0 );
		else
			RaidSortCallbacks[frame] = raid_id;
			frame.setUnitID( RaidSortAssignments[raid_id] );
		end

	end
		
--	nUI_ProfileStop();
	
	return unit_info;
	
end

function nUI_Unit:unregisterRaidSortFrame( frame )
	
--	nUI_ProfileStart( ProfileCounter, "unregisterRaidSort" );
	
	if RaidSortCallbacks[frame] then
		RaidSortCallbacks[frame] = nil;
	end
	
--	nUI_ProfileStop();
	
end
