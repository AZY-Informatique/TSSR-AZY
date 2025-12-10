#TP INFO PC

#Afficher les information suivantes :
#NOM DU PC
#TAILLE DE LA MEMOIRE EN (Go)
#TAILLE TOTAL DE LA PARTITION c: (ESPACE LIBRE en Go)
#ADRESSE IP DU PC et MASQUE
#ADRESSE IP DU  DNS
#ADRESSE IP DE LA passerelle
#Si le proxy est activé 

#Affiche le nom de l’ordinateur.
$env:COMPUTERNAME

#Taille de la mémoire RAM (en Go)
(Get-CimInstance Win32_PhysicalMemory | Measure-Object Capacity -Sum).Sum / 1GB

#Taille totale de la partition C: (et espace libre en Go)
Get-PSDrive -Name C | Select-Object Name, Used, Free, @{Name="TotalSize(GB)";Expression={[math]::Round($_.Used/1GB + $_.Free/1GB,2)}}, @{Name="Free(GB)";Expression={[math]::Round($_.Free/1GB,2)}}

#Adresse IP du PC et masque
Get-NetIPAddress -AddressFamily IPv4 |Where-Object { $_.InterfaceAlias -like "*Wi-Fi*" } |Select-Object InterfaceAlias, IPAddress, PrefixLength

#Adresse IP du DNS
(Get-DnsClientServerAddress -AddressFamily IPv4 | Select-Object -ExpandProperty ServerAddresses)[0]

#Adresse IP de la passerelle
Get-NetRoute -DestinationPrefix "0.0.0.0/0" | Select-Object NextHop

#Vérifier si un proxy est activé
netsh winhttp show proxy



pause