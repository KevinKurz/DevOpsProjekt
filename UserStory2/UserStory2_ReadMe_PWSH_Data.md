# README for PowerShell Script

## Overview

This PowerShell script facilitates the deployment of Azure resources using Bicep templates based on the specified environment parameter.

## Parameters

- **$parameters**: Specifies the target environment for deployment (production, test, or development).

## Usage

1. Open PowerShell.
2. Navigate to the directory containing the script.
3. Execute the script with the desired parameter:

    ``` pwsh
    .\deploy-resources.ps1 production
    ```

    Replace `production` with `test` or `development` for other environments.

## Script Logic

- If the parameter is `production`, the script deploys resources using the `parameter.production.json` file.
- If the parameter is `test`, the script deploys resources using the `parameter.test.json` file.
- If the parameter is `development`, the script deploys resources using the `parameter.development.json` file.
