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

if not nUI_Profile then nUI_Profile = {}; end;

nUI_Profile.nUI_DrDamage = {};

local ProfileCounter = nUI_Profile.nUI_DrDamage;
local ABtable        = nil;	-- Dr. Damage's Action Button Table

-------------------------------------------------------------------------------
-- save off a reference to Dr. Damage's local table "ABtable" so we can
-- manipulate it as our action bars change, then give Dr. Damage a method it
-- can call to create the table entries when it needs to. Otherwise, we'll
-- modify the table if and when action bars and buttons are added or removed
-- Note, nUI does not pass back a direct reference to nUI_BuildDrDamageTable
-- because that function will be replaced with a new function whenever the
-- bars or skin change. Passing back an indirect reference like this allows
-- Dr. Damage to alway call the current "right" method for the current bar
-- set rather than a stale method.

function nUI_DrDamageIntegration( table )
	
--	nUI_ProfileStart( ProfileCounter, "nUI_DrDamageIntegration" );
	
	local func = function() nUI_BuildDrDamageTable(); end;
	
	ABtable = table;
	
--	nUI_ProfileStop();
	
	return func;
	
end

-------------------------------------------------------------------------------
-- for now this method builds the ABtable list using nUI's default config
-- bar list. This method will need to be modified to support skin changing
-- and UI customization when that feature is enabled for users. This method
-- also serves as the means of building the button list of nUI's default skin.
-- If and when the user changes skins/layouts, this method will be replaced
-- with a new method applicable to the new bar layout

function nUI_BuildDrDamageTable()
	
--	nUI_ProfileStart( ProfileCounter, "nUI_BuildDrDamageTable" );
	
	local func = function( button ) return ActionButton_CalculateAction( button ); end;
	
	for bar_name in pairs( nUI_DefaultConfig.ButtonBars ) do
		
		local id     = 1;
		local config = nUI_DefaultConfig.ButtonBars[bar_name];
		
		for i=1,config.rows do
			for j=1,config.cols do
				ABtable[bar_name.."_Button"..id] = func;
				id = id+1;
			end
		end
	end	
	
--	nUI_ProfileStop();
	
end