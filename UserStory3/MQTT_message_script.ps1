# Importieren des MQTT-Client-Moduls
Import-Module PSMQTT

# Definieren der Verbindungsinformationen für Ihre Azure IoT-Hub-Ressource
$iotHubHostName = "SuperDuperIoTHub3"
$deviceId = "<YOUR_DEVICE_ID>"
$username = "$iotHubHostName/$deviceId/?api-version=2018-06-30"
$password = "<YOUR_IOTHUB_SHARED_ACCESS_KEY>"

# Definieren der MQTT-Nachricht
$topic = "devices/$deviceId/messages/events/"
$message = "Hello from PowerShell MQTT!"

# Verbindung zum MQTT-Broker herstellen
$mqttClient = Connect-MqttBroker -ClientId $deviceId -Server $iotHubHostName -Port 8883 -Username $username -Password $password -UseSSL

# Nachricht veröffentlichen
Publish-MqttMessage -Topic $topic -Message $message -Client $mqttClient

# Verbindung trennen
Disconnect-MqttBroker -Client $mqttClient
