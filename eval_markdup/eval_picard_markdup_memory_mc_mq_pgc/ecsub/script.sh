#!/bin/bash

set -o errexit
set -o nounset

mkdir -p ${OUTPUT_DIR}

output_bam=${OUTPUT_DIR}/${SAMPLE}.markdup.bam
metrics_file=${OUTPUT_DIR}/${SAMPLE}.markdup_metrics.txt

time java -jar \
        ${JAVA_OPTION} \
        /tools/picard.jar \
        MarkDuplicates \
        I=${INPUT_BAM} \
        O=${output_bam} \
        METRICS_FILE=${metrics_file} \
        ASSUME_SORT_ORDER=queryname \
        QUIET=true \
        COMPRESSION_LEVEL=0

ls -l ${OUTPUT_DIR}

rm -f ${output_bam}
rm -f ${metrics_file}

