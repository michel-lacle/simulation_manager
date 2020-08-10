#!/bin/bash

echo "running SimulationManager install"

rm -fr /tmp/SimulationEngineInstall

cp -r /tmp/SimulationEngine /tmp/SimulationEngineInstall

ENVIRONMENT="dev"
export ENVIRONMENT

cd /tmp/SimulationEngineInstall

pip3 install -r requirements.txt

# kill running python process
if pgrep simulation_manager_main; then kill -9 `ps -eaf | grep simulation_manager_main | awk '{print $2}'`; fi

echo "ENVIRONMENT=${ENVIRONMENT}"

# start python process
nohup  python3 -u simulation_manager_main.py > log.txt 2>&1 &
