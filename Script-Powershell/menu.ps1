#menu2.ps1

$continue = $true
while ($continue) {
    write-host ".............MON MENU..............."
    write-host "1 - Action 1"
    write-host "2 - Action 2"
    write-host "3 - Action 3"
    write-host "q - Quitter le menu"    
    write-host "..................................."
    $choix=read-host "Veuillez selection votre action"
    switch ($choix) {
        1{Write-host "Vous avez choisi le menu 1"}
        2{Write-host "Vous avez choisi le menu 2"}
        3{Write-host "Vous avez choisi le menu 3"}
        'q'{$continue = $false}
        default {Write-host "Je n'ai pas compris votre choix"}
    }
}  