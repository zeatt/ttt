; ==================================================
; АВТООБНОВЛЕНИЕ ЧЕРЕЗ GITHUB для AHK v2
; ==================================================

#Requires AutoHotkey v2.0
#SingleInstance Force
Persistent

; ========== НАСТРОЙКИ ==========
CurrentVersion := "1.0.0"
RepoOwner := "zeatt"
RepoName := "ttt"
Branch := "main"

; ========== ФУНКЦИЯ ПРОВЕРКИ ==========
CheckForUpdates() {
    global CurrentVersion, RepoOwner, RepoName, Branch

    VersionURL := "https://raw.githubusercontent.com/" RepoOwner "/" RepoName "/" Branch "/version.txt"
    TempFile := A_Temp "\github_version.txt"

    ; Скачиваем файл с версией
    try {
        Download(VersionURL, TempFile)
    } catch {
        return  ; Нет интернета
    }

    ; Читаем версию
    githubVersion := Trim(FileRead(TempFile), " `t`n`r")
    FileDelete(TempFile)

    ; Сравниваем
    if (githubVersion != CurrentVersion) {
        Result := MsgBox("Доступна новая версия " githubVersion "!`nУ вас версия " CurrentVersion "`n`nОбновить?", "Обновление", 4)
        if (Result = "Yes") {
            UpdateScript()
        }
    }
}

; ========== ОБНОВЛЕНИЕ ==========
UpdateScript() {
    global RepoOwner, RepoName, Branch

    ScriptURL := "https://raw.githubusercontent.com/" RepoOwner "/" RepoName "/" Branch "/script.ahk"
    NewScript := A_Temp "\new_script.ahk"

    ; Скачиваем новый скрипт
    try {
        Download(ScriptURL, NewScript)
    } catch {
        MsgBox("Не удалось скачать обновление", "Ошибка", 16)
        return
    }

    ; Создаём BAT-файл
    BatFile := A_Temp "\update.bat"
    BatContent := '
    @echo off
    timeout /t 2 /nobreak >nul
    copy /Y "' NewScript '" "' A_ScriptFullPath '"
    if %errorlevel% equ 0 (
        del "' NewScript '"
        start "" "' A_ScriptFullPath '"
    )
    del "%~f0"
    '

    FileDelete(BatFile)
    FileAppend(BatContent, BatFile)

    ; Запускаем обновление и закрываемся
    Run(BatFile, , "Hide")
    ExitApp()
}

; ========== ЗАПУСК ==========
CheckForUpdates()

; ========== ВАШ ОСНОВНОЙ КОД ==========
; ВСТАВЬТЕ СЮДА ВАШИ ГОРЯЧИЕ СТРОКИ

; Пример:
; ::р1::https://disk.yandex.ru/...

; ==================================================
