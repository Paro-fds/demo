# Application Python - "Bonjour mr. Villard"

Application web légère développée avec **Flask** et prête à être déployée sur une instance **Ubuntu** (Machine Virtuelle ou Conteneur LXC) hébergée sur **Proxmox VE**.

---

## 📁 Structure du projet

```text
├── app.py                  # Application Flask principale
├── templates/
│   └── index.html          # Page d'accueil moderne avec le message
├── requirements.txt        # Dépendances Python (Flask, Gunicorn)
├── Dockerfile              # Image Docker optimisée
├── docker-compose.yml      # Lancement rapide multi-conteneurs / Docker
├── villard-app.service     # Service systemd pour démarrage automatique natif
└── README.md               # Guide complet de déploiement
```

---

## 🧪 1. Tester en local (optionnel)

Sous Windows / PowerShell :
```powershell
python -m venv venv
.\venv\Scripts\activate
pip install -r requirements.txt
python app.py
```
Accédez à l'URL : `http://localhost:5000`

---

## 🚀 2. Déploiement sur votre instance Ubuntu (Proxmox)

Copiez le dossier de votre projet vers votre VM/CT Ubuntu via `scp` ou `rsync` :
```bash
scp -r "c:\Users\LENOVO\OneDrive\Desktop\New folder" user@<IP_UBUNTU>:/opt/villard-app
```

---

### Option A : Déploiement avec Docker (Recommandé)

1. **Installer Docker & Compose sur Ubuntu (si pas encore installé) :**
   ```bash
   sudo apt update
   sudo apt install -y docker.io docker-compose-v2
   sudo usermod -aG docker $USER
   ```

2. **Démarrer l'application :**
   ```bash
   cd /opt/villard-app
   docker compose up -d --build
   ```

3. **Vérification :**
   ```bash
   docker ps
   ```

---

### Option B : Déploiement Natif (Systemd + Gunicorn)

1. **Installer Python et les outils sur Ubuntu :**
   ```bash
   sudo apt update
   sudo apt install -y python3 python3-pip python3-venv
   ```

2. **Créer l'environnement virtuel et installer les dépendances :**
   ```bash
   cd /opt/villard-app
   python3 -m venv venv
   ./venv/bin/pip install -r requirements.txt
   ```

3. **Activer le service Systemd :**
   ```bash
   sudo cp villard-app.service /etc/systemd/system/
   sudo systemctl daemon-reload
   sudo systemctl enable --now villard-app
   sudo systemctl status villard-app
   ```

---

## 🌐 3. Accès à l'application

Ouvrez votre navigateur et entrez l'adresse IP de votre instance Ubuntu sur Proxmox :
```text
http://<IP_DE_VOTRE_INSTANCE_UBUNTU>:5000
```
Le message élégant **"Bonjour mr. Villard"** s'affichera directement.
