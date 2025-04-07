from motor.motor_asyncio import AsyncIOMotorClient
from app.core.config import settings

async def get_mongodb_client():
    client = AsyncIOMotorClient(settings.MONGODB_URL)
    try:
        yield client
    finally:
        client.close()