#!/bin/bash

set -o errexit
set -o nounset

REFERENCE=${REFERENCE}/GRCh38.d1.vd1.fa

mkdir -p ${OUTPUT_DIR}

read_group='@RG\tID:12345\tPL:illumina\tLB:lib\tSM:100percent_5929'

case "${TOOL_COMBINATION}" in
    "0")
        # bwa only

        output_file=${OUTPUT_DIR}/${SAMPLE}.sam

        time /tools/bwa-0.7.17/bwa mem \
                -T 0 \
                -K 100000000 \
                -Y \
                -t 8 \
                -R "${read_group}" \
                ${REFERENCE} \
                ${INPUT_FASTQ1} \
                ${INPUT_FASTQ2} \
                > ${output_file}

        rm -f ${output_file}

        ;;
    "1")
        # without samblaster

        output_file=${OUTPUT_DIR}/${SAMPLE}.namesort.bam

        time /tools/bwa-0.7.17/bwa mem \
                -T 0 \
                -K 100000000 \
                -Y \
                -t 8 \
                -R "${read_group}" \
                ${REFERENCE} \
                ${INPUT_FASTQ1} \
                ${INPUT_FASTQ2} \
            | /tools/samtools-1.9/samtools view \
                -Sbhu \
            | /tools/sambamba sort \
                -n \
                -t 8 \
                --tmpdir /scratch/ \
                -o ${output_file} \
                /dev/stdin
        ;;
    "2")
        # with samblaster

        output_file=${OUTPUT_DIR}/${SAMPLE}.samblaster.namesort.bam

        time /tools/bwa-0.7.17/bwa mem \
                -T 0 \
                -K 100000000 \
                -Y \
                -t 8 \
                -R "${read_group}" \
                ${REFERENCE} \
                ${INPUT_FASTQ1} \
                ${INPUT_FASTQ2} \
            | /tools/samblaster-v.0.1.24/samblaster \
                --addMateTags \
                -a \
            | /tools/samtools-1.9/samtools view \
                -Sbhu \
            | /tools/sambamba sort \
                -n \
                -t 8 \
                --tmpdir /scratch/ \
                -o ${output_file} \
                /dev/stdin
        ;;
esac
