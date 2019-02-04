#!/bin/bash

task_name=eval_sambamba_sort
docker_image=kyamamot/eval_sambamba-0.6.8:20190201
aws_ec2_instance_type=m5.4xlarge
aws_disk_size=120
aws_s3_backet=s3://keisuke-singapore/${task_name}/


root_directory=$(cd $(dirname ${0}) && pwd)


/bin/bash ../src/_run_all.sh "${task_name}" \
                             "${docker_image}" \
                             "${aws_ec2_instance_type}" \
                             "${aws_disk_size}" \
                             "${aws_s3_backet}" \
                             "${root_directory}"
