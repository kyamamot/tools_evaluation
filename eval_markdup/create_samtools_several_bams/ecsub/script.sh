#!/bin/bash

set -o errexit
set -o nounset

REFERENCE=${REFERENCE}/GRCh38.d1.vd1.fa

read_group='@RG\tID:12345\tPL:illumina\tLB:lib\tSM:100percent_5929'

mkdir -p ${OUTPUT_DIR}

time /tools/bwa-0.7.17/bwa mem \
    -T 0 \
    -K 10000000 \
    -Y \
    -t 8 \
    -R "${read_group}" \
    ${REFERENCE} \
    ${INPUT_FASTQ1} \
    ${INPUT_FASTQ2} \
| /tools/samtools-1.9/samtools view \
    -Sbhu \
    -o ${OUTPUT_DIR}/${SAMPLE}.uncompress.unsort.bam


/tools/samtools-1.9/samtools sort \
    -n \
    -@ 8 \
    -o ${OUTPUT_DIR}${SAMPLE}.namesort.bam \
    ${OUTPUT_DIR}/${SAMPLE}.uncompress.unsort.bam



/tools/samtools-1.9/samtools fixmate \
    -m \
    -@ 8 \
    ${OUTPUT_DIR}/${SAMPLE}.namesort.bam \
    ${OUTPUT_DIR}/${SAMPLE}.samtools_fixmate.namesort.bam


/tools/samtools-1.9/samtools sort \
    -@ 8 \
    -o ${OUTPUT_DIR}${SAMPLE}.samtools_fixmate.sort.bam \
    ${OUTPUT_DIR}/${SAMPLE}.samtools_fixmate.namesort.bam
