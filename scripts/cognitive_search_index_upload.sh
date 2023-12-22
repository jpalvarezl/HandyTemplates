#!/bin/bash

# Usage: bash <script-name>.sh <resource-name> <api-key> <file-path> <schema-file-path

# Description:
# This script uploads a markdown file to an Azure Cognitive Search index.
#
# Arguments:
#   <resource-name>        The name of the Azure Cognitive Search resource.
#   <api-key>              The API key for the Azure Cognitive Search resource.
#   <file-path>            The path to the markdown file to upload.
#   <schema-file-path>     The path to the schema file for the search index.

# Example usage:
#   bash cognitive_search_index_upload.sh <cog_search_resource_name> <cog_search_admin_key> ./my-markdown-file.md ./my-schema-file.json

# Define variables
resource_name="$1"
api_key="$2"
file_path="$3"
schema_file_path="$4"
index_name="my_index" # needs to match the value of the "name" property in the schema file `index_fields.json`
resource_group_name="cognitive_search_resource"

# Create the search index
az search service index create \
    --name "$index_name" \
    --resource-group "$resource_group_name" \
    --service-name "$resource_name" \
    --api-key "$api_key" \
    --schema "@$schema_file_path"

# Upload the file to the search index
az search index documents upload \
    --name "$index_name" \
    --resource-group "$resource_group_name" \
    --service-name "$resource_name" \
    --api-key "$api_key" \
    --file-path "$file_path" \
    --data-action upload
