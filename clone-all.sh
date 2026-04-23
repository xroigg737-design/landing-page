#!/bin/bash
# Clonar totes les apps de la landing page XRoig
# Executar des del HOME: bash clone-all.sh

GITHUB="https://github.com/xroigg737-design"
DIR="$HOME"

echo "=== Clonant totes les apps de la landing page ==="

# Llista de repos a clonar
REPOS=(
    landing-page
    webcams-cns
    cataleg-concerts
    chess
    chess-openings
    concert-10e-aniversari
    entrenador-partitures
    manuals
    meteo-previ
    partitura
    piano-chords
    repertori
    text2audio
    videomind
    webdl
)

for repo in "${REPOS[@]}"; do
    if [ -d "$DIR/$repo" ]; then
        echo "[$repo] Ja existeix, actualitzant..."
        cd "$DIR/$repo" && git pull
    else
        echo "[$repo] Clonant..."
        git clone "$GITHUB/$repo.git" "$DIR/$repo"
    fi
done

# Symlink avui-regu -> webcams-cns (la landing page referencia avui-regu/)
if [ ! -e "$DIR/avui-regu" ]; then
    echo "[avui-regu] Creant symlink -> webcams-cns"
    ln -s "$DIR/webcams-cns" "$DIR/avui-regu"
fi

echo ""
echo "=== Tot clonat! ==="
echo "Ara pots accedir a http://localhost:8080/"
