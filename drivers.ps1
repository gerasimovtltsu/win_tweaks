function Export-Drivers {
	$backupPath = Read-Host "������� ���� ��� ���������� ���������"
	if (-not (Test-Path -Path $backupPath)) {
		New-Item -ItemType Directory -Path $backupPath
	}
	
	pnputil.exe /export-driver * $backupPath
	Write-Host "�������� ������� �������������� � $backupPath"
}

function Import-Drivers {
	$importPath = Read-Host "������� ����, ������ ����� ��������������� ��������"
	pnputil /add-driver "$importPath\*.inf" /subdirs /install
	$rebootRequired = Read-Host "��������� �� ������������ ����� ��������� ���������? (��/���)"
	if ($rebootRequired -eq "��") {
        Write-Host "������������ ������������..."
        Restart-Computer
    } else {
        Write-Host "������������ �� ���������. ������� ������� ��������."
    }
}

Write-Host "�������� ��������:"
Write-Host "1: ������� ���������"
Write-Host "2: ������ ���������"
$choice = Read-Host "������� ����� �������� (1 ��� 2)"

switch ($choice) {
    "1" {
        Export-Drivers
    }
    "2" {
        Import-Drivers
    }
    default {
        Write-Host "�������� �����. ��������� ������ ������ � �������� 1 ��� 2."
    }
}