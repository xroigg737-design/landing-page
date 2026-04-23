#!/bin/bash
# Deploy landing page a AWS (i-xr.duckdns.org)

SSH_KEY="~/AWS/claus/la-meva-clau-ubuntu.pem"
REMOTE="ubuntu@13.63.16.49"
REMOTE_DIR="/var/www/html/"

echo "Desplegant landing page a producció..."

# Copiar index.html al root del servidor
rsync -avz \
  -e "ssh -i $SSH_KEY" \
  index.html \
  "$REMOTE:$REMOTE_DIR"

# Copiar assets (favicon, icones, manifest)
rsync -avz --exclude='.git' --exclude='deploy.sh' --exclude='README.md' --exclude='index.html' \
  -e "ssh -i $SSH_KEY" \
  ./ \
  "$REMOTE:$REMOTE_DIR"

echo "Deploy completat! → https://i-xr.duckdns.org/"
