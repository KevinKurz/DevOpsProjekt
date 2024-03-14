# Variablen für Ihren IoTHub, das Gerät und den Nachrichteninhalt festlegen

$iotHubName = "your-iot-hub-name"
$deviceId = "your-iot-hub-device-name"
$message = "your-testmessage"

# Meldung senden
az iot device send-d2c-message --hub-name $iotHubName --device-id $deviceId --data $message

