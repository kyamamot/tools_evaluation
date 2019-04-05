#!/bin/bash

set -o errexit
set -o nounset

REFERENCE=${REFERENCE}/GRCh38.d1.vd1.fa

read_group='@RG\tID:12345\tPL:illumina\tLB:lib\tSM:100percent_5929'

mkdir -p ${OUTPUT_DIR}


case "${EVAL_PATTERN}" in
"samtools")
########## samtools

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
| /tools/samtools-1.9/samtools sort \
    -n \
    -l 0 \
    -@ 8 \
    -T /scratch/ \
| /tools/samtools-1.9/samtools fixmate \
    -m \
    -@ 8 \
    - \
| /tools/samtools-1.9/samtools sort \
    -l 0 \
    -@ 8 \
    -T /scratch/ \
| /tools/samtools-1.9/samtools markdup \
    -@ 8 \
    - \
    ${OUTPUT_DIR}/100percent_5929_2M_reads_extract.samtools_markdup.sort.bam

time /tools/samtools-1.9/samtools index ${OUTPUT_DIR}/100percent_5929_2M_reads_extract.samtools_markdup.sort.bam

ls -l ${OUTPUT_DIR}

;;


"picard")
########## picard

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
    --addMateTags \
    -a \
| /tools/samtools-1.9/samtools view \
    -Sbhu \
| /tools/sambamba sort \
    -n \
    -t 8 \
    --tmpdir /scratch/ \
    -o ${OUTPUT_DIR}/temp.bam \
    /dev/stdin

time java \
    -Xms24g -Xmx24g \
    -XX:-UseContainerSupport \
    -jar /tools/picard.jar \
    MarkDuplicates \
    I=${OUTPUT_DIR}/temp.bam \
    O=/dev/stdout \
    METRICS_FILE=/dev/null \
    ASSUME_SORT_ORDER=queryname \
    QUIET=true \
    COMPRESSION_LEVEL=0 \
| /tools/sambamba sort \
    -n \
    -t 8 \
    --tmpdir /scratch/ \
    -o ${OUTPUT_DIR}/100percent_5929_2M_reads_extract.picard_markdup.sort.bam \
    /dev/stdin

rm -f temp.bam
ls -l ${OUTPUT_DIR}

;;


"gatk-spark")
########## gatk-spark

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
    --addMateTags \
    -a \
| /tools/samtools-1.9/samtools view \
    -Sbhu \
    > ${OUTPUT_DIR}/temp.bam

time /tools/gatk-4.1.1.0/gatk MarkDuplicatesSpark \
    --java-options "-XX:-UseContainerSupport -Xms24g -Xmx24g" \
    -tmp-dir /scratch \
    -I ${OUTPUT_DIR}/temp.bam \
    -O ${OUTPUT_DIR}/100percent_5929_2M_reads_extract.gatk-spark.sort.bam

rm -f temp.bam
ls -l ${OUTPUT_DIR}

;;


esac
