@echo off
set domaine=tssr
set extension=local

REM ETAPE01
REM DEMANDER A L USER LE NOM DU DOSSIER
set /p dossier=Veuillez saisir le nom du dossier :
mkdir e:\partage\%dossier%

REM ETAPE02
REM On créer les 3 dossier DL (F/C/R)
dsadd group cn=dl_Dossier_%dossier%_F,ou=groupe,ou=@%domaine%,dc=%domaine%,dc=%extension% -scope l
dsadd group cn=dl_Dossier_%dossier%_C,ou=groupe,ou=@%domaine%,dc=%domaine%,dc=%extension% -scope l
dsadd group cn=dl_Dossier_%dossier%_R,ou=groupe,ou=@%domaine%,dc=%domaine%,dc=%extension% -scope l

REM ETAPE03
REM ON DESACTIVE L HERITAGE
icacls e:\partage\%dossier% /inheritance:d

REM ETAPE04
REM on supprime utilisateur
icacls e:\partage\%dossier% /remove:g "Utilisateurs"

REM ETAPE 05
REM AJOUTER LES 3 Groupes DL_DOSSIER_xxxxxxx
icacls e:\partage\%dossier% /grant dl_Dossier_%dossier%_F:(OI)(CI)(F)
icacls e:\partage\%dossier% /grant dl_Dossier_%dossier%_C:(OI)(CI)(M)
icacls e:\partage\%dossier% /grant dl_Dossier_%dossier%_R:(OI)(CI)(RX)

pause
