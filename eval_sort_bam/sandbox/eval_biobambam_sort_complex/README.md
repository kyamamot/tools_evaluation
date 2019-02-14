# eval_biobambam_sort_complex

## Description
bamsort inputthreads={thread} outputthreads={thread} inputformat=sam outputformat=bam I={sam_file} O={bam_file} index=1 level=1 calmdnm=1 calmdnmrecompindentonly=1 calmdnmreference={reference} indexfilename={bai_file}

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
