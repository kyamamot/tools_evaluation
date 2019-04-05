#!/bin/bash

set -o errexit
set -o nounset

mkdir -p ${OUTPUT_DIR}

output_bam=${OUTPUT_DIR}/${SAMPLE}.markdupspark.bam

#    --java-options "${JAVA_OPTION}" \
time /tools/gatk-4.1.1.0/gatk MarkDuplicatesSpark \
    -I ${INPUT_BAM} \
    -O ${output_bam} \
    --tmp-dir /scratch

ls -l ${OUTPUT_DIR}
rm -f ${output_bam}
