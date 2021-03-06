#!/bin/bash

#for SGE jobs


WD='/home/despoB/TRSEPPI/TDSigEI'
SCRIPTS='/home/despoB/lyang/TDSigEI'

cd ${WD}

for Subject in 550; do
	
	for r in $(seq 1 1 24); do
		if [ ! -e "${WD}/${Subject}/run${r}/nswdktm_functional_6.nii.gz" ]; then
			sed "s/s in P001/s in ${Subject}/g; s/run1/run${r}/g " < ${SCRIPTS}/proc_functional.sh > /home/despoB/lyang/tmp/proc_functional_${Subject}_${r}.sh 
			qsub -V -M lyang -l mem_free=2G -m e -e ~/tmp -o ~/tmp /home/despoB/lyang/tmp/proc_functional_${Subject}_${r}.sh
		fi
	done

done
