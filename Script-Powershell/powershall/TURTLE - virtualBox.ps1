######################
TURTLE - virtualBox.ps1
####################
# Function to print a message and stop the script if an error occurs
function Stop-ScriptOnError {
    param (
        [string]$message
    )
    Write-Error $message
    exit 1
}

# Disable Hyper-V
try {
    Write-Output "Disabling Hyper-V (bcdedit)..."
    cmd.exe /c bcdedit /set hypervisorlaunchtype off
    Write-Output "Successfully disabled Hyper-V."
} catch {
    Stop-ScriptOnError "Failed to disable Hyper-V."
}

# Disable Hyper-V, part two
try {
    Write-Output "Disabling Hyper-V (DISM)..."
    DISM /Online /Disable-Feature:Microsoft-Hyper-V
    Write-Output "Successfully disabled Hyper-V (DISM)."
} catch {
    Stop-ScriptOnError "Failed to disable Hyper-V (DISM)."
}

# Disable Device Guard and Credential Guard
try {
    Write-Output "Disabling Device Guard and Credential Guard..."
    $regPathSystemGuard = "HKLM:\SYSTEM\CurrentControlSet\Control\DeviceGuard\Scenarios\SystemGuard"
    $regPathCredentialGuard = "HKLM:\SYSTEM\CurrentControlSet\Control\DeviceGuard\Scenarios\CredentialGuard"
    $regPathDeviceGuard = "HKLM:\SYSTEM\CurrentControlSet\Control\DeviceGuard"

    if (Test-Path $regPathSystemGuard) {
        Set-ItemProperty -Path $regPathSystemGuard -Name "Enabled" -Value 0
        Write-Output "Successfully disabled Device Guard."
    } else {
        Write-Warning "Device Guard registry path not found, ignoring."
    }

    if (Test-Path $regPathCredentialGuard) {
        Set-ItemProperty -Path $regPathCredentialGuard -Name "Enabled" -Value 0
        Write-Output "Successfully disabled Credential Guard."
    } else {
        Write-Warning "Credential Guard registry path not found, ignoring."
    }

    if (Test-Path $regPathDeviceGuard) {
        Set-ItemProperty -Path $regPathDeviceGuard -Name "EnableVirtualizationBasedSecurity" -Value 0
        Write-Output "Successfully disabled EnableVirtualizationBasedSecurity."
    } else {
        Write-Warning "EnableVirtualizationBasedSecurity registry path not found, ignoring."
    }
} catch {
    Stop-ScriptOnError "Failed to disable Device Guard or Credential Guard."
}

# Disable Virtual Secure Mode
try {
    Write-Output "Disabling Virtual Secure Mode..."
    cmd.exe /c bcdedit /set vsmlaunchtype Off
    Write-Output "Successfully disabled Virtual Secure Mode."
} catch {
    Stop-ScriptOnError "Failed to disable Virtual Secure Mode."
}

Write-Output "All steps completed. Please verify that all changes were applied successfully."
Write-Output "Complete manual steps if necessary, and reboot the system."