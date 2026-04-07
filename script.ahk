; ========== АВТООБНОВЛЕНИЕ ЧЕРЕЗ GITHUB ==========
; Для AutoHotkey 1.1.37.02

#NoEnv
#Persistent
SendMode Input

; ========== НАСТРОЙКИ ==========
CurrentVersion := "1.0.0"
RepoOwner := "zeatt"
RepoName := "ttt"
Branch := "main"

; Формируем ссылки
VersionURL := "https://raw.githubusercontent.com/" RepoOwner "/" RepoName "/" Branch "/version.txt"
ScriptURL := "https://raw.githubusercontent.com/" RepoOwner "/" RepoName "/" Branch "/script.ahk"

; ========== ФУНКЦИЯ ОБНОВЛЕНИЯ ==========
CheckForUpdates() {
    global CurrentVersion, VersionURL, ScriptURL
    
    tempFile := A_Temp "\github_version.txt"
    
    URLDownloadToFile, %VersionURL%, %tempFile%
    
    if ErrorLevel {
        return
    }
    
    if !FileExist(tempFile) {
        return
    }
    
    FileRead, githubVersion, %tempFile%
    FileDelete, %tempFile%
    
    githubVersion := Trim(githubVersion, " `t`n`r")
    
    if (githubVersion != CurrentVersion) {
        MsgBox, 4, Обновление, Доступна новая версия %githubVersion%!`nУ вас версия %CurrentVersion%.`n`nОбновить?
        IfMsgBox Yes
        {
            UpdateScript()
        }
    }
}

; ========== ФУНКЦИЯ ОБНОВЛЕНИЯ СКРИПТА ==========
UpdateScript() {
    global ScriptURL
    
    newScript := A_Temp "\new_script.ahk"
    
    URLDownloadToFile, %ScriptURL%, %newScript%
    
    if ErrorLevel {
        MsgBox, Не удалось скачать обновление.
        return
    }
    
    if !FileExist(newScript) {
        MsgBox, Ошибка: файл обновления не скачался.
        return
    }
    
    ; Создаём BAT-файл (другой способ записи)
    batFile := A_Temp "\update.bat"
    
    ; Удаляем старый BAT-файл, если есть
    FileDelete, %batFile%
    
    ; Записываем BAT-файл построчно
    FileAppend, @echo off`n, %batFile%
    FileAppend, timeout /t 2 /nobreak >nul`n, %batFile%
    FileAppend, copy /Y "%newScript%" "%A_ScriptFullPath%"`n, %batFile%
    FileAppend, if %%errorlevel%% equ 0 (`n, %batFile%
    FileAppend,     del "%newScript%"`n, %batFile%
    FileAppend,     start "" "%A_ScriptFullPath%"`n, %batFile%
    FileAppend, )`n, %batFile%
    FileAppend, del "%%~f0"`n, %batFile%
    
    ; Запускаем BAT-файл и закрываем скрипт
    Run, %batFile%,, Hide
    ExitApp
}

; ========== ЗАПУСК ПРОВЕРКИ ==========
CheckForUpdates()

; ========== ВАШ ОСНОВНОЙ КОД ==========
; ЗДЕСЬ ВСТАВЬТЕ ВАШИ ГОРЯЧИЕ СТРОКИ

::р1::https://disk.yandex.ru/d/KbSZjhPWvJaVYQ 165 тыс./чел., 2-х местный номер (санузел на 2 комнаты)
::р2::https://disk.yandex.ru/d/L_9WKglBQ0_bcA 179 тыс./чел., 2-х местный номер (свой санузел)
::р3::https://disk.yandex.ru/d/UUekdbfxQys0UQ 179 тыс./чел., 3-х местный номер (свой санузел)
::р4::https://disk.yandex.ru/d/Gc6c2yd3WZqhTQ 179 тыс./чел., 4-х местный номер (свой санузел)

::к1::https://disk.yandex.ru/d/gPQsRMKT2CPSNg 165 тыс./чел., 2-х местный номер (туалет в номере, душ общий)
::к2::https://disk.yandex.ru/d/C8bF6NlbDU5x5Q 165 тыс./чел., 2-х местный номер (туалет в номере, душ общий)
::к3::https://disk.yandex.ru/d/b_AyU8vH4YTFPw 169 тыс./чел., 2-х местный номер (санузел на 2 комнаты)
::к4::https://clck.ru/3RDNpV 179 тыс./чел., одноместный номер (санузел на 2 комнаты)
::к5::https://disk.yandex.ru/d/U2-iRYUjrPbD5Q 179 тыс./чел., 2-х местный номер (свой санузел за пределами номера)
::к6::https://disk.yandex.ru/d/ose-NoIbZq1m0Q 185 тыс./чел., одноместный номер (свой санузел за пределами номера)
::к7::https://clck.ru/3RK9WY 179 тыс./чел., 3-х местный номер (свой санузел за пределами номера)
::к8::https://clck.ru/3RNCbo 179 тыс./чел., 2-х местный номер (свой санузел)
::к9::https://clck.ru/3RKV8Q 179 тыс./чел., 2-х/3-х местный номер (свой санузел)

::о1::https://disk.yandex.ru/d/iLm8XE2BtdbCdA 179 тыс./чел., 2-х местный номер (свой санузел)
::о2::169 тыс./чел., 2-х местный номер (санузел на 2 комнаты) — ссылки нет

; ========== КОНЕЦ СКРИПТА ==========
