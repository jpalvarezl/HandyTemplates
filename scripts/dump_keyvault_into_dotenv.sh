#!/usr/bin/env bash

# Note: running from a subshell could cause the values to not be set even after the script completes.
# If this happens, run the script with the source command: `source set_env_vars_from_keyvault.sh`

# Use the script to fetch secrets from Azure Key Vault and set them as environment variables.
# You need to either give yourself or a service principal access to the Key Vault.
# Go to "Access control (IAM)" in the key vault 
#

KEY_VAULT="aoai-tests-keyvault"

function fetch_secret_from_keyvault() {
    local SECRET_NAME=$1

    az keyvault secret show --vault-name "${KEY_VAULT}" --name "${SECRET_NAME}" --query "value"
}

function export_env_var_from_keyvault() {
    local SECRET_VAR=$1
    local SECRET_NAME=$2

    local SECRET_VALUE=`fetch_secret_from_keyvault "${SECRET_NAME}"`
    export_env_var "${SECRET_VAR}" "${SECRET_VALUE}"
}

function export_env_var() {
    local SECRET_VAR=$1
    local SECRET_VALUE=$2

    echo "Fetching ${SECRET_VAR} value ..."
    echo ${SECRET_VAR}="${SECRET_VALUE}" >> .env
}

echo "# ----------------------- "
echo "# Fetching environment variables from secrets in the ${KEY_VAULT} key vault"
echo "# and writing them to a ./.env file ..."	

export_env_var_from_keyvault "COGNITIVE_SEARCH_ENDPOINT" "cognitive-search-endpoint"
export_env_var_from_keyvault "COGNITIVE_SEARCH_PRIMARY_KEY" "cognitive-search-primary-key"
export_env_var_from_keyvault "GPT_35_TURBO_1106_OPENAI_ENDPOINT" "gpt-35-turbo-1106-openai-endpoint"
export_env_var_from_keyvault "GPT_35_TURBO_1106_OPENAI_KEY" "gpt-35-turbo-1106-openai-key"
export_env_var_from_keyvault "WHISPER_01_OPENAI_ENDPOINT" "whisper-01-openai-endpoint"
export_env_var_from_keyvault "WHISPER_01_OPENAI_KEY" "whisper-01-openai-key"

echo "# ----------------------- "
