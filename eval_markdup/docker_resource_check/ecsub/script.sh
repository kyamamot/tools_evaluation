#!/bin/bash

set -o errexit
set -o nounset

mkdir -p ${OUTPUT_DIR}

output_bam=${OUTPUT_DIR}/${SAMPLE}.markdupspark.bam

ls -l /sys/fs/cgroup/
ls -l /sys/fs/cgroup/cpuset/
cat /sys/fs/cgroup/cpuset/cpuset.cpus

echo /tools/gatk-4.1.0.0/gatk MarkDuplicatesSpark \
    ${GATK_OPTION} \
    -I ${INPUT_BAM} \
    -O ${output_bam} \
    --tmp-dir /scratch

#ls -l ${OUTPUT_DIR}

#rm -f ${output_bam}
