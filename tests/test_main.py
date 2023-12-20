from httpx import AsyncClient
import pytest
from main import app

@pytest.mark.asyncio
async def test_add_store():
    async with AsyncClient(app=app, base_url="http://test") as ac:
        response = await ac.post("/stores/", json={"store_name": "test_store"})
    assert response.status_code == 200
    assert response.json()["store_name"] == "test_store"
