#Create by Azy
#Date 09 DEC 2025
#Exemple 02 elseif
$rep= Read-host "Etes vous en PLS ? Tapez O OU N"
If ($rep -eq "O") 
{
    Write-Host "Prends un doliprane."
}
elseif ($rep -eq "N") 
{
    write-host "Super on continu."
}
else {
    Write-Host "Je n'ai pas compris ta reponse."
}