#!/bin/bash

set -o errexit
set -o nounset

mkdir -p ${OUTPUT_DIR}

BAM_FILE=${OUTPUT_DIR}/${SAMPLE}.bam
BAI_FILE=${OUTPUT_DIR}/${SAMPLE}.bam.bai

time java -jar ${JAVA_OPTION} -Djava.io.tmpdir=/scratch /tools/picard.jar SortSam I=${INPUT_FILE} O=${BAM_FILE} SO=${SORT_ORDER} ${PICARD_OPTION} CREATE_INDEX=true
echo $?

ls -l ${OUTPUT_DIR}
rm -f ${BAM_FILE}
rm -f ${BAI_FILE}
