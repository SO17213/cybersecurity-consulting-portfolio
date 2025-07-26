# Disable McAfee services and startup tasks
# Designed for deployment via Intune under SYSTEM context
# Author: Segun Oladipo

Write-Output "Starting McAfee disable process..."

# Stop and disable known McAfee services
$services = @(
    "mc-fw-host",
    "mc-wps-update",
    "mc-wps-secdashboardservice",
    "mfeelam",
    "mfesec"
)

foreach ($svc in $services) {
    if (Get-Service -Name $svc -ErrorAction SilentlyContinue) {
        Write-Output "Disabling service: $svc"
        Stop-Service -Name $svc -Force -ErrorAction SilentlyContinue
        Set-Service -Name $svc -StartupType Disabled
    } else {
        Write-Output "Service not found: $svc"
    }
}

# Disable WebAdvisor service if present
if (Get-Service -Name "McAfee WebAdvisor" -ErrorAction SilentlyContinue) {
    Write-Output "Disabling McAfee WebAdvisor..."
    Stop-Service -Name "McAfee WebAdvisor" -Force -ErrorAction SilentlyContinue
    Set-Service -Name "McAfee WebAdvisor" -StartupType Disabled
}

# Remove McAfee-related registry keys (non-destructive - skip if missing)
$registryKeys = @(
    "HKLM:\SYSTEM\CurrentControlSet\Services\McAfee WebAdvisor",
    "HKLM:\SYSTEM\CurrentControlSet\Services\mc-fw-host",
    "HKLM:\SYSTEM\CurrentControlSet\Services\mc-wps-update",
    "HKLM:\SYSTEM\CurrentControlSet\Services\mc-wps-secdashboardservice",
    "HKLM:\SYSTEM\CurrentControlSet\Services\mfeelam",
    "HKLM:\SYSTEM\CurrentControlSet\Services\mfesec",
    "HKLM:\SOFTWARE\McAfee"
)

foreach ($reg in $registryKeys) {
    if (Test-Path $reg) {
        Write-Output "Removing registry key: $reg"
        Remove-Item -Path $reg -Recurse -Force
    } else {
        Write-Output "Registry key not found: $reg"
    }
}

Write-Output "McAfee disable process completed."

