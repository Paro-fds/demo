from flask import Flask, render_template

app = Flask(__name__)

@app.route("/")
def home():
    return render_template("index.html", message="Bonjour mr. Villard")

if __name__ == "__main__":
    # Écoute sur 0.0.0.0 pour être accessible depuis le réseau local / Proxmox
    app.run(host="0.0.0.0", port=5000, debug=True)
