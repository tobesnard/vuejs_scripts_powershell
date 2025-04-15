
$version = ([System.Environment]::OSVersion.Version | Select-Object @{n= 'version'; e={$_.major+$_.minor/100}}).version
$isWinCompatible = $version -le 6.01



function replace_nextbrowser {
    Write-Host "Préparation pour le remplacement de C:\NextBrowser"
    if( !(Test-Path "C:\CEPI")) { New-Item -ItemType Directory c:\CEPI }
    if( Test-path "C:\CEPI\NextBrowser"){ Remove-Item -Force -Recurse C:\CEPI\NextBrowser }

    Write-Host "Téléchargement de NextBrowser.zip depuis http://pharmavitale.fr/docs/releases/latest"
    # Invoke-WebRequest http://pharmavitale.fr/docs/releases/latest/NextBrowser.zip -OutFile c:\cepi\NextBrowser.zip
    download_ftp

    Write-Host "Suppression du dossier C:\Pharmavitale\NextBrowser"
    if( (Test-path "C:\PharmaVitale\NextBrowser")){ Remove-Item -Recurse -Force C:\PharmaVitale\NextBrowser }
    
    Write-Host "Extraction de l'archive C:\CEPI\NextBrowser.zip dans C:\Pharmavitale\NextBrowser"
    Expand-Archive C:\CEPI\NextBrowser.zip C:\CEPI\NextBrowser
    
}



    # Config
$Username = "cepisoftdj-webmaster"
$Password = "DyPC6kzaDQie"
$LocalFile = "C:\CEPI\NextBrowser.zip"
$RemoteFile = "ftp://ftp.cepisoft.net/docs/releases/latest/NextBrowser.zip"
 



function download_ftp{
    $ftp_script = "C:\CEPI\ftp_download_nextbrowser_script.txt"
    if( Test-Path $ftp_script ) {Remove-Item $ftp_script }
    
    "open" >> $ftp_script  
    "ftp.cepisoft.net" >> $ftp_script
    "cepisoftdj-webmaster" >> $ftp_script
    "DyPC6kzaDQie" >> $ftp_script
    "get" >> $ftp_script
    "/docs/releases/latest/NextBrowser.zip" >> $ftp_script
    "C:\CEPI\NextBrowser.zip" >> $ftp_script
    "quit" >> $ftp_script 

    ftp -s:$ftp_script

    # $source = 'ftp://ftp.cepisoft.net/docs/releases/latest/NextBrowser.zip'
    # $target = 'C:\CEPI\NextBrowser.zip'
    # $password = Microsoft.PowerShell.Security\ConvertTo-SecureString -String 'DyPC6kzaDQie' -AsPlainText -Force
    # $credential = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList "cepisoftdj-webmaster", $password

# Download
# Invoke-WebRequest -Uri ftp://ftp.cepisoft.net/docs/releases/latest/NextBrowser.zip -OutFile C:\CEPI\NextBrowser.zip -Credential $credential -UseBasicParsing -AllowUnencryptedAuthentication
}

Write-Host "start script..."
replace_nextbrowser