# Script Batch pour la Gestion de Vidéos

Ce script batch permet de simplifier diverses tâches liées à la gestion de vidéos, notamment le téléchargement depuis un grand nombre de sites et la manipulation de fichiers vidéo à l'aide de FFmpeg.

## Configuration Requise

- Windows
- FFmpeg (doit être installé et configuré dans le PATH)
- yt-dlp (doit être installé et configuré dans le PATH)

## Utilisation

1. Exécutez le script en double-cliquant dessus.

2. Vous serez accueilli par un menu principal avec les options suivantes :
   - [1] Télécharger
   - [2] Outil vidéo
   - [Q] Quitter le programme

3. Choisissez l'option en entrant le numéro correspondant ou en appuyant sur "Q" pour quitter le programme.

### Option 1 : Télécharger

L'option "Télécharger" vous permet de télécharger des vidéos depuis un large panel de site. Vous aurez les sous-options suivantes :
   - [1] Télécharger une vidéo
   - [2] Télécharger uniquement l'audio
   - [3] Télécharger avec un compte
   - [Liste des sites pris en charge](https://github.com/yt-dlp/yt-dlp/blob/master/supportedsites.md)

Suivez les instructions pour télécharger les vidéos.

### Option 2 : Outil vidéo

L'option "Outil vidéo" vous permet de manipuler des vidéos à l'aide de FFmpeg. Vous aurez les sous-options suivantes :
   - [1] Couper une vidéo
   - [2] Compresser une vidéo
   - [3] Couper et compresser une vidéo
   - [4] Extraire l'audio et la vidéo d'une vidéo
   - [5] Convertir une vidéo
   - [6] Ajouter un filigrane
   - [7] Convertir une vidéo en GIF
   - [8] Convertir une vidéo en MP3
   - [9] Fusionner deux pistes audio

Suivez les instructions pour effectuer les opérations vidéo souhaitées.

## Notes

- Assurez-vous d'avoir installé FFmpeg et yt-dlp et de les avoir configurés dans votre PATH système.

## Avertissement

Ce script est destiné à un usage personnel et non commercial. Veuillez respecter les droits d'auteur et les conditions d'utilisation lors du téléchargement et de l'utilisation de vidéos depuis Internet.

## Application Electron

Une version expérimentale de VideoMaster est disponible dans le dossier `electron-app`. Cette application utilise Electron pour fournir une interface graphique simple.

### Prérequis
- Node.js
- FFmpeg et yt-dlp disponibles dans le PATH

### Lancer l'application
```bash
cd electron-app
npm install
npm start
```

Cela ouvrira une fenêtre permettant d'exécuter quelques fonctionnalités de base :
- Téléchargement de vidéo ou d'audio
- Conversion d'une vidéo en MP3
- Découpage d'une vidéo

