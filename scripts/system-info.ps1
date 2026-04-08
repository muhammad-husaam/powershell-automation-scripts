# System Information Script (Improved)

Write-Host "===== System Information =====" -ForegroundColor Green

$os = Get-CimInstance Win32_OperatingSystem

Write-Host "Computer Name: $env:COMPUTERNAME"
Write-Host "OS: $($os.Caption)"
Write-Host "Build Number: $($os.BuildNumber)"
Write-Host "Version: $($os.Version)"

$ram = (Get-CimInstance Win32_ComputerSystem).TotalPhysicalMemory
Write-Host "RAM: $([math]::Round($ram/1GB,2)) GB"
