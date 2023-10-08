reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\PCHC" /v PreviousUninstall /t REG_DWORD /d 1 /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\PCHealthCheck" /v installed /t REG_DWORD /d 1 /f