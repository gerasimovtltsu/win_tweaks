@echo off 
chcp 65001
cd %systemroot%\system32
call :IsAdmin

Color 0F
Echo    ������� ������ ��� ����� ��������� + ���������� ����������:
Echo.
Echo    1  - ������ ���������
Echo    2  - �����  ���������
echo.
Set /p choice="�������� ������ ��������� (1 ��� 2) : "
if "%choice%"=="1" reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Shell Extensions\Blocked" /v {e2bf9676-5f8f-435c-97eb-11607a5bedf7} /f
if "%choice%"=="2" reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Shell Extensions\Blocked"  /f
: /v {e2bf9676-5f8f-435c-97eb-11607a5bedf7} /f
Echo. ���������� ����������
@echo off 
Taskkill /F /IM explorer.exe 
start explorer.exe

:IsAdmin

Reg.exe query "HKU\S-1-5-19\Environment"
If Not %ERRORLEVEL% EQU 0 (
Color 4F
 Cls & Echo    ��������� ���� �� ����� �������������� ... 
 Pause & Exit
)
Cls
goto:eof
