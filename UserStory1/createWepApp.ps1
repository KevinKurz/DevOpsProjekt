$parameters

if ($parameters == 'production')
{
    az deployment group create --resource-group rg-kevin-kurz --template-file UserStory1.bicep --parameters parameter.production.json
}
elseif ($parameters == 'test')
{
    az deployment group create --resource-group rg-kevin-kurz --template-file UserStory1.bicep --parameters parameter.test.json
}
elseif ($parameters == 'development')
{
    az deployment group create --resource-group rg-kevin-kurz --template-file UserStory1.bicep --parameters parameter.development.json
}