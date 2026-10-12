# Application Python - "Bonjour mr. Villard" & Pipeline CI/CD Proxmox

Application web Python/Flask prête pour la production avec simulation complète de **Pipeline CI/CD** vers une instance **Ubuntu** hébergée sur **Proxmox VE**.

---

## 📁 Structure du projet

```text
├── .github/
│   └── workflows/
│       └── ci-cd.yml           # Workflow officiel GitHub Actions (CI & CD)
├── app.py                      # Application Flask principale
├── test_app.py                 # Tests unitaires automatisés (Pytest)
├── simulate_pipeline.py        # Simulateur interactif de pipeline CI/CD
├── templates/
│   └── index.html              # Interface utilisateur ("Bonjour mr. Villard")
├── requirements.txt            # Dépendances Python (Flask, Gunicorn, Pytest)
├── Dockerfile                  # Image Docker optimisée
├── docker-compose.yml          # Déploiement conteneurisé
├── villard-app.service         # Service systemd pour Ubuntu natif
└── README.md                   # Documentation complète
```

---

## ⚡ 1. Lancer la Simulation du Pipeline CI/CD

Un script de simulation est inclus pour tester toutes les étapes (CI & CD) directement :

```bash
python simulate_pipeline.py
```

### Ce que fait la simulation :
1. **Étape 1 (CI - Linting)** : Analyse syntaxique de `app.py` et des tests.
2. **Étape 2 (CI - Tests)** : Exécute les tests unitaires réels (code 200, présence du message "Bonjour mr. Villard", gestion des 404).
3. **Étape 3 (CI - Docker)** : Valide le Dockerfile et la configuration de build.
4. **Étape 4 (CD - SSH/Sync)** : Simule la connexion SSH et la synchronisation vers l'instance Ubuntu sur Proxmox.
5. **Étape 5 (CD - Déploiement)** : Simule le lancement du conteneur en arrière-plan.
6. **Étape 6 (CD - Smoke test)** : Vérifie la disponibilité et le bon affichage de l'application.

---

## 🔄 2. Pipeline Réel (GitHub Actions)

Le fichier [.github/workflows/ci-cd.yml](file:///.github/workflows/ci-cd.yml) automatise l'ensemble du cycle lors de chaque push :

- **Job CI (Tests & Build)** :
  - Installation automatique des dépendances.
  - Exécution des tests via `pytest test_app.py`.
  - Construction de l'image Docker.

- **Job CD (Déploiement sur Proxmox)** :
  - Connexion SSH sécurisée vers la VM/LXC Ubuntu.
  - Synchronisation des fichiers avec `rsync`.
  - Redémarrage sans coupure du conteneur avec `docker compose up -d --build`.
  - Smoke test automatisé via `curl`.

### Secrets GitHub à configurer (pour déploiement réel) :
Dans les paramètres de votre dépôt GitHub (*Settings > Secrets and variables > Actions*) :
- `PROXMOX_HOST` : Adresse IP de l'instance Ubuntu.
- `PROXMOX_USER` : Nom d'utilisateur SSH (ex: `ubuntu`).
- `PROXMOX_SSH_KEY` : Clé privée SSH pour la connexion sans mot de passe.

---

## 🌐 3. Accès à l'application déployée

Une fois déployée, l'application est accessible sur :
```text
http://<IP_UBUNTU_PROXMOX>:5000/
```
