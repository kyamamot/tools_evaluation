#!/bin/bash

set -o errexit
set -o nounset

REFERENCE=${REFERENCE}/GRCh38.d1.vd1.fa

mkdir -p ${OUTPUT_DIR}

output_file=${OUTPUT_DIR}/${SAMPLE}.uncompressed.name-sorted.bam

read_group='@RG\tID:12345\tPL:illumina\tLB:lib\tSM:5929_tumor'

case "${TOOL_COMBINATION}" in
    "0")
        # bwa only
        time /tools/bwa-0.7.17/bwa mem ${BWA_OPTION} -R "${read_group}" ${REFERENCE} ${INPUT_FASTQ1} ${INPUT_FASTQ2} > ${output_file}
        ;;
    "1")
        # all samtools
        time /tools/bwa-0.7.17/bwa mem ${BWA_OPTION} -R "${read_group}" ${REFERENCE} ${INPUT_FASTQ1} ${INPUT_FASTQ2} \
            | /tools/samtools-1.9/samtools view ${SAMTOOLS_VIEW_OPTION} \
            | /tools/samtools-1.9/samtools sort ${SAMTOOLS_SORT_OPTION} -o ${output_file}
        ;;
    "2")
        # all sambamba
        time /tools/bwa-0.7.17/bwa mem ${BWA_OPTION} -R "${read_group}" ${REFERENCE} ${INPUT_FASTQ1} ${INPUT_FASTQ2} \
            | /tools/sambamba view ${SAMBAMBA_VIEW_OPTION} /dev/stdin \
            | /tools/sambamba sort ${SAMBAMBA_SORT_OPTION} -o ${output_file} /dev/stdin
        ;;
    "3")
        # samtools view and sambamba sort
        time /tools/bwa-0.7.17/bwa mem ${BWA_OPTION} -R "${read_group}" ${REFERENCE} ${INPUT_FASTQ1} ${INPUT_FASTQ2} \
            | /tools/samtools-1.9/samtools view ${SAMTOOLS_VIEW_OPTION} \
            | /tools/sambamba sort ${SAMBAMBA_SORT_OPTION} -o ${output_file} /dev/stdin
        ;;
    "4")
        # biobambam sort
        time /tools/bwa-0.7.17/bwa mem ${BWA_OPTION} -R "${read_group}" ${REFERENCE} ${INPUT_FASTQ1} ${INPUT_FASTQ2} \
            | /usr/local/bin/bamsort ${BIOBAMBAM_OPTION} O=${output_file}
        ;;
esac

samtools view ${output_file} | head -10

ls -lh ${OUTPUT_DIR}

rm -f ${output_file}
