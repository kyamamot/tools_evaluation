# eval_sambamba_sort

## Description
samtools view <samtools_view_option> -@ 8 <sam_file> | { samtools sort [-n] -@ 8 -m 4G | sambamba sort [-n] -t 8 -m 4G }

## Computing Environment
aws m5.4xlarge EC2 spot instance - 16 cpu, 64GiB memory, 120GB EBS

## Running Time
![Running Time](output/running_time.png)

## CPU Utilization
![CPU Utilization](output/cpu_utilization.png)

## Memory Utilization
![Memory Utilization](output/memory_utilization.png)

## Disk Storage Usage
![Disk Storage Usage](output/disk_storage_usage.png)
