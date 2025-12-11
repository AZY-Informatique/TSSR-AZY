#TP

#Faire un script qui demande à l'utilisateur le nom d'un dossier

#Il creer le dossier sur la partition e:

#Il partage le dossier et donne controle total à tout le monde

#Affiche la liste des dossier partager de la machine (le nom de partage et le chemin du dossier)

# Demande du nom du dossier
$folderName = Read-Host "Entrez le nom du dossier à créer et partager"

# Construction du chemin complet
$folderPath = "E:\$folderName"

# Création du dossier s'il n'existe pas
if (-Not (Test-Path $folderPath)) {
    New-Item -ItemType Directory -Path $folderPath | Out-Null
    Write-Host "Dossier créé : $folderPath"
} else {
    Write-Host "Le dossier existe déjà."
}

# Création du partage
New-SmbShare -Name $folderName -Path $folderPath -FullAccess "Tout le monde" -Force
Write-Host "Partage SMB créé : $folderName"

# Affichage des dossiers partagés
Write-Host "`nListe des partages :"
Get-SmbShare | Select-Object Name, Path

