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


; common substitutions 
#IfWinActive
;::(c)::©
::(r)::®
::tm::™
:::degree::°
:::euro::€
:::pound::£
:*:sss::§
::--::–
::---::—
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
::!=::≠
::+-::±
::<=::≤
::>=::≥
::1/2::½
::1/3::⅓
::1/4::¼
::1/8::⅛
::2/3::⅔
::3/4::¾
::3/8::⅜
::5/8::⅝
::7/8::⅞
:::square::²
:*?:...::…
