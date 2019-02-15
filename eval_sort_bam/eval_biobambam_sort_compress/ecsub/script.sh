#!/bin/bash

set -o errexit
set -o nounset

REFERENCE=${REFERENCE}/GRCh38.d1.vd1.fa
mkdir -p ${OUTPUT_DIR}

ls -l ${OUTPUT_DIR}

bam_file=${OUTPUT_DIR}/${SAMPLE}.sorted.bam
bai_file=${bam_file}.bai

time /usr/local/bin/bamsort ${SORT_OPTION} I=${INPUT_FILE} O=${bam_file}
echo $?

ls -l ${OUTPUT_DIR}

rm -f ${bam_file}
rm -f ${bam_file}.bai
