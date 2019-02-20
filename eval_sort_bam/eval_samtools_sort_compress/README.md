# eval_samtools_sort_compress

## Description
samtools sort -@ 8 [-l {0|1|9}] {input_bam} -o {output_bam} <BR>Note: "-l" is compression level, from 0 (uncompressed) to 9 (best).

## Computing Environment
m5.4xlarge Amazon EC2 spot instance - 16 cpu, 64GiB memory, 120GB EBS

## Running Time
![Running Time](output/running_time.png)

## CPU Utilization
![CPU Utilization](output/cpu_utilization.png)

## Memory Utilization
![Memory Utilization](output/memory_utilization.png)

## Disk Storage Usage
![Disk Storage Usage](output/disk_storage_usage.png)
