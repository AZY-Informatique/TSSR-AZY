Clear-Host

function Get-OSVersion {

    $reg = Get-ItemProperty "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion"

    $build = [int]$reg.CurrentBuild
    $ubr   = $reg.UBR
    $display = $reg.DisplayVersion

    # Détection Windows 10 vs Windows 11 par build
    if ($build -ge 22000) {
        $baseName = "Windows 11"
    }
    else {
        $baseName = "Windows 10"
    }

    # Détection édition
    switch ($reg.EditionID) {
        "Professional" { $edition = "Pro" }
        "Core"         { $edition = "Home" }
        "Enterprise"   { $edition = "Enterprise" }
        default        { $edition = $reg.EditionID }
    }

    Write-Host "Système d'exploitation : $baseName $edition $display (Build $build.$ubr)"
}


function Get-CPUUsage {
    # Récupère la charge CPU totale via WMI
    $cpu = Get-CimInstance Win32_Processor | Measure-Object -Property LoadPercentage -Average | Select-Object -ExpandProperty Average
    Write-Host "Utilisation CPU : $cpu %"
}

function Get-Disks {
    Get-WmiObject Win32_LogicalDisk -Filter "DriveType=3" | ForEach-Object {
        $total = "{0:N2}" -f ($_.Size/1GB)
        $free  = "{0:N2}" -f ($_.FreeSpace/1GB)
        $used  = "{0:N2}" -f (($_.Size - $_.FreeSpace)/1GB)
        Write-Host "`nLecteur $($_.DeviceID)"
        Write-Host "  Taille totale : $total Go"
        Write-Host "  Utilisé       : $used Go"
        Write-Host "  Libre         : $free Go"
    }
}

function Get-WifiIP {
    $wifi = Get-NetIPAddress -AddressFamily IPv4 -InterfaceAlias "Wi-Fi" -ErrorAction SilentlyContinue
    if ($wifi) {
        Write-Host "IP Wi-Fi (IPv4) : $($wifi.IPAddress)"
    }
    else {
        Write-Host "Aucune IP Wi-Fi trouvée."
    }
}

function Get-PublicIP {
    try {
        $ip = (Invoke-WebRequest -Uri "https://api.ipify.org").Content
        Write-Host "Adresse IP publique : $ip"
    }
    catch {
        Write-Host "Impossible de récupérer l'IP publique."
    }
}

function Get-CPUUsage {
    # Récupère la charge CPU totale via WMI
    $cpu = Get-CimInstance Win32_Processor | Measure-Object -Property LoadPercentage -Average | Select-Object -ExpandProperty Average
    Write-Host "Utilisation CPU : $cpu %"
}


function Get-RAM {
    $os = Get-CimInstance Win32_OperatingSystem
    $total = [math]::Round($os.TotalVisibleMemorySize / 1MB, 2)
    $free  = [math]::Round($os.FreePhysicalMemory / 1MB, 2)
    $used  = [math]::Round($total - $free, 2)
    $pct   = [math]::Round(($used / $total) * 100, 2)

    Write-Host "RAM totale : $total Go"
    Write-Host "RAM utilisée : $used Go ($pct %)"
    Write-Host "RAM libre : $free Go"
}

# ===============================
#           MENU
# ===============================

do {
    Clear-Host
    Write-Host "================ MENU SYSTEME ================"
    Write-Host "1 - Version système d'exploitation"
    Write-Host "2 - Temps depuis démarrage"
    Write-Host "3 - Taille des disques et espace utilisé"
    Write-Host "4 - IP Wi-Fi (IPv4)"
    Write-Host "5 - IP publique"
    Write-Host "6 - Taux occupation CPU"
    Write-Host "7 - RAM et occupation"
    Write-Host "Q - Quitter"
    Write-Host "=============================================="
    $choice = Read-Host "Entrez votre choix"

    switch ($choice) {
        "1" { Get-OSVersion; Pause }
        "2" { Get-Uptime; Pause }
        "3" { Get-Disks; Pause }
        "4" { Get-WifiIP; Pause }
        "5" { Get-PublicIP; Pause }
        "6" { Get-CPUUsage; Pause }
        "7" { Get-RAM; Pause }
        "Q" { Write-Host "Fermeture du menu..." }
        "q" { Write-Host "Fermeture du menu..." }
        default { Write-Host "Choix invalide"; Pause }
    }

} while ($choice -notin @("Q","q"))
