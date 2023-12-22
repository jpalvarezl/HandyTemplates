using 'main.bicep'

// If you get an error, is because you haven't set your environment variable correctly.
param objectId = '${readEnvironmentVariable('SERVICE_PRINCIPAL_OBJECT_ID')}'

