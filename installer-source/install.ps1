$ErrorActionPreference = 'Stop'
try {
    $sourceExe = Join-Path $PSScriptRoot 'AutoClicker.exe'
    $installDir = Join-Path $env:LOCALAPPDATA 'Programs\AutoClickerPro'
    $exePath = Join-Path $installDir 'AutoClicker.exe'
    $desktop = [Environment]::GetFolderPath('Desktop')
    $startMenu = Join-Path $env:APPDATA 'Microsoft\Windows\Start Menu\Programs\AutoClickerPro'
    New-Item -ItemType Directory -Force -Path $installDir, $startMenu | Out-Null
    Copy-Item -LiteralPath $sourceExe -Destination $exePath -Force
    $shell = New-Object -ComObject WScript.Shell
    foreach ($linkPath in @((Join-Path $desktop 'AutoClickerPro.lnk'), (Join-Path $startMenu 'AutoClickerPro.lnk'))) {
        $shortcut = $shell.CreateShortcut($linkPath)
        $shortcut.TargetPath = $exePath
        $shortcut.WorkingDirectory = $installDir
        $shortcut.IconLocation = "$exePath,0"
        $shortcut.Description = 'AutoClickerPro — автокликер от Kwizeek'
        $shortcut.Save()
    }
    Add-Type -AssemblyName System.Windows.Forms
    $choice = [System.Windows.Forms.MessageBox]::Show('AutoClickerPro установлен. Ярлык создан на рабочем столе. Запустить приложение сейчас?', 'Установка завершена', [System.Windows.Forms.MessageBoxButtons]::YesNo, [System.Windows.Forms.MessageBoxIcon]::Information)
    if ($choice -eq [System.Windows.Forms.DialogResult]::Yes) { Start-Process -FilePath $exePath -WorkingDirectory $installDir }
} catch {
    Add-Type -AssemblyName System.Windows.Forms -ErrorAction SilentlyContinue
    [System.Windows.Forms.MessageBox]::Show("Не удалось установить AutoClickerPro:`n$($_.Exception.Message)", 'Ошибка установки', [System.Windows.Forms.MessageBoxButtons]::OK, [System.Windows.Forms.MessageBoxIcon]::Error) | Out-Null
    exit 1
}
