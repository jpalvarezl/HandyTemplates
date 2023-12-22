# Handy_templates

This project got a bit out of hand and is no longer accurately named. 

The idea has extended into this project becoming (in due time) the basis on which we can build our live testing infrastructure.

## Structure

- `infra`: contains Bicep templates and instructions to run them and set them up to deploy resources that we normally use in our Azure OpenAI SDKs
- `scripts`: contains handy scripts. For now, scripts that access the keyvault in which the parameters of the resources deployed by the `infra` template files and retrieve all the values necessary to run requests against them.
- `rest_tests`: some basic testing making use of the `infra` and `scripts`. This is mainly for my personal validation and was the simplemost way to achieve, that I could think of.
