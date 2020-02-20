#!/bin/bash

# options:
# remove stopped containers and untagged images
#   $ ./cleanup
# remove all stopped|running containers and untagged images
#   $ ./cleanup --reset
# remove containers|images| matching {repository: id}
# pattern and untagged images
#   $ ./cleanup --purge {image}
# everything
#   $ ./cleanup --nuclear

function _clean_docker {
local matchExp=""
if [ "$1" == "--reset" ]; then
  # Remove all containers regardless of state
    docker rm -vf $(docker ps -a -q) 2>/dev/null || \
    echo "No more containers to remove."
elif [ "$1" == "--purge" ]; then
    matchExp=$2
    echo "Match exp here: $matchExp ------>"
    # Attempt to remove running containers that are using the images we're trying to purge first.
    docker rm -vf $(docker ps -a --format "{{.Image}} {{.Names}} {{.ID}}" | grep "$matchExp" | awk -v matchExp="$2" '{print $2}') 2>/dev/null

    #docker rm -vf $(docker ps -a --format "{{.Image}} {{.Names}} {{.ID}}" | \
    #awk -v matchExp="$2" '$0 ~ matchExp {print $2}') 2>/dev/null
    #echo "Here:------------> grep match"
    #docker images --format "{{.Repository}}: {{.ID}}" | grep "$matchExp"
    echo "Here:------------> grep and awk"
    # Remove all images matching arg given after "--purge"`
    returnVal=$?
    #echo "Return value: $returnVal ----->"
    if [ $returnVal -ne 0 ]; then
        echo "No running containers using the \"$2\" image, continuing purge."
    else
        docker images --format "{{.Repository}}:{{.Tag}}" | grep "$matchExp" | awk -v matchExp="$2" '$0 ~ matchExp {print $1}' | xargs docker rmi 2>/dev/null
        exit 0
    fi
else
  # This alternate only removes "stopped" containers
    docker rm -vf $(docker ps -a | grep "Exited" | \
    awk '{print $2}') 2>/dev/null || echo "No stopped containers to remove."
fi

if [ "$1" == "--nuclear" ]; then
    docker rm -vf $(docker ps -a -q) 2>/dev/null || \
    echo "No more containers to remove."
    docker rmi $(docker images -q) 2>/dev/null || echo "No more images to remove."
    echo "Preparing to uninstall docker ....."
    dpkg -l | grep Docker | awk '{print $2}' > /tmp/docker-list.txt
    while read list; do
        sudo apt-get remove $list -y
    done </tmp/docker-list.txt
    rm /tmp/docker-list.txt
    else
  # Remove all images which are not used by existing container
    docker image prune -a || echo "No untagged images to delete."
fi

}

function _clean_ansible {
if [ "$1" == "--nuclear" ]; then
version=$(grep "ansible_version" ${kud_playbooks}/kud-vars.yml | \
awk -F ': ' '{print $2}')
sudo pip uninstall ansible==$version
fi
}

#Defining config path
INSTALLER_DIR="$(readlink -f "$(dirname "${BASH_SOURCE[0]}")")"
kud_folder=${INSTALLER_DIR}
kud_infra_folder=$kud_folder/../../deployment_infra
kud_playbooks=$kud_infra_folder/playbooks

_clean_docker $@
_clean_ansible $1
