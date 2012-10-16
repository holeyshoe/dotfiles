-------------------------------------------------------------------------
-- This runs on pure voodoo as far as I can tell.

import XMonad

import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.ManageHelpers
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.InsertPosition

import XMonad.Util.Run(spawnPipe)
import XMonad.Util.EZConfig(additionalKeys)
import XMonad.Util.Scratchpad

import XMonad.Layout.PerWorkspace
import XMonad.Layout.MultiColumns
import XMonad.Layout.ResizableTile

import qualified XMonad.StackSet as W
import qualified Data.Map as M

import System.IO

-------------------------------------------------------------------------
-- Terminal & Other Commands--

myTerminal = "urxvt"

-------------------------------------------------------------------------
-- Workspaces --

myWorkspaces = ["1:web","2:chat","3:term","4:games","5:media", "6:misc"] ++ map show [7..9]

-------------------------------------------------------------------------
-- Mod Mask --

myModMask = mod4Mask

-------------------------------------------------------------------------
-- xmobar colours and border colours --

xmobarTitleColor 	    = "#01DF01"
xmobarCurrentWorkspaceColor = "#2E64FE"

myBorderWidth 	     = 1
myNormalBorderColor  = "#000000"
myFocusedBorderColor = "#800000"

-------------------------------------------------------------------------
-- Scratchpad

manageScratchPad :: ManageHook
manageScratchPad = scratchpadManageHookDefault

-------------------------------------------------------------------------
-- Find the property name of a program with xprop | grep WM_CLASS
-- then click on the client your interested in.
-- Manage Hook --
-- classNotRole doesnt work with skype, because it doesnt have WM_WINDOW_ROLE defined. Fuckers.

myManageHook = composeAll
	[ className =? "Gimp"			--> doFloat
	, className =? "feh"			--> doFloat
	, className =? "MPlayer"		--> doFloat
	, className =? "Vlc"			--> doFloat
	, className =? "Nm-connection-editor"	--> doFloat
	, className =? "Xmessage"		--> doFloat
	, className =? "Skype"			--> doShift	"2:chat"
	, className =? "Pidgin"			--> doShift	"2:chat"
	, classNotRole ("Pidgin", "buddy_list") --> doFloat
	, role =? ("ConversationsWindow")	--> doFloat
	, role =? ("CallWindow")		--> doFloat
	, insertPosition Above Newer
	]
	where
		role = stringProperty "WM_WINDOW_ROLE"

		classNotRole :: (String, String) -> Query Bool
		classNotRole (c,r) = className =? c <&&> role /=? r

------------------------------------------------------------------------
-- Layout Hook
--
myLayout = avoidStruts $ onWorkspace "1:web" webLayout
		       $ onWorkspace "2:chat" chatLayout
		       $ standardLayout
 where
	standardLayout = avoidStruts $ rTile ||| Mirror rTile ||| Full
	webLayout = avoidStruts $ Full ||| rTile  ||| Mirror rTile 
	chatLayout  = multiCol [2] 1 0.01 0.48 ||| rTile ||| Mirror rTile 

	rTile = ResizableTall nmaster delta ratio slaves
	tiled = Tall nmaster delta ratio

	nmaster = 1 	-- number of windows in master pane
	ratio = 1/2   	-- ratio of workspace used for master pane
	delta = 3/100 	-- size of increments for master pane
	slaves = [1]

------------------------------------------------------------------------
-- Key bindings --
myKeys :: XConfig Layout -> M.Map (KeyMask, KeySym) (X ())
myKeys (XConfig {modMask = mM}) = M.fromList $
	[ ((mM .|. shiftMask, xK_Escape), 	spawn "i3lock -i ~/backgrounds/i3lock/locked.png -c 000000 -n")
	, ((mM, xK_Print),			spawn "scrot -e 'mv $f ~/Dropbox/arch_stuff/screenshots'")
	, ((mM, xK_p),				spawn "dmenu_run")
	, ((mM, xK_s),				scratchpadSpawnActionTerminal myTerminal)

	-- Audio Keybinds: codes are in /usr/include/X11/XF86keysym.h

	, ((0, 0x1008FF11),			spawn "amixer -c 0 set Master 2dB-") -- XF86AudioLowerVolume
	, ((0, 0x1008FF13),			spawn "amixer -c 0 set Master 2dB+") -- XF86AudioRaiseVolume
	, ((0, 0x1008FF12),			spawn "amixer -c 0 set Master toggle") --XF86AudioMute
	, ((mM, xK_F1),			spawn "amixer set 'Rear Mic' 100% unmute && amixer set 'Rear Mic Boost' 2") --Unmute Mic
	, ((mM, xK_F2),			spawn "amixer set 'Rear Mic' 0% mute && amixer set 'Rear Mic Boost' 0") --Mute Mic
	, ((0, 0x1008FF14),			spawn "ncmpcpp toggle") --XF86AudioPlay
	, ((0, 0x1008FF15),			spawn "ncmpcpp stop") --XF86AudioStop
	, ((0, 0x1008FF16),			spawn "ncmpcpp prev") --XF86AudioPrev
	, ((0, 0x1008FF17),			spawn "ncmpcpp next") --XF86AudioNext

	-- Xmonad Keys

	, ((mM, xK_b),				sendMessage ToggleStruts)
	, ((mM, xK_q),				spawn "killall xmobar trayer && xmonad --restart")
	, ((mM, xK_a),				sendMessage MirrorShrink)
	, ((mM, xK_z),				sendMessage MirrorExpand)
	]


-------------------------------------------------------------------------
-- Main --

main = do
  xmobarPipe <- spawnPipe "/usr/bin/xmobar ~/.xmobar"
  trayerPipe <- spawnPipe "/usr/bin/trayer --edge top --align left --margin 1800 --width 120 --widthtype pixel --height 18 --heighttype pixel --padding 1 --alpha 0 --tint 0x000000 --transparent true"
  xmonad $ defaults {
	logHook = dynamicLogWithPP $ xmobarPP {
		  ppOutput = hPutStrLn xmobarPipe
		, ppTitle = xmobarColor xmobarTitleColor "" .shorten 100
		, ppCurrent = xmobarColor xmobarCurrentWorkspaceColor ""
		, ppSep = " | "
		}
	, manageHook = manageDocks <+> manageScratchPad <+> myManageHook <+> manageHook defaultConfig
	, handleEventHook = fullscreenEventHook
	, layoutHook = myLayout 
	}

--------------------------------------------------------------------------
-- Default settings --

defaults = defaultConfig {
	-- simple stuff
	  terminal		 = myTerminal
	, modMask			 = myModMask
	, workspaces		 = myWorkspaces
	, borderWidth 		 = myBorderWidth
	, normalBorderColor	 = myNormalBorderColor
	, focusedBorderColor = myFocusedBorderColor
	, keys			 = \c -> myKeys c `M.union` keys defaultConfig c 
	}
