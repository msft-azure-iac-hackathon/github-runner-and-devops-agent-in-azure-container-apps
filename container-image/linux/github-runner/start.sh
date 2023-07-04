#!/bin/bash

GH_OWNER=$GH_OWNER
GH_REPOSITORY=$GH_REPOSITORY
GH_TOKEN=$GH_TOKEN
RUNNER_NAME=$(hostname)

REG_TOKEN=$(curl -sX POST -H "Accept: application/vnd.github.v3+json" -H "Authorization: token ${GH_TOKEN}" https://api.github.com/orgs/${GH_OWNER}/actions/runners/registration-token | jq .token --raw-output)


echo $REG_TOKEN
ls -asl
mkdir -p ./_work/$(hostname)
ls -asl

export RUNNER_ALLOW_RUNASROOT="1"

echo "Configuring runner ${RUNNER_NAME}..."

echo https://github.com/${GH_OWNER}

./config.sh --unattended --url https://github.com/${GH_OWNER} \
    --ephemeral \
    --token ${REG_TOKEN} \
    --name ${RUNNER_NAME} \
    --labels pwsh,azps,azcli,"$(lsb_release -si):$(lsb_release -sr)" \
    --work _work/$(hostname)


cleanup() {
    echo "Removing runner ${RUNNER_NAME}...}"
    REM_TOKEN=$(curl -sX POST -H "Accept: application/vnd.github.v3+json" -H "Authorization: token ${GH_TOKEN}" https://api.github.com/orgs/${GH_OWNER}/actions/runners/remove-token | jq .token --raw-output)
    echo ${REM_TOKEN}
    ./config.sh remove --token ${REM_TOKEN}
    echo "Removing work directory..."
    ls -asl _work
    rm -r _work/$(hostname)
    ls -asl _work
    echo "Runner successfully removed!"
}

trap 'cleanup; exit 0' EXIT
trap 'cleanup; exit 130' INT
trap 'cleanup; exit 143' TERM

echo "Starting runner..."
./run.sh & wait $!