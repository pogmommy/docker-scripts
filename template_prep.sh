#!/bin/bash

find "${HOME}/Dockers/" -iname '*.env' -not -iname '.*' -exec cp "{}" "{}_template" \;
find "${HOME}/Dockers/" -iname '*.env_template' -exec sed -i 's/=.*/=/' {} \;
#cp .env .env_template
#sed -i 's/=.*/=/' .env_template

#git add .
#git commit -m "New backup `date +'%Y-%m-%d %H:%M:%S'`"
#git push
