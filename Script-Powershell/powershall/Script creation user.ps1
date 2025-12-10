############################
## Script creation user
###########################
# --- CONFIGURATION ---
$Domaine   = "tssr"
$Extension = "local"
# Le chemin de base pour éviter de le réécrire partout (ex: dc=tssr,dc=local)
$BaseDN    = "DC=$Domaine,DC=$Extension"
$RacineOU = "OU=@$Domaine,$BaseDN"

# --- ETAPE 4 : LES UTILISATEURS ---
Write-Host "Importation des utilisateurs..."

# On charge le fichier texte dans une variable
$ListeUtilisateurs = Import-Csv -Path ".\users.txt" -Delimiter ";"

# On boucle : "Pour chaque ligne ($User) dans ma liste ($ListeUtilisateurs)"
foreach ($User in $ListeUtilisateurs) {

    # 1. On prépare le mot de passe (Obligatoire en PowerShell pour la sécurité)
    $SecuriseMdp = ConvertTo-SecureString $User.PASSWORD -AsPlainText -Force

    # 3. On crée l'utilisateur
    Write-Host "Création de $($User.LOGIN)..."
    
    New-ADUser -Name "$($User.PRENOM) $($User.NOM)" `
               -GivenName $User.PRENOM `
               -Surname $User.NOM `
               -SamAccountName $User.LOGIN `
               -UserPrincipalName "$($User.LOGIN)@$Domaine.$Extension" `
               -Path "OU=$($User.OU),$RacineOU" `
               -AccountPassword $SecuriseMdp `
               -Enabled $true `
               -PasswordNeverExpires $true

    # 4. On l'ajoute au Groupe 1
    Add-ADGroupMember -Identity $User.GROUPE1 -Members $User.LOGIN

    # 5. On l'ajoute au Groupe 2 (Seulement s'il n'est pas "vide")
    if ($User.GROUPE2 -ne "vide") {
        Add-ADGroupMember -Identity $User.GROUPE2 -Members $User.LOGIN
    }
}

Write-Host "Terminé !"
Pause