$ErrorActionPreference = 'Stop'
$root = Split-Path $PSScriptRoot -Parent
$seven = Get-Command '7z.exe' -ErrorAction SilentlyContinue
if (-not $seven) { $seven = Get-Item 'C:\Program Files\7-Zip\7z.exe' -ErrorAction SilentlyContinue }
if (-not $seven) { throw 'Установи 7-Zip, чтобы пересобрать установщик.' }
$sevenPath = if ($seven.Source) { $seven.Source } else { $seven.FullName }
$module = Join-Path (Split-Path $sevenPath -Parent) '7z.sfx'
if (-not (Test-Path $module)) { throw 'Не найден 7z.sfx рядом с 7z.exe.' }
$stage = Join-Path $root 'build\installer-sfx'
New-Item -ItemType Directory -Force $stage, (Join-Path $root 'downloads') | Out-Null
foreach ($file in @('AutoClicker.exe','install.ps1','install.cmd')) { Copy-Item (Join-Path $PSScriptRoot $file) (Join-Path $stage $file) -Force }
$payload = Join-Path $stage 'payload.7z'
Push-Location $stage
try { & $sevenPath a -t7z -mx=3 $payload 'AutoClicker.exe' 'install.ps1' 'install.cmd' | Out-Null; if ($LASTEXITCODE -ne 0) { throw 'Не удалось упаковать файлы установщика.' } }
finally { Pop-Location }
$config = ";!@Install@!UTF-8!`nTitle=`"AutoClickerPro — установка`"`nBeginPrompt=`"Установить AutoClickerPro для текущего пользователя Windows?`"`nRunProgram=`"install.cmd`"`n;!@InstallEnd@!`n"
$output = Join-Path $root 'downloads\AutoClickerPro-Setup.exe'
$stream = [IO.File]::Open($output, [IO.FileMode]::Create, [IO.FileAccess]::Write)
try { foreach ($part in @([IO.File]::ReadAllBytes($module), [Text.UTF8Encoding]::new($false).GetBytes($config), [IO.File]::ReadAllBytes($payload))) { $stream.Write($part, 0, $part.Length) } }
finally { $stream.Dispose() }
Write-Host "Готово: $output"
