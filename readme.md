# Readme - Les scripts PowerShell

Pour consulter la documentation d'un script PowerShell, vous pouvez soit :

1. Utiliser la commande PowerShell : `Get-Help .\script-name.ps1 -Detailed`
2. Consulter directement le fichier `script-name.ps1`

## Build script.ps1

Script de génération des builds pour les projets écrits en Vue JS.

Ce script ajoute quelques étapes à la compilation classique via Vite.
Entre autres, il met en place des mécanismes pour gérer le cache des fichiers JS et CSS.
On y retrouve également la mise à jour du numéro de version du build Vue JS qui apparaît sur la page de connexion de Next.

**Notes** :
Ce script ne renomme pas les fichiers JS et CSS de la production en ajoutant la date de compilation.  
Ce travail est effectué par l'outil de développement Vite et son fichier de configuration `vite.config.js`.
Voir la section `build->rollupOptions->output->chunkFileNames` du fichier `vite.config.js`.

## Déploiement Nextbrowser.ps1 (Mise à jour de Next et Nextbrowser)

Script pour visualiser l'état et mettre à jour à la fois Next et Nextbrowser depuis un poste serveur.

Ce script fait 3 choses : 

1. Met à jour le fichier asset/manageExe/update/nextbrowser.zip
2. Force la mise à jour de Next
3. Affiche des informations avant/après telles que :
    - le numéro de commit
    - le paramètre NOVERNXTB 
    - la date de modification du fichier Nextbrowser.zip 

**Notes** :
Ce script fonctionne uniquement sur le serveur.
[Des étapes préalables](#déploiement-step1ps1) doivent être vérifiées. 
Au préalable, le fichier `https://pharmavitale.fr/docs/releases/latest/NextBrowser.zip` doit être vérifié.
C'est lui qui sera déployé. Il se trouve sur le ftp webmaster de CEPI.

Utilisation depuis une console Powershell :

1. Télécharger le script avec la commande Powershell Invoke-WebRequest (iwr) : 
iwr https://pharmavitale.fr/docs/releases/script/deploiement_nextbrowser.ps1 -OutFile depnext.ps1
2. Lancer le script : .\depnext.ps1

## Déploiement Step1.ps1

Script pour préparer l'utilisation des autres scripts et notamment deploiement_nextbrowser.ps1.
Sur les serveurs déjà en place tout devrait fonctionner.
Sur un nouveau serveur, il faut impérativement :

- Avoir Winget d'installé c'est mieux.
- Exécuter Powershell avec droit Administrateur
- Avoir l'autorisation d'exécuter des scripts : Set-ExecutionPolicy Unrestricted
- Installer Powershell via la commande : winget install --id Microsoft.Powershell --source winget 
    ou par le store de Microsoft


## Install Next NextBrowser.ps1

Ce script est en cours de création. Il n'a pas été testé.
