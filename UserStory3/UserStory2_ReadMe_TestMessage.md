# Azure IoT Device Message Sender Readme

This readme provides instructions for sending a message from an IoT device to an Azure IoT Hub using the provided PowerShell script.

## Prerequisites

Ensure you have the following prerequisites before running the script:

- Azure CLI installed
- Access to an Azure IoT Hub
- An IoT device registered with the IoT Hub

## Script Usage

1. Open PowerShell.
2. Set the following variables in the script:
    - **$iotHubName**: Name of your Azure IoT Hub.
    - **$deviceId**: ID of your IoT device registered with the IoT Hub.
    - **$message**: Message to be sent from the IoT device.
3. Run the script:

    ```pwsh
    $iotHubName = "<YourIoTHubName>"
    $deviceId = "<YourDeviceId>"
    $message = "<YourMessage>"

    az iot device send-d2c-message --hub-name $iotHubName --device-id $deviceId --data $message
    ```

## Description

This PowerShell script sends a message from an IoT device to an Azure IoT Hub. Replace the variables `<YourIoTHubName>`, `<YourDeviceId>`, and `<YourMessage>` with your specific values.
