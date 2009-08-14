;title: ClipChain
;description: Clipboard utility for copying multiple strings into one long "chain"
;author: Dustin Luck
;version: 0.1
;homepage: http://lifehacker.com/5306452/clipchain-copies-multiple-text-strings-for-easy-pasting


#NoTrayIcon 
#SingleInstance force

;DEFINE COPY HOTKEY
CapsLock & c::
;clear the clipboard and send copy command
Clipboard =
Send ^c
;wait for clipboard data
ClipWait 1
if ErrorLevel
    return
;append the newly copied data to the ClipChain
;add the separator only if ClipChain has something in it
if (ClipChain <> "") {
    ClipChain = %ClipChain%%ClipSep%%Clipboard%
} else {
    ClipChain = %Clipboard%
}
return

;DEFINE PASTE HOTKEY
CapsLock & v::
;replace the clipboard contents with the stored ClipChain and send paste command
Clipboard := ClipChain
Send ^v
;clear ClipChain
ClipChain =
return

;DEFINE SEPARATOR HOTKEYS
CapsLock & -::
CapsLock & NumpadSub:: ClipSep := "-"
CapsLock & ,:: ClipSep := ","
CapsLock & |:: ClipSep := "|"
CapsLock & /:: ClipSep := "/"
CapsLock & Space:: ClipSep := A_Space
CapsLock & Tab:: ClipSep := A_Tab
CapsLock & Enter:: ClipSep := "`r`n"
;no separator
CapsLock & Esc:: ClipSep :=

;DEFINE CLEAR CONTENTS HOTKEY
CapsLock & BS:: ClipChain =