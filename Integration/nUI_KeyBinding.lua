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
if not nUI_Profile then nUI_Profile = {}; end;

nUI_Profile.nUI_KeyBinding = {};

local ProfileCounter = nUI_Profile.nUI_KeyBinding;

local frame = CreateFrame( "Button", "nUI_KeyBindingFrame", nUI_Dashboard.anchor );	

local function onEvent()
	
--	nUI_ProfileStart( ProfileCounter, "onEvent", event );
	
	LoadAddOn( "Blizzard_BindingUI" );
	
	local button1 = CreateFrame( "Button", "$parent_Button1", frame, "KeyBindingFrameBindingButtonTemplate" );
	local button2 = CreateFrame( "Button", "$parent_Button2", frame, "KeyBindingFrameBindingButtonTemplate" );
	local okay    = CreateFrame( "Button", "$parent_OkayButton", frame, "UIPanelButtonTemplate" );
	local cancel  = CreateFrame( "Button", "$parent_CancelButton", frame, "UIPanelButtonTemplate" );
	local unbind  = CreateFrame( "Button", "$parent_UnbindButton", frame, "UIPanelButtonTemplate" );

	frame:SetWidth( 310 );
	frame:SetHeight( 120 );
	
	okay:SetText( OKAY );
	cancel:SetText( CANCEL );
	unbind:SetText( UNBIND );

	okay:SetWidth( 95 );
	cancel:SetWidth( 95 );
	unbind:SetWidth( 95 );
	
	okay:SetHeight( 25 );
	cancel:SetHeight( 25 );
	unbind:SetHeight( 25 );
	
	cancel:SetPoint( "BOTTOM", frame, "BOTTOM", 0, 10 );
	okay:SetPoint( "RIGHT", cancel, "LEFT", -2, 0 );
	unbind:SetPoint( "LEFT", cancel, "RIGHT", 2, 0 );
	
	frame.header  = frame:CreateFontString( nil, nil );
	frame.label1  = frame:CreateFontString( nil, nil );
	frame.label2  = frame:CreateFontString( nil, nil );
	
	frame.header:SetFont( nUI_L["font1"], 14, "OUTLINE" );
	frame.label1:SetFont( nUI_L["font1"], 10, "OUTLINE" );
	frame.label2:SetFont( nUI_L["font1"], 10, "OUTLINE" );
	
	frame.header:SetJustifyV( "MIDDLE" );
	frame.header:SetJustifyH( "CENTER" );
	frame.label1:SetJustifyV( "MIDDLE" );
	frame.label1:SetJustifyH( "LEFT" );
	frame.label2:SetJustifyV( "MIDDLE" );
	frame.label2:SetJustifyH( "LEFT" );
	
	frame.header:SetHeight( 22 );
	frame.label1:SetHeight( 22 );
	frame.label2:SetHeight( 22 );
	
	frame.header:SetPoint( "TOPLEFT", frame, "TOPLEFT", 5, -5 );
	frame.header:SetPoint( "TOPRIGHT", frame, "TOPRIGHT", -5, -5 );
	frame.label1:SetPoint( "TOPLEFT", frame.header, "BOTTOMLEFT", 5, -5 );
	frame.label2:SetPoint( "TOPLEFT", frame.label1, "BOTTOMLEFT", 0, -2 );
	
	frame.label1:SetTextColor( 1, 0.83, 0 );
	frame.label2:SetTextColor( 1, 0.83, 0 );
	
	frame.label1:SetText( "Key 1" );
	frame.label2:SetText( "Key 2" );
	
	frame:SetPoint( "CENTER", UIParent, "CENTER", 0, 0 );
	
	button1:SetID( 1 );
	button2:SetID( 2 );
	
	button1:SetWidth( 260 );
	button1:SetHeight( 22 );
	button2:SetWidth( 260 );
	button2:SetHeight( 22 );
	
	button1:SetPoint( "TOPRIGHT", frame.header, "BOTTOMRIGHT", -5, -5 );
	button2:SetPoint( "TOP", button1, "BOTTOM", 0, -2 );

	frame:SetBackdrop(
		{
			bgFile   = "Interface\\Tooltips\\UI-Tooltip-Background", 
			edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border", 
			tile     = true, 
			tileSize = 1, 
			edgeSize = 10, 
			insets   = { left = 0, right = 0, top = 0, bottom = 0 },
		}
	);
	
	frame:SetBackdropColor( 0, 0, 0, 0.75 );
	frame:RegisterForClicks( "AnyUp" );
	frame:EnableKeyboard( true );

	cancel:SetScript( "OnClick", function() frame:Hide(); end );

	frame.onKeyDown = function( self, keyOrButton )
	
--		nUI_ProfileStart( ProfileCounter, "onKeyDown" );
	
		if ( GetBindingByKey(keyOrButton) == "SCREENSHOT" ) then

			RunBinding("SCREENSHOT");
			
		else
		
			local button = nil;
			
			if button1.selected then button = button1;
			elseif button2.selected then button = button2;
			end
			
			if button then
				
				-- Convert the mouse button names
				
				if     keyOrButton == "LeftButton"   then keyOrButton = "BUTTON1";
				elseif keyOrButton == "RightButton"  then keyOrButton = "BUTTON2";
				elseif keyOrButton == "MiddleButton" then keyOrButton = "BUTTON3";
				elseif keyOrButton == "Button4"      then keyOrButton = "BUTTON4";
				elseif keyOrButton == "Button5"      then keyOrButton = "BUTTON5";
				end

				if  keyOrButton ~= "BUTTON1"
				and keyOrButton ~= "BUTTON2"
				and keyOrButton ~= "UNKNOWN"
				and keyOrButton ~= "LSHIFT"
				and keyOrButton ~= "RSHIFT"
				and keyOrButton ~= "LCTRL"
				and keyOrButton ~= "RCTRL"
				and keyOrButton ~= "LALT"
				and keyOrButton ~= "RALT"
				then
					
					if ( IsShiftKeyDown() ) then
						keyOrButton = "SHIFT-"..keyOrButton;
					end
					if ( IsControlKeyDown() ) then
						keyOrButton = "CTRL-"..keyOrButton;
					end
					if ( IsAltKeyDown() ) then
						keyOrButton = "ALT-"..keyOrButton;
					end
					
					button.key = keyOrButton;
					button.selected = false;
					button:SetText( GetBindingText( keyOrButton, "KEY_" ) );
					button:UnlockHighlight();
					button:SetAlpha( 1 );
					unbind:Disable();
					
					if button1.key 
					and button1.key == button2.key
					then
						button2.key = nil;
						button2:SetText( NORMAL_FONT_COLOR_CODE..NOT_BOUND..FONT_COLOR_CODE_CLOSE );
						button2:SetAlpha( 0.8 );
					end
				end
			end				
		end			

--		nUI_ProfileStop();					
					
	end
	
	frame.bindAction = function( button, label, action )
		
--		nUI_ProfileStart( ProfileCounter, "bindAction" );
	
		if not InCombatLockdown() then

			local btnName    = button:GetName();
			local bindAction = action
							   or (button.actionType and (button.actionType..(button.actionID or "")))
			                   or "CLICK "..btnName..":LeftButton";
			local key1, key2 = GetBindingKey( bindAction ); 
	
			frame:Show();
			frame.header:SetText( label or button:GetName() );
			
			button1:SetText( key1 and GetBindingText( key1, "KEY_" ) or (NORMAL_FONT_COLOR_CODE..NOT_BOUND..FONT_COLOR_CODE_CLOSE) );
			button2:SetText( key2 and GetBindingText( key2, "KEY_" ) or (NORMAL_FONT_COLOR_CODE..NOT_BOUND..FONT_COLOR_CODE_CLOSE) );
	
			button1:SetAlpha( key1 and 1 or 0.8 );
			button2:SetAlpha( key2 and 1 or 0.8 );
			
			button1.selected = false;
			button1.key      = key1;
			
			button2.selected = false;
			button2.key      = key2;
			
			unbind:Disable();
			
			button1:UnlockHighlight();
			button2:UnlockHighlight();
			
			okay:SetScript( "OnClick",
				function()

--					nUI_ProfileStart( ProfileCounter, "okay.OnClick" );
					
					-- unbind the old keys
					
					if button1.key ~= key1 then
						if key1 then SetBinding( key1 ); end
					end
					
					if button2.key ~= key2 then
						if key2 then SetBinding( key2 ); end
					end
					
					-- bind the new keys
					
					if button1.key ~= key1 then
						if button1.key then SetBinding( button1.key, bindAction ); end -- set the new binding
					end
					
					if button2.key ~= key2 then
						if button2.key then SetBinding( button2.key, bindAction ); end -- set the new binding
					end
					
					if button1.key ~= key1
					or button2.key ~= key2
					then SaveBindings( GetCurrentBindingSet() );
					end
						
					frame:Hide();
					
--					nUI_ProfileStop();					
					
				end
			);
		
			button1:SetScript( "OnClick",
				function( self, button )
					
--					nUI_ProfileStart( ProfileCounter, "button1.OnClick" );
					
					if  button ~= "LeftButton" 
					and button ~= "RightButton"
					then

						frame.onKeyDown( self, button );
						
					elseif button1.selected 
					then
						
						button1.selected = false;
						button1:UnlockHighlight();
						unbind:Disable();					

					else
						
						if button2.selected then
							button2:UnlockHighlight();
							button2.selected = false;
						end
						
						button1.selected = true;
						button1:LockHighlight();
						unbind:Enable();
						
						unbind:SetScript( "OnClick",
							function()
								button1.key = button2.key;
								button2.key = nil;
								button1.selected = false;
								button1:UnlockHighlight();
								button1:SetText( button1.key and GetBindingText( button1.key, "KEY_" ) or (NORMAL_FONT_COLOR_CODE..NOT_BOUND..FONT_COLOR_CODE_CLOSE) );
								button2:SetText( NORMAL_FONT_COLOR_CODE..NOT_BOUND..FONT_COLOR_CODE_CLOSE );
								button2:SetAlpha( 0.8 );
								unbind:Disable();
							end
						);
					end

--					nUI_ProfileStop();					
					
				end
			);
			
			button2:SetScript( "OnClick",
				function( self, button )
					
--					nUI_ProfileStart( ProfileCounter, "button2.OnClick" );
					
					if  button ~= "LeftButton" 
					and button ~= "RightButton"
					then

						frame.onKeyDown( self, button );
						
					elseif button2.selected 
					then
											
						button2.selected = false;
						button2:UnlockHighlight();
						unbind:Disable();					

					else
						
						if button1.selected then
							button1:UnlockHighlight();
							button1.selected = false;
						end
						
						button2.selected = true;
						button2:LockHighlight();
						unbind:Enable();
						
						unbind:SetScript( "OnClick",
							function()
								button2.key = nil;
								button2.selected = false;
								button2:UnlockHighlight();
								button2:SetText( NORMAL_FONT_COLOR_CODE..NOT_BOUND..FONT_COLOR_CODE_CLOSE );
								button2:SetAlpha( 0.8 );
								unbind:Disable();
							end
						);
					end

--					nUI_ProfileStop();					
					
				end
			);

		end

--		nUI_ProfileStop();					
		
	end
		
	frame:SetScript( "OnKeyDown", frame.onKeyDown );

--	nUI_ProfileStop();					
		
end

frame:SetScript( "OnEvent", onEvent );
frame:RegisterEvent( "PLAYER_LOGIN" );
frame:Hide();
