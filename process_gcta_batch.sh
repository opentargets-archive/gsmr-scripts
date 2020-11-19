#!/bin/bash

# PLINK format needs the file with the prefix for the multi-file per chromosome so 
# jsut one entry per chromosome without the multiple extensions

# $DIR/gcta_1.93.2beta/gcta64 \
# --mbfile $DIR/ukb_v3_downsampled10k_plink.txt \
# --gsmr-file $DIR/prot.txt $DIR/covid_gsmr.txt \
# --gsmr-direction 2 --clump-r2 0.05 --gwas-thresh 5e-8 --gsmr-snp-min 10 --effect-plot --out sun_outcomes_covid3_oct2020_gsmr_results

echo "cmd ${GCTA} files from ${UK10K} and ${PROTEINS} and ${OUTCOMES} to this output ${OUTPUT}" > ${OUTPUT}/inputs.txt

echo find ref chromosome list and put into a file for later use
find $UK10K -type f | grep 'downsampled10k' | awk -F'.' '{print $1"."$2}' | uniq > ${OUTPUT}/uk10k_ref_panel.txt

echo find all protein files from the path ${PROTEINS}/mohd/dsub-test/SUN2018_full_harmonised_gsmr_v2
find ${PROTEINS}/mohd/dsub-test/SUN2018_full_harmonised_gsmr_v2 -type f > ${OUTPUT}/proteins.txt

echo find all outcomes we need to run GSMR
find ${OUTCOMES} -type f > ${OUTPUT}/outcomes.txt

cp ${GCTA} .
export PATH=$PATH:.

echo change permissions of the gcta executable
chown root gcta64
chmod u+x gcta64

echo current dir name $(pwd)

gcta64 \
    --mbfile ${OUTPUT}/uk10k_ref_panel.txt \
    --gsmr-file ${OUTPUT}/proteins.txt ${OUTPUT}/outcomes.txt \
    --gsmr-direction 2 --clump-r2 0.05 --gwas-thresh 5e-8 --gsmr-snp-min 10 --effect-plot \
    --out ${OUTPUT}/results

exit 0
