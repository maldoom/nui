--[[---------------------------------------------------------------------------

Copyright (c) 2008, 2009 by K. Scott Piel 
All Rights Reserved

E-mail: < kscottpiel@gmail.com >
Web:    < http://www.scottpiel.com >

This file is part of nUI.

	The copyright for all material provided within the nUI software package 
	("nUI") is held by Kenneth Scott Piel. Except as stated herein, none of 
	the material may be copied, reproduced, distributed, republished, 
	downloaded, displayed, posted or transmitted in any form or by any means, 
	including, but not limited to, electronic, mechanical, photocopying, 
	recording, or otherwise, without the prior written permission of 
	the copyright holder. Permission is granted to display, copy, distribute 
	and download the materials on this Site for personal, non-commercial use 
	only provided you do not modify the materials and that you retain all 
	copyright and other proprietary notices contained in the materials. You 
	also may not, without the copyright holder's permission, "mirror" any 
	material contained in nUI on any other server. This permission terminates 
	automatically if you breach any of these terms or conditions. Upon 
	termination, you will immediately destroy any downloaded and printed 
	materials. Any unauthorized use of any material contained in nUI may 
	violate copyright laws, trademark laws, the laws of privacy and publicity, 
	and communications regulations and statutes.
	
	nUI is packaged in four distributable versions known as "nUI Release",
	"nUI+", "nUI Development" and "nUI PTR Beta" -- Redistribution for these
	versions is governed by the following terms...
	
	1) Redistribution of the nUI Release (aka nUI Lite) version is permitted under 
	   the following terms... Permission is hereby	granted for unlimited free 
	   and open distribution of "nUI Release" / "nUI Lite" by anyone in any 
	   form and by any means provided the nUI Release distribution contents 
	   are not altered in any way, are distributed in full with all copyright 
	   statements and licensing terms included and intact and that any 
	   interface the end user is provided for the purpose of downloading nUI 
	   includes a plainly visible and functioning link to nUI's official web 
	   site at http://www.nUIaddon.com and a plainly visible notice that nUI 
	   accepts user donations with a working link to nUI's donation page at 
	   http://www.nUIaddon.com/donate.html
	   
	2) Permission is hereby granted for distribution of the "nUI+", "nUI+
	   Development" and "nUI+ PTR Beta" versions of nUI via the online download
	   service at http://www.wowinterface.com and the copyright holder's own
	   web site http://www.nuiaddon.com -- The end user is granted permission
	   to download any nUI package from these two web sites for their personal
	   use under the same terms and conditions as nUI Release but are prohibited
	   from sharing the contents of these packages via any means in any form
	   with anyone other than via direct transfer with immediate friends and
	   family members. Distribution of nUI+, nUI+ Development or nUI+ PTR Beta
	   via any other means by any other entity in any other form is strictly 
	   prohibited without the copyright holder's express written permission
	   explicitly granting such distribution rights specifically to that entity.
	   
	3) Deep-linking and leeching of nUI distributions is strictly prohibited. 
	   Any individual or entity who wishes to offer downloads of nUI 
	   distributions must either host the legal and unmodified distribution 
	   on their own servers to be distributed at their own expense using their 
	   own bandwidth or they must link the user back to the official download 
	   page on the third party provider's servers from which the user can 
	   initiate the download. Use of any download link or mechanism which 
	   initiates a download of any nUI distribution from a third party 
	   distribtion site that bypasses the official content and download pages 
	   or advertisements of that third party site is strictly prohibited
       without the express written consent of that site.
       
    See the included files "nUI_RELEASE_LICENSE.txt" and "nUI_PLUS_LICENSE.txt"
    for the complete terms of nUI's licensing terms.
	   
    nUI is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    enclosed license for more details.
	
THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS 
"AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT 
LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR 
A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT 
OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, 
SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT 
LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, 
DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY 
THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT 
(INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE 
USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

--]]---------------------------------------------------------------------------

if not nUI_Profile then nUI_Profile = {}; end;

local CreateFrame         = CreateFrame;

nUI_Profile.nUI_ExtraActionBar = {};

local ProfileCounter = nUI_Profile.nUI_ExtraActionBar;

-------------------------------------------------------------------------------
-- the extra action bar frame

-- Added to Create Extra Action Bar Frame Holder and Mover 5.0.5

local anchor     = CreateFrame( "Frame", "nUI_ExtraActionBarEvents", WorldFrame );
local frame      = CreateFrame( "Frame", "nUI_ExtraActionBar", nUI_Dashboard.Anchor, "SecureFrameTemplate" );

local f = ExtraActionBarFrame
f:SetParent(frame)
f:ClearAllPoints()
f:SetPoint("CENTER",nUI_MasterFrame,"CENTER",0,0)
f.ignoreFramePositionManager = true

local b = ExtraActionButton1
frame.button = b

local s = b.style
s:SetTexture(nil)

--nUI_Movers:lockFrame( frame, false, "nUI_ExtraBarMover" );

f:Show()
b:Show()

