@echo off
chcp 65001
:menu_principal
cls
    echo Que voulez-vous faire ?
    echo [1] Telecharger
    echo [2] Outil video
    echo [Q] Quitter le programme
    echo [D] Telecharge ffmpeg et yt-dlp et ajout dans PATH
    set /p choix="Votre choix : "
        if "%choix%"=="1" goto telecharger_video
        if "%choix%"=="2" goto outil_video
        if "%choix%"=="q" goto fin
        if "%choix%"=="d" goto install
        goto menu_principal
:telecharger_video
cls
    echo Que voulez-vous faire ?
    echo [1] Telecharger video
    echo [2] Telecharger audio
    echo [3] Telecharger avec compte
    echo [4] Telecharger un live depuis le debut
    echo [Q] Quitter le programme
    set /p choix="Votre choix : "
        if "%choix%"=="1" goto telecharger_video
        if "%choix%"=="2" goto telecharger_audio
        if "%choix%"=="3" goto telecharger_compte
        if "%choix%"=="4" goto telecharger_live

        if "%choix%"=="q" goto fin
        goto telecharger_video

:telecharger_video
    set /p "input=Video a telecharger : "
        yt-dlp -f bestvideo[ext=mp4]+bestaudio[ext=m4a]/best[ext=mp4]/best "%input%"
    pause
goto menu_principal

:telecharger_audio
    set /p "input=Audio a telecharger : "
        yt-dlp -x --audio-format mp3 "%input%"
    pause
goto menu_principal

:telecharger_compte
    set /p "input=Fichier a telecharger : "
    set /p "name=Nom du fichier : "
    set /p "user=Nom d'utilisateur : "
    set /p "pass=Mot de passe : "
        yt-dlp -o "%name%.%%(ext)s" -f mp4 -u "%user%" -p "%pass%" "%input%"
    pause
goto menu_principal

:telecharger_live
    set /p "input=Lien du live : "
        yt-dlp -o "%(title)s.%(ext)s" -ciw --no-part --hls-use-mpegts --live-from-start "%input%"
    pause
goto menu_principal

:outil_video
cls
    echo Que voulez-vous faire ?
    echo [1] Couper une vidéo
    echo [2] Compresser une vidéo
    echo [3] Couper et compresser une vidéo
    echo [4] Extraire l'audio et la vidéo d'une vidéo
    echo [5] Convertir une vidéo
    echo [6] Ajouter un filigrane
    echo [7] Convertir une vidéo en GIF
    echo [8] Convertir une vidéo en MP3
    echo [9] Fusionner deux pistes audio
    echo [Q] Quitter le programme
    set /p choix="Votre choix : "
        if "%choix%"=="1" goto couper_video
        if "%choix%"=="2" goto compresser_video
        if "%choix%"=="3" goto couper_et_compresser_video
        if "%choix%"=="4" goto extraire_audio_video
        if "%choix%"=="5" goto convertir_video
        if "%choix%"=="6" goto ajouter_filigrane
        if "%choix%"=="7" goto convertir_video_gif
        if "%choix%"=="8" goto convertir_video_mp3
        if "%choix%"=="9" goto merge_audio

        if "%choix%"=="q" goto fin
        goto menu_principal

:couper_video
    set /p "input=Entrez le nom de la vidéo d'entrée : "
    set /p "output=Entrez le nom de la vidéo de sortie : "
    set /p "start=Entrez le temps de début (en secondes ou en format hh:mm:ss) : "
    set /p "end=Entrez le temps de fin (en secondes ou en format hh:mm:ss) : "
    set "input=%input:"=%"
    set "output=%output:"=%"
        ffmpeg -i "%input%" -ss %start% -to %end% -c copy "%output%"
    echo La vidéo a été coupée avec succès.
pause
goto menu_principal

:compresser_video
    set /p "input=Entrez le nom de la vidéo d'entrée : "
    set /p "output=Entrez le nom de la vidéo de sortie : "
    set "input=%input:"=%"
    set "output=%output:"=%"
        ffmpeg -i "%input%" -c:v libx264 -preset slower -crf 28 -c:a aac -b:a 128k "%output%"
    echo La vidéo a été compressée avec succès.
pause
goto menu_principal

:couper_et_compresser_video
    set /p "input=Entrez le nom de la vidéo d'entrée : "
    set /p "output=Entrez le nom de la vidéo de sortie : "
    set /p "start=Entrez le temps de début (en secondes ou en format hh:mm:ss) : "
    set /p "end=Entrez le temps de fin (en secondes ou en format hh:mm:ss) : "
    set "input=%input:"=%"
    set "output=%output:"=%"
        ffmpeg -i "%input%" -ss %start% -to %end% -c:v libx264 -preset medium -crf 23 -c:a aac -b:a 128k "%output%"
    echo La vidéo a été coupée et compressée avec succès.
pause
goto menu_principal

:extraire_audio_video
    set /p "input=Entrez le nom de la vidéo d'entrée : "
    set /p "output_audio=Entrez le nom de la sortie audio : "
    set /p "output_video=Entrez le nom de la sortie vidéo : "
    set "input=%input:"=%"
    set "output_audio=%output_audio:"=%"
    set "output_video=%output_video:"=%"
        ffmpeg -i "%input%" -vn -acodec libmp3lame -q:a 4 "%output_audio%"
        ffmpeg -i "%input%" -an -vcodec copy "%output_video%"
    echo L'audio et la vidéo ont été extraits avec succès.
pause
goto menu_principal

:convertir_video
    set /p "input=Entrez le nom de la vidéo d'entrée : "
    set /p "output=Entrez le nom de la vidéo de sortie : "
    set /p "format=Entrez le format de sortie (ex: mp4, avi, mov) : "
    set "input=%input:"=%"
    set "output=%output:"=%"
        ffmpeg -i "%input%" -c:v libx264 -preset medium -crf 23 -c:a aac -b:a 128k "%output%.%format%"
    echo La vidéo a été convertie avec succès.
pause
goto menu_principal

:ajouter_filigrane
    set /p "input=Entrez le nom de la vidéo d'entrée : "
    set /p "output=Entrez le nom de la vidéo de sortie : "
    set /p "watermark=Entrez le nom du fichier de filigrane : "
    set /p "interval=Entrez l'intervalle de temps (en secondes) entre chaque changement de position : "
    set "input=%input:"=%"
    set "output=%output:"=%"
    set "watermark=%watermark:"=%"
        ffmpeg -i "%input%" -i "%watermark%" -filter_complex "[0:v][1:v]overlay=x='if(lt(mod(t\,%interval%),%interval%/2),80,W-w-80)':y='if(lt(mod(t\,%interval%),%interval%/2),80,H-h-80)'" -codec:a copy "%output%"
    echo La vidéo a été traitée avec succès.
pause
goto menu_principal

:convertir_video_gif
    set /p "input=Entrez le nom de la vidéo d'entrée : "
    set /p "output=Entrez le nom de la vidéo de sortie : "
    set "input=%input:"=%"
    set "output=%output:"=%"
        ffmpeg -i "%input%" -vf "fps=24,scale=320:-1:flags=lanczos" -c:v gif "%output%.gif"
    echo La vidéo a été convertie en gif avec succès.
pause
goto menu_principal

:convertir_video_mp3
    set /p "input=Entrez le nom de la vidéo d'entrée : "
    set /p "output=Entrez le nom du fichier audio de sortie : "
        ffmpeg -i "%input%" -vn -acodec mp3 "%output%.mp3"
    echo La conversion en MP3 a été effectuée avec succès.
pause
goto menu_principal

:merge_audio
    set /p "audio1=Audio 1 : "
    set /p "audio2=Audio 2 : "
    set /p "output=Nom du fichier final : "
        ffmpeg -i "%audio1%" -i "%audio2%" -filter_complex "[0:a][1:a]amerge=inputs=2[aout]" -map "[aout]" -c:v copy "%output%"
    echo La conversion en MP3 a été effectuée avec succès.
pause
goto menu_principal

:fin
    echo Au revoir !
pause
exit

:install
cls
echo Installation de FFmpeg et yt-dlp dans le chemin d'environnement (PATH)...

rem Déterminez le chemin vers le répertoire %appdata%
set "appdataDir=%appdata%\VideoMaster"

rem Créez le répertoire %appdataDir% s'il n'existe pas déjà
if not exist "%appdataDir%" mkdir "%appdataDir%"

rem Téléchargement de FFmpeg
curl -LO https://ffmpeg.org/releases/ffmpeg-latest-win64.zip

rem Téléchargement de yt-dlp
curl -LO https://github.com/yt-dlp/yt-dlp/releases/latest/download/yt-dlp.exe

rem Déplacement de FFmpeg et yt-dlp dans %appdataDir%
move ffmpeg-latest-win64.zip "%appdataDir%"
move yt-dlp.exe "%appdataDir%"

rem Extraction des fichiers FFmpeg dans %appdataDir%
cd /d "%appdataDir%"
tar -xf ffmpeg-latest-win64.zip

rem Ajout du chemin d'environnement (PATH) pour %appdataDir%
set "newPath=%appdataDir%;%PATH%"
setx PATH "%newPath%"

echo Installation terminée. Veuillez redémarrer votre invite de commande pour appliquer les modifications au PATH.
pause
goto menu_principal
