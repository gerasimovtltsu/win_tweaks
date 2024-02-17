function Export-Drivers {
	$backupPath = Read-Host "Input path to saving drivers"
	if (-not (Test-Path -Path $backupPath)) {
		New-Item -ItemType Directory -Path $backupPath
	}
	
	Export-WindowsDriver -Online -Destination $backupPath
	Write-Host "Drivers backuped successfully in $backupPath"
}

function Import-Drivers {
	$importPath = Read-Host "Input path to folder with drivers"
	Get-ChildItem $importPath -Recurse -Filter "*.inf" | ForEach-Object { PNPUtil.exe /add-driver $_.FullName /install }
}

Write-Host "Choose option:"
Write-Host "1: Export drivers"
Write-Host "2: Import drivers"
$choice = Read-Host "Choose option (1 or 2)"

switch ($choice) {
    "1" {
        Export-Drivers
    }
    "2" {
        Import-Drivers
    }
    default {
        Write-Host "Wrong option"
    }
}
