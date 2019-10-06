# -*- coding: utf-8 -*-
import os
from AWSIoTPythonSDK.MQTTLib import AWSIoTMQTTClient
import json
import time
from config import configs

stage = configs[os.environ.get("STAGE")]

# Parameters
host = stage.HOST
root_ca_path = stage.ROOT_CA_PATH
certificate_path = stage.CERTIFICATE_PATH
private_key_path = stage.PRIVATE_KEY_PATH
client_id = "air-pollution"
topic = "thing"
location = "home"

# Custom MQTT message callback
def on_message(client: AWSIoTMQTTClient, data: dict, message) -> None:
    print("Received a new message: ")
    print(message.payload)
    print("from topic: ")
    print(message.topic)
    print("--------------\n\n")


def get_mqtt_client() -> AWSIoTMQTTClient:
    """Connect to Mqtt"""
    mqtt_client = None
    mqtt_client = AWSIoTMQTTClient(client_id)
    mqtt_client.configureEndpoint(host, 8883)
    mqtt_client.configureCredentials(root_ca_path, private_key_path, certificate_path)
    mqtt_client.configureAutoReconnectBackoffTime(1, 32, 20)
    mqtt_client.configureOfflinePublishQueueing(-1)  # Infinite offline Publish queueing
    mqtt_client.configureDrainingFrequency(2)  # Draining: 2 Hz
    mqtt_client.configureConnectDisconnectTimeout(10)  # 10 sec
    mqtt_client.configureMQTTOperationTimeout(5)  # 5 sec
    mqtt_client.connect()
    return mqtt_client


def send_message(client: AWSIoTMQTTClient, data: dict) -> None:
    message_json = json.dumps(data)
    client.publish(topic, message_json, 1)


if __name__ == "__main__":
    """Execute send payload."""
    mqtt_client = get_mqtt_client()
    while True:
        # Built message
        message = {
            "device": client_id,
            "location": location,
            "mq2": 30,
            "mq5": 30,
            "mq7": 30,
            "mq135": 30,
            "dht22": {"temperature": 10, "humidity": 10},
        }
        send_message(client=mqtt_client, data=message)
        print("Published topic %s: %s\n" % (topic, message))
        time.sleep(1)
