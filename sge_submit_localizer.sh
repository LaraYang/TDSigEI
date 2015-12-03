#!/bin/bash

#for SGE jobs

#mkdir tmp;
WD='/home/despoB/TRSEPPI/TDSigEI'
SCRIPTS='/home/despoB/lyang/TDSigEI'

cd ${WD}

for Subject in $(ls -d 540 542 547 549 550); do
	sed "s/s in P001/s in ${Subject}/g" < ${SCRIPTS}/run_localizer.sh> /home/despoB/lyang/tmp/run_localizer_${Subject}.sh
	qsub -V -M lyang -m e -e ~/tmp -o ~/tmp /home/despoB/lyang/tmp/run_localizer_${Subject}.sh
done
