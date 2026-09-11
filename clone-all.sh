#!/bin/bash
# Clonar totes les apps de la landing page XRoig i deixar-les servides a localhost:8080
# Executar des de qualsevol lloc: bash ~/landing-page/clone-all.sh

GITHUB="https://github.com/xroigg737-design"
DIR="$HOME"
LANDING="$HOME/landing-page"

echo "=== Clonant totes les apps de la landing page ==="

# Repos amb contingut estàtic que la landing page enllaça per path relatiu
REPOS=(
    landing-page
    webcams-cns
    cataleg-concerts
    cerca-vivenda
    chess
    chess-openings
    concert-10e-aniversari
    cuinetas
    digitacio
    entrenador-partitures
    manuals
    menorca-nautica
    meteo-previ
    musicaolerdola
    partitura
    piano-chords
    piano-search
    piano-teacher
    quina-dificultat
    repertori
    rituals-palau
    text2audio
    videomind
    webdl
)

for repo in "${REPOS[@]}"; do
    if [ -d "$DIR/$repo" ]; then
        echo "[$repo] Ja existeix, actualitzant..."
        git -C "$DIR/$repo" pull --quiet
    else
        echo "[$repo] Clonant..."
        git clone --quiet "$GITHUB/$repo.git" "$DIR/$repo"
    fi
done

# El servidor local (python3 -m http.server 8080) serveix des de ~/landing-page,
# així que cada app necessita un symlink dins d'aquesta carpeta (estan al .gitignore).
# Nom del symlink -> carpeta real a ~/
declare -A LINKS=(
    [avui-regu]=webcams-cns
    [cerca-vivenda]=cerca-vivenda
    [chess]=chess
    [chess-openings]=chess-openings
    [concert-10e-aniversari]=concert-10e-aniversari
    [cuinetas]=cuinetas
    [digitacio]=digitacio
    [entrenador-partitures]=entrenador-partitures
    [manuals]=manuals
    [menorca-nautica]=menorca-nautica
    [musicaolerdola]=musicaolerdola
    [piano-search]=piano-search
    [piano-teacher]=piano-teacher
    [rituals-palau]=rituals-palau
    [webdl]=webdl
)

echo ""
echo "=== Creant symlinks dins de $LANDING ==="
for link in "${!LINKS[@]}"; do
    target="${LINKS[$link]}"
    if [ -d "$DIR/$target" ]; then
        ln -sfn "../$target" "$LANDING/$link"
        echo "[$link] -> ../$target"
    else
        echo "[$link] AVÍS: falta $DIR/$target"
    fi
done

echo ""
echo "=== Tot clonat! ==="
echo "Servidor local:  cd ~/landing-page && python3 -m http.server 8080"
echo "Ara pots accedir a http://localhost:8080/"
echo "(Les apps Flask —acords 5070, partitura 5050, repertori 5075,"
echo " quina-dificultat 5004, text2audio 5065— s'engeguen a part.)"
