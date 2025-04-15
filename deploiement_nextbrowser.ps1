

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


function Run-Pass {
	$manageexe_path = "C:\PharmaVitale\Fichiers\PHP\Prog\Next\asset\manageExe\update\nextbrowser*"
	Write-Host "PASS *******************************************"
	Write-Host "NOVERSNXTB : " ( Get-DBParametre -Param NOVERSNXTB )
	Write-Host "Before ... "
	Get-ChildItem $manageexe_path | Select-Object Name, LastWriteTime
	Write-Host "Invoke manage exe ... "
	(Invoke-WebRequest http://localhost/prog/next/index.php/cron/manageExe).Content > null
	Get-ChildItem $manageexe_path | Select-Object Name, LastWriteTime
	write-host "Stop-Process chrome-phv"
	Get-Process chromephv* | Stop-Process
	Write-Host "Invoke selfmaj ... "
	(Invoke-WebRequest http://localhost/prog/next/index.php/cron/selfMaj/1).Content > null
	Get-ChildItem $manageexe_path | Select-Object Name, LastWriteTime
	Write-Host "NOVERSNXTB : " ( Get-DBParametre -Param NOVERSNXTB )
}




$location = Get-Location
Set-Location C:\PharmaVitale\Fichiers\PHP\Prog\Next\

git config --global --add safe.directory C:/PharmaVitale/Fichiers/PHP/Prog/Next
$commit = git log -1 --format=%h
git log --oneline -5
Write-Host "commit actuel : $commit"


Run-Pass
# Write-Host "Set parametre noversion à 20230101: "
# Set-DBParametre -param "NOVERSNXTB" -value "20230101"
# Run-Pass




Set-Location $location



# Set-DBParametre -param VENTE_DBG -value "0"
# Get-DBParametre -Param VENTE_DBG