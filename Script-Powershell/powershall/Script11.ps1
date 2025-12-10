#Create by Azy
#Date 09 DEC 2025
#Exemple 03 (OR)
$rep= Read-host "Etes vous en PLS ? Tapez O ou OUI,N ou NON"
If (($rep -eq "O") -OR ($rep -eq "OUI"))
{
    Write-Host "Prends un doliprane."
}
elseif (($rep -eq "N") -OR  ($rep -eq "NON"))
{
    write-host "Super on continu."
}
else {
    Write-Host "Je n'ai pas compris ta reponse."
}