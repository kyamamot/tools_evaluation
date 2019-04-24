aws s3 cp --only-show-errors  s3://ncc-otsuka-clinseq/data/fastq/CCRF_CEM_R1.fastq /scratch/AWS_DATA/ncc-otsuka-clinseq/data/fastq/CCRF_CEM_R1.fastq
aws s3 cp --only-show-errors  s3://ncc-otsuka-clinseq/data/fastq/CCRF_CEM_R2.fastq /scratch/AWS_DATA/ncc-otsuka-clinseq/data/fastq/CCRF_CEM_R2.fastq
aws s3 cp --only-show-errors  s3://keisuke-nccj-otsuka/config/fusioncatcher/configuration.cfg /scratch/AWS_DATA/keisuke-nccj-otsuka/config/fusioncatcher/configuration.cfg
aws s3 cp --only-show-errors --recursive s3://keisuke-nccj-otsuka/database/fusioncatcher/human_v95/ /scratch/AWS_DATA/keisuke-nccj-otsuka/database/fusioncatcher/human_v95/
