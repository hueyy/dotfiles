#Hotstring O SI

; emojis
#IfWinActive
:*::shrg::¯\_(ツ)_/¯
:*::check::✅
:*::thinking::🤔
:*::joy::😂
:*::like::👍
:*::dislike::👎
:*::ok::👌
#IfWinActive


; common substitutions 
; sleep as a workaround for vscode
; https://github.com/yzhang-gh/vscode-markdown/issues/200
SetTitleMatchMode, 2
#IfWinActive !WinActive(".md ahk_exe Code.exe alacritty.exe")
;::(c)::©
:*:(r)::{Sleep 50}®
::tm::™
:*::euro::{Sleep 50}€
:*::pound::£
:*:sss::§
::--::{Sleep 50}—
::-->::→
::->::→
::<—::←
::<-::←
::<->::↔
::<-->::↔
::==>::⇒
::<==::⇐
::<=>::⇔
:*::deg::°

; prose substitutions
; only in markdown files
; for compatibility with Markdown All in One extension in vscode: k500 T
SetTitleMatchMode, 2
#If WinActive(".md ahk_exe Code.exe") or  WinActive("ahk_exe WINWORD.EXE")
::!=::{Sleep 50}≠
::+-::{Sleep 50}±
::<=::{Sleep 50}≤
::>=::{Sleep 50}≥
::1/2::{Sleep 50}½
::1/3::{Sleep 50}⅓
::1/4::{Sleep 50}¼
::1/8::{Sleep 50}⅛
::2/3::{Sleep 50}⅔
::3/4::{Sleep 50}¾
::3/8::{Sleep 50}⅜
::5/8::{Sleep 50}⅝
::7/8::{Sleep 50}⅞
:::square::{Sleep 50}²
:*?:...::{Sleep 50}…
#IfWinActive

