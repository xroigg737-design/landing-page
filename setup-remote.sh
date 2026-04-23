#!/bin/bash
# Setup landing page a una estació remota amb Ubuntu WSL2
# Executar: curl -sL https://raw.githubusercontent.com/xroigg737-design/landing-page/main/setup-remote.sh | bash

echo "=== Setup Landing Page XRoig ==="

# 1. Clonar el repo si no existeix
if [ ! -d ~/landing-page ]; then
    echo "Clonant repo..."
    git clone https://github.com/xroigg737-design/landing-page.git ~/landing-page
else
    echo "Repo ja existeix, actualitzant..."
    cd ~/landing-page && git pull
fi

# 2. Crear el servei systemd
echo "Creant servei web..."
sudo tee /etc/systemd/system/xroig-web.service << 'EOF'
[Unit]
Description=XRoig Apps Web Server
After=network.target

[Service]
Type=simple
User=xroig
WorkingDirectory=/home/xroig/landing-page
ExecStart=/usr/bin/python3 -m http.server 8080
Restart=always
RestartSec=3

[Install]
WantedBy=multi-user.target
EOF

# 3. Activar i arrencar
echo "Activant servei..."
sudo systemctl daemon-reload
sudo systemctl enable --now xroig-web.service

# 4. Verificar
echo ""
echo "=== Estat del servei ==="
systemctl status xroig-web.service --no-pager

echo ""
echo "Obre http://localhost:8080/ al navegador"
echo "=== Setup completat! ==="
