#Write-Host "===== INFORMATIONS DU PC =====" -ForegroundColor Cyan

# Nom du PC
Write-Host "Nom du PC        : $env:COMPUTERNAME"

# Domaine ou Workgroup
$sys = Get-CimInstance Win32_ComputerSystem
Write-Host "Domaine/Workgroup : $($sys.Domain)"

# RAM totale en Go
$ramGB = [Math]::Round($sys.TotalPhysicalMemory / 1GB, 2)
Write-Host "Mémoire RAM       : $ramGB Go"

Write-Host "`n===== CARTE WI-FI =====" -ForegroundColor Yellow

$wifi = Get-NetAdapter | Where-Object { $_.InterfaceDescription -match "Wi-Fi|Wireless" }
if ($wifi) {
    # IPv4 de la carte Wi-Fi
    $wifiIP = Get-NetIPAddress -InterfaceAlias $wifi.Name -AddressFamily IPv4 -ErrorAction SilentlyContinue
    if ($wifiIP) {
        # Adresse IP
        Write-Host "Adresse IP        : $($wifiIP.IPAddress)"

        # Passerelle IPv4
        $gateway = Get-NetRoute -InterfaceAlias $wifi.Name -AddressFamily IPv4 -DestinationPrefix "0.0.0.0/0"
        Write-Host "Passerelle        : $($gateway.NextHop)"

        # DNS IPv4
        $dns = (Get-DnsClientServerAddress -InterfaceAlias $wifi.Name -AddressFamily IPv4).ServerAddresses
        Write-Host "DNS               : $dns"
    }
    else {
        Write-Host "Pas d'adresse IPv4 détectée." -ForegroundColor Red
    }

}
else {
    Write-Host "Aucune carte Wi-Fi trouvée." -ForegroundColor Red
}
Write-Host "================================" -ForegroundColor Cyan

$proxySettings = Get-ItemProperty "HKCU:\Software\Microsoft\Windows\CurrentVersion\Internet Settings"

if ($proxySettings.ProxyEnable -eq 1) {
    Write-Host "Proxy activé" -ForegroundColor Green
    Write-Host "Adresse proxy : $($proxySettings.ProxyServer)"
} else {
    Write-Host "Proxy désactivé" -ForegroundColor Yellow
}


Pause
