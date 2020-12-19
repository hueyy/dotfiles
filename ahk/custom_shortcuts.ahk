/*

HasSelectedText()
{
	ClipSaved := ClipboardAll
	clipboard := ""
	Send, ^c
	Sleep 100
	If(clipboard = A_Space or clipboard = A_Tab or clipboard = "")
	{
		clipboard := ClipSaved
		return false
	}
	Else
	{
		clipboard := ClipSaved
		return ClipboardAll
	}
}


; vscode markdown mode
SetTitleMatchMode, 2
#If WinActive(".md ahk_exe Code.exe")

^i::
	If(HasSelectedText() = false)
	{
		Send __
		Send {Left}
	}
	Else
	{
		Send _
	}
	return
	
^b::
	If(HasSelectedText() = false)
	{
		Send ****
		Send {Left 2}
	}
	Else
	{
		Send **
	}
	return

return

; end context sensitivity
#If

*/