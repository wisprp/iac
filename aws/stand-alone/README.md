Set of script to set up and run stand alone dev instances on AWS 
More detailed description TBA

Directory structure

* instance/ - instanse setup definition
* startup_scripts/ - user-data startup scripts, must match project name
* projects.tf - list of projects modules



Notes:
AWS credentilas via `export` profile

`dns_zone` and `dns_zone_id` defined as var in export with `TF_VAR_` prefix

Simpliest way to export .env

``` export $(xargs < .env) ```