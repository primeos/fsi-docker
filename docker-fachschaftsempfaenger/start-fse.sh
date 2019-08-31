#!/bin/bash

set -o errexit

docker-compose down
docker-compose build
docker-compose up -d
# we need to copy the files used for SSL in the container to another location because we shouldn't change the permissions on the host file 
docker exec -it codimd_container sh -c "cp /codimd/ssl/pad.fsi.uni-tuebingen.de.key_cp /codimd/ssl/pad.fsi.uni-tuebingen.de.key && chmod 666 /codimd/ssl/pad.fsi.uni-tuebingen.de.key && 
	cp /codimd/ssl/pad.fsi.uni-tuebingen.de.crt_cp /codimd/ssl/pad.fsi.uni-tuebingen.de.crt && chmod 666 /codimd/ssl/pad.fsi.uni-tuebingen.de.crt && 
	cp /codimd/ssl/LetsEncrypt_X3.crt_cp /codimd/ssl/LetsEncrypt_X3.crt && chmod 666 /codimd/ssl/LetsEncrypt_X3.crt &&  
	cp /codimd/ssl/dhparam.pem_cp /codimd/ssl/dhparam.pem && chmod 666 /codimd/ssl/dhparam.pem && 
	cp /codimd/config.json_cp /codimd/config.json && chmod 666 /codimd/config.json"
docker exec -it codimd_nginx sh -c "cp /etc/nginx/ssl/pad.fsi.uni-tuebingen.de.key /etc/nginx/pad.fsi.uni-tuebingen.de.key && chmod 666 /etc/nginx/pad.fsi.uni-tuebingen.de.key && 
        cp /etc/nginx/ssl/pad.fsi.uni-tuebingen.de.cer /etc/nginx/pad.fsi.uni-tuebingen.de.crt && chmod 666 /etc/nginx/pad.fsi.uni-tuebingen.de.crt && nginx"

