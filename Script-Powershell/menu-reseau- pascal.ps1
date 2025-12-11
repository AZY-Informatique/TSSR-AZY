#*******************************************************************
#menu-reseau.ps1
#*******************************************************************
# Récupération de l'interface Wi-Fi (nom contenant "Wi*fi")
$wifi = Get-NetIPAddress |
    Where-Object { $_.InterfaceAlias -like "Wi*fi" }

# Extraction IPv4 / IPv6
$ipv4 = $wifi | Where-Object { $_.AddressFamily -eq "IPv4" } | Select-Object -ExpandProperty IPAddress
$ipv6 = $wifi | Where-Object { $_.AddressFamily -eq "IPv6" } | Select-Object -ExpandProperty IPAddress

$ipPublic = Invoke-RestMethod -Uri "https://api.ipify.org?format=text"


$continue = $true
while ($continue) {
    write-host ".............MON MENU..............."
    write-host "1 - Afficher iPV4 de carte Wifi"
    write-host "2 - Afficher iPV6 de carte Wifi"
    write-host "3 - Afficher IP Publique de carte Wifi"
    write-host "q - Quitter le menu"    
    write-host "..................................."
    $choix=read-host "Veuillez selection votre action"
    switch ($choix) {
        1{Write-Host "IPv4 locale  : $ipv4"}
        2{Write-Host "IPv6 locale  : $ipv6"}
        3{Write-Host "IP publique  : $ipPublic"}
        'q'{$continue = $false}
        default {Write-host "Je n'ai pas compris votre choix"}
    }
}  