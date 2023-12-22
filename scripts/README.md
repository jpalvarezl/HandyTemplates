# Scripts

Compilation of useful scripts for now. I would like to extend this to also contain scripts to be used in the deployment process (for example, deploy an index to cognitive search)

# Instructions

If you are running from a subshell:

```bash
source <script_name>
```

# Available scripts

- `dump_keyvault_into_dotenv.sh` : This will generate a `.env` file with (for now) a hardcoded list of secrets from the Azure key vault containing all the resource parameters necessary to issue data-plane level requests from the `infra` folder. (**note:** you can see the `rest_test` folder as an example, it relies on this script to be able to run the requests)

- `set_env_vars_from_keyvault.sh`: This script will setup in your running terminal a (for now) hardcoded list of the secrets from the Azure key vault containing all the resource parameters necessary to issue data-plane level requests from the `infra` folder.
