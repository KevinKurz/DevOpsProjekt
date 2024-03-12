$output_iotHubName = Get-Content -Path "UserStory3.bicep"
$input_iotHubName = $output_iotHubName.Value

# Define variables
$resourceGroupName = "rg-kevin-kurz"
$iotHubName = $input_iotHubName
$deviceName = "testDevice"
$messageBody = "{ 'temperature': 22.3, 'humidity': 55.6 }"

# Get the primary connection string for the IoT Hub
$iotHub = Get-AzIotHub -ResourceGroupName $resourceGroupName -Name $iotHubName
$connectionString = ($iotHub | Get-AzIotHubSasToken -DeviceId $deviceName -Duration [System.TimeSpan]::FromMinutes(5)).ConnectionString

# Send a test message to the IoT Hub
Invoke-AzIoTHubDeviceMethod -ResourceGroupName $resourceGroupName -HubName $iotHubName -DeviceId $deviceName -MethodName "SendMessage" -Payload $messageBody -ConnectionString $connectionString
