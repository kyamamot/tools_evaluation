#!/bin/bash

set -o errexit
set -o nounset

REFERENCE=${REFERENCE}/GRCh38.d1.vd1.fa

read_group='@RG\tID:12345\tPL:illumina\tLB:lib\tSM:100percent_5929'

mkdir -p ${OUTPUT_DIR}


case "${EVAL_PATTERN}" in
"bwa")
########## bwa only
time /tools/bwa-0.7.17/bwa mem \
    -T 0 \
    -K 10000000 \
    -Y \
    -t 16 \
    -R "${read_group}" \
    ${REFERENCE} \
    ${INPUT_FASTQ1} \
    ${INPUT_FASTQ2} \
    > ${OUTPUT_DIR}/${SAMPLE}.sam

ls -l ${OUTPUT_DIR}
rm -f ${OUTPUT_DIR}/${SAMPLE}.sam

;;


"samtools")
########## samtools

time /tools/bwa-0.7.17/bwa mem \
    -T 0 \
    -K 10000000 \
    -Y \
    -t 16 \
    -R "${read_group}" \
    ${REFERENCE} \
    ${INPUT_FASTQ1} \
    ${INPUT_FASTQ2} \
| /tools/samtools-1.9/samtools view \
    -Sbhu \
| /tools/samtools-1.9/samtools sort \
    -n \
    -l 0 \
    -@ 16 \
    -T /scratch/ \
| /tools/samtools-1.9/samtools fixmate \
    -m \
    -@ 16 \
    - \
    - \
| /tools/samtools-1.9/samtools sort \
    -l 0 \
    -@ 16 \
    -T /scratch/ \
| /tools/samtools-1.9/samtools markdup \
    -@ 16 \
    - \
    ${OUTPUT_DIR}/${SAMPLE}.samtools_markdup.sort.bam

time /tools/samtools-1.9/samtools index \
    -@ 16 \
    ${OUTPUT_DIR}/${SAMPLE}.samtools_markdup.sort.bam

ls -l ${OUTPUT_DIR}
rm -f ${OUTPUT_DIR}/${SAMPLE}.samtools_markdup.sort.bam
rm -f ${OUTPUT_DIR}/${SAMPLE}.samtools_markdup.sort.bam.bai

;;


"picard")
########## picard

time /tools/bwa-0.7.17/bwa mem \
    -T 0 \
    -K 10000000 \
    -Y \
    -t 16 \
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
    -t 16 \
    --tmpdir /scratch/ \
    -o ${OUTPUT_DIR}/temp.bam \
    /dev/stdin

time java \
    -Xmx1g \
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
    -t 16 \
    --tmpdir /scratch/ \
    -o ${OUTPUT_DIR}/${SAMPLE}.picard_markdup.sort.bam \
    /dev/stdin

rm -f ${OUTPUT_DIR}/temp.bam
ls -l ${OUTPUT_DIR}
rm -f ${OUTPUT_DIR}/${SAMPLE}.picard_markdup.sort.bam
rm -f ${OUTPUT_DIR}/${SAMPLE}.picard_markdup.sort.bam.bai

;;


"gatk-spark-1")
########## gatk-spark unsort/uncompress BAM input

time /tools/bwa-0.7.17/bwa mem \
    -T 0 \
    -K 10000000 \
    -Y \
    -t 16 \
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
    --java-options "-XX:-UseContainerSupport" \
    --create-output-bam-index false --create-output-bam-splitting-index false --create-output-variant-index false \
    -tmp-dir /scratch \
    -I ${OUTPUT_DIR}/temp.bam \
    -O ${OUTPUT_DIR}/${SAMPLE}.gatkspark1_markdup.sort.bam

time /tools/samtools-1.9/samtools index \
    -@ 16 \
    ${OUTPUT_DIR}/${SAMPLE}.gatkspark1_markdup.sort.bam

rm -f ${OUTPUT_DIR}/temp.bam
ls -l ${OUTPUT_DIR}
rm -f ${OUTPUT_DIR}/${SAMPLE}.gatkspark1_markdup.sort.bam
rm -f ${OUTPUT_DIR}/${SAMPLE}.gatkspark1_markdup.sort.bam.bai

;;


"gatk-spark-2")
########## gatk-spark unsort/compress BAM input

time /tools/bwa-0.7.17/bwa mem \
    -T 0 \
    -K 10000000 \
    -Y \
    -t 16 \
    -R "${read_group}" \
    ${REFERENCE} \
    ${INPUT_FASTQ1} \
    ${INPUT_FASTQ2} \
| /tools/samblaster-v.0.1.24/samblaster \
    --addMateTags \
    -a \
| /tools/samtools-1.9/samtools view \
    -Sbh \
    -@ 16 \
    > ${OUTPUT_DIR}/temp.bam

time /tools/gatk-4.1.1.0/gatk MarkDuplicatesSpark \
    --java-options "-XX:-UseContainerSupport" \
    --create-output-bam-index false --create-output-bam-splitting-index false --create-output-variant-index false \
    -tmp-dir /scratch \
    -I ${OUTPUT_DIR}/temp.bam \
    -O ${OUTPUT_DIR}/${SAMPLE}.gatkspark2_markdup.sort.bam

time /tools/samtools-1.9/samtools index \
    -@ 16 \
    ${OUTPUT_DIR}/${SAMPLE}.gatkspark2_markdup.sort.bam

rm -f ${OUTPUT_DIR}/temp.bam
ls -l ${OUTPUT_DIR}
rm -f ${OUTPUT_DIR}/${SAMPLE}.gatkspark2_markdup.sort.bam
rm -f ${OUTPUT_DIR}/${SAMPLE}.gatkspark2_markdup.sort.bam.bai

;;


"gatk-spark-3")
########## gatk-spark name-sort BAM input

time /tools/bwa-0.7.17/bwa mem \
    -T 0 \
    -K 10000000 \
    -Y \
    -t 16 \
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
    -t 16 \
    --tmpdir /scratch/ \
    -o ${OUTPUT_DIR}/temp.bam \
    /dev/stdin

time /tools/gatk-4.1.1.0/gatk MarkDuplicatesSpark \
    --java-options "-XX:-UseContainerSupport" \
    --create-output-bam-index false --create-output-bam-splitting-index false --create-output-variant-index false \
    -tmp-dir /scratch \
    -I ${OUTPUT_DIR}/temp.bam \
    -O ${OUTPUT_DIR}/${SAMPLE}.gatkspark3_markdup.sort.bam

time /tools/samtools-1.9/samtools index \
    -@ 16 \
    ${OUTPUT_DIR}/${SAMPLE}.gatkspark3_markdup.sort.bam

rm -f ${OUTPUT_DIR}/temp.bam
ls -l ${OUTPUT_DIR}
rm -f ${OUTPUT_DIR}/${SAMPLE}.gatkspark3_markdup.sort.bam
rm -f ${OUTPUT_DIR}/${SAMPLE}.gatkspark3_markdup.sort.bam.bai

;;


"gatk-spark-4")
########## gatk-spark SAM input

time /tools/bwa-0.7.17/bwa mem \
    -T 0 \
    -K 10000000 \
    -Y \
    -t 16 \
    -R "${read_group}" \
    ${REFERENCE} \
    ${INPUT_FASTQ1} \
    ${INPUT_FASTQ2} \
| /tools/samblaster-v.0.1.24/samblaster \
    --addMateTags \
    -a \
    > ${OUTPUT_DIR}/temp.sam

time /tools/gatk-4.1.1.0/gatk MarkDuplicatesSpark \
    --java-options "-XX:-UseContainerSupport" \
    --create-output-bam-index false --create-output-bam-splitting-index false --create-output-variant-index false \
    -tmp-dir /scratch \
    -I ${OUTPUT_DIR}/temp.sam \
    -O ${OUTPUT_DIR}/${SAMPLE}.gatkspark4_markdup.sort.bam

time /tools/samtools-1.9/samtools index \
    -@ 16 \
    ${OUTPUT_DIR}/${SAMPLE}.gatkspark4_markdup.sort.bam

rm -f ${OUTPUT_DIR}/temp.sam
ls -l ${OUTPUT_DIR}
rm -f ${OUTPUT_DIR}/${SAMPLE}.gatkspark4_markdup.sort.bam
rm -f ${OUTPUT_DIR}/${SAMPLE}.gatkspark4_markdup.sort.bam.bai

;;

esac
