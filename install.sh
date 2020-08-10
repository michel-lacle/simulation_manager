#!/bin/bash

echo "running SimulatorEngine install"

exit 0

cd /tmp/SimulationEngine

cp config.Qa.json config.json

pip3 install -r requirements.Qa.txt

# kill running python process
kill -9 `ps -eaf | grep simulation_engine_manager | awk '{print $2}'`

# start python process
python3 simulation_engine_manager.py > /dev/null 2> /dev/null < /dev/null &
