#Faire un script Powershell qui affiche les informations suivantes 
#=== Informations Réseau Wi-Fi ===
#Interface    : Wi-Fi
#IPv4 locale  : 172.20.0.110
#IPv6 locale  : fe80::6d9f:5f18:52db:2c48%13
#IP publique  : 194.206.218.105

# Récupération de l'interface Wi-Fi (nom contenant "Wi*fi")
$wifi = Get-NetIPAddress |
    Where-Object { $_.InterfaceAlias -like "Wi*fi" }

# Extraction IPv4 / IPv6
$ipv4 = $wifi | Where-Object { $_.AddressFamily -eq "IPv4" } | Select-Object -ExpandProperty IPAddress
$ipv6 = $wifi | Where-Object { $_.AddressFamily -eq "IPv6" } | Select-Object -ExpandProperty IPAddress

$ipPublic = Invoke-RestMethod -Uri "https://api.ipify.org?format=text"

# Affichage
Write-Host "=== Informations Réseau Wi-Fi ===" -ForegroundColor Cyan
Write-Host "Interface    : $($wifi[0].InterfaceAlias)"
Write-Host "IPv4 locale  : $ipv4"
Write-Host "IPv6 locale  : $ipv6"
Write-Host "IP publique  : $ipPublic"

read-host