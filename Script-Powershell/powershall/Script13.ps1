#Create by Azy
#Date 09 DEC 2025
#les boucles Exemple 01
#while => Tant que

[int]$val= read-host "Entrez un nombre"
While ($val -lt 10) #tant que la variable est inferieur à 10 
{
$val = $val +1 #$val++
write-host $val
}
