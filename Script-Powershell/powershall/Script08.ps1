#Create by Azy
#Date 09 DEC 2025
function Afficher {
param(
    [string]$nom,
    [int32]$age
)
#si erreur dans la commande, alors la prime sera de 50

try {$prime = 1000/($age-25)}
catch {$prime = 50}
"Bonjour {0}, tu as une prime de : {1} € ." -F $nom,$prime
}
Afficher "Azy" 25
Afficher "Pascal" 99
