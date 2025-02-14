from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
from pydantic import BaseModel
import boto3
import json
from datetime import datetime, timezone
import os

# Define a model for the request body
class Alert(BaseModel):
    event: str

app = FastAPI()

# Configure CORS middleware
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],  # Adjust this in production to specific origins
    allow_credentials=True,
    allow_methods=["*"],  # Allows all HTTP methods (OPTIONS, GET, POST, etc.)
    allow_headers=["*"],
)

AWS_REGION = os.getenv("AWS_REGION", "us-east-1")
SNS_TOPIC_ARN = os.getenv("SNS_TOPIC_ARN", "arn:aws:sns:us-east-1:922890021564:weather-alerts")

sns = boto3.client(
    "sns",
    region_name=AWS_REGION,
    endpoint_url=os.getenv("AWS_ENDPOINT", "http://127.0.0.1:4566")
)

@app.post("/alert")
async def send_alert(alert: Alert):
    message = {
        "event": alert.event,
        "timestamp": str(datetime.now(timezone.utc))
    }
    sns.publish(
        TopicArn=SNS_TOPIC_ARN,
        Message=json.dumps(message)
    )
    data = {
        "status": "Alert sent!",
        "message": message
    }
    return data
