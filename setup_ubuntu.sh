#!/usr/bin/env bash
set -e

echo "=========================================================="
echo "  Configuration Automatique - Bonjour mr. Villard"
echo "=========================================================="

# Détecte automatiquement le dossier actuel
APP_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CURRENT_USER="$(whoami)"

echo "📁 Dossier de l'application : $APP_DIR"
echo "👤 Utilisateur système      : $CURRENT_USER"

# 1. Installation des paquets nécessaires
echo -e "\n[1/4] Installation des paquets système (Python, venv, pip)..."
sudo apt update -y
sudo apt install -y python3 python3-venv python3-pip

# 2. Création de l'environnement virtuel et installation
echo -e "\n[2/4] Configuration de l'environnement virtuel Python..."
cd "$APP_DIR"
python3 -m venv venv
./venv/bin/pip install --upgrade pip
./venv/bin/pip install -r requirements.txt

# 3. Création automatique du service systemd
echo -e "\n[3/4] Création du service de démarrage automatique..."
sudo tee /etc/systemd/system/villard-app.service > /dev/null <<EOF
[Unit]
Description=Application Flask Bonjour mr. Villard
After=network.target

[Service]
User=$CURRENT_USER
WorkingDirectory=$APP_DIR
ExecStart=$APP_DIR/venv/bin/gunicorn --workers 2 --bind 0.0.0.0:5000 app:app
Restart=always

[Install]
WantedBy=multi-user.target
EOF

# 4. Activation et démarrage
echo -e "\n[4/4] Démarrage du service villard-app..."
sudo systemctl daemon-reload
sudo systemctl enable --now villard-app

echo "=========================================================="
echo "✔ TERMINÉ AVEC SUCCÈS !"
echo "=========================================================="
IP_ADDR=$(hostname -I 2>/dev/null | awk '{print $1}')
echo "L'application tourne en arrière-plan."
echo "Accès : http://${IP_ADDR:-<IP_UBUNTU>}:5000"
echo "Vérifier le statut : sudo systemctl status villard-app"
