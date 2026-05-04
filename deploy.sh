#!/bin/bash
# Deploy landing page a AWS (i-xr.duckdns.org)

SSH_KEY="~/AWS/claus/la-meva-clau-ubuntu.pem"
REMOTE="ubuntu@13.63.16.49"
REMOTE_DIR="/var/www/html/"
VERSION=$(cat VERSION 2>/dev/null || echo "?")

echo "Desplegant landing page v${VERSION} a producció..."

# Copiar index.html al root del servidor
rsync -avz \
  -e "ssh -i $SSH_KEY" \
  index.html \
  "$REMOTE:$REMOTE_DIR"

# Copiar assets (favicon, icones, manifest)
rsync -avz --exclude='.git' --exclude='deploy.sh' --exclude='README.md' --exclude='index.html' --exclude='VERSION' \
  -e "ssh -i $SSH_KEY" \
  ./ \
  "$REMOTE:$REMOTE_DIR"

echo "Deploy v${VERSION} completat! → https://i-xr.duckdns.org/"
