# Variablen für Ihren IoTHub, das Gerät und den Nachrichteninhalt festlegen
$resourceGroup = "rg-kevin-kurz"
$iotHubName = "userstory3Hub3ziviq2pzerxa"
$deviceId = "KevinsDevice"
$message = "Testnachricht von meinem Gerät"
$consumerGroup = "\$Default"  # Standardverbrauchergruppe

#$deleteDelayInSeconds = 60  # Anzahl der Sekunden, nach denen die Nachricht gelöscht wird

# Meldung senden
az iot device send-d2c-message --hub-name $iotHubName --device-id $deviceId --data $message

# # Warten, um sicherzustellen, dass die Nachricht in der Queue verarbeitet wird
# Start-Sleep -Seconds $deleteDelayInSeconds

# # Nachrichten aus der Queue löschen
# az storage message delete --queue-name $storageQueueName --id "*" --account-name $storageAccountName


# Nachrichten aus dem Event Hub abrufen
$events = az iot hub monitor-events --hub-name $iotHubName --device-id $deviceId --consumer-group $consumerGroup --timeout 30

# Überprüfen, ob die Testnachricht empfangen wurde
$received = $events -like "*$message*"

if ($received) {
    Write-Host "Die Testnachricht wurde erfolgreich empfangen."
} else {
    Write-Host "Die Testnachricht wurde nicht empfangen."
}
