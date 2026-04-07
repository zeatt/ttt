#Requires AutoHotkey v2.0
#SingleInstance Force
Persistent

; ==================================================
;              GITHUB AUTO-UPDATER
; ==================================================

CurrentVersion := "1.0.0"

GitHubVersionURL := "https://raw.githubusercontent.com/zeatt/ttt/refs/heads/main/version.txt"
GitHubScriptURL  := "https://raw.githubusercontent.com/zeatt/ttt/refs/heads/main/script.ahk"

CheckForUpdates()

; ==================================================
; ПРОВЕРКА ОБНОВЛЕНИЙ
; ==================================================
CheckForUpdates() {
    global CurrentVersion, GitHubVersionURL

    tempVersionFile := A_Temp "\ttt_version.txt"

    try Download(GitHubVersionURL, tempVersionFile)
    catch
        return   ; нет интернета = просто продолжаем

    if !FileExist(tempVersionFile)
        return

    newVersion := Trim(FileRead(tempVersionFile), " `t`n`r")
    FileDelete(tempVersionFile)

    if (newVersion = "")
        return

    if (newVersion != CurrentVersion) {
        result := MsgBox(
            "Доступно обновление!" "`n`n"
            "Текущая версия: " CurrentVersion "`n"
            "Новая версия: " newVersion "`n`n"
            "Установить сейчас?",
            "Обновление TTT",
            "YesNo Iconi"
        )

        if (result = "Yes")
            InstallUpdate()
    }
}

; ==================================================
; УСТАНОВКА ОБНОВЛЕНИЯ
; ==================================================
InstallUpdate() {
    global GitHubScriptURL

    tempNewScript := A_Temp "\ttt_new.ahk"
    tempBat       := A_Temp "\ttt_updater.bat"
    scriptPath    := A_ScriptFullPath
    ahkExe        := A_AhkPath

    ; скачиваем новую версию
    try Download(GitHubScriptURL, tempNewScript)
    catch {
        MsgBox("Не удалось скачать обновление.", "Ошибка", "Iconx")
        return
    }

    if !FileExist(tempNewScript) {
        MsgBox("Файл обновления не найден.", "Ошибка", "Iconx")
        return
    }

    ; BAT для безопасной замены после закрытия
    batText :=
    (
    '@echo off
    chcp 65001 >nul
    timeout /t 3 /nobreak >nul
    move /Y "' tempNewScript '" "' scriptPath '" >nul
    start "" "' ahkExe '" "' scriptPath '"
    del "%~f0"
    '
    )

    try {
        if FileExist(tempBat)
            FileDelete(tempBat)

        FileAppend(batText, tempBat, "UTF-8")
    } catch {
        MsgBox("Не удалось создать файл обновления.", "Ошибка", "Iconx")
        return
    }

    ; запускаем updater
    Run('cmd.exe /c "' tempBat '"', , "Hide")

    ; закрываем текущий скрипт
    ExitApp
}

; ==================================================
; ОСНОВНОЙ КОД
; ==================================================

::р1::https://disk.yandex.ru/d/KbSZjhPWvJaVYQ
::р2::https://disk.yandex.ru/d/L_9WKglBQ0_bcA
::р3::https://disk.yandex.ru/d/UUekdbfxQys0UQ
::р4::https://disk.yandex.ru/d/Gc6c2yd3WZqhTQ

::к1::https://disk.yandex.ru/d/gPQsRMKT2CPSNg
::к2::https://disk.yandex.ru/d/C8bF6NlbDU5x5Q
::к3::https://disk.yandex.ru/d/b_AyU8vH4YTFPw
