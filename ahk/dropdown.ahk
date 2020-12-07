;; Huey Lee
;; 7th December 2020
;; adapted from:
;; Jon Dolan ;;
;; V1.0 - March 5th, 2017 ;;

;; Windows emulator for Yakuake/Guake written in AHK (https://autohotkey.com) ;;
;; Provies drop down capabilities to whatever Windows terminal program you please ;;

;; By default, this script uses Bitvise xterm with the hotkey F12 ;;
;; But it is configurable by changing the global variables below ;;

;; To compile this script after changing it to your liking: ;;
;; https://autohotkey.com/docs/Scripts.htm#ahk2exe	;;
;; Best to just download/install autohotkey and right click on the .ahk file and select "compile" ;) ;;



;;;;;;;;; GLOBAL AHK SETTINGS (DO NOT MODIFY) ;;;;;;;;;
#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.



;;;;;;;;; GLOBAL VARIABLES (CHANGE THESE!) ;;;;;;;;;
; title of the terminal window
; note - this script will do nothing if there is no matching window
; choose a uniquely identifiable substring of your terminal program's title
win_title = Alacritty

; hotkey to open/hide/unhide
; choose from https://autohotkey.com/docs/KeyList.htm
hotkey = ^``
fullscreen_hotkey = F11

; window resizing options
win_width_percent  = 100 ; set to 0 to disable
win_height_percent = 50 ; set to 0 to disable
win_visible_transparency = 200	; the transparency of the terminal window when it is visible 0 (transparent) through 255 (opaque)



;;;;;;;;; SCRIPT (DO NOT MODIFY) ;;;;;;;;;
SetTitleMatchMode, RegEx
Hotkey, %hotkey%, TheHotKey	; initialize the hotkey specified above
Hotkey, %fullscreen_hotkey%, FullscreenHotKey

win_topleft_x := A_ScreenWidth * ((100 - win_width_percent)/2)/100 ; calculate the top left (x,y)
win_topleft_y := 25

win_height := A_ScreenHeight * (win_height_percent/100) ; calculate the window width, height
win_width := A_ScreenWidth * (win_width_percent/100)

currentWindow := 0
previousWindow := 0 ; so we can restore focus to previous window

loop {	; loop infinitely
	WinGet, currentWindow, ID, A	; get the current active window
	
	WinWaitNotActive, ahk_id %currentWindow% 	; wait until that window is not active anymore
	
	IfWinNotActive, %win_title%			; if our terminal window is no longer active (it was and then it was clicked out), make sure it's hidden
		WinSet, Transparent, On, %win_title%
	
	previousWindow := currentWindow	; so we can keep track of previous window
}

TheHotKey: ; setup our hotkey
	IfWinExist, %win_title% ; ensure our window even exists
	{
		WinMove, %win_title%,, %win_topleft_x%, %win_topleft_y%, %win_width%, %win_height%	; make sure it's in the correct location and has correct size
		IfWinNotActive, %win_title%	; if the window is not active and our hotkey was fired, let's show it
		{
			WinSet, Transparent, %win_visible_transparency%, %win_title%
			WinActivate, %win_title%
		}
		Else	; if the window is active and our hotkey was fired, let's hide it and active the previous window
		{
			WinSet, Transparent, On, %win_title%
			WinActivate, ahk_id %previousWindow%
		}
	}
	return
	
FullscreenHotKey:
	IfWinExist, %win_title%
	{
		IfWinActive, %win_title%
		{
			WinGetPos, , , , terminal_height, %win_title%
			if(terminal_height = win_height)
			{
				WinMove, %win_title%,,%win_topleft_x%, %win_topleft_y%, %win_width%, %A_ScreenHeight%
			}
			Else {
				WinMove, %win_title%,,%win_topleft_x%, %win_topleft_y%, %win_width%, %win_height%
			}
		}
	}
	return
