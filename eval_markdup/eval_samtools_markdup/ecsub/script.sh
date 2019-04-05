#!/bin/bash

set -o errexit
set -o nounset

mkdir -p ${OUTPUT_DIR}

output_bam=${OUTPUT_DIR}/${SAMPLE}.samtools_markdup.bam

time /tools/samtools-1.9/samtools markdup \
    ${SAMTOOLS_OPTION} \
    -T /scratch/ \
    ${INPUT_BAM} \
    ${output_bam}

ls -l ${OUTPUT_DIR}
rm -f ${output_bam}
