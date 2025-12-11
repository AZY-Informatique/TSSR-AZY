$continue = $true
while ($continue) {
    write-host ".............MON MENU..............."
    write-host "1 - VERSION SYSTEME EXPLOITATION "
    write-host "2 - DEPUIS COMBIEN DE TEMPS LE PC EST ALLUME"
    write-host "3 - TAILLE DES DISQUES DUR ET L ESPACE UTILISE"
    write-host "4 - IP V4 CARTE WIFI"
    write-host "5 - IP PUBLIC"
    write-host "6 - TAUX OCCUPATION DU PROCESSEUR"
    write-host "7 - LA RAM ET LE TAUX OCCUPATION DE LA RAM"
    write-host "8 - LA RAM en temps real "
    write-host "9 - processeur en temps real  "
    write-host "q - Quitter le menu"    
    write-host "..................................."
    $choix=read-host "Veuillez selection votre action"
    switch ($choix) {
        1{ $c1= Get-ComputerInfo | Select-Object OsName, OsVersion, OsBuildNumber
    write-host "$c1"

}
        2{ $c2=(Get-CimInstance Win32_OperatingSystem).LastBootUpTime

write-host "$c2"

 }
        3{ Get-PSDrive -PSProvider FileSystem | Select-Object Name, Used, Free, @{Name="Total(GB)";Expression={"{0:N2}" -f ($_.Used + $_.Free)/1GB}}, @{Name="Used(GB)";Expression={"{0:N2}" -f ($_.Used/1GB)}}, @{Name="Free(GB)";Expression={"{0:N2}" -f ($_.Free/1GB)}}
}
        4{Get-NetIPAddress -InterfaceAlias "Wi-Fi" -AddressFamily IPv4 | Select-Object IPAddress}

        5{$ipPublic = Invoke-RestMethod -Uri "https://api.ipify.org?format=text"
Write-Host "IP publique  : $ipPublic"}
        6{ $c6= Get-CimInstance Win32_Processor | Select-Object Name, LoadPercentage

write-host "$c6"

}
         
        7{



# Récupération des infos mémoire
$ram = Get-CimInstance Win32_OperatingSystem

# Calcul RAM totale et taux d'utilisation
$TotalRAM = [math]::Round($ram.TotalVisibleMemorySize / 1MB, 2)    # en GB
$UsagePct = [math]::Round((1 - ($ram.FreePhysicalMemory / $ram.TotalVisibleMemorySize)) * 100, 2)

# Affichage
Write-Host "-----------------------------" -ForegroundColor Cyan
Write-Host "         MEMOIRE RAM         " -ForegroundColor Cyan
Write-Host "-----------------------------"
Write-Host "RAM totale        : $TotalRAM GB"
Write-Host "Taux d'utilisation: $UsagePct %"
Write-Host "-----------------------------"










}












8{
    Write-Host "Appuyez sur 'Q' pour revenir au menu..." -ForegroundColor Yellow
    Start-Sleep -Milliseconds 800

    while ($true) {

        if ([Console]::KeyAvailable) {
            $key = [Console]::ReadKey($true)
            if ($key.Key -eq "Q") { break }   # Sortie du temps réel
        }

        $ram = Get-CimInstance Win32_OperatingSystem

        # Calcul RAM totale et taux d'utilisation
        $TotalRAM = [math]::Round($ram.TotalVisibleMemorySize / 1MB, 2)
        $UsagePct = [math]::Round((1 - ($ram.FreePhysicalMemory / $ram.TotalVisibleMemorySize)) * 100, 2)

        Clear-Host
        Write-Host "-----------------------------" -ForegroundColor Cyan
        Write-Host "     RAM EN TEMPS REEL       " -ForegroundColor Cyan
        Write-Host "-----------------------------"
        Write-Host "RAM totale        : $TotalRAM GB"
        Write-Host "Taux d'utilisation: $UsagePct %"
        Write-Host "-----------------------------"
        Write-Host "(Appuyez sur 'Q' pour revenir au menu)"

        Start-Sleep -Seconds 1
    }
}



9{


    Write-Host "Appuyez sur Q pour revenir au menu..." -ForegroundColor Yellow
    Start-Sleep -Milliseconds 800

    while ($true) {

        # Permet de quitter avec Q sans bloquer
        if ([Console]::KeyAvailable) {
            $key = [Console]::ReadKey($true)
            if ($key.Key -eq [ConsoleKey]::Q) { break }
        }

        # Récupère l'utilisation CPU réelle
        $cpu = (Get-CimInstance Win32_Processor).LoadPercentage

        Clear-Host
        Write-Host "----------------------------------------" -ForegroundColor Cyan
        Write-Host "  TAUX D'OCCUPATION DU PROCESSEUR (LIVE)" -ForegroundColor Cyan
        Write-Host "----------------------------------------"
        Write-Host "Utilisation CPU : $cpu %"
        Write-Host "----------------------------------------"
        Write-Host "Appuyez sur Q pour revenir au menu"

        Start-Sleep -Seconds 1
    
}








}





        'q'{$continue = $false}
        default {Write-host "Je n'ai pas compris votre choix"}
    }
}