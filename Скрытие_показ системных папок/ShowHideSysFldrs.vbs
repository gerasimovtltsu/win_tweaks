Hidden = "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced\Hidden"
SSHidden = "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced\ShowSuperHidden"
set Command1 = WScript.CreateObject("WScript.Shell")
Check = Command1.RegRead(Hidden)
if Check = 2 then
    Command1.RegWrite Hidden, 1, "REG_DWORD"
    Command1.RegWrite SSHidden, 1, "REG_DWORD"
else
    Command1.RegWrite Hidden, 2, "REG_DWORD"
    Command1.RegWrite SSHidden, 0, "REG_DWORD"
end if
Command1.SendKeys "{F5}"