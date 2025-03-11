#!/bin/bash

script_root="$( dirname $0 )"
dockers_root="${HOME}/Dockers"

project_setup(){
  project_dir="${dockers_root}/${1}"
  cat "${dockers_root}/.env" | tee "${project_dir}/.env" >/dev/null
  cat "${project_dir}/${1}.env" | tee -a "${project_dir}/.env" >/dev/null
}
project_pull(){
  project_yml="${dockers_root}/${1}/docker-compose.yml"
  project_dir="${dockers_root}/${1}"
  echo "pulling resources for ${project_yml}"
  sudo docker-compose --file "${project_yml}" pull
}
project_up(){
  project_yml="${dockers_root}/${1}/docker-compose.yml"
  project_dir="${dockers_root}/${1}"
  echo "bringing up ${project_yml}"
  sudo docker-compose --file "${project_yml}" --project-directory "${project_dir}" --project-name "${project_name}" up -d
}

if [ -z ${1} ];then
  for d in $( find "${dockers_root}" -maxdepth 1 -type d );do
    echo "docker: ${d}"
    if [ -f "${d}/docker-compose.yml" ];then
      project_name="$(basename ${d})"
      echo "project: ${project_name}"
      project_setup "${project_name}"
      project_pull "${project_name}"
      project_up "${project_name}"
    fi
  done
else
  echo "searching for ${dockers_root}/${1}/docker-compose.yml"
  if [ -f "${dockers_root}/${1}/docker-compose.yml" ];then
    echo "Single project"
    project_setup "${1}"
    project_pull "${1}"
    project_up "${1}"
  else
    echo "project ${1} does not exist"
  fi
fi

sudo docker image prune -f
