from fastapi import FastAPI, HTTPException
import os
import psycopg2
from psycopg2.extras import RealDictCursor
from pydantic import BaseModel

app = FastAPI()

# Read environment variables
MODE = os.getenv('MODE', 'dev')
LOG_LEVEL = os.getenv('LOG_LEVEL', 'info')

# Database connection parameters
DB_HOST = os.getenv('DB_HOST', 'localhost')
DB_PORT = os.getenv('DB_PORT', '5432')
DB_NAME = os.getenv('POSTGRES_DB', 'demo')
DB_USER = os.getenv('POSTGRES_USER', 'demouser')
DB_PASSWORD = os.getenv('POSTGRES_PASSWORD', 'password')

# Pydantic model for store item
class StoreItem(BaseModel):
    store_name: str

# Print MODE on startup if LOG_LEVEL is debug
if LOG_LEVEL == 'debug':
    print(f"Application running in {MODE} mode.")

# Database connection function
def get_db_connection():
    conn = psycopg2.connect(
        host=DB_HOST,
        database=DB_NAME,
        user=DB_USER,
        password=DB_PASSWORD,
        cursor_factory=RealDictCursor
    )
    return conn

@app.post("/stores/")
def add_store(store_item: StoreItem):
    conn = get_db_connection()
    cursor = conn.cursor()
    try:
        cursor.execute("INSERT INTO store (name) VALUES (%s) RETURNING id;", (store_item.store_name,))
        store_id = cursor.fetchone()['id']
        conn.commit()
    except Exception as e:
        conn.rollback()
        raise HTTPException(status_code=500, detail=str(e))
    finally:
        cursor.close()
        conn.close()

    return {"store_id": store_id, "store_name": store_item.store_name}
