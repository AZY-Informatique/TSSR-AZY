#TP

#Faire un script qui demande à l'utilisateur le nom d'un dossier

#Il creer le dossier sur la partition e:

#Il partage le dossier et donne controle total à tout le monde

#Affiche la liste des dossier partager de la machine (le nom de partage et le chemin du dossier)

$dossier = read-host "Veuillez saisir le nom du dossier"
new-item -Path "e:\$dossier\" -Name "$dossier" -ItemType Directory
New-smbshare -path "e:\$dossier" -name "$dossier" -FullAccess "tout le monde"
Get-smbshare  | Format-List -Property $_.path
read-host

