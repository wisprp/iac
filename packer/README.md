### quickdoc

copy and fill .env variables

`cp .env-sample .env`

load environmental variables

`export $(xargs < .env)` 

validate config

`packer validate aws-min-provisioners.json`

build and provision AMI 

`packer build aws-min-provisioners.json`