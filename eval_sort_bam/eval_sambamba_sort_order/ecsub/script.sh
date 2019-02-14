#!/bin/bash

set -o errexit
set -o nounset

mkdir -p ${OUTPUT_DIR}

sorted_bam_file=${OUTPUT_DIR}/${SAMPLE}.sorted.bam
sorted_bai_file_1=${sorted_bam_file%.bam}.bai
sorted_bai_file_2=${sorted_bam_file}.bai

time /tools/sambamba-0.6.8-linux-static sort ${SORT_ORDER} -t 8 --tmpdir /scratch -o ${sorted_bam_file} ${INPUT_FILE}

ls -l ${OUTPUT_DIR}

rm -f ${sorted_bam_file}
rm -f ${sorted_bai_file_1}
rm -f ${sorted_bai_file_2}
