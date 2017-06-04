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

if not nUI_HUDLayouts then nUI_HUDLayouts = {}; end

-------------------------------------------------------------------------------
-- default configuration for the combat log info panel

nUI_HUDLayouts[nUI_HUDLAYOUT_NOHUD] =
{	
	enabled   = true,
	desc      = nUI_L[nUI_HUDLAYOUT_NOHUD],				-- player friendly name/description of the layout
	label     = nUI_L[nUI_HUDLAYOUT_NOHUD.."Label"],	-- label to use on the panel selection button face
	rotation  = nUI_HUDMODE_NOHUD,						-- index or position this panel appears on/in when clicking the selector button
	
	options  =
	{
		enabled     = true,
		scale       = 1,
		show_race   = false,
		show_threat = false,
		show_pet    = false,
		show_tot    = false,
		npc_bars    = false,
		hGap        = 400,
		vGap        = 400,
		
		alpha =
		{
			idle    = 0,
			regen   = 0.35,
			target  = 0.75,
			combat  = 1,
		},
	},
	elements =
	{
	},
};
