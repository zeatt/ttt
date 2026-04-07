#Requires AutoHotkey v2.0
#SingleInstance Force

; ============================================
;             CONFIG
; ============================================
APP_VERSION := "2.0.0"

VERSION_URL := "https://raw.githubusercontent.com/zeatt/ttt/main/version.txt"
SCRIPT_URL  := "https://raw.githubusercontent.com/zeatt/ttt/main/script.ahk"

CheckForUpdate()

; ============================================
;       MAIN HOTSTRINGS / YOUR CODE
; ============================================

::р1::https://disk.yandex.ru/d/KbSZjhPWvJaVYQ
::к1::https://disk.yandex.ru/d/gPQsRMKT2CPSNg


; ============================================
;            UPDATE CHECK
; ============================================
CheckForUpdate() {
    global APP_VERSION, VERSION_URL

    versionFile := A_Temp "\ttt_version.txt"

    try Download(VERSION_URL, versionFile)
    catch
        return

    onlineVersion := Trim(FileRead(versionFile))
    FileDelete(versionFile)

    if (onlineVersion = "")
        return

    if (onlineVersion != APP_VERSION) {
        result := MsgBox(
            "Доступно обновление " onlineVersion "`n" .
            "Установить?",
            "TTT Updater",
            "YesNo Iconi"
        )

        if (result = "Yes")
            LaunchUpdater()
    }
}

; ============================================
;         LAUNCH EXTERNAL UPDATER
; ============================================
LaunchUpdater() {
    global SCRIPT_URL

    updaterPath := A_Temp "\ttt_updater.ahk"

    updaterCode :=
    '
#Requires AutoHotkey v2.0
Sleep 1500

newFile := A_Temp "\ttt_new.ahk"
target  := "' A_ScriptFullPath '"
ahkExe  := "' A_AhkPath '"
url     := "' SCRIPT_URL '"

try Download(url, newFile)
catch ExitApp

if !FileExist(newFile)
    ExitApp

try {
    FileMove(newFile, target, 1)
} catch {
    ExitApp
}

Run "\"" ahkExe "\" \"" target "\""
FileDelete(A_ScriptFullPath)
ExitApp
'

    try {
        if FileExist(updaterPath)
            FileDelete(updaterPath)

        FileAppend(updaterCode, updaterPath, "UTF-8")
    } catch {
        MsgBox("Не удалось создать updater")
        return
    }

    Run('"' A_AhkPath '" "' updaterPath '"')
    ExitApp
}
