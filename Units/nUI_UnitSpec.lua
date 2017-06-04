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
if not nUI_DefaultConfig then nUI_DefaultConfig = {}; end
if not nUI_Profile then nUI_Profile = {}; end;

local CheckInteractDistance = CheckInteractDistance;
local CreateFrame           = CreateFrame;
local GetNetStats           = GetNetStats;
local GetTime               = GetTime;
local GetTalentTabInfo      = GetTalentTabInfo;
local NotifyInspect         = NotifyInspect;

-------------------------------------------------------------------------------
-- unit spec event management

if not nUI_Unit.Drivers then 
	nUI_Unit.Drivers = CreateFrame( "Frame", "nUI_UnitDrivers", WorldFrame ); 
end

nUI_Profile.nUI_UnitSpec       = {};
nUI_Profile.nUI_UnitSpec.Frame = {};

local ProfileCounter      = nUI_Profile.nUI_UnitSpec;
local FrameProfileCounter = nUI_Profile.nUI_UnitSpec.Frame;

local frame = CreateFrame( "Frame", "$parent_Spec", nUI_Unit.Drivers )

local first_queue      = true;
local updating_queue   = 0;
local queue_check      = 1 / nUI_DEFAULT_FRAME_RATE;
local num_queued       = 0;
local TalentBuildQueue = {};
local QueueCount       = {};
local SpecCallbacks    = {};
local SpecUnits        = {};

nUI_Unit.Drivers.Spec  = frame;

-------------------------------------------------------------------------------
-- this callback method is called when one of the unit IDs we are monitoring
-- for spec changes GUID or when the unit reaction information changes

frame.newUnitInfo = function( list_unit, unit_info )

--	nUI_ProfileStart( ProfileCounter, "newUnitInfo" );
	
	local new_data  = nUI_Unit:updateSpecInfo( list_unit, unit_info );
	local callbacks = SpecCallbacks;
	local unitlist  = SpecUnits;

	nUI_Unit:notifyCallbacks( nUI_L["unit spec"], callbacks, unitlist, unit_info, list_unit, new_data );

--	nUI_ProfileStop();

end

-------------------------------------------------------------------------------
-- track which unit is currently pending inspection

local currentInspectUnit = nil;
local currentInspectGUID = nil;

hooksecurefunc( "NotifyInspect", 

	function( unitID )

		local guid = UnitGUID( unitID );

		if not currentInspectUnit
		or (currentInspectUnit and guid ~= currentInspectGUID) 
		then
			currentInspectUnit = unitID;
			currentInspectGUID = guid;
		end					

	end
);

-------------------------------------------------------------------------------
-- add a request to the talent build inspection queue (API entry point)

local pendingQueue = {};
local inspectQueue = {};
local queueLength  = 0;

local function GetTalentBuild( unit_id )
	
--	nUI_ProfileStart( ProfileCounter, "GetTalentBuild" );

	-- if the unit is not in the queue of pending inspections, add it

	--  if not pendingQueue[unit_id] then	
	--	queueLength = queueLength + 1;
	--	pendingQueue[unit_id] = true;
	--	inspectQueue[queueLength] = unit_id;
	--end			
	
	-- if there's no active inspection, start one
	
	--if unit_id ~= "mouseover" then
	
	--	if not (InspectFrame and InspectFrame:IsVisible())
	--	and not (PaperDollFrame and PaperDollFrame:IsVisible())
	--	and not currentInspectUnit
	--	and CanInspect(unit_id) 					-- 5.0.1 Change
	--	then
	--		inspectedUnit = unit_id					-- 5.0.1 Change
	--		NotifyInspect( unit_id );
	--	end
	--end	
		
--	nUI_ProfileStop();

end

-------------------------------------------------------------------------------
-- read the talent table

local function ReadTalents( guid )

	-- perform the talent inspection on the ready unit and add it to the
	-- cache for the identified GUID if there is one
		
	local unit_info     = nUI_Unit:getGUIDInfo( guid );
	local remoteInspect = UnitGUID( "player" ) ~= guid;

	-- 5.0.1 Change Start
	--currentInspectUnit = nil;
	--currentInspectGUID = nil;
	--if unit_info then
		--local build = unit_info.build or {};
		--build.expires = GetTime() + 300; -- expire the build data every five minutes
		--build.id1, build.name1, build.desc, build.iconTexture1, build.num1, build.background1  = GetTalentTabInfo( 1, remoteInspect );
		--build.id2, build.name2, build.desc, build.iconTexture2, build.num2, build.background2  = GetTalentTabInfo( 2, remoteInspect );
		--build.id3, build.name3, build.desc, build.iconTexture3, build.num3, build.background3  = GetTalentTabInfo( 3, remoteInspect );		
	-- end

	local unitID = inspectedUnit
	local specID = GetInspectSpecialization(unitID)
	if unit_info and (specID and specID > 0) then	
		local build = unit_info.build or {};	
		build.expires = GetTime() + 300; -- expire the build data every five minutes		
		build.id, build.name, build.desc, build.iconTexture, build.background, build.role = GetSpecializationInfoByID(specID)		
		unit_info.build = build;
	end	
	currentInspectUnit = nil;
	currentInspectGUID = nil;
	-- 5.0.1 Change End


	-- dequeue any pending units for the same GUID since we have it now
	
	local newLength = 0;

	for i=1,queueLength do
	
		if UnitGUID( inspectQueue[i] ) == guid then
			pendingQueue[inspectQueue[i]] = nil;
		else
			newLength = newLength+1;
			inspectQueue[newLength] = inspectQueue[i];
		end						
	end
	
	queueLength = newLength;

	-- if there's another unit pending inspection, do so now
	
	if queueLength > 0 then
		GetTalentBuild( inspectQueue[1] );
	end
		
--	nUI_ProfileStop();

end

-------------------------------------------------------------------------------
-- flag the unit spec ready for reading on a unit we're waiting for

local count = 1;

local function onTalentBuildEvent( who, event, arg1 )
	
	-- 5.0.1 change start - Event name change
	--if event == "INSPECT_TALENT_READY" then
	if event == "INSPECT_READY" then
	-- 5.0.1 Change end
		ReadTalents( arg1 );		
		--nUI_Unit:refreshSpecCallbacks()
		
	elseif event == "PLAYER_TALENT_UPDATE" then
		GetTalentBuild( "player" );	
		
	-- 5.0.1 Change Start - Load Blizzard Inspect UI
	--elseif event == "ADDON_LOADED" and arg1 == "nUI" then
	--	LoadAddOn("Blizzard_InspectUI")
	-- 5.0.1 Change end
	end
	
--	nUI_ProfileStop();

end

frame:SetScript( "OnEvent", onTalentBuildEvent );

-- 5.0.1 Change Start - Event name change
--frame:RegisterEvent( "INSPECT_TALENT_READY" );
frame:RegisterEvent("INSPECT_READY");				
frame:RegisterEvent( "ADDON_LOADED");				
-- 5.0.1 Change End

frame:RegisterEvent( "PLAYER_TALENT_UPDATE" );

-------------------------------------------------------------------------------
-- add and remove callbacks from the list of unit spec listeners we manage
--
-- calling this method will return the current unit_info structure for this 
-- unit if it exists or nil if the unit does not exist at this time
--
-- Note: these callbacks will be notified both when the underlying GUID for the
--		 unit changes or when the unit spec of the underlying GUID to the
--		 player changes. If the underlying unit does not exist, the callback
--		 will be passed a nil unit_info structure

function nUI_Unit:registerSpecCallback( unit_id, callback )
	
--	nUI_ProfileStart( ProfileCounter, "registerSpecCallback" );
	
	local unit_info = nil;
	
	if unit_id and callback then
		
		-- get the list of callbacks for this unit id and add this callback
		
		local list = SpecCallbacks[unit_id] or {};
		
		nUI:TableInsertByValue( list, callback );
		
		-- if this is a new unit id, add it to the callback list
		
		if not SpecCallbacks[unit_id] then
			SpecCallbacks[unit_id] = list;
		end
		
		-- if this is the first callback for the unit id, then register our
		-- event driver to receive notice when the GUID changes on this id
		-- or the unit reaction status changes (enters/leaves a party/raid, etc.)
		
		if #list == 1 then
			nUI_Unit:registerUnitChangeCallback( unit_id, nUI_Unit.Drivers.Spec );
		end
		
		-- collect unit spec information for this unit as we know it at this time
	
		unit_info = nUI_Unit:getUnitInfo( unit_id );
		
		if unit_info then
			nUI_Unit:updateSpecInfo( unit_id, unit_info );
		end
	end
	
--	nUI_ProfileStop();

	return unit_info;
	
end

function nUI_Unit:unregisterSpecCallback( unit_id, callback )
	
--	nUI_ProfileStart( ProfileCounter, "unregisterSpecCallback" );
	
	if unit_id and callback then
		
		-- get the list of current callbacks for this unit ud and remove this callback
		
		local list = SpecCallbacks[unit_id] or {};
		
		nUI:TableRemoveByValue( list, callback );
		
		-- if that's the last callback in the list, then remove our event handler of
		-- the list of unit change callbacks for that unit it
		
		if #list == 0 then
			nUI_Unit:unregisterUnitChangeCallback( unit_id, nUI_Unit.Drivers.Spec );
		end
	end

--	nUI_ProfileStop();

end

-------------------------------------------------------------------------------
-- update the unit spec information for this unit
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

function nUI_Unit:updateSpecInfo( unit_id, unit_info )

--	nUI_ProfileStart( ProfileCounter, "updateSpecInfo" );
	
	local modified  = false;
	
	if unit_info then

		-- if this is not a player character, then our only concern is 
		-- whether or not it is an elite, rare, world boss, etc.
		
		local family         = UnitCreatureFamily( unit_id );
		local type           = UnitCreatureType( unit_id );
		local race           = UnitRace( unit_id );
		local sex            = UnitSex( unit_id );
		local classification = UnitClassification( unit_id );
		local build			 = unit_info.build or nil;
		
		-- rare spotting functionality is located here because we only want to spot
		-- once, not for every unit frame that references the mob
		
		if classification == "rare" or classification == "rareelite" then
			
			local now = GetTime();
			
			if not unit_info.spotted or unit_info.spotted+30 < now then
				
				local mapX, mapY   = GetPlayerMapPosition( "player" );
				local location     = mapX and mapY and (mapX > 0 or mapY > 0) and (" at (%0.1f,%0.1f)"):format( mapX * 100, mapY * 100 ) or "";
				
				unit_info.spotted = now;				
				PlaySound("AuctionWindowOpen");
				
				if classification == "rare" then DEFAULT_CHAT_FRAME:AddMessage( "nUI: "..nUI_L["You have spotted a rare mob: |cFF00FF00<mob name>|r<location>"]:format( UnitName( unit_id ), location ), 1, 0.83, 0 );
				else DEFAULT_CHAT_FRAME:AddMessage( "nUI: "..nUI_L["You have spotted a rare elite mob: |cFF00FF00<mob name>|r<location>"]:format( UnitName( unit_id ), location ), 1, 0.83, 0 );
				end
				
			end
			
		end
		
		-- if this unit is not a player, then there is no such thing
		-- as a talent build for it
		
		if not unit_info.is_player 
		then build = nil;
		
		-- otherwise, if this is a player and we don't already have
		-- a talent build for it, then queue a request for one
		
		elseif not build or build.expires < GetTime()
		then GetTalentBuild( unit_id )			
		end		
		
		-- has anything about the unit changed?
		
		if unit_info.family         ~= family
		or unit_info.type           ~= type
		or unit_info.race           ~= race
		or unit_info.sex            ~= sex
		or unit_info.classification ~= classification
		or unit_info.build          ~= build
		then
			
			modified                 = true;
			unit_info.modified       = true;
			unit_info.last_change    = GetTime();
			unit_info.family         = family;
			unit_info.type           = type;
			unit_info.race           = race;
			unit_info.sex            = sex;
			unit_info.classification = classification;
			unit_info.build          = build;
			
		end
	end
	
	frame.build = nil;
	
--	nUI_ProfileStop();

	return modified and unit_info or nil;
	
end

-------------------------------------------------------------------------------
-- update all of the registered unit spec listeners, even if there's no 
-- change in data.

function nUI_Unit:refreshSpecCallbacks()
	
--	nUI_ProfileStart( ProfileCounter, "refreshSpecCallbacks" );
	
	nUI_Unit:refreshCallbacks( 
	
		nUI_L["unit spec"], SpecCallbacks, SpecUnits, 
	
		function( list_unit, unit_info ) 
			nUI_Unit:updateSpecInfo( list_unit, unit_info ); 
		end 
	);

--	nUI_ProfileStop();

end

-------------------------------------------------------------------------------
-- create a new unit spec frame

function nUI_Unit:createSpecFrame( parent, unit_id, id, options )

--	nUI_ProfileStart( ProfileCounter, "createSpecFrame" );
	
	local frame = nUI_Unit:createFrame( "$parent_Spec"..(id or ""), parent, unit_id, options and options.clickable );
	frame.text  = frame:CreateFontString( "$parentLabel", "OVERLAY" );
	frame.icon  = frame:CreateTexture( "$parentIcon", "ARTWORK" );
	frame.Super = {};
	
	frame.icon:SetAlpha( 0 );
	
	-- called when the underlying GUID for the unit changes or when the
	-- content of the GUID is updated

	frame.Super.newUnitInfo = frame.newUnitInfo;
	frame.newUnitInfo       = function( list_unit, unit_info )

--		nUI_ProfileStart( FrameProfileCounter, "newUnitInfo" );
		
		frame.Super.newUnitInfo( list_unit, unit_info );
		
		if frame.enabled then
			nUI_Unit:updateSpecFrame( frame );
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
		
		local prior_state = frame.enabled;
		
		frame.Super.setEnabled( enabled );
		
		if frame.enabled ~= prior_state then
		
			if frame.enabled then
				frame.unit_info = nUI_Unit:registerSpecCallback( frame.unit, frame );
				nUI_Unit:updateSpecFrame( frame );
			else
				nUI_Unit:unregisterSpecCallback( frame.unit, frame );
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

		if frame.options 
		and frame.options.icon 
		and frame.options.icon.enabled
		then
			
			local width  = frame.options.icon.width * frame.hScale;
			local height = frame.options.icon.height * frame.vScale;
			
			if frame.icon.width  ~= width
			or frame.icon.height ~= height
			then
		
				frame.icon.width  = width;
				frame.icon.height = height;
				
				frame.icon:SetWidth( width );
				frame.icon:SetHeight( height );
				
			end
		end
		
		frame.configText( frame.text, frame.options.label );
		
--		nUI_ProfileStop();
	
	end
	
	-- anchor the frame and its icon if it has one
	
	frame.Super.applyAnchor = frame.applyAnchor;
	frame.applyAnchor       = function( anchor )
		
--		nUI_ProfileStart( FrameProfileCounter, "applyAnchor" );
		
		frame.Super.applyAnchor( anchor );
		
		if frame.options 
		and frame.options.icon 
		and frame.options.icon.enabled
		then
			
			local options = frame.options.icon;
			local anchor_pt   = options.anchor_pt or "CENTER";
			local relative_to = options.relative_to or frame:GetName();
			local relative_pt = options.relative_pt or anchor_pt;
			local xOfs        = (options.xOfs or 0) * frame.hScale;
			local yOfs        = (options.yOfs or 0) * frame.vScale;
			
			if frame.icon.anchor_pt   ~= anchor_pt
			or frame.icon.relative_to ~= relative_to
			or frame.icon.relative_pt ~= relative_pt
			or frame.icon.xOfs        ~= xOfs
			or frame.icon.yOfs        ~= yOfs
			then
				
				frame.icon.anchor_pt = anchor_pt;
				frame.icon.relative_to = relative_to;
				frame.icon.relative_pt = relative_pt;
				frame.icon.xOfs        = xOfs;
				frame.icon.yOfs        = yOfs;
				
				frame.icon:ClearAllPoints();
				frame.icon:SetPoint( anchor_pt, relative_to:gsub( "$parent", frame.parent:GetName() ), relative_pt, xOfs, yOfs );
				
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
		
		if not frame.options.icon 
		or not frame.options.icon.enabled
		then
			
			frame.icon.enabled = false;
			frame.icon:Hide();
			
		else
			
			frame.icon.enabled = true;
			frame.icon:Show();
			
		end
		
		nUI_Unit:updateSpecFrame( frame );
		
--		nUI_ProfileStop();
	
	end
	
	-- initiate the frame
	
	frame.unit_info = nUI_Unit:registerSpecCallback( frame.unit, frame );
	frame.applyOptions( options );
	
--	nUI_ProfileStop();
	
	return frame;
		
end

-------------------------------------------------------------------------------
-- remove a unit spec frame

function nUI_Unit:deleteSpecFrame( frame )

--	nUI_ProfileStart( ProfileCounter, "deleteSpecFrame" );
		
	nUI_Unit:unregisterSpecCallback( frame.unit, frame );
	nUI_Unit:deleteFrame( frame );
	
--	nUI_ProfileStop();
	
end

-------------------------------------------------------------------------------
-- display the appropriate text for the unit's spec
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

function nUI_Unit:updateSpecFrame( frame )
	
--	nUI_ProfileStart( ProfileCounter, "updateSpecFrame" );
		
	local unit_info = frame.unit_info;

	-- if there is no unit or we don't know it's unit spec, then hide the panel
	
	if not unit_info 
	then
		
		if frame.active then

			frame.active = false;
			frame:SetAlpha( 0 );
		end
	
	-- otherwise, show the unit spec
	
	else

		local spec;
		local icon = nil;
		local coord;
		
		-- if the unit spec is hidden, show it
		
		if not frame.active then

			frame.active = true;
			frame:SetAlpha( 1 );
		end

		-- if this unit has a talent build, then we build the label from that
		
		if unit_info.build then

			-- 5.0.1 Change Start
			--if frame.options.show_name and frame.options.show_points then
			--	spec = unit_info.build.name.." ("..unit_info.build.points..")";
			--elseif frame.options.show_name then
			--	spec = unit_info.build.name;
			--elseif frame.options.show_points then
			--	spec = unit_info.build.points;
			--end
			if frame.options.show_name then
				spec = unit_info.build.name
			end
			-- 5.0.1 Change End
		
		-- otherwise is there some generic mob information we need to display about this unit?
		
		elseif unit_info.classification == "worldboss" then			
			icon  = frame.options.icon  and frame.options.icon.world_boss_icon or nil;
			coord = frame.options.icon and frame.options.icon.world_boss_coord or nil;
			spec  = nUI_L["World Boss"];
			
		elseif unit_info.classification == "elite" then			
			icon  = frame.options.icon and frame.options.icon.elite_icon or nil;
			coord = frame.options.icon and frame.options.icon.elite_coord or nil;
			spec  = nUI_L["Elite"];
			
		elseif unit_info.classification == "rare" then			
			icon  = frame.options.icon and frame.options.icon.rare_icon or nil;
			coord = frame.options.icon and frame.options.icon.rare_coord or nil;
			spec  = nUI_L["Rare"];
			
		elseif unit_info.classification == "rareelite" then
			icon  = frame.options.icon and frame.options.icon.rare_elite_icon or nil;
			coord = frame.options.icon and frame.options.icon.rare_elite_coord or nil;
			spec  = nUI_L["Rare Elite"];
			
		elseif UnitIsUnit( frame.unit, "vehicle" ) then
			spec = nUI_L["Vehicle"];
			
		elseif frame.options.show_family then
			spec = unit_info.family;
			
		elseif frame.options.show_type then
			spec = unit_info.type;
			
		end
		
		-- if the unit spec has changed from what we last knew, then update 
		
		-- 5.0.1 Change Start
		--if frame.spec ~= spec then
		if frame.spec ~= spec and spec ~= nil then
		-- 5.0.1 change end
			frame.spec = spec;			
			frame.text:SetText( spec );
			
		end		
		
		-- set the frame icon if required
		
		if frame.icon.enabled
		and (frame.icon.texture ~= icon or frame.icon.coord ~= coord)
		then
			frame.icon.texture = icon;
			frame.icon.coord   = coord;
			frame.icon:SetTexture( icon );
			frame.icon:SetTexCoord( unpack( coord or { 0, 0, 0, 1, 1, 0, 1, 1 } ) );

		end
		
		if frame.icon.enabled
		and icon
		then
			
			if not frame.icon.active then
				
				frame.icon.active = true;
				frame.icon:SetAlpha( 1 );
				
			end
			
		elseif frame.icon.active then
			
			frame.icon.active = false;
			frame.icon:SetAlpha( 0 );
			
		end

	end
	
--	nUI_ProfileStop();
	
end
