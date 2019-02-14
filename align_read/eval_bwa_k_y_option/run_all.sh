#!/bin/bash

task_name=eval_bwa_k_y_option

root_directory=$(cd $(dirname ${0}) && pwd)
config_file=${root_directory}/run_config.txt
if [ ! -f ${config_file} ]; then
	exit 1
fi

source ${config_file}

task_template_file=${root_directory}/ecsub/tasks-${task_name}.tsv.template
if [ ! -f ${task_template_file} ]; then
	exit 1
fi

task_file=${task_template_file%.template}

cat ${task_template_file} | sed "s|___SAMPLE___|${SAMPLE}|g" \
                          | sed "s|___INPUT_FASTQ1___|${INPUT_FASTQ1}|g" \
                          | sed "s|___INPUT_FASTQ2___|${INPUT_FASTQ2}|g" \
                          | sed "s|___OUTPUT_DIR___|${OUTPUT_DIR}|g" \
                          | sed "s|___REFERENCE___|${REFERENCE}|g" \
                          > ${task_file}

/bin/bash -x ../src/_run_all.sh "${task_name}" \
                                "${task_file}" \
                                "${root_directory}" \
                                "${DOCKER_IMAGE}" \
                                "${AWS_EC2_INSTANCE_TYPE}" \
                                "${AWS_DISK_SIZE}" \
                                "${AWS_S3_BUCKET}" \
                                "${EVAL_DESCRIPTION}" \
                                "${EVAL_ENVIRONMENT}"
