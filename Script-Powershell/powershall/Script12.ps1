#Create by Azy
#Date 09 DEC 2025
#Exemple 04 (AND) Toutes conditions doivent  etre vrai
[int]$rep =read-host "Entez un numbre entre 10 et 20"
# -ge =Superieur et égale , -le plus petite et égale
If (($rep -ge 10) -AND ($rep -le 20)){
Write-Host "le nombre est validé."
}
else {
    Write-Host "????????"
}
