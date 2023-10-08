@echo off
fltmc >nul 2>&1 || (
    echo ��������� ����� ��������������.
    PowerShell Start -Verb RunAs '%0' 2> nul || (
        echo �������� ������ ������� ���� �� ������� � �������� "��������� �� ����� ��������������".
        pause & exit 1
    )
    exit 0
)


:: ----------------------------------------------------------
:: --------- ����� NTP-������� �� pool.ntp.org --------------
:: ----------------------------------------------------------
echo "Change NTP server to pool.ntp.org"
:: ���������������� ���������� �������
w32tm /config /syncfromflags:manual /manualpeerlist:"0.pool.ntp.org 1.pool.ntp.org 2.pool.ntp.org 3.pool.ntp.org"
:: ��������� ������� ������� ���� �������
SC queryex "w32time"|Find "STATE"|Find /v "RUNNING">Nul||(
    net stop w32time
)
:: ������ ������� ������� � �������������
net start w32time
w32tm /config /update
w32tm /resync
:: ----------------------------------------------------------


pause
exit /b 0