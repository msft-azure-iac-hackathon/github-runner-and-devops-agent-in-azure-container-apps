#!/bin/bash
set -e

ADO_ORG_URL=$ADO_ORG_URL
ADO_PAT=$ADO_PAT
ADO_HOSTPOOL_NAME=$ADO_HOSTPOOL_NAME
ADO_AGENT_NAME=$(hostname)
ADO_PLACEHOLDER=$ADO_PLACEHOLDER

ls -asl
mkdir -p ./_work/$(hostname)
ls -asl

source ./env.sh

export AGENT_ALLOW_RUNASROOT="1"

./config.sh --unattended \
    --agent $ADO_AGENT_NAME \
    --url $ADO_ORG_URL \
    --token $ADO_PAT \
    --pool $ADO_HOSTPOOL_NAME \
    --work _work/$(hostname) \
    --replace \
    --acceptTeeEula & wait $!

cleanup() {
    if [ -n "$ADO_PLACEHOLDER" ]; then
        echo 'Running in placeholder mode, skipping cleanup...'
        return
    fi
    echo "Removing Azure Pipelines agent..."
    ./config.sh remove --unattended --auth PAT --token $ADO_PAT
    echo "Removing work directory..."
    #ls -asl _work
    #rm -r _work/$(hostname)
    #ls -asl _work
    echo "Runner successfully removed!"
}

trap 'cleanup; exit 0' EXIT
trap 'cleanup; exit 130' INT
trap 'cleanup; exit 143' TERM

echo "Starting runner..."
chmod +x ./run.sh
./run.sh "$@" & wait $!