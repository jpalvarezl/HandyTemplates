## Select the right Subscription

```
az account set --subscription <subscription_name>
```

## Check what changes

```
az deployment group what-if --resource-group <target-rg-name> --template-file main.bicep
```

## Actual deployment

To am existing resource group: 

```
az deployment group create --resource-group <resource-group-name> --template-file <path-to-template>
```
