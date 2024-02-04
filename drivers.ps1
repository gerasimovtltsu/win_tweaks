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
	pnputil /add-driver "$importPath\*.inf" /subdirs /install
	$rebootRequired = Read-Host "Требуется ли перезагрузка после установки драйверов? (да/нет)"
	if ($rebootRequired -eq "да") {
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