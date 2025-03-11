#!/bin/bash

find "${HOME}/Dockers/" -iname '*.env' -not -iname '.*' -exec cp "{}" "{}_template" \;
cp "${HOME}/Dockers/.env" "${HOME}/Dockers/.env_template"
find "${HOME}/Dockers/" -iname '*.env_template' -exec sed -i 's/=.*/=/' {} \;
sed -i 's/=.*/=/' "${HOME}/Dockers/.env"
