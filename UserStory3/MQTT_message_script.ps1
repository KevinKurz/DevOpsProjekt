# Variablen für Ihren IoTHub, das Gerät und den Nachrichteninhalt festlegen
$resourceGroup = "rg-kevin-kurz"
$iotHubName = "userstory3Hub3ziviq2pzerxa"
$deviceId = "KevinsDevice"
$message = "Testnachricht von meinem Gerät"

az iot device send-d2c-message --hub-name $iotHubName --device-id $deviceId --data $message