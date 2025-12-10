######################################################
### Script_agdlp.ps1
#######################################################
$domaine= "tssr"
$extention="local"
Install-Module -Name NTFSSecurity -Scope CurrentUser
Import-Module NTFSSecurity

#ETAPE01
#DEMANDER A L USER LE NOM DU DOSSIER
$dossier= read-host "Veuillez saisir le nom du dossier"
New-Item -Path "e:\partage\$dossier" -ItemType Directory

#ETAPE02
#On créer les 3 dossier DL dans ou=groupe,ou=@tssr,dc=tssr,dc=local(F/C/R)
New-ADGroup -name "dl_dossier_${dossier}_F" -path "OU=Groupe,ou=@${domaine},dc=${domaine},dc=${extention}" -GroupScope DomainLocal
New-ADGroup -name "dl_dossier_${dossier}_C" -path "OU=Groupe,ou=@${domaine},dc=${domaine},dc=${extention}" -GroupScope DomainLocal
New-ADGroup -name "dl_dossier_${dossier}_R" -path "OU=Groupe,ou=@${domaine},dc=${domaine},dc=${extention}" -GroupScope DomainLocal

#ETAPE03
#ON DESACTIVE L HERITAGE
$Chemin = "E:\partage\$dossier"
$acl = Get-Acl $Chemin

# 1. IMPORTANT : On coupe le lien avec le dossier parent (Casser l'héritage)
# Le premier $true = "Couper le lien"
# Le deuxième $true = "Copier les droits actuels" (pour ne pas se retrouver avec un dossier vide inaccessible)
$acl.SetAccessRuleProtection($true, $true)
$acl |Set-Acl

#ETAPE04
#SUPPRIMER LE GROUPE UTILISATEURS
$acl = Get-Acl $Chemin

$userAccess1=New-Object security.AccessControl.FileSystemAccessRule("BUILTIN\Utilisateurs"," CreateFiles, AppendData",3,0,"Allow")
$userAccess2=New-Object security.AccessControl.FileSystemAccessRule("BUILTIN\Utilisateurs"," ReadAndExecute, Synchronize",3,0,"Allow")

$acl.RemoveAccessRule($userAccess1)
$acl.RemoveAccessRule($userAccess2)
$acl |Set-Acl

# ETAPE 05
# AJOUTER LES 3 Groupes DL_DOSSIER_xxxxxxx

Add-NTFSAccess -Path "$Chemin" -Account "dl_dossier_${dossier}_F" -AccessRights FullControl -AppliesTo ThisFolderSubfoldersAndFiles
Add-NTFSAccess -Path "$Chemin" -Account "dl_dossier_${dossier}_C" -AccessRights Modify -AppliesTo ThisFolderSubfoldersAndFiles
Add-NTFSAccess -Path "$Chemin" -Account "dl_dossier_${dossier}_R" -AccessRights Read -AppliesTo ThisFolderSubfoldersAndFiles