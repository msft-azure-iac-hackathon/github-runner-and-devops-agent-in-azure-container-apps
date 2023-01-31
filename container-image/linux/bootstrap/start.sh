#!/bin/bash

GH_OWNER=$GH_OWNER
GH_REPOSITORY=$GH_REPOSITORY
GH_TOKEN=$GH_TOKEN

RUNNER_NAME=$(hostname)

REG_TOKEN=$(curl -sX POST -H "Accept: application/vnd.github.v3+json" -H "Authorization: token ${GH_TOKEN}" https://api.github.com/repos/${GH_OWNER}/${GH_REPOSITORY}/actions/runners/registration-token | jq .token --raw-output)

cd /home/docker/actions-runner
mkdir _work
mkdir _work/$(hostname)
echo "Configuring runner..."
echo https://github.com/${GH_OWNER}/${GH_REPOSITORY}
./config.sh --unattended --url https://github.com/${GH_OWNER}/${GH_REPOSITORY} \
    --token ${REG_TOKEN} \
    --name ${RUNNER_NAME} \
    --labels pwsh,azps,azcli,"$(lsb_release -si):$(lsb_release -sr)" \
    --work _work/$(hostname)

cleanup() {
    echo "Removing runner..."
    ./config.sh remove --token ${REG_TOKEN}
    echo "Removing work directory..."
    rm -rf ${_work/$(hostname)}
}

trap 'cleanup; exit 130' INT
trap 'cleanup; exit 143' TERM

./run.sh & wait $!