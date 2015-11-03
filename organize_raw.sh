#!/bin/bash
# try to run script and see if it works

WD='/home/despoB/TRSEPPI/TDSigEI'

cd ${WD}
# for subj in $(ls -d 5*); do
for subj in $(ls -d 539); do
	if [ "${subj}" != "Raw" ]; then
		cd ${WD}/${subj}

		mprage_dir=$(ls -d MEMPRAGE_P2_RMS*)

		if [ ! -d ${WD}/${subj}/MPRAGE ]; then
			ln -s ${mprage_dir} MPRAGE
		fi	
	
		BOLD_DIRs=($(ls -d tmsMRI_sequence_PA_TR1500_4mm_* | sort -V))
		i=0
		for ((r=1; r <=24; )); do
			if [ $i -lt ${#BOLD_DIRs[@]} ] && [ ! -L ${WD}/${subj}/run${r} ]; then
				numfiles=$(ls -l ${BOLD_DIRs[i]} | wc -l)
				if [ $numfiles == '102' ]; then
					ln -s ${BOLD_DIRs[i]} run${r}
					$r=$r+1
				else
					str=" does not have 102 files"
					str=${BOLD_DIRs[i]}$str 
					echo $str
				fi
			elif [ $i -ge ${#BOLD_DIRs[@]} ]; then
				str=" has fewer than 24 full blocks"
				str=${BOLD_DIRs[i]}$str 
				echo $str
				break
			fi
			i=$(($i+1))

		done
	fi

done
