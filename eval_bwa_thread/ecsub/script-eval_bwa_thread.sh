#!/bin/bash

set -o errexit
set -o nounset

REFERENCE=${REFERENCE}/GRCh38.d1.vd1.fa
mkdir -p ${OUTPUT_DIR}

ls -l ${OUTPUT_DIR}

/tools/bwa-0.7.17/bwa mem \
    ${BWA_OPTION} -R "@RG\tID:12345\tPL:illumina\tLB:lib\tSM:5929_tumor" \
    ${REFERENCE} \
    ${INPUT_FASTQ1} \
    ${INPUT_FASTQ2} > ${OUTPUT_DIR}/${SAMPLE}.sam

echo $?

ls -l ${OUTPUT_DIR}/${SAMPLE}.sam

rm -f ${OUTPUT_DIR}/${SAMPLE}.sam
