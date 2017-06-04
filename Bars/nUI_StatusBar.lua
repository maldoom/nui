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

if not nUI_Options then nUI_Options = {}; end
if not nUI_Bars then nUI_Bars = {}; end
if not nUI_Profile then nUI_Profile = {}; end;

local CreateFrame = CreateFrame;

nUI_Profile.nUI_StatusBar = {};

local ProfileCounter = nUI_Profile.nUI_StatusBar;
local BarFrames      = {};

local event_frame = CreateFrame( "Frame", "nUI_StatusBarEvents", WorldFrame );
local timer       = 1 / nUI_DEFAULT_FRAME_RATE;

nUI_Options.show_anim = true;

-------------------------------------------------------------------------------
-- variables used in methods within this module are declared here to eliminate
-- the use of dynamic memory and the garbage collector

local x1;
local x2;
local y1;
local y2;
local xOfs;
local yOfs;
local bar;			
local delta;
local anim;
local r,g,b,a;
local size;	
local deltaWidth;
local pct;
local bar_length;
local procTime;
local barFrame;

-------------------------------------------------------------------------------
-- bar event management

local function onBarEvent( who, event, arg1 )
	
--	nUI_ProfileStart( ProfileCounter, "onBarEvent", event );
	
	if event == "ADDON_LOADED" and arg1 == "nUI" then
		
		-- set up a slash command handler for dealing with setting the tooltip mode
		
		local option = nUI_SlashCommands[nUI_SLASHCMD_SHOWANIM];
		
		nUI_SlashCommands:setHandler( option.command, 
			
			function( msg )
				
				nUI_Options.show_anim = not nUI_Options.show_anim;
				
				DEFAULT_CHAT_FRAME:AddMessage( (option.message):format( nUI_Options.show_anim and nUI_L["|cFF00FF00ENABLED|r"] or nUI_L["|cFFFF0000DISABLED|r"] ), 1, 0.83, 0 );
				
			end
		);
		
	end
	
--	nUI_ProfileStop();
	
end

event_frame:SetScript( "OnEvent", onBarEvent );
event_frame:RegisterEvent( "ADDON_LOADED" );

-------------------------------------------------------------------------------
-- bar update management handles displaying changes in bar length and animation
-- 
-- this bar updater helps throttle hammering of the graphics engine by health
-- and mana updates, etc. particularly when in a large raid and battlegrounds
-- where you could potentially be slamming the GPU with changes in health
-- and mana for 30, 40 or more unit IDs across who knows how many bars. This
-- engine ensures a smooth bar update frequency regardless of how many times
-- the values may have changed in the interim. It also handles update optimizatio
-- by ensuring the bar actually changed before hitting the GPU as well as doing
-- the work required to animate bars that are so configured presuming the user
-- has not disabled animation.

local function onBarUpdate( who, elapsed )
	
--	nUI_ProfileStart( ProfileCounter, "onBarUpdate" );
	
	timer = timer - elapsed;
	
	if timer <= 0 then

		timer    = nUI_Unit.frame_rate;
		procTime = GetTime();

		for i=#BarFrames, 1, -1 do

			barFrame  = BarFrames[i];
			
			if barFrame.enabled and barFrame.active then
					
				x1     = barFrame.x1;
				x2     = barFrame.x2;
				y1     = barFrame.y1;
				y2     = barFrame.y2
				xOfs   = 0;
				yOfs   = 0;
				bar    = barFrame.bar;			
				delta   = barFrame.delta;
				anim   = barFrame.anim;
	
				if anim and nUI_Options.show_anim then
					
					local step = (anim.step + 1) % anim.num_steps;
					anim.step  = step;
					xOfs       = step * anim.xOfs;
					yOfs       = step * anim.yOfs;
					x1         = x1 + xOfs;
					x2         = x2 + xOfs;
					y1         = y1 + yOfs;
					y2         = y2 + yOfs;
					
				end
				
				if barFrame.hideTicks or not delta.length or delta.length == 0 then 
					if delta.alpha ~= 0 and delta.lastUpdate < procTime-5 then
						delta.alpha = 0;
						delta:SetAlpha( 0 );
					end
				else 

					delta.lastUpdate = procTime;
					
					if delta.alpha ~= 0.5 then
						delta.alpha = bar:GetAlpha() > 0 and 0.5 or 0;
						delta:SetAlpha( delta.alpha );
					end

					delta:SetTexCoord( delta.x1, delta.y1, delta.x1, delta.y2, delta.x2, delta.y1, delta.x2, delta.y2 );
					delta:ClearAllPoints();
										
					if barFrame.left then

						if barFrame.x2 == delta.x1 then delta:SetPoint( "LEFT", bar, "RIGHT", 0, 0 );
						else delta:SetPoint( "RIGHT", bar, "RIGHT", 0, 0 );
						end

						delta:SetWidth( barFrame.window * (delta.length / barFrame.view_size) );
						
					elseif barFrame.right then

						if barFrame.x1 == delta.x1 then delta:SetPoint( "LEFT", bar, "LEFT", 0, 0 );
						else delta:SetPoint( "RIGHT", bar, "LEFT", 0, 0 );
						end

						delta:SetWidth( barFrame.window * (delta.length / barFrame.view_size) );
						
					elseif barFrame.top then

						if barFrame.y2 == delta.y1 then delta:SetPoint( "TOP", bar, "BOTTOM", 0, 0 );
						else delta:SetPoint( "BOTTOM", bar, "BOTTOM", 0, 0 );
						end
						
						delta:SetHeight( barFrame.window * (delta.length / barFrame.view_size) );
						
					elseif barFrame.bottom then

						if barFrame.y1 == delta.y1 then delta:SetPoint( "TOP", bar, "TOP", 0, 0 );
						else delta:SetPoint( "BOTTOM", bar, "TOP", 0, 0 );
						end
						
						delta:SetHeight( barFrame.window * (delta.length / barFrame.view_size) );

					elseif barFrame.vCenter then

						delta:SetPoint( "CENTER", bar, "CENTER", 0, 0 );
						delta:SetHeight( barFrame.window * (delta.length / barFrame.view_size) );
						
					elseif barFrame.hCenter then

						delta:SetPoint( "CENTER", bar, "CENTER", 0, 0 );
						delta:SetWidth( barFrame.window * (delta.length / barFrame.view_size) );
						
					end
					
					delta.length = 0;
										
				end
				
				if bar.x1 ~= x1
				or bar.x2 ~= x2
				or bar.y1 ~= y1
				or bar.y2 ~= y2
				then
					
					bar.x1 = x1;
					bar.x2 = x2;
					bar.y1 = y1;
					bar.y2 = y2;

--					nUI:debug( ("nUI_StatusBar: "..frame:GetName().." -- start=%0.3f, window=%0.3f, pct=%0.3f, height=%0.1f"):format( frame.start, frame.window, frame.pct, frame.start + frame.window * frame.pct ) );

					if barFrame.horizontal then 
					
						bar:SetWidth(  barFrame.start + barFrame.window * barFrame.pct );
					
					elseif barFrame.vCenter then
					 
						bar:SetHeight( barFrame.window * barFrame.pct );
						
					elseif barFrame.hCenter then
					 
						bar:SetWidth( barFrame.window * barFrame.pct );
						
					else 
					
						bar:SetHeight(  barFrame.start + barFrame.window * barFrame.pct );
						
					end

--					nUI:debug( ("nUI_StatusBar: "..frame:GetName().." -- x1=%0.3f, x2=%0.3f, y1=%0.3f, y2=%0.3f"):format( x1, x2, y1, y2 ) );
				
					bar:SetTexCoord( x1, y1, x1, y2, x2, y1, x2, y2 );
					
				end
			end
		end	
	end
	
--	nUI_ProfileStop();
	
end

event_frame:SetScript( "OnUpdate", onBarUpdate );

-------------------------------------------------------------------------------
-- creates a new generic status bar frame tied directly to its parent frame
-- including taking its height and width from the parent frame (at all times)
-- the resulting status bar frame has no functionality other than to create
-- a bar frame and set the size of a colored bar within it.
--
-- Note: the status bar created will set a "OnSizeChanged" method for the 
--       parent frame. If you assign a method to OnSizeChanged for the parent
--       AFTER you cresate the status bar frame, then you should be sure to
--       call the status bar's onSizeChanged() method from inside your parent
--       frames OnSizeChanged event.
--
-- name:	  the name to give this bar's primary frame
-- parent:	  a reference to the parent frame this bar will be attached to
-- orient:    where is the origin of the colored bar? "TOP", "BOTTOM", "LEFT" or "RIGHT"
-- height:    the height of the bar texture (not of the rendered bar!)
-- width:     the width of the bar texture (not of the rendered bar!)
-- bar:       the underlying bar texture
-- min:		  given the origin edge of the bar, how far from the edge is the start of the bar or "min" value (0 <= value <= 1) where 0 is the origin and 1 is the opposite side
-- max:		  again, given the origin, how far across the texture is the end of the bar or "max" value
-- overlay:   the path to a BLP or TGA file to overlay the bar with (for style -- such as a frame around the bar)

function nUI_Bars:createStatusBar( name, parent, hideTicks )
	
--	nUI_ProfileStart( ProfileCounter, "createStatusBar" );
	
	local frame = CreateFrame( "Frame", name, parent );
	
	frame.parent             = parent;
	frame.active             = false;
	frame.horizontal         = true;
	frame.orient             = nil;
	frame.left               = true;
	frame.pct                = 0;
	frame.hideTicks          = hideTicks;
	frame.view_size          = 1;
	frame.min_offset         = 0;
	frame.max_offset         = 1;
	frame.view_size          = 1;
	frame.bar                = frame:CreateTexture( "$parentBar", "BORDER" );
	frame.delta              = frame:CreateTexture( "$parentDelta", "ARTWORK" );
	frame.delta.length       = 0;
	frame.delta.lastUpdate   = GetTime();
	frame.overlay            = frame:CreateTexture( "$parentOverlay", "OVERLAY" );
	frame.parent.sizeChanged = frame.parent:GetScript( "OnSizeChanged" );
	
	frame.bar:SetColorTexture( 1, 1, 1, 1 );
	frame.delta:SetColorTexture( 1, 1, 1, 1 );
	
	frame.bar:SetAlpha( 0 );
	frame.delta:SetAlpha( 0 );
	frame.bar:SetPoint( "LEFT", frame, "LEFT", 0, 0 );
	frame.delta:SetPoint( "LEFT", frame, "LEFT", 0, 0 );
	frame.overlay:SetAllPoints( frame );
	
	frame:SetScript( "OnSizeChanged", function() frame.onSizeChanged(); end );

	-- notify the bar it is no longer needed
	
	frame.deleteBar = function()
	
--		nUI_ProfileStart( ProfileCounter, "deleteBar" );	
		nUI:TableRemoveByValue( BarFrames, frame );
--		nUI_ProfileStop();
		
	end
	
	-- set bar animation on or off.. passing a nil value for anim will disabled animation (the default)
	-- otherwise, anim should be a table structure containing the following information...
	--
	-- anim =
	-- {
	--		int num_steps	-- how many steps are there in a complete cycle? The animation will update the animation a one step every frame cycle based on the user's frame rate, normally 30 steps per second.
	--		float xOfs		-- how far to step the animation texture horizontally in a single step as a percent of the texture width ( 0 < xOfs < 1), negative values move the animation right to left.
	--		float yOfs		-- how far to step the animation texture veritically in a single step
	-- }
	
	frame.setAnimation = function( anim )
	
--		nUI_ProfileStart( ProfileCounter, "setAnimation" );	
		
		frame.anim = anim;
		
		if anim then anim.step = 0; end;
		
--		nUI_ProfileStop();
		
	end
	
	-- update the sizing of the status bar texture if the frame size changes
	
	frame.onSizeChanged = function()
		
--		nUI_ProfileStart( ProfileCounter, "onSizeChanged" );	
		
		frame.height = frame:GetHeight();
		frame.width  = frame:GetWidth();
		
		if frame.horizontal or frame.hCenter then
			
			frame.start  = frame.width * frame.min_offset;
			frame.window = frame.width * frame.view_size;
			
			frame.bar:SetHeight( frame.height );
			frame.delta:SetHeight( frame.height );
			
			if not frame.hCenter then
				frame.bar:SetWidth(  frame.start + frame.window * frame.pct );
			else
				frame.bar:SetWidth( frame.window * frame.pct );
			end

		else
			
			frame.start  = frame.height * frame.min_offset;
			frame.window = frame.height * (frame.view_size or 1);
			
			frame.bar:SetWidth( frame.width );
			frame.delta:SetWidth( frame.width );
			frame.bar:SetHeight(  frame.start + frame.window * frame.pct );

			if not frame.vCenter then
				frame.bar:SetHeight(  frame.start + frame.window * frame.pct );
			else
				frame.bar:SetHeight( frame.window * frame.pct );
			end
		end
		
--		nUI_ProfileStop();
		
	end
	
	-- set the orientation of the bar relative to the parent frame... as in
	-- which direction the status bar will grow in. If the value of the orientation
	-- is "LEFT" then the status bar is anchored to the left edge of the parent 
	-- frame and will grow to the right, "BOTTOM" anchors to the bottom edge of
	-- the parent and will then grow upwards, etc.
	
	frame.setOrientation = function( orientation )
	
--		nUI_ProfileStart( ProfileCounter, "setOrientation" );	
		
		local orient = strupper( orientation );
		
		-- we're only going to update if we're actually changing the orientation
		
		if frame.orient ~= orient then
			
			-- make sure we have a sane value for the orientation
			
			frame.left           = orient == "LEFT"
			frame.right          = orient == "RIGHT"
			frame.bottom         = orient == "BOTTOM"
			frame.top            = orient == "TOP"
			frame.vCenter        = orient == "VCENTER"
			frame.hCenter        = orient == "HCENTER"
			
			if  not frame.left
			and not frame.right
			and not frame.top
			and not frame.bottom
			and not frame.vCenter
			and not frame.hCenter
			then 
				
				frame.left = true;
				orient     = "LEFT";
				
				DEFAULT_CHAT_FRAME:AddMessage( nUI_L["nUI: [%s] is not a valid option for orienting a status bar... use LEFT, RIGHT, TOP or BOTTOM"]:format( orient ), 1, 0.5, 0.5 );
				
			end

			-- remember what our current orientation is
			
			frame.orient = (orient ~= "VCENTER" and orient ~= "HCENTER") and orient or "CENTER";
			
			-- reset the anchor point for the status bar
			
			frame.bar:ClearAllPoints();				
			frame.bar:SetPoint( frame.orient, frame, frame.orient, 0, 0 );
			
			frame.delta:ClearAllPoints();				
			frame.delta:SetPoint( frame.orient, frame, frame.orient, 0, 0 );
			
			-- if the orientation is horizontal, then note it and set
			-- the height of the bar (which will not change again unless
			-- the parent is resized or we change orientation again)
			
			local reoriented = false;

			if frame.left
			or frame.right
			then

				if not frame.horizontal then
					
					reoriented       = true;
					frame.horizontal = true;
					frame.bar:SetHeight( frame:GetHeight() );
					frame.delta:SetHeight( frame:GetHeight() );					
					
				end
		
			-- otherwise we have a vertical orientation and set the width
			-- of the bar (which will, also, not change again unless the
			-- parent is resized or the orientation is changed again)
			
			else
				
				if frame.horizontal then
					
					reoriented       = true;
					frame.horizontal = false;
					frame.bar:SetWidth( frame:GetWidth() );
					frame.delta:SetWidth( frame:GetWidth() );
				
				end
				
			end
						
			-- if the bar has been reoriented, then update it since we
			-- need to set its length on a different axis
			
			if reoriented then			
				frame.updateBar();
			end
		end
		
--		nUI_ProfileStop();
		
	end;
		
	-- this method sets (or clears) the overlay graphic for the status bar... the
	-- overlay argument is a path to a BLP or TGA file, typically at least semi-transparent
	-- to give the statusbar a visual style or frame. Passing a nil overlay will hide the layer
	
	frame.setOverlay = function( overlay )

--		nUI_ProfileStart( ProfileCounter, "setOverlay" );	
		
		if frame.overlay_texture ~= overlay then
			
			frame.overlay_texture = overlay;
			
			if not overlay then
				
				frame.overlay:SetAlpha( 0 );
				
			else
				
				frame.overlay:SetAlpha( 1 );
				frame.overlay:SetTexture( overlay );
				frame.overlay:SetTexCoord( 0, 0, 0, 1, 1, 0, 1, 1 );
				
			end
		end
		
--		nUI_ProfileStop();
		
	end

	-- likewise, this method sets the actual bar texture
	--
	-- bar			-- string path to the texture file to use or nil to use a solid bar color
	-- min_offset	-- offset from the origin edge of the bar texture to the start of the bar itself... 0 is at the origin edge, 1 is at the opposite edge -- default is 0 is min is nil
	-- max_offset	-- offset from the origin edge of the bar texture to the end of the bar iself -- default is 1 if max is nil
	
	frame.setBar = function( bar, min_offset, max_offset )
			
--		nUI_ProfileStart( ProfileCounter, "setBar" );	
		
		if bar then 
		
			frame.bar:SetTexture( bar );
			frame.delta:SetTexture( bar );
			
		else 
		
			frame.bar:SetColorTexture( 1, 1, 1, 1 );
			frame.delta:SetColorTexture( 1, 1, 1, 0.5 );
			
		end

		frame.pct = 0;
		frame.bar:SetTexCoord( 0, 0, 0, 1, 1, 0, 1, 1 );
		frame.delta:SetTexCoord( 0, 0, 0, 1, 1, 0, 1, 1 );
		
		frame.bar:ClearAllPoints();
		frame.bar:SetPoint( frame.orient or "LEFT", frame, frame.orient or "LEFT", 0, 0 );
		
		frame.delta:ClearAllPoints();
		frame.delta:SetPoint( frame.orient or "LEFT", frame, frame.orient or "LEFT", 0, 0 );
		
		frame.min_offset = max( 0, min( 1, min_offset or 0 ) );
		frame.max_offset = max( 0, min( 1, max_offset or 1 ) );
		frame.view_size  = frame.max_offset - frame.min_offset;

		frame.onSizeChanged();
		
--		nUI_ProfileStop();
		
	end
	
	-- set the enabled state of the bar... when disabled, the bar is removed from the bar update
	-- loop to reduce frame drag/game engine load
	
	frame.setEnabled = function( enabled )
	
--		nUI_ProfileStart( ProfileCounter, "setEnabled" );	
		
		if frame.enabled ~= enabled then
			
			frame.enabled = enabled;
			
			if enabled and frame.active then nUI:TableInsertByValue( BarFrames, frame );
			elseif not enabled then nUI:TableRemoveByValue( BarFrames, frame );
			end
			
		end
		
--		nUI_ProfileStop();
		
	end
	
	-- returns the current color set for the bar
	
	frame.getBarColor = function()
		
--		nUI_ProfileStart( ProfileCounter, "getBarColor" );	
		
		r = frame.cur_r or 0;
		g = frame.cur_g or 0;
		b = frame.cur_b or 0;
		a = frame.cur_a or 0;
	
--		nUI_ProfileStop();
		
		return r, g, b, a;
		
	end

	-- set the length and, if required, the color of the status bar
	--
	-- note: this method expends extra energy in state management... as in knowing
	--       exactly what state it is currently in and only updating the frame text,
	--       content, colors, alphas, etc. when a change in state occurs. The extra
	--       effort is spent on state management in order to reduce impact to the
	--       graphis engine so as to preserve frame rate. It costs far less to check
	--		 a memory value than to burn through the graphics geometry. It does not
	--       matter how many times the unit changes GUID or how many times this 
	--       method will call, it will only alter the graphics elements when its
	--       relative state changes.

	frame.updateBar = function( percent, color )
	
--		nUI_ProfileStart( ProfileCounter, "updateBar" );	
		
		if frame.enabled then
					
			bar   = frame.bar;
			delta = frame.delta;
			size  = frame.view_size;	
			pct   = max( 0, min( 1, percent or 0) );
			r     = color and color.r or frame.r or 0;
			g     = color and color.g or frame.g or 0;
			b     = color and color.b or frame.b or 0;
			a     = color and color.a or frame.a or 1;

			-- if the bar is visible, check to see if we need to recolor it
			
			if frame.r ~= r
			or frame.g ~= g
			or frame.b ~= b
			or frame.a ~= a
			then

				frame.r = r;
				frame.g = g;
				frame.b = b;
				frame.a = a;
				
				bar:SetVertexColor( r, g, b, 1 );				
				bar:SetAlpha( frame.active and (pct > 0) and a or 0 );
				frame.active = frame.active and (pct > 0) or false;
				
				delta.alpha = 0;
				delta:SetAlpha( 0 );

			end
			
--			if frame:GetName() == "nUI_SoloUnit_Player_PowerBar" then
--				print( "Color = (" .. frame.r .. "," .. frame.g .. "," .. frame.b .. "," .. frame.a .. ")" );
--			end

			-- set the bar size if the pecentage of the bar  has changed
				
			if not percent or pct == 0 then
				
				frame.pct = 0;
				
				if frame.active then

					nUI:TableRemoveByValue( BarFrames, frame );
					
					frame.active = false;
					bar:SetAlpha( 0 );
				
					delta.alpha = 0;
					delta:SetAlpha( 0 );
		
				end				
	
			elseif frame.pct ~= pct
			then

				delta.length = (delta.length or 0) + (pct - frame.pct) * frame.view_size;
				frame.pct   = pct;			

				-- how much of the bar should we be revealing now?
				
				bar_length = size * pct;
				
				if frame.bar_length ~= bar_length 
				then
					
					frame.bar_length  = bar_length;
					
					if frame.left then 

						delta.x1 = frame.x2;	
						frame.x1 = frame.min_offset;
						frame.x2 = frame.x1 + bar_length;
						frame.y1 = 0;
						frame.y2 = 1;
						delta.x2 = frame.x2;
						delta.y1 = 0;
						delta.y2 = 1;
							
						if not delta.x1 then delta.x1 = delta.x2; end
						
						if delta.x2 < delta.x1 then
							delta.length = delta.x1;
							delta.x1     = delta.x2;
							delta.x2     = delta.length;
						end
						
						delta.length = delta.x2 - delta.x1;
						
					elseif frame.right then
	
						delta.x1 = frame.x1;
						frame.x2 = 1 - frame.min_offset;
						frame.x1 = frame.x2 - bar_length;
						frame.y1 = 0;
						frame.y2 = 1;
						delta.x2 = frame.x1;
						delta.y1 = 0;
						delta.y2 = 1;
							
						if not delta.x1 then delta.x1 = delta.x2; end
						
						if delta.x2 < delta.x1 then
							delta.length = delta.x1;
							delta.x1     = delta.x2;
							delta.x2     = delta.length;
						end
						
						delta.length = delta.x2 - delta.x1;
	
					elseif frame.top then

						delta.x1 = 0;
						delta.x2 = 1;
						delta.y1 = frame.y2;
						frame.x1 = 0;
						frame.x2 = 1;
						frame.y1 = frame.min_offset;
						frame.y2 = frame.y1 + bar_length;
						delta.y2 = frame.y2;
						
						if not delta.y1 then delta.y1 = delta.y2; end
						
						if delta.y2 < delta.y1 then
							delta.length = delta.y1;
							delta.y1     = delta.y2;
							delta.y2     = delta.length;
						end

						delta.length = delta.y2 - delta.y1;
						
					elseif frame.bottom then
	
						delta.x1 = 0;
						delta.x2 = 1;
						delta.y1 = frame.y1;
						frame.x1 = 0;
						frame.x2 = 1;
						frame.y2 = 1 - frame.min_offset;
						frame.y1 = frame.y2 - bar_length;
						delta.y2 = frame.y1;
						
						if not delta.y1 then delta.y1 = delta.y2; end
						
						if delta.y2 < delta.y1 then
							delta.length = delta.y1;
							delta.y1     = delta.y2;
							delta.y2     = delta.length;
						end

						delta.length = delta.y2 - delta.y1;

					elseif frame.hCenter then
					
						delta.x1 = frame.x1;
						delta.x2 = frame.x2;
						delta.y1 = 0;
						delta.y2 = 1;
						frame.x1 = (frame.min_offset + frame.max_offset - bar_length)/2;
						frame.x2 = frame.x1 + bar_length;
						frame.y1 = 0;
						frame.y2 = 1;

						if not delta.x2 then delta.x2 = frame.x2; end
						if not delta.x1 then delta.x1 = frame.x1; end

						delta.length = delta.x2 - delta.x1;
						if delta.length <= bar_length then delta.length = 0; end

					elseif frame.vCenter then
					
						delta.x1 = 0;
						delta.x2 = 1;
						delta.y1 = frame.y1;
						delta.y2 = frame.y2;
						frame.x1 = 0;
						frame.x2 = 1;
						frame.y1 = (frame.min_offset + frame.max_offset - bar_length)/2;
						frame.y2 = frame.y1 + bar_length;

						if not delta.y2 then delta.y2 = frame.y2; end
						if not delta.y1 then delta.y1 = frame.y1; end

						delta.length = delta.y2 - delta.y1;
						if delta.length <= bar_length then delta.length = 0; end

					end							
				end			
	
				if frame.x1 == frame.x2
				or frame.y1 == frame.y2
				then
					
					if frame.active then
						
						nUI:TableRemoveByValue( BarFrames, frame );

						frame.active = false;
						bar:SetAlpha( 0 );
						delta.length  = 0;
					end
					
				-- otherwise show the bar if it is not already visible
	
				elseif not frame.active 
				then
	
					nUI:TableInsertByValue( BarFrames, frame );
					bar:SetAlpha( frame.a );
					frame.active = true;
					delta.length  = 0;
				end
			end
		end
		
--		nUI_ProfileStop();
		
	end	

	frame.setOrientation( "LEFT" );
	frame.onSizeChanged();
	
--	nUI_ProfileStop();
	
	return frame;
	
end
