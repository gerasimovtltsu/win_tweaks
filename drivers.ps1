function Export-Drivers {
	$backupPath = Read-Host "Введите путь для сохранения драйверов"
	if (-not (Test-Path -Path $backupPath)) {
		New-Item -ItemType Directory -Path $backupPath
	}
	
	pnputil.exe /export-driver * $backupPath
	Write-Host "Драйверы успешно экспортированы в $backupPath"
}

function Import-Drivers {
	$importPath = Read-Host "Введите путь, откуда будут импортироваться драйверы"
	$driver_inf_files = Get-ChildItem -Path $importPath -Filter "*.inf" -Recurse -File
	foreach($driver_inf_file in $driver_inf_files) {
		$driver_inf_file.FullName
		pnputil.exe -i -a "$driver_inf_file.FullName"
	}
	$rebootRequired = Read-Host "Требуется ли перезагрузка после установки драйверов? (y/n)"
	if ($rebootRequired -eq "y") {
        Write-Host "Планирование перезагрузки..."
        Restart-Computer
    } else {
        Write-Host "Перезагрузка не требуется. Процесс импорта завершен."
    }
}

Write-Host "Выберите действие:"
Write-Host "1: Экспорт драйверов"
Write-Host "2: Импорт драйверов"
$choice = Read-Host "Введите номер действия (1 или 2)"

switch ($choice) {
    "1" {
        Export-Drivers
    }
    "2" {
        Import-Drivers
    }
    default {
        Write-Host "Неверный выбор. Запустите скрипт заново и выберите 1 или 2."
    }
}
