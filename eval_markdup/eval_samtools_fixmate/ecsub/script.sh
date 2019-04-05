#!/bin/bash

set -o errexit
set -o nounset

mkdir -p ${OUTPUT_DIR}

output_bam=${OUTPUT_DIR}/${SAMPLE}.samtools_fixmate.bam

time /tools/samtools-1.9/samtools fixmate \
    -m \
    ${SAMTOOLS_OPTION} \
    ${INPUT_BAM} \
    ${output_bam}

ls -l ${OUTPUT_DIR}
rm -f ${output_bam}
