#!/bin/bash

set -o errexit
set -o nounset

mkdir -p ${OUTPUT_DIR}

output_bam=${OUTPUT_DIR}/${SAMPLE}.possort.bam

time /tools/samtools-1.9/samtools sort \
    -l 0 -@ 8 \
    ${INPUT_SAM} \
    -T /scratch/ \
    -o ${output_bam}
