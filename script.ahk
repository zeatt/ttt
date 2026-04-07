; ========== ДИРЕКТИВЫ ==========
#NoEnv
SendMode Input
#Persistent

; ========== АВТООБНОВЛЕНИЕ ==========
CurrentVersion := "1.0.4"

; GitHub RAW ссылки
VersionURL := "https://raw.githubusercontent.com/zeatt/ttt/main/version.txt"
ScriptURL  := "https://raw.githubusercontent.com/zeatt/ttt/main/script.ahk"

; ФУНКЦИЯ ПРОВЕРКИ ОБНОВЛЕНИЙ
CheckForUpdates() {
    global CurrentVersion, VersionURL, ScriptURL
    TempFile := A_Temp "\version_check.txt"
    
    URLDownloadToFile, %VersionURL%, %TempFile%
    
    if ErrorLevel {
        MsgBox, Ошибка скачивания! ErrorLevel = %ErrorLevel%
        return
    }
    
    ; Читаем файл
    FileRead, LatestVersionRaw, %TempFile%
    
    ; Показываем, что скачали (для отладки)
    MsgBox, Скачано из version.txt: [%LatestVersionRaw%]`nДлина: %StrLen(LatestVersionRaw)%
    
    ; Очищаем от всех невидимых символов
    LatestVersion := RegExReplace(LatestVersionRaw, "\s+")
    CurrentVersionClean := RegExReplace(CurrentVersion, "\s+")
    
    ; Показываем очищенные версии
    MsgBox, Очищенная версия с GitHub: [%LatestVersion%]`nОчищенная ваша версия: [%CurrentVersionClean%]`nРавны? % (LatestVersion = CurrentVersionClean ? "ДА" : "НЕТ")
    
    FileDelete, %TempFile%
    
    if (LatestVersion != CurrentVersionClean) {
        MsgBox, 36, Доступно обновление!, Версия %LatestVersion% уже доступна.`nУ вас версия %CurrentVersion%.`n`nОбновить скрипт сейчас?
        IfMsgBox, Yes
        {
            NewScript := A_Temp "\script_new.ahk"
            URLDownloadToFile, %ScriptURL%, %NewScript%
            
            if ErrorLevel {
                MsgBox, Не удалось скачать обновление.
                return
            }
            
            DetectHiddenWindows, On
            WinClose, %A_ScriptFullPath% ahk_class AutoHotkey
            
            FileCopy, %NewScript%, %A_ScriptFullPath%, 1
            
            if ErrorLevel {
                MsgBox, Не удалось обновить файл.
                return
            }
            
            MsgBox, Обновление успешно установлено!
            Reload
        }
    } else {
        MsgBox, Версии совпадают. Обновление не требуется.
    }
}

CheckForUpdates()

; ========== ДАЛЬШЕ ВЕСЬ ОСНОВНОЙ КОД ==========

; ========== УСАДЬБА "РОСИНКА" ==========
::р1::https://disk.yandex.ru/d/KbSZjhPWvJaVYQ 165515151 тыс./чел., 2-х местный номер (санузел на 2 комнаты)
::р2::https://disk.yandex.ru/d/L_9WKglBQ0_bcA 179 тыс./чел., 2-х местный номер (свой санузел)
::р3::https://disk.yandex.ru/d/UUekdbfxQys0UQ 179 тыс./чел., 3-х местный номер (свой санузел)
::р4::https://disk.yandex.ru/d/Gc6c2yd3WZqhTQ 179 тыс./чел., 4-х местный номер (свой санузел)

; ========== УСАДЬБА "КАНТРИ" ==========
::к1::https://disk.yandex.ru/d/gPQsRMKT2CPSNg 165 тыс./чел., 2-х местный номер (туалет в номере, душ общий)
::к2::https://disk.yandex.ru/d/C8bF6NlbDU5x5Q 165 тыс./чел., 2-х местный номер (туалет в номере, душ общий)
::к3::https://disk.yandex.ru/d/b_AyU8vH4YTFPw 169 тыс./чел., 2-х местный номер (санузел на 2 комнаты)
::к4::https://clck.ru/3RDNpV 179 тыс./чел., одноместный номер (санузел на 2 комнаты)
::к5::https://disk.yandex.ru/d/U2-iRYUjrPbD5Q 179 тыс./чел., 2-х местный номер (свой санузел за пределами номера)
::к6::https://disk.yandex.ru/d/ose-NoIbZq1m0Q 185 тыс./чел., одноместный номер (свой санузел за пределами номера)
::к7::https://clck.ru/3RK9WY 179 тыс./чел., 3-х местный номер (свой санузел за пределами номера)
::к8::https://clck.ru/3RNCbo 179 тыс./чел., 2-х местный номер (свой санузел)
::к9::https://clck.ru/3RKV8Q 179 тыс./чел., 2-х/3-х местный номер (свой санузел)

; ========== ОЙКУМЕН ==========
::о1::https://disk.yandex.ru/d/iLm8XE2BtdbCdA 179 тыс./чел., 2-х местный номер (свой санузел)
::о2::169 тыс./чел., 2-х местный номер (санузел на 2 комнаты) — ссылки нет
