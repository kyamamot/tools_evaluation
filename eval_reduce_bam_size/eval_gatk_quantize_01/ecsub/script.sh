#!/bin/bash

set -o errexit
set -o nounset

reference_fasta=${REFERENCE_DIR}/GRCh37.fa
#reference_fasta=${REFERENCE_DIR}/GRCh38.d1.vd1.fa


mkdir -p ${OUTPUT_DIR}

input_bam=${INPUT_DIR}/${SAMPLE}.markdup.bam

work_bam=${OUTPUT_DIR}/${SAMPLE}.addrg.bam
time java -jar /tools/picard.jar AddOrReplaceReadGroups \
    I=${input_bam} \
    O=${work_bam} \
    RGID=1 \
    RGLB=library1 \
    RGPL=illumina \
    RGPU=unit1 \
    RGSM=sample1 \
    VALIDATION_STRINGENCY=SILENT

rm -f ${input_bam}

ls -l ${OUTPUT_DIR}
ls -lh ${OUTPUT_DIR}

time samtools index \
    -@ 16 \
    ${work_bam}

ls -l ${OUTPUT_DIR}
ls -lh ${OUTPUT_DIR}

recal_report=${OUTPUT_DIR}/${SAMPLE}.recal_report.txt
time java -jar /tools/GenomeAnalysisTK-3.8-1.jar \
    -T BaseRecalibrator \
    -I ${work_bam} \
    -R ${reference_fasta} \
    -o ${recal_report} \
    -nct 16 \
    -L 1 -L 2 -L 3 -L 4 -L 5 -L 6 -L 7 -L 8 -L 9 -L 10 \
    -L 11 -L 12 -L 13 -L 14 -L 15 -L 16 -L 17 -L 18 -L 19 \
    -L 20 -L 21 -L 22 \
    -knownSites ${DATABASE_DIR}/Mills_and_1000G_gold_standard.indels.hg38.vcf.gz

ls -l ${OUTPUT_DIR}
ls -lh ${OUTPUT_DIR}

output_bam=${OUTPUT_DIR}/${SAMPLE}.quantize.bam
time java -jar /tools/GenomeAnalysisTK-3.8-1.jar \
    -T PrintReads \
    -I ${work_bam} \
    -o ${output_bam} \
    --BQSR ${recal_report} \
    --globalQScorePrior -1.0 \
    --preserve_qscores_less_than 6 \
    --static_quantized_quals 10 \
    --static_quantized_quals 20 \
    --static_quantized_quals 30 \
    -R ${reference_fasta}

ls -l ${OUTPUT_DIR}
ls -lh ${OUTPUT_DIR}

output_cram=${OUTPUT_DIR}/${SAMPLE}.cram
time samtools view \
    -@ 16 \
    -C \
    -T ${reference_fasta} \
    -o ${output_cram} \
    ${output_bam}

ls -l ${OUTPUT_DIR}
ls -lh ${OUTPUT_DIR}
