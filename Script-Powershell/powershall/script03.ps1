#Create by Azy
#Date 08 DEC 2025

$prenom = read-host "Veuillez saisir votre prénom"
write-host {"Ton prénom est $prenom"} -BackgroundColor Blue
$nom = read-host "Veuillez saisir votre nom"
write-host {"Ton nom est $nom"} -BackgroundColor Blue
$ville = read-host "Veuillez saisir votre ville"
write-host {"Ton ville est $ville"} -BackgroundColor Blue
$OS = read-host "Veuillez saisir OS"
write-host {"Ton OS est $OS"} -BackgroundColor Blue
Write-host "A $ville , $prenom à un PC $OS" -BackgroundColor green