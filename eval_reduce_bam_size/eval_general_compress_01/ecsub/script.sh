#!/bin/bash

set -o errexit
set -o nounset

pwd

mkdir -p ${OUTPUT_DIR}

echo "sample: ${SAMPLE}"
echo "input fastq 1: ${INPUT_FASTQ1}"
echo "input fastq 2: ${INPUT_FASTQ2}"
echo "cwd: $(pwd)"

fq1_gz=$(basename ${INPUT_FASTQ1})
fq1=${fq1_gz%.gz}

fq2_gz=$(basename ${INPUT_FASTQ2})
fq2=${fq2_gz%.gz}

fq1_dir=$(dirname ${INPUT_FASTQ1})
fq2_dir=$(dirname ${INPUT_FASTQ2})
ls -l ${fq1_dir}
ls -lh ${fq1_dir}
ls -l ${fq2_dir}
ls -lh ${fq2_dir}

time gunzip ${INPUT_FASTQ1}
time gunzip ${INPUT_FASTQ2}
ls -l ${fq1_dir}
ls -lh ${fq1_dir}
ls -l ${fq2_dir}
ls -lh ${fq2_dir}

bzip2 ${fq1_dir}/${fq1}
bzip2 ${fq2_dir}/${fq2}
ls -l ${fq1_dir}
ls -lh ${fq1_dir}
ls -l ${fq2_dir}
ls -lh ${fq2_dir}
