# ================================
# Disk Usage Alert Script
# Author: Your Name
# Date: 2026
# ================================

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "        DISK USAGE ALERT CHECK" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan

# Set alert threshold in GB
$threshold = 20

$disks = Get-WmiObject Win32_LogicalDisk -Filter "DriveType=3"

foreach ($disk in $disks) {
    $total = [math]::Round($disk.Size / 1GB, 2)
    $free = [math]::Round($disk.FreeSpace / 1GB, 2)
    $used = [math]::Round($total - $free, 2)
    $percentFree = [math]::Round(($free / $total) * 100, 1)

    Write-Host "`nDrive: $($disk.DeviceID)" -ForegroundColor Yellow
    Write-Host "Total: $total GB" -ForegroundColor Yellow
    Write-Host "Used:  $used GB" -ForegroundColor Yellow
    Write-Host "Free:  $free GB" -ForegroundColor Yellow
    Write-Host "Free%: $percentFree%" -ForegroundColor Yellow

    if ($free -lt $threshold) {
        Write-Host "WARNING: Low disk space on $($disk.DeviceID)!" -ForegroundColor Red
    } else {
        Write-Host "Status: OK" -ForegroundColor Green
    }
}

Write-Host "`n========================================" -ForegroundColor Cyan
Write-Host "         CHECK COMPLETE" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
