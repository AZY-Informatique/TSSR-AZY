#Create by Azy
#Date 09 DEC 2025
$ville="Paris","Lyon","Lens","Nior"
#Afficher Lyon
Write-host $ville[1] -BackgroundColor Red
#Afficher le nombre de valeur dans le tableau
Write-Host $ville.Count -BackgroundColor Yellow
#Afficher toute les valeur de tableau
for ($i=0;$i -lt $ville.count;$i++) {Write-Host $ville[$i] -BackgroundColor Green}

