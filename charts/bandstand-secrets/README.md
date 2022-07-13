# Bandstand secrets

## Values
just have values-<<test/preprod/prod>>.yaml file with the following key 

| Key                       | Type   |  Description                                       |
|---------------------------|--------|----------------------------------------------------|
| env                       | string |  The environment, either test, preprod or prod     |

## Secrets file 
Place the secret files under templates folder

## Circle CI steps required
Have dry run and install chart steps in circle ci