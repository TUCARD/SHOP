#!/bin/bash

maindir=/Users/vinodvenkatraman/Desktop/SHOP/derivatives
model=task-wtp_model1

# sub=$1

for sub in 016 021 028 029 031 032 033 034 035 038 039 041 042 044 046 047 051 052 053 056 057 058 059 060; do

# for sub in 015; do

NCOPES=10
ppi=0 # just here from Dave's scripts. Needed for the if later.

MAINOUTPUT=${maindir}/FSL/${model}/sub-${sub}

INPUT1=${MAINOUTPUT}/${model}_run-004.feat
INPUT2=${MAINOUTPUT}/${model}_run-005.feat

OUTPUT=${MAINOUTPUT}/L2_${model}_R45

ITEMPLATE=${maindir}/FSL/Template_L2_R45.fsf
OTEMPLATE=${MAINOUTPUT}/L2_${model}_R45.fsf

if [ "$ppi" == "0" ]; then
	sed -e 's@OUTPUT@'$OUTPUT'@g' \
	-e 's@INPUT1@'$INPUT1'@g' \
	-e 's@INPUT2@'$INPUT2'@g' \
	<$ITEMPLATE> $OTEMPLATE
fi

feat $OTEMPLATE


# delete unused files
for cope in `seq ${NCOPES}`; do
	rm -rf ${OUTPUT}.gfeat/cope${cope}.feat/stats/res4d.nii.gz
	rm -rf ${OUTPUT}.gfeat/cope${cope}.feat/stats/corrections.nii.gz
	rm -rf ${OUTPUT}.gfeat/cope${cope}.feat/stats/threshac1.nii.gz
	rm -rf ${OUTPUT}.gfeat/cope${cope}.feat/filtered_func_data.nii.gz
	rm -rf ${OUTPUT}.gfeat/cope${cope}.feat/var_filtered_func_data.nii.gz
done
done