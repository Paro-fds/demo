import pytest
from app import app

@pytest.fixture
def client():
    app.config["TESTING"] = True
    with app.test_client() as client:
        yield client

def test_homepage_status_code(client):
    """Vérifie que la page d'accueil répond avec un code HTTP 200."""
    response = client.get("/")
    assert response.status_code == 200

def test_homepage_greeting_content(client):
    """Vérifie que le message spécifique 'Bonjour mr. Villard' est bien présent dans la réponse."""
    response = client.get("/")
    assert "Bonjour mr. Villard" in response.get_data(as_text=True)

def test_invalid_route_404(client):
    """Vérifie le traitement d'une route inconnue."""
    response = client.get("/route-inexistante")
    assert response.status_code == 404
