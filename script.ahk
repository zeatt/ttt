; ========== АВТООБНОВЛЕНИЕ ЧЕРЕЗ GITHUB ==========
; Простая и надёжная версия

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
    
    ; Создаём временный файл
    tempFile := A_Temp "\github_version.txt"
    
    ; Скачиваем файл с версией
    try {
        URLDownloadToFile, %VersionURL%, %tempFile%
    } catch {
        return  ; Нет интернета - выходим
    }
    
    ; Проверяем, скачался ли файл
    if !FileExist(tempFile) {
        return
    }
    
    ; Читаем версию с GitHub
    FileRead, githubVersion, %tempFile%
    FileDelete, %tempFile%
    
    ; Удаляем лишние пробелы и переносы строк
    githubVersion := Trim(githubVersion, " `t`n`r")
    
    ; Сравниваем версии
    if (githubVersion != CurrentVersion) {
        ; Спрашиваем пользователя
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
    
    ; Скачиваем новый скрипт
    newScript := A_Temp "\new_script.ahk"
    try {
        URLDownloadToFile, %ScriptURL%, %newScript%
    } catch {
        MsgBox, Не удалось скачать обновление.
        return
    }
    
    if !FileExist(newScript) {
        MsgBox, Ошибка: файл обновления не скачался.
        return
    }
    
    ; Создаём BAT-файл для обновления
    batFile := A_Temp "\update.bat"
    FileDelete, %batFile%
    
    ; Содержимое BAT-файла
    batContent =
(
@echo off
timeout /t 2 /nobreak >nul
copy /Y "%newScript%" "%A_ScriptFullPath%"
if %errorlevel% equ 0 (
    del "%newScript%"
    start "" "%A_ScriptFullPath%"
)
del "%~f0"
)
    
    ; Записываем BAT-файл
    FileAppend, %batContent%, %batFile%
    
    ; Запускаем BAT-файл и закрываем текущий скрипт
    Run, %batFile%,, Hide
    ExitApp
}

; ========== ЗАПУСК ПРОВЕРКИ ==========
; Проверяем обновления при старте
CheckForUpdates()

; ========== ВАШ ОСНОВНОЙ КОД ==========
; Всё, что было раньше - горячие строки, и т.д.

; Пример горячих строк (ваши данные)
::test::Тестовое сообщение

; ========== КОНЕЦ СКРИПТА ==========
