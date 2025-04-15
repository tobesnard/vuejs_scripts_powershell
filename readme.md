# Readme - Les scripts PowerShell

Pour consulter la documentation d'un script PowerShell, vous pouvez soit :
1. Utiliser la commande PowerShell : `Get-Help .\script-name.ps1 -Detailed`
2. Consulter le fichier `script-name.ps1`

## build script

Script de génération des builds pour les projets écrits en Vue.js.  
Ce script ajoute quelques étapes à la compilation classique via Vite.  
Entre autres, il met en place des mécanismes pour gérer le cache des fichiers JS et CSS.  
On y retrouve également la mise à jour du numéro de version du build Vue.js qui apparaît sur la page de connexion de Next.

Notes :
Ce script ne renomme pas les fichiers JS et CSS de la production en ajoutant la date de compilation.  
Ce travail est effectué par l'outil de développement Vite et son fichier de configuration `vite.config.js`.  
Voir la section `build->rollupOptions->output->chunkFileNames` du fichier `vite.config.js`.

## déploiement Nextbrowser

Script de contrôle et de mise à jour de Next et Nextbrowser.
Ce script fait 3 choses : 

1. Met à jour le fichier asset/manageExe/update/nextbrowser.zip 
2. Force la mise à jour de Next 
3. Affiche des informations avant/après telles que :
    - le numéro de commit
    - le paramètre NOVERNXTB 
    - la date de modification du fichier Nextbrowser.zip 

Notes :
Ce script fonctionne uniquement sur le serveur.
[Les étapes préalables](#déploiement-step1) doivent être vérifié. 
Au préalable, le fichier `https://pharmavitale.fr/docs/releases/latest/NextBrowser.zip` doit être vérifié. C'est lui qui
sera déployé. Il se trouve sur le ftp de cepi.

Utilisation depuis une console Powerhell :
    1. Télécharger le script : iwr https://pharmavitale.fr/docs/releases/script/deploiement_nextbrowser.ps1 -OutFile script.ps1 
    2. Lancer le script : .\script.ps1

## Déploiement Step1

Script pour préparer l'utilisation des autres script et notamment deploiement_nextbrowser.
Sur les serveurs déjà en place tout devrait fonctionner.
Sur un nouveau serveur, il faut impérativement :
    - avoir Winget d'installé
    - Exécuter Powershell avec droit Administrateur
    - Avoir l'autorisation d'exécuter des scripts : Set-ExecutionPolicy Unrestricted
    - installer Powershell via la commande : winget install --id Microsoft.Powershell --source winget

## 
# Readme - Les scripts PowerShell

Pour consulter la documentation d'un script PowerShell, vous pouvez soit :
1. Utiliser la commande PowerShell : `Get-Help .\script-name.ps1 -Detailed`
2. Consulter le fichier `script-name.ps1`

## build script

Script de génération des builds pour les projets écrits en Vue.js.  
Ce script ajoute quelques étapes à la compilation classique via Vite.  
Entre autres, il met en place des mécanismes pour gérer le cache des fichiers JS et CSS.  
On y retrouve également la mise à jour du numéro de version du build Vue.js qui apparaît sur la page de connexion de Next.

Notes :
Ce script ne renomme pas les fichiers JS et CSS de la production en ajoutant la date de compilation.  
Ce travail est effectué par l'outil de développement Vite et son fichier de configuration `vite.config.js`.  
Voir la section `build->rollupOptions->output->chunkFileNames` du fichier `vite.config.js`.

## déploiement Nextbrowser

Script de contrôle et de mise à jour de Next et Nextbrowser.
Ce script fait 3 choses :

1. Mets à jour le fichier asset/manageExe/update/nextbrowser.zip 
2. Force la mise à jour de Next 
3. Affiche des informations avant/après tel que :
    - le numéro de commit
    - le paramètre NOVERNXTB 
    - la date de modification du fichier Nextbrowser.zip 

Notes:
Ce script fonctionne uniquement sur le serveur.
[Les étapes préalables](#déploiement-step1) doivent être vérifié. 
Au préalable, le fichier `https://pharmavitale.fr/docs/releases/latest/NextBrowser.zip` doit être vérifié. C'est lui qui
sera déployé. Il se trouve sur le ftp de cepi.

Utilisation depuis une console Powerhell :

1. Télécharger le script : iwr https://pharmavitale.fr/docs/releases/script/deploiement_nextbrowser.ps1 -OutFile script.ps1 
2. Lancer le script : .\script.ps1

## déploiement step1

Script pour préparer l'utilisation des autres script et notamment deploiement_nextbrowser.
Sur les serveur déjà en place tout devrait fonctionner.
Sur un nouveau serveur, il faut impérativement :
 
    - avoir Winget d'installé
    - Exécuter Powershell avec droit Administrateur
    - Avoir l'autorisation d'éxécuter des scripts : Set-ExecutionPolicy Unrestricted
    - installer Powershell via la commande : winget install --id Microsoft.Powershell --source winget

## Install Next NextBrowser

Ce script est en cours de création. Il n'a pas été testé.
