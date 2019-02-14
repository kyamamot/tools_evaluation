#!/bin/bash

set -o errexit
set -o nounset

REFERENCE=${REFERENCE}/GRCh38.d1.vd1.fa
mkdir -p ${OUTPUT_DIR}

ls -l ${OUTPUT_DIR}

BAM_FILE=${OUTPUT_DIR}/${SAMPLE}.biobambam.sorted.bam
BAI_FILE=${BAM_FILE}.bai

/usr/local/bin/bamsort \
    index=1 \
    level=1 \
    inputthreads=${INPUT_THREAD} \
    outputthreads=${OUTPUT_THREAD} \
    calmdnm=1 \
    calmdnmrecompindentonly=1 \
    calmdnmreference=${REFERENCE} \
    inputformat=sam \
    outputformat=bam \
    I=${INPUT_FILE} \
    O=${BAM_FILE} \
    indexfilename=${BAI_FILE}

echo $?

ls -l ${BAM_FILE}
ls -l ${BAM_FILE}.bai

rm -f ${BAM_FILE}
rm -f ${BAM_FILE}.bai
