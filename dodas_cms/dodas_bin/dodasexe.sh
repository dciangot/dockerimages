#!/bin/bash

condor_master

export WN_TIMEOUT=60
COUNTER=0

###Check CVMFS status every 5s as it can create a black hole
###Check every 10 minutes if cmsRun executed at least once in the past hour. 

while true; do
    cmd="ls /cvmfs/cms.cern.ch/cmsset_default.sh"
    timeout 10 $cmd
    if [ $? -ne 0 ]; then
        echo "CVMFS Problems"
        if [ $? -eq 124 ]; then
            echo "Actually a timeout occurred"
        fi
        echo "shutdown the docker"
        shutdown -h now
    fi
    if [ "$COUNTER" == "120" ];then
        COUNTER=0
        cmd=$(find /var/log/condor -type f -name StartLog -mmin -$WN_TIMEOUT)
        if [ -z $cmd ]; then
            echo "shutdwon the docker"
            shutdown -h now
        fi
    fi
    let COUNTER=COUNTER+1
    sleep 5
done
