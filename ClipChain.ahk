;title: ClipChain
;description: Clipboard utility for copying multiple strings into one long "chain"
;author: Dustin Luck
;version: 2.0
;homepage: http://lifehacker.com/5306452/clipchain-copies-multiple-text-strings-for-easy-pasting

#NoTrayIcon 
#SingleInstance Force
#Warn
#Requires AutoHotkey v2.0+

ClearClipSep()
ClearClipChain()

;DEFINE COPY HOTKEY
CapsLock & c::
{
    global ClipChain
    global ClipSep

    ;clear the clipboard and send copy command
    A_Clipboard := ""
    Send "^c"
    ;wait for clipboard data
    if(!ClipWait(1))
    {
        return
    }
    ;append the newly copied data to the ClipChain
    ;add the separator only if ClipChain has something in it
    if (ClipChain != "") {
        ClipChain := ClipChain . ClipSep . A_Clipboard
    } else {
        ClipChain := A_Clipboard
    }
}

;DEFINE PASTE HOTKEY
CapsLock & v::
{
    global ClipChain
    global ClipSep

    if (ClipChain != "") {
        ;if ClipChain has some text, replace the clipboard contents with the stored ClipChain
        A_Clipboard := ClipChain
    } else {
        ;if ClipChain doesn't have any text, strip the formatting from the clipboard contents
        A_Clipboard := A_Clipboard
    }
    ;send the paste command
    Send "^v"
    ClearClipChain()
}

;DEFINE SEPARATOR HOTKEYS
CapsLock & -::
CapsLock & NumpadSub:: SetClipSep("-")
CapsLock & ,:: SetClipSep(",")
CapsLock & |:: SetClipSep("|")
CapsLock & /:: SetClipSep("/")
CapsLock & Space:: SetClipSep(A_Space)
CapsLock & Tab:: SetClipSep(A_Tab)
CapsLock & Enter:: SetClipSep("`r`n")
;no separator
CapsLock & Esc:: ClearClipSep()

;DEFINE CLEAR CONTENTS HOTKEY
CapsLock & BS:: ClearClipChain()

ClearClipChain()
{
    global ClipChain := ""
}

ClearClipSep()
{
    SetClipSep("")
}

SetClipSep(separator)
{
    global ClipSep := separator
}