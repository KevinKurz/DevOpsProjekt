param ([string] $parameters = $args[0])

if ($parameters -eq 'production')
{
    Write-Host 'production parameter detected'
    az deployment group create --resource-group rg-kevin-kurz --template-file UserStory3.bicep --parameters parameter.production.json
}
elseif ($parameters -eq 'test')
{
    Write-Host 'test parameter detected'
    az deployment group create --resource-group rg-kevin-kurz --template-file UserStory3.bicep --parameters parameter.test.json
}
elseif ($parameters -eq 'development')
{
    Write-Host 'development parameter detected'
    az deployment group create --resource-group rg-kevin-kurz --template-file UserStory3.bicep --parameters parameter.development.json
}
elseif ($parameters -eq 'world')
{
    Write-Host 'Hello, World!'
}