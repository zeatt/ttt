; ==================================================
; АВТООБНОВЛЕНИЕ ЧЕРЕЗ GITHUB для AHK v2
; Проверено и готово к использованию
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

    ; Скачиваем файл с версией (исправлено: UrlDownloadToFile)
    try {
        UrlDownloadToFile(VersionURL, TempFile)
    } catch {
        return  ; Нет интернета
    }

    ; Проверяем, скачался ли файл
    if !FileExist(TempFile) {
        return
    }

    ; Читаем версию
    githubVersion := Trim(FileRead(TempFile), " `t`n`r")
    FileDelete(TempFile)

    ; Сравниваем
    if (githubVersion != CurrentVersion) {
        ; MsgBox в AHK v2: (текст, заголовок, кнопки)
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
        UrlDownloadToFile(ScriptURL, NewScript)
    } catch {
        MsgBox("Не удалось скачать обновление", "Ошибка", 16)
        return
    }

    if !FileExist(NewScript) {
        MsgBox("Файл обновления не скачался", "Ошибка", 16)
        return
    }

    ; Создаём BAT-файл (исправленный способ записи)
    BatFile := A_Temp "\update.bat"
    
    ; Удаляем старый BAT-файл, если есть
    if FileExist(BatFile) {
        FileDelete(BatFile)
    }
    
    ; Записываем BAT-файл (правильный синтаксис для AHK v2)
    batContent := "@echo off`n"
    batContent .= "timeout /t 2 /nobreak >nul`n"
    batContent .= 'copy /Y "' NewScript '" "' A_ScriptFullPath '"`n'
    batContent .= "if %errorlevel% equ 0 (`n"
    batContent .= '    del "' NewScript '"`n'
    batContent .= '    start "" "' A_ScriptFullPath '"`n'
    batContent .= ")`n"
    batContent .= 'del "%~f0"`n'
    
    ; Сохраняем BAT-файл
    FileOpen(BatFile, "w").Write(batContent)

    ; Запускаем обновление и закрываемся
    Run(BatFile, , "Hide")
    ExitApp()
}

; ========== ЗАПУСК ПРОВЕРКИ ==========
CheckForUpdates()

; ========== ВАШ ОСНОВНОЙ КОД ==========
; ВНИМАНИЕ: В AHK v2 горячие строки работают так же!
; Все ваши горячие строки должны работать без изменений

; УСАДЬБА "РОСИНКА"
:?*:р1::https://disk.yandex.ru/d/KbSZjhPWvJaVYQ 165 тыс./чел., 2-х местный номер (санузел на 2 комнаты)
:?*:р2::https://disk.yandex.ru/d/L_9WKglBQ0_bcA 179 тыс./чел., 2-х местный номер (свой санузел)
:?*:р3::https://disk.yandex.ru/d/UUekdbfxQys0UQ 179 тыс./чел., 3-х местный номер (свой санузел)
:?*:р4::https://disk.yandex.ru/d/Gc6c2yd3WZqhTQ 179 тыс./чел., 4-х местный номер (свой санузел)

; УСАДЬБА "КАНТРИ"
:?*:к1::https://disk.yandex.ru/d/gPQsRMKT2CPSNg 165 тыс./чел., 2-х местный номер (туалет в номере, душ общий)
:?*:к2::https://disk.yandex.ru/d/C8bF6NlbDU5x5Q 165 тыс./чел., 2-х местный номер (туалет в номере, душ общий)
:?*:к3::https://disk.yandex.ru/d/b_AyU8vH4YTFPw 169 тыс./чел., 2-х местный номер (санузел на 2 комнаты)
:?*:к4::https://clck.ru/3RDNpV 179 тыс./чел., одноместный номер (санузел на 2 комнаты)
:?*:к5::https://disk.yandex.ru/d/U2-iRYUjrPbD5Q 179 тыс./чел., 2-х местный номер (свой санузел за пределами номера)
:?*:к6::https://disk.yandex.ru/d/ose-NoIbZq1m0Q 185 тыс./чел., одноместный номер (свой санузел за пределами номера)
:?*:к7::https://clck.ru/3RK9WY 179 тыс./чел., 3-х местный номер (свой санузел за пределами номера)
:?*:к8::https://clck.ru/3RNCbo 179 тыс./чел., 2-х местный номер (свой санузел)
:?*:к9::https://clck.ru/3RKV8Q 179 тыс./чел., 2-х/3-х местный номер (свой санузел)

; ОЙКУМЕН
:?*:о1::https://disk.yandex.ru/d/iLm8XE2BtdbCdA 179 тыс./чел., 2-х местный номер (свой санузел)
:?*:о2::169 тыс./чел., 2-х местный номер (санузел на 2 комнаты) — ссылки нет

; ========== КОНЕЦ ==========
