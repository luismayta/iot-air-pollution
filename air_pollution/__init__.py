# -*- coding: utf-8 -*-
from AWSIoTPythonSDK.MQTTLib import AWSIoTMQTTClient
import json
import time

# Custom MQTT message callback
def on_message(client, data, message):
    print("Received a new message: ")
    print(message.payload)
    print("from topic: ")
    print(message.topic)
    print("--------------\n\n")


# Parameters
host = "amzoprft33wg6-ats.iot.us-east-1.amazonaws.com"
root_ca_path = "/keybase/private/luismayta/csr/terraform-iot-air-pollution-prod-root-certificate.pem.crt"
certificate_path = (
    "/keybase/private/luismayta/csr/terraform-iot-air-pollution-prod.pem.crt"
)
private_key_path = (
    "/keybase/private/luismayta/csr/terraform-iot-air-pollution-prod.private.key"
)

client_id = "air-pollution"
topic = "thing"
location = "home"

# Init AWSIoTMQTTClient
mqttclient = None
mqttclient = AWSIoTMQTTClient(client_id)
mqttclient.configureEndpoint(host, 8883)
mqttclient.configureCredentials(root_ca_path, private_key_path, certificate_path)

mqttclient.configureAutoReconnectBackoffTime(1, 32, 20)
mqttclient.configureOfflinePublishQueueing(-1)  # Infinite offline Publish queueing
mqttclient.configureDrainingFrequency(2)  # Draining: 2 Hz
mqttclient.configureConnectDisconnectTimeout(10)  # 10 sec
mqttclient.configureMQTTOperationTimeout(5)  # 5 sec

# Built message
message_template = {
    "device": client_id,
    "location": location,
    "mq2": 30,
    "mq5": 30,
    "mq7": 30,
    "mq135": 30,
    "dht22": 30,
}

message_json = json.dumps(message_template)

mqttclient.connect()

while True:
    mqttclient.publish(topic, message_json, 1)
    print("Published topic %s: %s\n" % (topic, message_json))
    time.sleep(1)
