#!/bin/bash

set -o errexit
set -o nounset

mkdir -p ${OUTPUT_DIR}

BAM_FILE=${OUTPUT_DIR}/${SAMPLE}.bam

time /usr/local/bin/samtools view ${SAMTOOLS_VIEW_OPTION} -@ ${THREAD} ${INPUT_FILE} > ${BAM_FILE}
echo $?

ls -l ${BAM_FILE}
rm -f ${BAM_FILE}
