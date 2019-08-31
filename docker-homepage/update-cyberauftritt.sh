#!/bin/bash

cd /srv/docker-homepage/


# shut down the jekyll container
#docker-compose exec jekyll killall bundle
#docker container rm cyberauftritt_jekyll
#docker-compose down
docker-compose stop
# TODO:
#docker-compose rm -f

# pull new version of our code from github
cd cyberauftritt-git
rm -r _site
git pull origin master
mkdir _site
chown 1000 -R _site

cd ..
# start the shit
docker-compose up -d

# Sed is not needed anymore
exit 0

# replace every occurence of this in
cd cyberauftritt-git/_site

# sleep a couple of secs so jekyll can generate the files
#chown -R root:root ../_site/
sleep 10
find ./ -type f -exec sed -i 's|http://www.fsi.uni-tuebingen.de:8080|https://www.fsi.uni-tuebingen.de|g' {} \;
