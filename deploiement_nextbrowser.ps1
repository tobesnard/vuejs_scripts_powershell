<#
.SYNOPSIS
    Script pour visualiser l'état et mettre à jour à la fois Next et Nextbrowser depuis un poste serveur.

.DESCRIPTION
    Ce script effectue les opérations suivantes :
    - Met à jour le fichier `nextbrowser.zip` sur le serveur via le script `manageExe`.
    - Force la mise à jour de Next via le script `selfMaj`.
    - Affiche quelques constantes pour vérifier la mise à jour (Commit, NOVERSNXTB, date de modification du fichier `nextbrowser.zip`).

    Notes :
    - Le script doit être exécuté depuis un poste serveur.
    - un préalable est nécessaire :
        [préalable à l'exécutions de script Powershell](./readme.md#déploiement-step1ps1)
        [Avoir connaissance du fonctionnement](.readme.md#déploiement-nextbrowserps1)

    Améliorations possibles :
    - Faire en sorte que le script soit déployé avec les versions de Next, le rendant ainsi disponible sans téléchargement préalable.
#>


# Mets à jour un paramètre de la table `parametre` dans la base de données.
# Passe par l'API de Next pour faire la mise à jour (common/setParametre)
function Set-DBParametre {
	[CmdletBinding()]
	param(
		[string]$Param,
		[string]$Value
	)
	$header = @{'X-Requested-With'='XMLHttpRequest'}
	$postdata = @{multiple=$false; nomOpt=$Param; valueOpt=$Value}
	$uri = "http://localhost/prog/next/index.php/common/setParametre"
	(Invoke-WebRequest -Method Post -Headers $header -Body $postdata -Uri $uri).Content > null
}

# Récupère la valeur d'un paramètre de la table `parametre` dans la base de données.
# Passe par l'API de Next pour faire la récupération (common/getParametre)
function Get-DBParametre {
	[CmdletBinding()]
	param(
		[string]$Param
	)
	$header = @{'X-Requested-With'='XMLHttpRequest'}
	$postdata = @{multiple=$false; parametre=$Param; }
	$uri = "http://localhost/prog/next/index.php/common/getParametre"
	(Invoke-WebRequest -Method Post -Headers $header -Body $postdata -Uri $uri).Content 
}

function Show-Info {
    [CmdletBinding()]
    param(
        [string]$Message
    )
    $manageexe_path = "C:\PharmaVitale\Fichiers\PHP\Prog\Next\asset\manageExe\update\nextbrowser.zip"
    Write-Host "---- Informations " $Message
    Write-Host "Commit ->" ( git log -1 --format="%h : %s" )
	Write-Host "Numéro de version NOVERSNXTB : " ( Get-DBParametre -Param NOVERSNXTB )
    Write-Host "Date de modification du fichier Nextbrowser.zip : " ( Get-ChildItem $manageexe_path ).LastWriteTime
    Write-Host "----------------"
}

# Exécute la mise à jour de l'application NextBrowser.
# d'abord on exécute le script `manageExe` qui va récupérer et mettre à jour le fichier Nextbrowser.zip sur le serveur
# ensuite on exécute le script `selfMaj` qui forcer la mise à jour de Next
# enfin on vérifie la version de NextBrowser via le paramètre en BDD NOVERSNXTB 
function Run-Pass {
	Write-Host "Démarrage du processus de mise à jour de Next de Nextbrowser.zip"
    Show-Info "avant exécution"
	Write-Host "Mise à jour de manageExe\update\nextbrowser.zip ..."
	(Invoke-WebRequest http://localhost/prog/next/index.php/cron/manageExe).Content > null
	write-host "Fermeture de l'application NextBrowser"
	Get-Process chromephv* | Stop-Process
	Write-Host "Force la mise à jour de Next ..."
	(Invoke-WebRequest http://localhost/prog/next/index.php/cron/selfMaj/1).Content > null
    Show-Info "après exécution"
}


# Début du script
Push-Location
Set-Location C:\PharmaVitale\Fichiers\PHP\Prog\Next\
git config --global --add safe.directory C:/PharmaVitale/Fichiers/PHP/Prog/Next
Run-Pass
Pop-Location

