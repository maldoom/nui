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
if not nUI_ChatFrameOptions then nUI_ChatFrameOptions = {}; end
if not nUI_Profile then nUI_Profile = {}; end;

local CreateFrame = CreateFrame;
local MouseIsOver = MouseIsOver;

nUI_Profile.nUI_ChatFrame = {};

local ProfileCounter = nUI_Profile.nUI_ChatFrame;

--FCF_SetButtonSide    = function() end;
--FCF_UpdateButtonSide = f5unction() end;		

local frame    = CreateFrame( "Frame", "nUI_ChatFrame", nUI_Dashboard.Anchor );
nUI.chat_frame = frame;

-- relocate the chat frame to the area we have set aside for it on the dashboard

local firstPass = true;
local initializing = true;

local function reparentChatFrame()

	local haveChatMod = (IsAddOnLoaded( "Prat" ) or IsAddOnLoaded( "Chatter" ) );
	
	if initializing
	or(not firstPass and haveChatMod)
	then return;
	end

	firstPass = false;
	
	FCF_SetLocked( DEFAULT_CHAT_FRAME, nil );

	DEFAULT_CHAT_FRAME:SetClampedToScreen( nil );
	DEFAULT_CHAT_FRAME:StartMoving();
	DEFAULT_CHAT_FRAME:StartSizing();
	DEFAULT_CHAT_FRAME:Hide();
	DEFAULT_CHAT_FRAME:ClearAllPoints();
	DEFAULT_CHAT_FRAME:SetParent( nUI.chat_frame );
	DEFAULT_CHAT_FRAME:SetPoint( "BOTTOMRIGHT", nUI.chat_frame, "BOTTOMRIGHT", -5, 6 );
	DEFAULT_CHAT_FRAME:SetPoint( "TOPLEFT", nUI.chat_frame, "TOPLEFT", 4, -5 );
	DEFAULT_CHAT_FRAME:StopMovingOrSizing();
	
	if not haveChatMod then
		
		-- set strata, etc, for all defined frames, make sure they're all docked

		local options   = frame.options or {};
		local btn_hSize = (options.btn_size or 45) * (frame.scale or 1) * nUI.hScale;
		local btn_vSize = (options.btn_size or 45) * (frame.scale or 1) * nUI.vScale;
		
		for i=1, NUM_CHAT_WINDOWS * 2 do
			
			local cframe = _G["ChatFrame"..i];

			-- process the frame if it exists
						
			if cframe then
							
				if i ~= 2 then -- we handle the combat log separately
					
					cframe.is_chat_frame = (i == 1);
					cframe.buttonSide = "RIGHT";

					if cframe.is_chat_frame or cframe.isDocked then
							
						local left = cframe:GetRight() or 0;
						local right = cframe:GetLeft() or cframe:GetWidth();
						local bottom = cframe:GetBottom() or 0;
						local top = cframe:GetTop() or cframe:GetHeight();
								
						cframe:SetMovable( true );
						cframe:SetResizable( true );
						cframe:SetClampedToScreen( false );
						cframe:SetUserPlaced( true );
						
						cframe:ClearAllPoints();
						cframe:SetPoint( "TOPLEFT", frame, "TOPLEFT", 5 * nUI.hScale, -5 * nUI.vScale );
						cframe:SetPoint( "BOTTOMRIGHT", frame, "BOTTOMRIGHT", -5 * nUI.hScale, 5 * nUI.vScale );
						
						FCF_SetLocked( cframe, 1 );
						FCF_SetWindowAlpha( cframe, 0 );

						-- size the frame
						
						if i == 1 then
							cframe:SetWidth( right - left );
							cframe:SetHeight( top - bottom );
						else
							cframe:SetWidth( ChatFrame1:GetWidth() );
							cframe:SetHeight( ChatFrame1:GetHeight() );
						end								
					end
					
					-- relocate the chat frame buttons
			
					local minimize     = _G["ChatFrame"..i.."ButtonFrameMinimizeButton"];
					local bottom       = _G["ChatFrame"..i.."ButtonFrameBottomButton"];
					local down         = _G["ChatFrame"..i.."ButtonFrameDownButton"];
					local up           = _G["ChatFrame"..i.."ButtonFrameUpButton"];
					local frame		   = _G["ChatFrame"..i.."ButtonFrame"];
					local add          = _G["ChatFrame"..i.."ConversationButton"];
					local height       = FriendsMicroButton and FriendsMicroButton:GetHeight()/2 or 0;
					local top          = add or up;
					
					bottom:ClearAllPoints();
					bottom:SetPoint( "BOTTOMRIGHT", _G["ChatFrame"..i.."ResizeButton"], "TOPRIGHT", 2, -8 * nUI.vScale );
					
					down:ClearAllPoints();
					down:SetPoint( "BOTTOM", bottom, "TOP", 0, (options.btn_gap or 0) * nUI.vScale );
					
					up:ClearAllPoints();				
					up:SetPoint( "BOTTOM", down, "TOP", 0, (options.btn_gap or 0) * nUI.vScale );
					
					if add then
						add:ClearAllPoints();
						add:SetPoint( "BOTTOM", up, "TOP", 0, (options.btn_gap or 0) * nUI.vScale );
					end
					
					frame:ClearAllPoints();
					frame:SetPoint( "TOPLEFT", top, "TOPLEFT", 0, height );
					frame:SetPoint( "BOTTOMRIGHT", bottom, "TOPRIGHT", 0, 0 );
					frame:EnableMouse( 0 );
					
					if minimize then
						minimize:Hide();
					end
					
					if cframe.is_chat_frame then
						ChatFrameMenuButton:SetAlpha( 0 );
					end
					
					if FriendsMicroButton then
						FriendsMicroButton:SetAlpha( 0 );
					end
					
					if FriendsMicroButton then
						FriendsMicroButton:SetScale( btn_hSize / FriendsMicroButton:GetWidth() );
					end			
					
					bottom:SetWidth( btn_hSize );
					bottom:SetHeight( btn_vSize );
					
					down:SetWidth( btn_hSize );
					down:SetHeight( btn_vSize );
					
					up:SetWidth( btn_hSize );
					up:SetHeight( btn_vSize );

					bottom:SetAlpha( 0 );			
					down:SetAlpha( 0 );			
					up:SetAlpha( 0 );
						
					if add then
						add:SetWidth( btn_hSize );
						add:SetHeight( btn_vSize );
						add:SetAlpha( 0 );
					end
					
					-- set method to show or hide the scroll buttons based on whether or
					-- not the mouse is in the frame
					
					cframe.showButtons = function( enabled )

						local showButtons = cframe:IsVisible() and enabled or false;
						
						if showButtons ~= cframe.buttons_visible then
													
							cframe.buttons_visible = showButtons;

							if i <= NUM_CHAT_WINDOWS then
								ChatFrameMenuButton:Show();
								ChatFrameMenuButton:SetAlpha( enabled and 1 or 0 );
							elseif add then
								ChatFrameMenuButton:Hide();
								add:SetAlpha( enabled and 1 or 0 );
							end
							
							if FriendsMicroButton then
								FriendsMicroButton:SetAlpha( enabled and 1 or 0 );
							end
							
							bottom:SetAlpha( enabled and 1 or 0 );
							down:SetAlpha( enabled and 1 or 0 );
							up:SetAlpha( enabled and 1 or 0 );
												
						end
					end
					
					-- allow scrolling of the combat log frame with the mouse wheel
					
					cframe:EnableMouseWheel( true );	
					
					cframe:SetScript( "OnMouseWheel", 
						function( who, arg1 )
							if arg1 > 0 then cframe:ScrollUp();
							else cframe:ScrollDown();
							end	
						end	
					);		
					
				end
				
				-- relocate the chat frame edit box in the same manner
				
				local chatFrame = _G["ChatFrame"..i];
				local editBox   = _G["ChatFrame"..i.."EditBox"];
				
				if editBox then
					
					_G["ChatFrame"..i.."EditBoxLeft"]:SetColorTexture( 0, 0, 0, 0 );
					_G["ChatFrame"..i.."EditBoxRight"]:SetColorTexture( 0, 0, 0, 0 );
					_G["ChatFrame"..i.."EditBoxMid"]:SetColorTexture( 0, 0, 0, 0 );
					
					--editBox:SetParent( "ChatFrame"..i );
					editBox:SetScale( 0.75 / UIParent:GetScale() );
					editBox:ClearAllPoints();
					
					if i ~= 2 then
						editBox:SetPoint( "TOPLEFT", "ChatFrame"..i, "TOPLEFT", -10, 8 );
						editBox:SetPoint( "TOPRIGHT", "ChatFrame"..i, "TOPRIGHT", -15, 8 );
					else 
						nUI.HideDefaultFrame( editBox );
					end
					
					editBox:SetFrameStrata( chatFrame and chatFrame:GetFrameStrata() or "DIALOG" );
					editBox:SetFrameLevel( chatFrame and (chatFrame:GetFrameLevel() or 0) + 4 );
					
					local backdrop = editBox:CreateTexture( editBox:GetName().."_nUI_Backdrop", "BACKGROUND" );
					
					backdrop:SetPoint( "TOPLEFT", editBox, "TOPLEFT", 8, -8 );
					backdrop:SetPoint( "BOTTOMRIGHT", editBox, "BOTTOMRIGHT", -8, 8 );
					backdrop:SetColorTexture( 0, 0, 0, 1 );
					
				end
			end
		end
						
		ChatFrameMenuButton:ClearAllPoints();
		ChatFrameMenuButton:SetScale( 0.8 );
		ChatFrameMenuButton:SetPoint( "BOTTOM", ChatFrame1ButtonFrameUpButton, "TOP", 0, -6 );
	end
	
	frame.applyScale();
			
end

-------------------------------------------------------------------------------
-- chat frame event management

local function onChatFrameEvent( who, event, arg1 )

--	nUI_ProfileStart( ProfileCounter, "onChatFrameEvent", event );
	
	if event == "ADDON_LOADED" then

		if arg1 == "nUI" then
			nUI:registerScalableFrame( frame );		
		end

	elseif event == "UPDATE_CHAT_WINDOWS"
	or     event == "BN_CHAT_CHANNEL_CREATE_SUCCEEDED" then

		reparentChatFrame();
			
	else

        frame:UnregisterEvent( "PLAYER_ENTERING_WORLD" );

		initializing = false;
		
		nUI_ChatFrame:configFrame();
        
		frame.texture = frame:CreateTexture();
		frame.texture:SetAllPoints( nUI.chat_frame );

		if not IsAddOnLoaded( "Prat" ) 
		and not IsAddOnLoaded( "Chatter" )
		then
		
			hooksecurefunc( "FloatingChatFrame_OnLoad", reparentChatFrame );
			hooksecurefunc( "FCF_OpenNewWindow", reparentChatFrame );
			hooksecurefunc( "ChatFrame_OnLoad", reparentChatFrame );
			hooksecurefunc( "ChatEdit_OnLoad", reparentChatFrame );

-- Legion Update TJK			
--			hooksecurefunc( "BNConversationButton_OnLoad", reparentChatFrame );
--			hooksecurefunc( "BNCreateConversation", reparentChatFrame );
--			hooksecurefunc( "BNConversationInviteDialog_OnLoad", reparentChatFrame );
--			hooksecurefunc( "BNConversationButton_UpdateAttachmentPoint", reparentChatFrame );
-- Legion Update TJK

			reparentChatFrame();
			
		else
		
			frame:SetScript( "OnUpdate", nil );
			
		end
					
	end
	
--	nUI_ProfileStop();
	
end

frame:SetScript( "OnEvent", onChatFrameEvent );
frame:RegisterEvent( "ADDON_LOADED" );
frame:RegisterEvent( "PLAYER_ENTERING_WORLD" );
frame:RegisterEvent( "UPDATE_CHAT_WINDOWS" );

-- Legion Update TJK
--frame:RegisterEvent( "BN_CHAT_CHANNEL_CREATE_SUCCEEDED" );
-- Legion Update TJK

nUI.ReparentChat = reparentChatFrame;

nUI.FrameExplorer = function( what, indent )

	print( (indent or "")..(what.GetName and what:GetName() or "unamed frame" ) );		
	
	local children = { what.GetChildren and what:GetChildren() };
	
	if what.GetChildren then
		-- 5.0.4 Start
		-- for _,child in ipairs( children ) do
		for emptyVar,child in ipairs( children ) do
		-- 5.0.4 End
			if type( child ) == "table"
			then
				nUI.FrameExplorer( child, (indent or "").."    " );
			end
		end
	end
end
	

-------------------------------------------------------------------------------

local mouseover_timer = 0;
local resetTabs = true;

local function onChatFrameUpdate( who, elapsed )

--	nUI_ProfileStart( ProfileCounter, "onChatFrameUpdate" );
	
	mouseover_timer = mouseover_timer + elapsed;
	
	if mouseover_timer > 0.2 then -- 5 fps is plenty fast enough to show these buttons
	
		mouseover_timer = 0;
	
		for i=1, NUM_CHAT_WINDOWS * 2 do

			local cframe = _G["ChatFrame"..i];
				
			if cframe and cframe.showButtons and i ~= 2 then -- skip combat log
				cframe.showButtons( MouseIsOver( cframe ) );
			end
		end
		
		if resetTabs and #DOCKED_CHAT_FRAMES then
			FCF_DockUpdate();
			resetTabs = false;
		end
	end
	
--	nUI_ProfileStop();
	
end

frame:SetScript( "OnUpdate", onChatFrameUpdate );

-------------------------------------------------------------------------------
-- adjust the size of the chat frame according the screen scale

frame.applyScale = function( scale )
	
--	nUI_ProfileStart( ProfileCounter, "applyScale" );
	
	local options   = frame.options;
	
	if options then
		
		local anchor    = scale and frame.anchor or nil;
		local scale     = scale or frame.scale or 1;
		local width     = options.width  * scale * nUI.hScale;
		local height    = options.height * scale * nUI.vScale;
		
		frame.scale = scale;
		
		if frame.width  ~= width 
		or frame.height ~= height
		then
			
			frame.width = width;
			frame.height = height;
			
			frame:SetWidth( width );
			frame:SetHeight( height );
			
		end
		
		if anchor then frame.applyAnchor( anchor ); end
		
	end
		
--	nUI_ProfileStop();
	
end

-------------------------------------------------------------------------------
-- anchor the chat frame

frame.applyAnchor = function( anchor )

--	nUI_ProfileStart( ProfileCounter, "applyAnchor" );
	
	if anchor or frame.anchor then
		
		local anchor     = anchor or frame.anchor or {};
		local xOfs       = anchor.xOfs * nUI.hScale;
		local yOfs       = anchor.yOfs * nUI.vScale;	
		frame.anchor     = anchor;
		
		if frame.anchor_pt   ~= anchor.anchor_pt
		or frame.relative_to ~= anchor.relative_to
		or frame.relative_pt ~= anchor.relative_pt
		or frame.xOfs        ~= xOfs
		or frame.yOfs        ~= yOfs
		then
			
			frame.anchor_pt = anchor.anchor_pt;
			frame.relative_to = anchor.relative_to;
			frame.relative_pt = anchor.relative_pt;
			frame.xOfs        = xOfs;
			frame.yOfs        = yOfs;
			
			frame:ClearAllPoints();
			frame:SetPoint( anchor.anchor_pt, anchor.relative_to, anchor.relative_pt, xOfs, yOfs );

			reparentChatFrame();
					
		end
	end
		
--	nUI_ProfileStop();
	
end

-------------------------------------------------------------------------------
-- apply a set of configuration options to the chat frame

frame.applyOptions = function( options )

--	nUI_ProfileStart( ProfileCounter, "applyOptions" );
	
	frame.options = options;
	
	frame:SetFrameStrata( options.strata or nUI_Dashboard.Anchor:GetFrameStrata() );
	frame:SetFrameLevel( options.level or nUI_Dashboard.Anchor:GetFrameLevel()+2 );

	for i=1, NUM_CHAT_WINDOWS do

		if i ~= 2 then
			
			local cframe = _G["ChatFrame"..i];
			
			cframe:SetFrameStrata( frame:GetFrameStrata() );
			cframe:SetFrameLevel( frame:GetFrameLevel()+1 );
			
		end		
	end
		
	if options.background then
		
		local backdrop_color = options.background.color.backdrop;
		local border_color   = options.background.color.border;
		
		frame:SetBackdrop( options.background.backdrop );
		frame:SetBackdropColor( backdrop_color.r, backdrop_color.g, backdrop_color.b, backdrop_color.a );
		frame:SetBackdropBorderColor( border_color.r, border_color.g, border_color.b, border_color.a );
		
	else
		
		frame:SetBackdrop( nil );
		
	end
	
	frame.applyScale( frame.scale or 1 );
	
--	nUI_ProfileStop();
	
end

-------------------------------------------------------------------------------

function nUI_ChatFrame:configFrame( use_default )
	
--	nUI_ProfileStart( ProfileCounter, "configFrame" );
	
	local default = nUI_DefaultConfig.ChatFrame;
	local config  = nUI_ChatFrameOptions or {};
	
	if not config.anchor then config.anchor = {}; end
	if not config.options then config.options = {}; end
	if not config.options.background then config.options.background = {}; end
	if not config.options.background.backdrop then config.options.background.backdrop = {}; end
	if not config.options.background.backdrop.insets then config.options.background.backdrop.insets = {}; end
	if not config.options.background.color then config.options.background.color = {}; end
	if not config.options.background.color.border then config.options.background.color.border = {}; end
	if not config.options.background.color.backdrop then config.options.background.color.backdrop = {}; end
	
	if use_default then
		
		config.anchor.anchor_pt   = default.anchor.anchor_pt;
		config.anchor.relative_to = default.anchor.relative_to;
		config.anchor.relative_pt = default.anchor.relative_pt;
		config.anchor.xOfs        = default.anchor.xOfs;
		config.anchor.yOfs        = default.anchor.yOfs;
		
		config.options.strata   = default.options.strata;
		config.options.level    = default.options.level;
		config.options.scale    = default.options.scale;
		config.options.height   = default.options.height;
		config.options.width    = default.options.width;
		config.options.fontsize = default.options.fontsize;
		config.options.btn_size = default.options.btn_size;
		config.options.btn_gap  = default.options.btn_gap;
		
		config.options.background.backdrop.bgFile   = default.options.background.backdrop.bgFile;
		config.options.background.backdrop.edgeFile = default.options.background.backdrop.edgeFile;
		config.options.background.backdrop.tile     = default.options.background.backdrop.tile;
		config.options.background.backdrop.tileSize = default.options.background.backdrop.tileSize;
		config.options.background.backdrop.edgeSize = default.options.background.backdrop.edgeSize;
		
		config.options.background.backdrop.insets.left   = default.options.background.backdrop.insets.left;
		config.options.background.backdrop.insets.right  = default.options.background.backdrop.insets.right;
		config.options.background.backdrop.insets.top    = default.options.background.backdrop.insets.top;
		config.options.background.backdrop.insets.bottom = default.options.background.backdrop.insets.bottom;
		
		config.options.background.color.border.r = default.options.background.color.border.r;
		config.options.background.color.border.g = default.options.background.color.border.g;
		config.options.background.color.border.b = default.options.background.color.border.b;
		config.options.background.color.border.a = default.options.background.color.border.a;
		
		config.options.background.color.backdrop.r = default.options.background.color.backdrop.r;
		config.options.background.color.backdrop.g = default.options.background.color.backdrop.g;
		config.options.background.color.backdrop.b = default.options.background.color.backdrop.b;
		config.options.background.color.backdrop.a = default.options.background.color.backdrop.a;
		
	else
		
		config.anchor.anchor_pt   = strupper( default.anchor.anchor_pt or config.anchor.anchor_pt );
		config.anchor.relative_to = default.anchor.relative_to or config.anchor.relative_to;
		config.anchor.relative_pt = strupper( default.anchor.relative_pt or config.anchor.relative_pt );
		config.anchor.xOfs        = tonumber( default.anchor.xOfs or config.anchor.xOfs );
		config.anchor.yOfs        = tonumber( default.anchor.yOfs or config.anchor.yOfs );
		
		config.options.strata   = strupper( default.options.strata or config.options.strata );
		config.options.level    = tonumber( default.options.level or config.options.level );
		config.options.scale    = tonumber( default.options.scale or config.options.scale );
		config.options.height   = tonumber( default.options.height or config.options.height );
		config.options.width    = tonumber( default.options.width or config.options.width );
		config.options.fontsize = tonumber( default.options.fontsize or config.options.fontsize );
		config.options.btn_size = tonumber( default.options.btn_size or config.options.btn_size );
		config.options.btn_gap  = tonumber( default.options.btn_gap or config.options.btn_gap );
		
		config.options.background.backdrop.bgFile   = default.options.background.backdrop.bgFile or config.options.background.backdrop.bgFile;
		config.options.background.backdrop.edgeFile = default.options.background.backdrop.edgeFile or config.options.background.backdrop.edgeFile;
		config.options.background.backdrop.tile     = default.options.background.backdrop.tile or config.options.background.backdrop.tile;
		config.options.background.backdrop.tileSize = tonumber( default.options.background.backdrop.tileSize or config.options.background.backdrop.tileSize );
		config.options.background.backdrop.edgeSize = tonumber( default.options.background.backdrop.edgeSize or config.options.background.backdrop.edgeSize );
		
		config.options.background.backdrop.insets.left   = tonumber( default.options.background.backdrop.insets.left or config.options.background.backdrop.insets.left );
		config.options.background.backdrop.insets.right  = tonumber( default.options.background.backdrop.insets.right or config.options.background.backdrop.insets.right );
		config.options.background.backdrop.insets.top    = tonumber( default.options.background.backdrop.insets.top or config.options.background.backdrop.insets.top );
		config.options.background.backdrop.insets.bottom = tonumber( default.options.background.backdrop.insets.bottom or config.options.background.backdrop.insets.bottom );
		
		config.options.background.color.border.r = tonumber( default.options.background.color.border.r or config.options.background.color.border.r );
		config.options.background.color.border.g = tonumber( default.options.background.color.border.g or config.options.background.color.border.g );
		config.options.background.color.border.b = tonumber( default.options.background.color.border.b or config.options.background.color.border.b );
		config.options.background.color.border.a = tonumber( default.options.background.color.border.a or config.options.background.color.border.a );
		
		config.options.background.color.backdrop.r = tonumber( default.options.background.color.backdrop.r or config.options.background.color.backdrop.r );
		config.options.background.color.backdrop.g = tonumber( default.options.background.color.backdrop.g or config.options.background.color.backdrop.g );
		config.options.background.color.backdrop.b = tonumber( default.options.background.color.backdrop.b or config.options.background.color.backdrop.b );
		config.options.background.color.backdrop.a = tonumber( default.options.background.color.backdrop.a or config.options.background.color.backdrop.a );
		
	end		

	nUI_ChatFrameOptions = config;
	
	frame.applyOptions( config.options );
	frame.applyAnchor( config.anchor );

--	nUI_ProfileStop();
	
end
