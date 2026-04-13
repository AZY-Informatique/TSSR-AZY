@echo off

SETLOCAL ENABLEDELAYEDEXPANSION 

set domaine=tssr
set extension=local

REM CREATE BY PASCAL 
REM 12/11/2025 
REM VOTRE COMMENTAIRE 
 
REM a = PRENOM
REM b = NOM
REM c = LOGIN
REM d = PASSWORD
REM e = OU
REM f = Groupe1
REM g = Groupe2
REM h = ITINERANT


REM ETAPE 01
REM CREATION DES OU

dsadd ou ou=@%domaine%,dc=%domaine%,dc=%extension%
dsadd ou ou=compta,ou=@%domaine%,dc=%domaine%,dc=%extension%
dsadd ou ou=dsi,ou=@%domaine%,dc=%domaine%,dc=%extension%
dsadd ou ou=groupe,ou=@%domaine%,dc=%domaine%,dc=%extension%
dsadd ou ou=production,ou=@%domaine%,dc=%domaine%,dc=%extension%



REM ETAPE 02
REM CREATION DES GROUPES
dsadd group cn=g_comptable,ou=groupe,ou=@%domaine%,dc=%domaine%,dc=%extension% –scope g
dsadd group cn=g_informatique,ou=groupe,ou=@%domaine%,dc=%domaine%,dc=%extension% –scope g
dsadd group cn=g_direction,ou=groupe,ou=@%domaine%,dc=%domaine%,dc=%extension% –scope g
dsadd group cn=g_production,ou=groupe,ou=@%domaine%,dc=%domaine%,dc=%extension% –scope g


REM ETAPE 03
REM PARTAGE LE DOSSIER PROFILS ITINERANT
mkdir e:\partage_profils
net share partage_profils=e:\partage_profils /grant:"Tout le monde",full

REM ETAPE 04
REM CREATION DES USERS

FOR /F "delims=; tokens=1-8 skip=1" %%a in (users.txt) do (

if %%h EQU 1 (
set itinerant= -profile \\192.168.240.201\partage_profils\%%c
) else (
set itinerant=
)

echo pour %%c la variable h = %%h et profil = !itinerant!


IF %%g EQU vide (
dsadd user "cn=%%a %%b,ou=%%e,ou=@%domaine%,dc=%domaine%,dc=%extension%" -disabled no -pwd %%d -mustchpwd no -samid %%c -upn %%c@%domaine%.%extension% -fn %%a -ln %%b -display "%%a %%b" -pwdneverexpires yes -memberof "cn=%%f,ou=groupe,ou=@%domaine%,dc=%domaine%,dc=%extension%" !itinerant!
) else (
dsadd user "cn=%%a %%b,ou=%%e,ou=@%domaine%,dc=%domaine%,dc=%extension%" -disabled no -pwd %%d -mustchpwd no -samid %%c -upn %%c@%domaine%.%extension% -fn %%a -ln %%b -display "%%a %%b" -pwdneverexpires yes -memberof "cn=%%f,ou=groupe,ou=@%domaine%,dc=%domaine%,dc=%extension%" "cn=%%g,ou=groupe,ou=@%domaine%,dc=%domaine%,dc=%extension%" !itinerant!

)


) 






pause