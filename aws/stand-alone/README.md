Set of script to set up and run stand alone dev instances on AWS 
More detailed description TBA


Notes:
AWS credentilas via `export` profile

`dns_zone` and `dns_zone_id` defined as var in export with `TF_VAR_` prefix

Simpliest way to export .env

``` export $(xargs < .env) ```