#!/bin/bash

set -o errexit
set -o nounset

mkdir -p ${OUTPUT_DIR}

output_bam=${OUTPUT_DIR}/${SAMPLE}.markdupspark.bam

time /gatk/gatk MarkDuplicatesSpark \
    --java-options -Xmx48g \
    --spark-runner LOCAL \
    ${GATK_OPTION} \
    -I ${INPUT_BAM} \
    -O ${output_bam} \
    --tmp-dir /scratch

ls -l ${OUTPUT_DIR}
