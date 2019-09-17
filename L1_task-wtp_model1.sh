#!/bin/bash

maindir=/Users/vinodvenkatraman/Desktop/SHOP/derivatives
model=task-wtp_model1

# sub=$1
# run=$2

for sub in 012 015 016 021 028 029 031 032 033 034 035 038 039 041 042 044 046 047 051 052 053 056 057 058 059 060; do
for run in 001 002 003 004 005; do

ppi=0 # just here from Dave's scripts. Needed for the if later.

MAINOUTPUT=${maindir}/FSL/${model}/sub-${sub}
mkdir -p $MAINOUTPUT

EVDIR=${maindir}/EVFiles/sub-${sub}
EV1=${EVDIR}/sub-${sub}_task-wtp_run-${run}_cond1.txt
EV2=${EVDIR}/sub-${sub}_task-wtp_run-${run}_cond2.txt
EV3=${EVDIR}/sub-${sub}_task-wtp_run-${run}_cond3.txt
EV4=${EVDIR}/sub-${sub}_task-wtp_run-${run}_motor.txt
EV5=${EVDIR}/sub-${sub}_task-wtp_run-${run}_initial.txt

DATA=${maindir}/fmriprep/sub-${sub}/func/sub-${sub}_task-wtp_run-${run}_space-MNI152NLin2009cAsym_desc-preproc_bold.nii.gz
OUTPUT=${MAINOUTPUT}/${model}_run-${run}

# rm -r ${OUTPUT}.feat

ITEMPLATE=${maindir}/FSL/Template_L1.fsf
OTEMPLATE=${MAINOUTPUT}/${model}_run-${run}.fsf

if [ "$ppi" == "0" ]; then
	sed -e 's@ODIR@'$OUTPUT'@g' \
	-e 's@INPUT@'$DATA'@g' \
	-e 's@COND1@'$EV1'@g' \
	-e 's@COND2@'$EV2'@g' \
	-e 's@COND3@'$EV3'@g' \
	-e 's@MOTOR@'$EV4'@g' \
	-e 's@INITIAL@'$EV5'@g' \
	<$ITEMPLATE> $OTEMPLATE
fi

feat $OTEMPLATE
mkdir -p ${OUTPUT}.feat/reg
cp $FSLDIR/etc/flirtsch/ident.mat ${OUTPUT}.feat/reg/example_func2standard.mat
cp $FSLDIR/etc/flirtsch/ident.mat ${OUTPUT}.feat/reg/standard2example_func.mat
cp ${OUTPUT}.feat/mean_func.nii.gz ${OUTPUT}.feat/reg/standard.nii.gz

# delete unused files
rm -rf ${OUTPUT}.feat/stats/res4d.nii.gz
rm -rf ${OUTPUT}.feat/stats/corrections.nii.gz
rm -rf ${OUTPUT}.feat/stats/threshac1.nii.gz

done
done