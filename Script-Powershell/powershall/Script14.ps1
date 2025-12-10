#Create by Azy
#Date 09 DEC 2025
#les boucles Exemple 02
#while => Tant que

[int]$resultat = 42
[int]$rep=read-host "entrez un nombre"

While ($rep -ne $resultat) # tant que $rep est diffèrent de $resultat
{
Write-host "Non ce n'est pas le bon résultat. Recommencez !!"  
$rep=Read-Host "Entrez de nouveau un nombre"

}
Write-Host "Bravo tu as trouvé le nombre 42"
