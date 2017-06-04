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
if not nUI_Options then nUI_Options = {}; end
if not nUI_Unit then nUI_Unit = {}; end
if not nUI_UnitOptions then nUI_UnitOptions = {}; end
if not nUI_DefaultConfig then nUI_DefaultConfig = {}; end
if not nUI_Profile then nUI_Profile = {}; end;

local CreateFrame       = CreateFrame;
local GetTime           = GetTime;
local UnitCanAttack     = UnitCanAttack;
local UnitExists        = UnitExists;
local UnitIsDeadOrGhost = UnitIsDeadOrGhost;
local UnitIsUnit        = UnitIsUnit;

nUI_Options.feedback_curse   = true;
nUI_Options.feedback_magic   = true;
nUI_Options.feedback_poison  = true;
nUI_Options.feedback_disease = true;
nUI_Options.show_hits        = true;

-------------------------------------------------------------------------------
-- default options for the unit feedback colors

nUI_DefaultConfig.FeedbackColors =
{
	-- backdrop colors
	
	["bgAgro"]     = { r = 1, g = 0, b = 0, },
	["bgMagic"]    = DebuffTypeColor["Magic"],
	["bgCurse"]    = DebuffTypeColor["Curse"],
	["bgDisease"]  = DebuffTypeColor["Disease"],
	["bgPoison"]   = DebuffTypeColor["Poison"],
	
	-- highlight colors
	
	["hitHeal"]     = { r = 0, g = 1, b = 0, },
	["hitPhysical"] = { r = 1, g = 0, b = 0, },
	["hitHoly"]     = { r = 1, g = 0, b = 0, },
	["hitFire"]     = { r = 1, g = 0, b = 0, },
	["hitNature"]   = { r = 1, g = 0, b = 0, },
	["hitFrost"]    = { r = 1, g = 0, b = 0, },
	["hitShadow"]   = { r = 1, g = 0, b = 0, },
	["hitArcane"]   = { r = 1, g = 0, b = 0, },
	
	-- text colors
	
	["txtNormal"]   = { r = 1, g = 1, b = 1, },
	["txtHeal"]     = { r = 0, g = 0, b = 0, },
	["txtGlancing"] = { r = 0.75, g = 0.75, b = 0.75, },
	["txtCritical"] = { r = 1, g = 0.83, b = 0, },
	["txtCrushing"] = { r = 1, g = 0.25, b = 0.25, },
	
};

local HitColorMap =
{
	[1]  = "hitPhysical",
	[2]  = "hitHoly",
	[4]  = "hitFire",
	[8]  = "hitNature",
	[16] = "hitFrost",
	[32] = "hitShadow",
	[65] = "hitArcane",
};
-------------------------------------------------------------------------------
-- unit feedback event management

if not nUI_Unit.Drivers then 
	nUI_Unit.Drivers = CreateFrame( "Frame", "nUI_UnitDrivers", WorldFrame ); 
end

nUI_Profile.nUI_UnitFeedback       = {};
nUI_Profile.nUI_UnitFeedback.Frame = {};

local ProfileCounter      = nUI_Profile.nUI_UnitFeedback;
local FrameProfileCounter = nUI_Profile.nUI_UnitFeedback.Frame;

local frame = CreateFrame( "Frame", "$parent_Feedback", nUI_Unit.Drivers )

local HostileName;
local TargetInfo;
local ToTInfo;
local FeedbackTimer      = 0;
local FadeTimer          = 1 / nUI_DEFAULT_FRAME_RATE;
local queue_timer        = 1 / nUI_DEFAULT_FRAME_RATE;
local FeedbackCallbacks  = {};
local FeedbackUnits      = {};
local FeedbackData       = {};
local ActiveTextures     = {};
local NewUnitInfo        = {};
local UpdateQueue        = {};

nUI_Unit.Drivers.Feedback  = frame;

-------------------------------------------------------------------------------
-- variables used in methods within this module are declared here to eliminate
-- the use of dynamic memory and the garbage collector

local unit_id;
local unit_info;
local traceList = {};
local trace;
local i,j;
local tot_info;
local procTime;
local texture;
local elapsed_time;
local alpha;
local list;
local modified;
local feedback = {};
local cached;
local threatStatus;
local debuff;
local buff;
local prior_state;
local action;
local effect;
local hitValue;
local hitType;
local proc_time;
local feedback_color;

-------------------------------------------------------------------------------

local registered = false;

local function onFeedbackEvent( who, event, ... )
	
	local arg1, arg2, arg3, arg4, arg5 = ...;
	
--	nUI_ProfileStart( ProfileCounter, "onFeedbackEvent", event );
	
	if event == "ADDON_LOADED" and arg1 == "nUI" then
		
		nUI:patchConfig();
		nUI_Unit:configFeedback();
		
		-- set up a slash command handler for choosing whether or not nUI will display hit/heal background colors
		
		local option = nUI_SlashCommands[nUI_SLASHCMD_SHOWHITS];
		
		nUI_SlashCommands:setHandler( option.command,
			
			function( msg, arg1 )
				
				nUI_Options.show_hits = not nUI_Options.show_hits;
				
				DEFAULT_CHAT_FRAME:AddMessage( (option.message):format( nUI_Options.show_hits and nUI_L["|cFF00FF00ENABLED|r"] or nUI_L["|cFFFF0000DISABLED|r"] ), 1, 0.83, 0 );

			end
		);		
	
		-- set up a slash command handler for choosing whether or not nUI will highlight the various dispellable debuff types
		
		local option = nUI_SlashCommands[nUI_SLASHCMD_FEEDBACK];
		
		nUI_SlashCommands:setHandler( option.command,
			
			function( msg, arg1 )
				
				if arg1 == nUI_L[nUI_SLASHCMD_OPTIONS( nUI_SLASHCMD_FEEDBACK, "curse" )] then
					nUI_Options.feedback_curse = not nUI_Options.feedback_curse;
					DEFAULT_CHAT_FRAME:AddMessage( (option.message):format( arg1, nUI_Options.feedback_curse and nUI_L["|cFF00FF00ENABLED|r"] or nUI_L["|cFFFF0000DISABLED|r"] ), 1, 0.83, 0 );
				elseif arg1 == nUI_L[nUI_SLASHCMD_OPTIONS( nUI_SLASHCMD_FEEDBACK, "disease" )] then
					nUI_Options.feedback_disease = not nUI_Options.feedback_disease;
					DEFAULT_CHAT_FRAME:AddMessage( (option.message):format( arg1, nUI_Options.feedback_disease and nUI_L["|cFF00FF00ENABLED|r"] or nUI_L["|cFFFF0000DISABLED|r"] ), 1, 0.83, 0 );
				elseif arg1 == nUI_L[nUI_SLASHCMD_OPTIONS( nUI_SLASHCMD_FEEDBACK, "magic" )] then
					nUI_Options.feedback_magic = not nUI_Options.feedback_magic;
					DEFAULT_CHAT_FRAME:AddMessage( (option.message):format( arg1, nUI_Options.feedback_magic and nUI_L["|cFF00FF00ENABLED|r"] or nUI_L["|cFFFF0000DISABLED|r"] ), 1, 0.83, 0 );
				elseif arg1 == nUI_L[nUI_SLASHCMD_OPTIONS( nUI_SLASHCMD_FEEDBACK, "poison" )] then
					nUI_Options.feedback_poison = not nUI_Options.feedback_poison;
					DEFAULT_CHAT_FRAME:AddMessage( (option.message):format( arg1, nUI_Options.feedback_poison and nUI_L["|cFF00FF00ENABLED|r"] or nUI_L["|cFFFF0000DISABLED|r"] ), 1, 0.83, 0 );
				else
					DEFAULT_CHAT_FRAME:AddMessage( 
						nUI_L["nUI: [ %s ] is not a valid feedback option... please choose either <curse>, <disease>, <magic> or <poison>"]:format( 
							(arg1 or "<nil>"),
							nUI_L[nUI_SLASHCMD_OPTIONS( nUI_SLASHCMD_FEEDBACK, "curse" )],
							nUI_L[nUI_SLASHCMD_OPTIONS( nUI_SLASHCMD_FEEDBACK, "disease" )],
							nUI_L[nUI_SLASHCMD_OPTIONS( nUI_SLASHCMD_FEEDBACK, "magic" )],
							nUI_L[nUI_SLASHCMD_OPTIONS( nUI_SLASHCMD_FEEDBACK, "poison" )]
						), 1, 0.83, 0
					);
				end
			end
		);		
	
	-- for these events, we don't know which units are affected, so
	-- we span the list of all known interested units to see who is watching
		
	elseif event == "PLAYER_ENTERING_WORLD" then
		
		-- register to receive notices when the target changes so we can find out
		-- who has the new target's agro when required. We acutally use the 
		-- unit reaction callback instead of unit change because we also need to
		-- know if we can attack the unit or if it is friendly to us

		if not registered then
			
			registered = true;
			nUI_Unit:registerReactionCallback( "target", nUI_UnitDrivers.Feedback );
			nUI_Unit:registerReactionCallback( "targettarget", nUI_UnitDrivers.Feedback );
			
		else
			
			nUI_Unit:refreshFeedbackCallbacks()

		end
		
	-- a combat event
	
	elseif event == "UNIT_COMBAT" then

		if FeedbackCallbacks[arg1] and #FeedbackCallbacks[arg1] > 0 then			
		
			UpdateQueue[arg1] = true;
			NewUnitInfo[arg1] = nUI_Unit:getUnitInfo( arg1 );			
			
			if not FeedbackData[arg1] then FeedbackData[arg1] = {}; end

			FeedbackData[arg1].action   = arg2;
			FeedbackData[arg1].effect   = arg3;
			FeedbackData[arg1].hitValue = arg4;
			FeedbackData[arg1].hitType  = arg5;
			FeedbackData[arg1].newData  = true;
			
		end
	end

--	nUI_ProfileStop();
	
end

frame:SetScript( "OnEvent", onFeedbackEvent );
frame:RegisterEvent( "ADDON_LOADED" );
frame:RegisterEvent( "PLAYER_ENTERING_WORLD" );
frame:RegisterEvent( "UNIT_COMBAT" );

-------------------------------------------------------------------------------
-- feedback update event handler

local function onFeedbackUpdate( who, elapsed )
	
--	nUI_ProfileStart( ProfileCounter, "onFeedbackUpdate" );
	
	queue_timer = queue_timer - elapsed;
	
	if queue_timer <= 0 then -- process the update queue at the user selected frame rate
	
		queue_timer = nUI_Unit.frame_rate;

		for unit_id in pairs( UpdateQueue ) do
		
			if UpdateQueue[unit_id] then
			
				UpdateQueue[unit_id] = false;
				unit_info = NewUnitInfo[unit_id];
								
				if FeedbackCallbacks[unit_id] and #FeedbackCallbacks[unit_id] > 0 then
					nUI_Unit:notifyCallbacks( 
						nUI_L["unit feedback"], FeedbackCallbacks, FeedbackUnits, 
						unit_info, unit_id, nUI_Unit:updateFeedbackInfo( unit_id, unit_info ) 
					);
				end
			end
		end
	end	
		
	FeedbackTimer = FeedbackTimer + elapsed;
	
	if FeedbackTimer > 0.08 then -- 12.5fps check rate on taget agro
	
		FeedbackTimer = 0;

		unit_id   = "target";
		unit_info = nil;
		
		for i in pairs( traceList ) do
			traceList[i] = false;
		end
		
		-- find a unit that can attack us
		
		while true do
		
			unit_info = nUI_Unit:getUnitInfo( unit_id );

			-- if the unit doesn't exist, we've gone as deep as we can
			
			if not unit_info
			then break;
			end
			
			-- otherwise, if the unit is capable of attacking us, then
			-- we want to know who it is this unit is attacking
			
			if UnitCanAttack( unit_id, "player" )
			then break;
			end

			-- make sure we're not looping back on ourselves
			
			trace = UnitGUID( unit_id );
			
			if traceList[trace] then
				break;
			end
			
			traceList[trace] = true;
			
			-- otherwise, dig a level deeper

			unit_id = unit_id.."target";
						
		end
			
		-- if we don't have a hostile unit, try running down the focus chain and
		-- see if we can find one there
		
		if not unit_info then

			unit_id   = "focus";
					
			for i in pairs( traceList ) do
				traceList[i] = false;
			end
			
			while true do		
			
				unit_info = nUI_Unit:getUnitInfo( unit_id );

				-- if the unit doesn't exist, we've gone as deep as we can
				
				if not unit_info
				then break;
				end
				
				-- otherwise, if the unit is capable of attacking us, then
				-- we want to know who it is this unit is attacking
				
				if UnitCanAttack( unit_id, "player" )
				then break;
				end

				-- make sure we're not looping back on ourselves
				
				trace = UnitGUID( unit_id );
				
				if traceList[trace] then
					break;
				end
				
				traceList[trace] = true;
				
				-- otherwise, dig a level deeper

				unit_id = unit_id.."target";
				
			end
		end
		
		-- if we have a unit info structure, then we have a unit that is (or could 
		-- be) hostile to the player. The agro of that target is whoever it is
		-- they are targeting
		
		tot_info = nil;
					
		if unit_info 
		and not UnitIsDeadOrGhost( unit_id ) 
		and UnitExists( unit_id.."target" )		
		and UnitCanAttack( unit_id, unit_id.."target" )
		then tot_info = nUI_Unit:getUnitInfo( unit_id.."target" );
		end
		
		-- we only change the notion of who the agro is if we see a different
		-- agro in combat or we're not in combat at all. This prevents losing
		-- the idea of who the agro is if we momentarily have no target or 
		-- no target that resolves to an agro while we are still in combat
		-- in which case we assume the agro hasn't changed until we can resolve
		-- it accurately
		
		if (TotInfo and not tot_info and not InCombatLockdown())
		or (tot_info and TotInfo ~= tot_info)
		then 
			TotInfo = tot_info;
			nUI_Unit:refreshFeedbackCallbacks();
		end		
	end

	-- do whatever fading is required on hit highlights
	
	FadeTimer = FadeTimer - elapsed;
	
	if FadeTimer <= 0 then
	
		proc_time = GetTime();
		FadeTimer = nUI_Unit.frame_rate;
		
		for i=#ActiveTextures,1,-1 do
		
			texture = ActiveTextures[i];
			
			if texture.end_time <= proc_time then
				nUI:TableRemoveByValue( ActiveTextures, texture );
				texture:SetAlpha( 0 );
				texture.start_time = nil;
				texture.end_time = nil;
				texture.alpha = 0;
			else
				elapsed_time = proc_time - texture.start_time;
				alpha = 1;

				-- if this is a new hit, then we use either the current alpha or set a new alpha
				-- based on how long since the last hit. This causes the alpha to never retreat to
				-- a value smaller than the current if we get a hit before the last hit entirely
				-- faded away... in a busy environment like a BG, it would be possible to never
				-- actually show the hit if the unit was getting fast enough by enough players
				
				if elapsed_time < COMBATFEEDBACK_FADEINTIME then
					alpha = max( (texture.alpha or 0), alpha - (COMBATFEEDBACK_FADEINTIME - elapsed_time) / COMBATFEEDBACK_FADEINTIME );
					
				-- if we've reached the peak and are ready to fade away, then start lowering the alpha
				
				elseif elapsed_time > (COMBATFEEDBACK_FADEINTIME + COMBATFEEDBACK_HOLDTIME) then
					elapsed_time = elapsed_time - (COMBATFEEDBACK_FADEINTIME + COMBATFEEDBACK_HOLDTIME);
					alpha = (COMBATFEEDBACK_FADEOUTTIME - elapsed_time) / COMBATFEEDBACK_FADEOUTTIME;
				end
				
				texture.alpha = alpha;				
				texture:SetAlpha( alpha );

			end
		end
	end
		
--	nUI_ProfileStop();
	
end

frame:SetScript( "OnUpdate", onFeedbackUpdate );

-------------------------------------------------------------------------------
-- this callback method is called when one of the unit IDs we are monitoring
-- for unit feedback changes GUID

frame.newUnitInfo = function( unit_id, unit_info )

--	nUI_ProfileStart( ProfileCounter, "newUnitInfo" );
	
	UpdateQueue[unit_id] = true;
	NewUnitInfo[unit_id] = unit_info;
	
--	nUI_ProfileStop();
	
end

-------------------------------------------------------------------------------
-- initialize configuration for the unit feedback color indicators
-- 
-- this method is called when the mod's saved variables have been loaded by Bliz and
-- may be called again whenever the unit feedback configuration has been changed
-- by the player or programmatically. Passing true or a non-nil value for "use_default"
-- will cause the player's current feedback color configuration to be replaced with
-- the default settings defined at the top of this file (which cannot be undone!)

function nUI_Unit:configFeedback( use_default )
	
--	nUI_ProfileStart( ProfileCounter, "configFeedback" );
	
	if not nUI_UnitOptions then nUI_UnitOptions = {}; end
	if not nUI_UnitOptions.FeedbackColors then nUI_UnitOptions.FeedbackColors = {}; end
	
	for feedback in pairs( nUI_DefaultConfig.FeedbackColors ) do
		nUI_Unit:configFeedbackColor( feedback, use_default );
	end

--	nUI_ProfileStop();
	
end

function nUI_Unit:configFeedbackColor( feedback, use_default )
	
--	nUI_ProfileStart( ProfileCounter, "configFeedbackColor" );
	
	local config  = nUI_UnitOptions.FeedbackColors[feedback] or {};
	local default = nUI_DefaultConfig.FeedbackColors[feedback] or {};
	
	if use_default then
			
		config.r = default.r;
		config.g = default.g;
		config.b = default.b;

	else
			
		config.r = tonumber( config.r or default.r );
		config.g = tonumber( config.g or default.g );
		config.b = tonumber( config.b or default.b );

	end
	
	nUI_UnitOptions.FeedbackColors[feedback] = config;
	nUI_Unit:refreshFeedbackCallbacks();
	
--	nUI_ProfileStop();
	
end

-------------------------------------------------------------------------------
-- add and remove callbacks from the list of unit feedback listeners we manage
--
-- calling this method will return the current unit_info structure for this 
-- unit if it exists or nil if the unit does not exist at this time
--
-- Note: these callbacks will be notified both when the underlying GUID for the
--		 unit changes or when the feedback info of the underlying GUID to the
--		 player changes. If the underlying unit does not exist, the callback
--		 will be passed a nil unit_info structure

function nUI_Unit:registerFeedbackCallback( unit_id, callback )
	
--	nUI_ProfileStart( ProfileCounter, "registerFeedbackCallback" );
	
	unit_info = nil;
	
	if unit_id and callback then
		
		-- get the list of callbacks for this unit id and add this callback
		
		list = FeedbackCallbacks[unit_id] or {};
		
		nUI:TableInsertByValue( list, callback );
		
		-- if this is a new unit id, add it to the callback list
		
		if not FeedbackCallbacks[unit_id] then
			FeedbackCallbacks[unit_id] = list;
		end
		
		-- if this is the first callback for the unit id, then register our
		-- event driver to receive notice when the GUID changes on this id
		-- We use the aura callback system for this as we need both to know
		-- that the unit changed and to know that its auras have been 
		-- updated (which would cause or cure curse, poison, etc.)
		
		if #list == 1 then
			nUI_Unit:registerAuraCallback( unit_id, nUI_Unit.Drivers.Feedback );
		end
		
		-- collect feedback information for this unit as we know it at this time
	
		unit_info = nUI_Unit:getUnitInfo( unit_id );
		
		if unit_info then
			nUI_Unit:updateFeedbackInfo( unit_id, unit_info );
		end
	end
	
--	nUI_ProfileStop();
	
	return unit_info;
	
end

function nUI_Unit:unregisterFeedbackCallback( unit_id, callback )
	
--	nUI_ProfileStart( ProfileCounter, "unregisterFeedbackCallback" );
	
	if unit_id and callback then
		
		-- get the list of current callbacks for this unit ud and remove this callback
		
		list = FeedbackCallbacks[unit_id] or {};
		
		nUI:TableRemoveByValue( list, callback );
		
		-- if that's the last callback in the list, then remove our event handler of
		-- the list of unit change callbacks for that unit it
		
		if #list == 0 then
			nUI_Unit:unregisterAuraCallback( unit_id, nUI_Unit.Drivers.Feedback );
		end
	end

--	nUI_ProfileStop();
	
end

-------------------------------------------------------------------------------
-- update the feedback information for this unit
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

function nUI_Unit:updateFeedbackInfo( unit_id, unit_info )

--	nUI_ProfileStart( ProfileCounter, "updateFeedbackInfo" );
	
	modified  = false;
	
	if unit_info then
		
		cached = unit_info.feedback or { hitColor = {}, bgColor = {}, txtColor = {}, };

		-- if we have an action, then set the feedback to that action
		
		if not FeedbackData[unit_id] then FeedbackData[unit_id] = {}; end
		
		action   = FeedbackData[unit_id].newData and FeedbackData[unit_id].action or nil;
		effect   = FeedbackData[unit_id].newData and FeedbackData[unit_id].effect or nil;
		hitValue = FeedbackData[unit_id].newData and FeedbackData[unit_id].hitValue or nil;
		hitType  = FeedbackData[unit_id].newData and FeedbackData[unit_id].hitType or nil;

		FeedbackData[unit_id].newData = false;
		
		if action then

			feedback.start_time = GetTime();
			feedback.end_time   = feedback.start_time + COMBATFEEDBACK_FADEINTIME + COMBATFEEDBACK_HOLDTIME + COMBATFEEDBACK_FADEOUTTIME;
			feedback.action     = action;
			feedback.effect     = effect;
			feedback.hitValue   = hitValue;
			feedback.hitType    = hitType;
			
			if action == "HEAL" then feedback.hitColor = nUI_UnitOptions.FeedbackColors["hitHeal"];
			else feedback.hitColor = nUI_UnitOptions.FeedbackColors[HitColorMap[hitType or 1]];
			end
				
			if not feedback.hitColor then feedback.hitColor = {}; end
			
			if     action == "HEAL"     then feedback.txtColor = nUI_UnitOptions.FeedbackColors["txtHeal"];
			elseif effect == "GLANCING" then feedback.txtColor = nUI_UnitOptions.FeedbackColors["txtGlancing"];
			elseif effect == "CRITICAL" then feedback.txtColor = nUI_UnitOptions.FeedbackColors["txtCritical"];
			elseif effect == "CRUSHING" then feedback.txtColor = nUI_UnitOptions.FeedbackColors["txtCrushing"];
			else                             feedback.txtColor = nUI_UnitOptions.FeedbackColors["txtNormal"];
			end
			
		-- otherwise, the feedback info stays the same
		
		else
			
			feedback.start_time = cached.start_time;
			feedback.end_time   = cached.end_time;
			feedback.action     = cached.action;
			feedback.effect     = cached.effect;
			feedback.hitValue   = cached.hitValue;
			feedback.hitType    = cached.hitType;
			feedback.hitColor   = cached.hitColor or {};
			feedback.txtColor   = cached.txtColor or {};
			
		end

		-- does this unit have the last hostile target's agro or any curses?
		
		threatStatus = UnitExists( unit_id ) and UnitThreatSituation( unit_id );
		
		feedback.has_agro    = unit_info == TotInfo;
		feedback.has_magic   = false;
		feedback.has_poison  = false;
		feedback.has_curse   = false;
		feedback.has_disease = false;
		
		if unit_info.aura_info then
			
			if (not unit_info.can_attack and not unit_info.attackable)
			and unit_info.aura_info.debuff_list
			then
				
				for i in pairs( unit_info.aura_info.debuff_list ) do
			
					debuff = unit_info.aura_info.debuff_list[i];
					
					if debuff.can_dispell then
						feedback.has_magic = feedback.has_magic or debuff.type == "Magic";
						feedback.has_curse = feedback.has_curse or debuff.type == "Curse";
						feedback.has_poison = feedback.has_poison or debuff.type == "Poison";
						feedback.has_disease = feedback.has_disease or debuff.type == "Disease";
					end					
				end
			end
			
			if (unit_info.can_attack or unit_info.attackable)
			and unit_info.aura_info.buff_list
			then
				
				for i in pairs( unit_info.aura_info.buff_list ) do
			
					buff = unit_info.aura_info.buff_list[i];
					
					if buff.can_dispell then
						feedback.has_magic = feedback.has_magic  or buff.type == "Magic";
						feedback.has_curse = feedback.has_curse or buff.type == "Curse";
						feedback.has_poison = feedback.has_poison or buff.type == "Poison";
						feedback.has_disease = feedback.has_disease or buff.type == "Disease";
					end					
				end
			end
		end
				
		-- has anything changed?
		
		if not unit_info.feedback
		or cached.start_time  ~= feedback.start_time
		or cached.end_time    ~= feedback.end_time
		or cached.has_agro    ~= feedback.has_agro
		or cached.has_magic   ~= feedback.has_magic
		or cached.has_curse   ~= feedback.has_curse
		or cached.has_poison  ~= feedback.has_poison
		or cached.has_disease ~= feedback.has_disease
		or cached.hitColor.r  ~= feedback.hitColor.r
		or cached.hitColor.g  ~= feedback.hitColor.g
		or cached.hitColor.b  ~= feedback.hitColor.b
		or cached.txtColor.r  ~= feedback.txtColor.r
		or cached.txtColor.g  ~= feedback.txtColor.g
		or cached.txtColor.b  ~= feedback.txtColor.b
		then
			
			modified              = true;
			unit_info.modified    = true;
			unit_info.last_change = GetTime();

			cached.start_time  = feedback.start_time;
			cached.end_time    = feedback.end_time;
			cached.action      = feedback.action;
			cached.effect      = feedback.effect;
			cached.hitValue    = feedback.hitValue;
			cached.hitType     = feedback.hitType;
			cached.hitColor    = feedback.hitColor or {};
			cached.txtColor    = feedback.txtColor or {};
			cached.has_agro    = feedback.has_agro;
			cached.has_magic   = feedback.has_magic;
			cached.has_poison  = feedback.has_poison;
			cached.has_curse   = feedback.has_curse;
			cached.has_disease = feedback.has_disease;
			
			if not unit_info.feedback then
				unit_info.feedback = cached;
			end
		end
	end
	
--	nUI_ProfileStop();
	
	return modified and unit_info or nil;
	
end

-------------------------------------------------------------------------------
-- update all of the registered unit feedback listeners, even if there's no 
-- change in data... typically used when the feedback color options change
-- or entering the world

function nUI_Unit:refreshFeedbackCallbacks()

--	nUI_ProfileStart( ProfileCounter, "refreshFeedbackCallbacks" );
	
	for unit_id in pairs( FeedbackCallbacks ) do
		if FeedbackCallbacks[unit_id] and #FeedbackCallbacks[unit_id] > 0 then
			UpdateQueue[unit_id] = true;
			NewUnitInfo[unit_id] = nUI_Unit:getUnitInfo( unit_id );
		end
	end

--	nUI_ProfileStop();
	
end

-------------------------------------------------------------------------------
-- create a new unit feedback frame

function nUI_Unit:createFeedbackFrame( parent, unit_id, id, options )

--	nUI_ProfileStart( ProfileCounter, "createFeedbackFrame" );
	
	local frame            = nUI_Unit:createFrame( "$parent_Feedback"..(id or ""), parent, unit_id, options and options.clickable );
	frame.texture          = frame:CreateTexture( "$parentTexture", "BACKGROUND" );
	frame.highlight        = CreateFrame( "Frame", "$parentHighlight", frame );
	frame.text             = frame:CreateFontString( "$parentText", "OVERLAY" );
	frame.texture.active   = true;
	frame.highlight.active = true;
	frame.Super            = {};

	frame.texture:SetAlpha( 0 );
	frame.highlight:SetAlpha( 0 );
	frame.texture:SetPoint( "CENTER", frame, "CENTER", 0, 0 );
	frame.texture:SetTexture( "Interface\\Tooltips\\UI-Tooltip-Background" );	
	frame.highlight:SetPoint( "CENTER", frame, "CENTER", 0, 0 );

	frame.highlight:SetBackdrop( 
		{
			bgFile   = nil, 
			edgeFile = "Interface\\AddOns\\nUI\\Layouts\\Default\\Art\\nUI_UnitFeedback.blp", 
			tile     = true, 
			tileSize = 1, 
			edgeSize = 7.5, 
			insets   = { left = 0, right = 0, top = 0, bottom = 0 }
		}
	);

	-- called when the underlying GUID for the unit changes or when the
	-- content of the GUID is updated
	
	frame.Super.newUnitInfo = frame.newUnitInfo;
	frame.newUnitInfo       = function( list_unit, unit_info )
		
--		nUI_ProfileStart( FrameProfileCounter, "newUnitInfo" );
		
		frame.Super.newUnitInfo( list_unit, unit_info );
		
		if frame.enabled then
			nUI_Unit:updateFeedbackFrame( frame );
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
				frame.unit_info = nUI_Unit:registerFeedbackCallback( frame.unit, frame );
				nUI_Unit:updateFeedbackFrame( frame );
			else
				nUI_Unit:unregisterFeedbackCallback( frame.unit, frame );
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
		
		frame.configText( frame.text, frame.options.text );
		
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

			frame.highlight:SetWidth( (frame.hSize or frame.width) - frame.hInset );
			frame.highlight:SetHeight( (frame.vSize or frame.height) - frame.vInset );
			
		end				

--		nUI_ProfileStop();
		
	end
	
	-- applies the set of frame options to this frame. Typically called when the frame 
	-- is first created or when the user changes options via config.

	frame.Super.applyOptions = frame.applyOptions;
	frame.applyOptions       = function( options )

--		nUI_ProfileStart( FrameProfileCounter, "applyOptions" );
		
		frame.Super.applyOptions( options );
		nUI_Unit:updateFeedbackFrame( frame );
		
		frame.highlight:SetFrameStrata( frame:GetFrameStrata() );
		frame.highlight:SetFrameLevel( frame:GetFrameLevel()+1 );
--		nUI_ProfileStop();
		
	end

	-- initiate the frame
	
	frame.unit_info = nUI_Unit:registerFeedbackCallback( frame.unit, frame );
	
	frame.applyOptions( options );
	
--	nUI_ProfileStop();
	
	return frame;
	
end

-------------------------------------------------------------------------------
-- remove a unit feedback frame

function nUI_Unit:deleteFeedbackFrame( frame )

--	nUI_ProfileStart( ProfileCounter, "deleteFeedbackFrame" );
	
	nUI_Unit:unregisterFeedbackCallback( frame.unit, frame );
	nUI_Unit:deleteFrame( frame );
	
--	nUI_ProfileStop();
	
end

-------------------------------------------------------------------------------
-- display the appropriate icon for the unit's feedback
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

local feedback;

function nUI_Unit:updateFeedbackFrame( frame )
	
--	nUI_ProfileStart( ProfileCounter, "updateFeedbackFrame" );
	
	unit_info = frame.unit_info;
	feedback  = unit_info and unit_info.feedback;
	
	-- if there is no unit or we don't know it's feedback, then hide the icon
	
	if not unit_info or not feedback then
		
		if frame.active then
			
			if frame.texture.active then frame.texture:SetAlpha( 0 ); end
			if frame.highlight.active then frame.highlight:SetAlpha( 0 ); end
			
			frame.active           = false;
			frame.texture.active   = false;
			frame.highlight.active = false;

			frame.texture.alpha = 0;
			frame.highlight.color   = nil;
			
			nUI:TableRemoveByValue( ActiveTextures, frame.texture );
			
		end
	
	-- otherwise, show the icon and clip the appropriate region
	
	else

		proc_time = GetTime();
		
		frame.active = true;			
		frame.texture.active = true;
		frame.highlight.active = true;
		
		if nUI_Options.show_hits and feedback.start_time and feedback.start_time <= proc_time then
		
			if frame.texture.r ~= feedback.hitColor.r
			or frame.texture.g ~= feedback.hitColor.g
			or frame.texture.b ~= feedback.hitColor.b
			then
				frame.texture.r = feedback.hitColor.r;
				frame.texture.g = feedback.hitColor.g;
				frame.texture.b = feedback.hitColor.b;
				frame.texture:SetVertexColor( feedback.hitColor.r, feedback.hitColor.g, feedback.hitColor.b, 1 );
			end
			
			if not frame.texture.start_time then
				frame.texture.start_time = feedback.start_time;
				frame.texture.end_time   = feedback.end_time;
				
				nUI:TableInsertByValue( ActiveTextures, frame.texture );
			else
				frame.texture.start_time = feedback.start_time;
				frame.texture.end_time   = feedback.end_time;				
			end
		end
		
		feedback_color = nil;
		
		if feedback.has_magic and nUI_Options.feedback_magic then
			feedback_color = nUI_UnitOptions.FeedbackColors["bgMagic"];
		elseif feedback.has_disease and nUI_Options.feedback_disease then
			feedback_color = nUI_UnitOptions.FeedbackColors["bgDisease"];
		elseif feedback.has_curse and nUI_Options.feedback_curse then
			feedback_color = nUI_UnitOptions.FeedbackColors["bgCurse"];
		elseif feedback.has_poison and nUI_Options.feedback_poison then
			feedback_color = nUI_UnitOptions.FeedbackColors["bgPoison"];
		elseif feedback.has_agro then
			feedback_color = nUI_UnitOptions.FeedbackColors["bgAgro"];
		end
		
		if frame.highlight.color ~= feedback_color then
			frame.highlight.color = feedback_color;
			
			if not feedback_color then
				frame.highlight:SetAlpha( 0 );
			else
				frame.highlight:SetBackdropBorderColor( feedback_color.r, feedback_color.g, feedback_color.b, 1 );
				frame.highlight:SetAlpha( 1 );
			end
		end
	end
	
--	nUI_ProfileStop();
	
end
