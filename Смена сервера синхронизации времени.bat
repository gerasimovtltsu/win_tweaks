@echo off
fltmc >nul 2>&1 || (
    echo Требуются права администратора.
    PowerShell Start -Verb RunAs '%0' 2> nul || (
        echo Кликните правой кнопкой мыши по скрипту и выберите "Запустить от имени администратора".
        pause & exit 1
    )
    exit 0
)


:: ----------------------------------------------------------
:: --------- Смена NTP-сервера на pool.ntp.org --------------
:: ----------------------------------------------------------
echo "Change NTP server to pool.ntp.org"
:: Конфигурирование исходников времени
w32tm /config /syncfromflags:manual /manualpeerlist:"0.pool.ntp.org 1.pool.ntp.org 2.pool.ntp.org 3.pool.ntp.org"
:: остановка сервиса времени если запущен
SC queryex "w32time"|Find "STATE"|Find /v "RUNNING">Nul||(
    net stop w32time
)
:: запуск сервиса времени и синхронизация
net start w32time
w32tm /config /update
w32tm /resync
:: ----------------------------------------------------------


pause
exit /b 0