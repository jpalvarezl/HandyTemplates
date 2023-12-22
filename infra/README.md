# Required parameters

You should setup a service pricinpal using this [guide](https://learn.microsoft.com/en-us/entra/identity-platform/howto-create-service-principal-portal)
Required environment variables:
- `SERVICE_PRINCIPAL_OBJECT_ID`

# Required manual steps

- In order to see the value of a secret, there is still a manual step required. Go to [Azure portal](https://portal.azure.com)
- Navigate to the key vault created by these templates (look for `aoai-tests-keyvault`)
- Go to "Access control (IAM)" and click "Add role assignment"
- Assign your principal's Object ID to the role "Key vault Secrets Officer"
- (Optional) assign yourself too if you want to be able to access the secrets

# Run

Note: re running the script should not have any changes in the infra, as bicep template scripts are idempotent.

## Select the right Subscription

```
az account set --subscription <subscription_name>
```

## Check what changes

```
az deployment group what-if --resource-group <target-rg-name> --template-file main.bicep --parameters main.bicepparam
```

## Actual deployment

To am existing resource group: 

```
az deployment group create --resource-group <resource-group-name> --template-file <path-to-template> --parameters main.bicepparam
```

Adding `--paramater main.bicepparam` will prevent the Az CLI from prompting you for a value for `objectId`, it will be read directly from environment. (Don't forget to set it!)

# Delete

You may want to delete the resources you create with these bicep templates. That is not currently supported in Az CLI.

## Troubleshooting

There are various ways to go around this limitation. If you delete the resources manually (and want to keep the parent resource group) you migght run into a a "FlagMustBeSetForRestore" error, telling you to either purge the soft deleted resources or restore them.

To purge:

```bash
az cognitiveservices account purge  -l <location> -n <resource-name> -g <parent-resource-name>
```

You will have to do this for every individual resource causing problems.

## --mode Complete

You will find a lot of people running `az deployment gourp create --resource-group <rg> --template-file empty.bicep --mode complete`.

This is a well established hack. `--mode complete` will delete all the resources that aren't part of your bicep script. Therefore, if you have an empty script, it will delete all the resources. This is considered a bad practice, as you may accidentally delete things you shouldn't.

# Reference

Borrowed heavily from this [repo](https://github.com/Azure-Samples/azure-search-openai-demo-csharp/blob/main/infra/main.bicep)
