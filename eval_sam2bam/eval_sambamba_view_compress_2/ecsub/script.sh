#!/bin/bash

set -o errexit
set -o nounset

mkdir -p ${OUTPUT_DIR}

ls -l ${OUTPUT_DIR}

bam_file=${OUTPUT_DIR}/${SAMPLE}.sorted.bam
bai_file=${bam_file}.bai

time sambamba view ${VIEW_OPTION} ${INPUT_FILE} -o ${bam_file}
echo $?

ls -l ${OUTPUT_DIR}

rm -f ${bam_file}
rm -f ${bam_file}.bai
