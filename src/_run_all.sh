#!/bin/bash

task_name=${1}
task_file=${2}
root_directory=${3}
docker_image=${4}
aws_ec2_instance_type=${5}
aws_disk_size=${6}
aws_s3_backet=${7}

working_directory=${root_directory}/log

# Invoke ecsub and run tasks
echo ecsub submit \
    --spot \
    --script ${root_directory}/script-${task_name}.sh \
    --tasks ${task_file} \
    --aws-s3-bucket ${aws_s3_bucket} \
    --wdir ${working_directory} \
    --image ${docker_image} \
    --aws-ec2-instance-type ${aws_ec2_instance_type} \
    --task-name ${task_name} \
    --disk-size ${aws_disk_size}

# Create charts from metrics data
metrics_directory=${working_directory}/${task_name}/metrics
if [ ! -d ${metrics_directory} ]; then
    exit 1
fi

task_condition_field_number=$(head -1 ${task_file} \
    | tr '\t' '\n' \
    | grep -n EVAL_CONDITION \
    | cut -d : -f 1)

metrics_file_suffix_list=($(ls -1 ${metrics_directory} | grep "^0-" | grep ".txt$" | sed "s/^0-//g"))

task_number=-1
tail -n +2 ${task_file} | cut -f ${task_condition_field_number} | while read task_condition
do
    task_number=$(expr ${task_number} + 1)
    for metrics_file_suffix in ${metrics_file_suffix_list[@]}
    do
        metrics_file=${metrics_directory}/${task_number}-${metrics_file_suffix}
        merged_metrics_file=${metrics_directory}/${metrics_file_suffix}
        if [ ${task_number} -eq 0 ]; then
            cp /dev/null ${merged_metrics_file}
        fi
        tail -n +2 ${metrics_file} \
            | awk -v _task_condition="${task_condition}" -F'\t' '{print _task_condition"\t"$0}' \
            >> ${merged_metrics_file}
    done
done

# Output charts 
output_directory=${root_directory}/output
Rscript ${root_directory}/../src/R/plot.R ${metrics_directory} ${output_directory}
