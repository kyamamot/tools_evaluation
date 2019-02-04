#!/bin/bash

task_name=eval_bwa_thread
docker_image=kyamamot/eval_bwa-0.7.17:20190204
aws_ec2_instance_type=m5.4xlarge
aws_disk_size=80
aws_s3_bucket=s3://keisuke-singapore/${task_name}/


root_directory=$(cd $(dirname ${0}) && pwd)


/bin/bash -x ../src/_run_all.sh "${task_name}" \
                                "${docker_image}" \
                                "${aws_ec2_instance_type}" \
                                "${aws_disk_size}" \
                                "${aws_s3_bucket}" \
                                "${root_directory}"
