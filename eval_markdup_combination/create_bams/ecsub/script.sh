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
| /tools/samblaster-v.0.1.24/samblaster \
    --addMateTags -a \
| /tools/samtools-1.9/samtools view \
    -Sbhu - \
> ${OUTPUT_DIR}/${SAMPLE}.samblaster_matetag.uncompress.unsort.bam

/tools/samtools-1.9/samtools sort \
    -n \
    -l 0 \
    -@ 8 \
    -o ${OUTPUT_DIR}/${SAMPLE}.samblaster_matetag.uncompress.namesort.bam \
    ${OUTPUT_DIR}/${SAMPLE}.samblaster_matetag.uncompress.unsort.bam

/tools/samtools-1.9/samtools sort \
    -n \
    -@ 8 \
    -o ${OUTPUT_DIR}/${SAMPLE}.samblaster_matetag.namesort.bam \
    ${OUTPUT_DIR}/${SAMPLE}.samblaster_matetag.uncompress.unsort.bam

/tools/samtools-1.9/samtools sort \
    -l 0 \
    -@ 8 \
    -o ${OUTPUT_DIR}/${SAMPLE}.samblaster_matetag.uncompress.sort.bam \
    ${OUTPUT_DIR}/${SAMPLE}.samblaster_matetag.uncompress.unsort.bam

/tools/samtools-1.9/samtools sort \
    -@ 8 \
    -o ${OUTPUT_DIR}/${SAMPLE}.samblaster_matetag.sort.bam \
    ${OUTPUT_DIR}/${SAMPLE}.samblaster_matetag.uncompress.unsort.bam
