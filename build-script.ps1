<#
.SYNOPSIS
    Script de génération des builds Vue JS.

.DESCRIPTION
    Ce script commence par supprimer les anciens builds de développement et de production.
    Ensuite, il exécute la commande de construction appropriée en fonction du type spécifié (`dev`, `prod` ou `all`).
    Après la construction, il renomme le fichier `next.html` en `next.php`.
    
    Un traitement est ensuite appliqué à `next.php` :
    - Pour les fichiers JavaScript et CSS de la balise `<head>`, un mécanisme PHP est ajouté pour gérer le cache (ajoute `commonVar["appVersion"]`).
    - La chaîne `##buildVersion##` est remplacée par la date de construction. Cette date est affichée sur la page de connexion de Next.
    
    Notes :

    Le script doit être exécuté depuis le répertoire `vuejs`.
    Ce script utilise et est utilisé par les commandes `npm run ...`.
    Voir la section `scripts` du fichier `vuejs/package.json`.

    En production, les fichiers JS et CSS sont renommés avec la date de construction. 
    Il s'agit d'un autre mécanisme pour gérer le cache. Ce travail est fait par l'outil de développement Vite.
    Voir la section `build->rollupOptions->output->chunkFileNames` du fichier `vite.config.js`.

.PARAMETER Type
    Spécifie le type de build à générer :
    - dev  : compilation pour le développement.
    - prod : compilation pour la production.
    - all  : compilation pour le développement et la production.

.PARAMETER Project
    Spécifie le nom du projet à compiler. 
    Par défaut, il s'agit de `next`. `test` et `back` sont également des noms de projets valides.

.EXAMPLE
    ./build-script -Type dev -Project next
#>


# Déclaration des paramètres du script
Param(
    # Type de build
    [ValidateSet("dev", "prod", "all")]
    [string]$Type="dev",
    # Nom du projet
    [ValidateSet("next", "test", "back")]
    [string]$Project="next"
) 

# Constantes pour les chemins du build/distribution
$dev_directory = ".\dist\dev"   #dossier de la distribution de development
$prod_directory = ".\dist\prod" #dossier de la distribution de production

# Construction du build de développement
function buildDev 
{
    Write-Host "Development/Test Build"
    if( Test-Path $dev_directory){
        Remove-Item -Force -Recurse "$dev_directory/$Project" -ErrorAction SilentlyContinue
    }
    $script = "private:build:"+$Project+":dev"
    npm run $script
    Rename-Item "$dev_directory\$Project\$Project.html" "$Project.php"
    appendVersion -Dist $dev_directory
    setBuildVersion -Dist $dev_directory
}

# Construction du build de Production
function buildProd 
{
    Write-Host "Production Build"
    if( Test-Path $prod_directory ){
        Remove-Item -Force -Recurse "$prod_directory/$Project" -ErrorAction SilentlyContinue
    }
    $script = "private:build:"+$Project+":prod"
    npm run $script
    Rename-Item "$prod_directory\$Project\$Project.html" "$Project.php"
    appendVersion -Dist $prod_directory
    setBuildVersion -Dist $prod_directory
}

# Ajoute un mécanisme PHP permettant la gestion du cache pour les fichiers JS et CSS.
# CommonVar["appVersion"] est ajouté aux nom de fichier JS et CSS de la balise HEAD.
function appendVersion
{
    param($Dist)

    $files = getFilenames -Dist $dist
    $appendString = "?version=<?=`$this->config->item('commonVar')['appVersion'];?>"
    foreach( $file in $files){
        ( Get-Content -path ("$dist\$Project\$Project.php") ) -replace $file.Replace('.', '\.'), ( $file + $appendString ) | Set-Content -Path ("$dist\$Project\$Project.php")
    } 
}

# Récupère la liste des fichiers à modifier
function getFilenames
{
    param($Dist)

    $patternjs = '.*/(.*\.js).*' 
    $patterncss = '.*/(.*\.css).*'
    $files = Get-Content -path ("$dist\$Project\$Project.php") | Select-String -Pattern $patternjs, $patterncss | %{ $_.Matches} | %{$_.Groups[1].value }
    return $files
}

# Remplace ##buildVersion# par la date de construction
function setBuildVersion
{
    param($Dist)

    $version = get-date -Format "yyyyMMdd-HHmm"
    ( get-content -Path ("$dist\$Project\$Project.php") ) -replace '##buildVersion##', $version | Set-Content -Path ("$dist\$Project\$Project.php")
}


# Début du script
write-host "Génération des builds de type $Type"

# Exécution du script pour la version développement
if($type -eq "dev" ) {
     buildDev
}

# Exécution du script pour la version de production
if($type -eq "prod" ){
    buildProd
}

# Exécution du script pour les versions de développement de production
if($type -eq "all" ){
    buildDev
    buildProd
}







