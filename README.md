# Run

Note: re running the script should not have any changes in the infra, as bicep template scripts are idempotent.

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


# Reference

Borrowed heavily from this [repo](https://github.com/Azure-Samples/azure-search-openai-demo-csharp/blob/main/infra/main.bicep)
