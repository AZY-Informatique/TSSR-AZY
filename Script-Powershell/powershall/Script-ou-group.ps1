#Create by Azy
#Date 10 DEC 2025
#Script-ou-group
note du 10 décembre 2025

Conversion de Scriptcomplet.bat en powershell par Gemini mais simplifier à la mano

########################
##Script-ou-group.ps1
#########################

<#
.SYNOPSIS
    Script de création d'arborescence AD et d'utilisateurs (Migration du script Batch de Pascal)
.DESCRIPTION
    1. Crée les OUs
    2. Crée les Groupes
#>

# --- VARIABLES DE CONFIGURATION ---
$DomaineNom    = "tssr"
$Extension     = "local"
$RacineDN      = "DC=$DomaineNom,DC=$Extension" # ex: DC=tssr,DC=local
$RootOUName    = "@$DomaineNom"                 # ex: @tssr


Clear-Host
Write-Host "--- DÉBUT DU TRAITEMENT ---" -ForegroundColor Cyan

# --- ETAPE 01 : CRÉATION DES OUs ---
Write-Host "`n[ETAPE 01] Création des Unités d'Organisation..." -ForegroundColor Yellow


# 1. Création de l'OU Racine (@tssr)
New-ADOrganizationalUnit -Name $RootOUName -Path $RacineDN

$RootOU_DN = "OU=$RootOUName,$RacineDN"

# 2. Création des sous-OUs
$ListSousOU = @("compta", "dsi", "groupe", "production")
foreach ($ou in $ListSousOU) {
    New-ADOrganizationalUnit -Name $ou -Path $RootOU_DN
}

# --- ETAPE 02 : CRÉATION DES GROUPES ---
Write-Host "`n[ETAPE 02] Création des Groupes..." -ForegroundColor Yellow

$CheminGroupeOU = "OU=groupe,$RootOU_DN"
$ListeGroupes = @("g_comptable", "g_informatique", "g_direction", "g_production")

foreach ($grp in $ListeGroupes) {

        New-ADGroup -Name $grp -GroupScope Global -GroupCategory Security -Path $CheminGroupeOU -ErrorAction Stop
        Write-Host " + Groupe créé : $grp" -ForegroundColor Green
    
}

Write-Host "`n--- FIN DU TRAITEMENT ---" -ForegroundColor Cyan
Pause


############################
## Script creation user
###########################