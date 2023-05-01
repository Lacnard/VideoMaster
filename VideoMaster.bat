@echo off
chcp 65001
:menu_principal
cls
echo Que voulez-vous faire ?
echo [1] Couper une vidéo
echo [2] Compresser une vidéo
echo [3] Couper et compresser une vidéo
echo [4] Extraire l'audio et la vidéo d'une vidéo
echo [5] Convertir une vidéo
echo [6] Ajouter un filigrane
echo [Q] Quitter le programme
set /p choix="Votre choix : "

if "%choix%"=="1" goto couper_video
if "%choix%"=="2" goto compresser_video
if "%choix%"=="3" goto couper_et_compresser_video
if "%choix%"=="4" goto extraire_audio_video
if "%choix%"=="5" goto convertir_video
if "%choix%"=="6" goto ajouter_filigrane


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
ffmpeg -i "%input%" -c:v libx264 -preset medium -crf 23 -c:a aac -b:a 128k "%output%"
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




:fin
echo Au revoir !
pause
exit
