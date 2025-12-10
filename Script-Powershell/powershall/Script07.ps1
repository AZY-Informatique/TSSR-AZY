#Create by Azy
#Date 09 DEC 2025
function Afficher {
param(
    [string]$nom,
    [int32]$age
)
"Bonjour {0}, tu as {1} ans." -F $nom,$age
}
Afficher "Azy" 30
Afficher "Pascal" 99
