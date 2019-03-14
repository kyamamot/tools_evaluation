#!/bin/bash

set -o errexit
set -o nounset

mkdir -p ${OUTPUT_DIR}

ls -lh ${OUTPUT_DIR}

bam_file=${OUTPUT_DIR}/${SAMPLE}.bam

time /usr/local/bin/samtools view ${VIEW_OPTION} ${INPUT_FILE} -o ${bam_file}
echo $?

ls -lh ${OUTPUT_DIR}
rm -f ${bam_file}
