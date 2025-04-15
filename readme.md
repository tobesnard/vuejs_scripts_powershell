# Readme - Les scripts PowerShell

Pour consulter la documentation d'un script PowerShell, vous pouvez soit :
1. Utiliser la commande PowerShell : `Get-Help .\script-name.ps1 -Detailed`
2. Consulter le fichier `script-name.ps1`

## build-script.ps1

Script de génération des builds pour les projets écrits en Vue.js.  
Ce script ajoute quelques étapes à la compilation classique via Vite.  
Entre autres, il met en place des mécanismes pour gérer le cache des fichiers JS et CSS.  
On y retrouve également la mise à jour du numéro de version du build Vue.js qui apparaît sur la page de connexion de Next.

Notes :
Ce script ne renomme pas les fichiers JS et CSS de la production en ajoutant la date de compilation.  
Ce travail est effectué par l'outil de développement Vite et son fichier de configuration `vite.config.js`.  
Voir la section `build->rollupOptions->output->chunkFileNames` du fichier `vite.config.js`.
