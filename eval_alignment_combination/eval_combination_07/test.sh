#!/bin/bash

root_directory=$(cd $(dirname ${0}) && pwd)
config_file=${root_directory}/run_config.txt
if [ ! -f ${config_file} ]; then
	exit 1
fi
source ${config_file}

task_template_file=${root_directory}/ecsub/tasks.tsv.template
if [ ! -f ${task_template_file} ]; then
	exit 1
fi

task_name=$(basename ${root_directory})
task_file=${root_directory}/ecsub/tasks-${task_name}.tsv

/bin/bash -x ../../src/test.sh "${task_name}" \
                                "${task_file}" \
                                "${root_directory}" \
                                "${DOCKER_IMAGE}" \
                                "${AWS_EC2_INSTANCE_TYPE}" \
                                "${AWS_DISK_SIZE}" \
                                "${AWS_S3_BUCKET}" \
                                "${EVAL_DESCRIPTION}" \
                                "${EVAL_ENVIRONMENT}"
