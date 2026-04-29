#Créer le dossier C:\echange s'il n'existe pas

if (!(Test-Path "C:\echange")) {
New-Item -Path "C:\echange" -ItemType Directory
}

#Créer deux fichiers dans C:\echange

New-Item -Path "C:\echange\fichier01.txt" -ItemType File -Force
New-Item -Path "C:\echange\fichier02.txt" -ItemType File -Force

#Ajouter un peu de contenu (optionnel)

Set-Content -Path "C:\echange\fichier01.txt" -Value "Contenu du fichier 01"
Set-Content -Path "C:\echange\fichier02.txt" -Value "Contenu du fichier 02"

#Créer le dossier C:\backup s'il n'existe pas

if (!(Test-Path "C:\backup")) {
New-Item -Path "C:\backup" -ItemType Directory
}

#Copier les fichiers vers C:\backup

Copy-Item -Path "C:\echange\fichier01.txt" -Destination "C:\backup"
Copy-Item -Path "C:\echange\fichier02.txt" -Destination "C:\backup"