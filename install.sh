#!/bin/bash

echo "running SimulationManager install"

rm -fr /tmp/SimulationEngineInstall

cp -r /tmp/SimulationEngine /tmp/SimulationEngineInstall

ENVIRONMENT=dev
export ENVIRONMENT

cd /tmp/SimulationEngineInstall

pip3 install -r requirements.txt

# kill running python process
kill -9 `ps -eaf | grep simulation_manager_main | awk '{print $2}'`

# start python process
python3 simulation_manager_main.py > /dev/null 2> /dev/null < /dev/null &
