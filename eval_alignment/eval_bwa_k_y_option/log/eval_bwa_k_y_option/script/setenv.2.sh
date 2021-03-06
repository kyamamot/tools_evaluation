export SAMPLE="5929_tumor"
export S3_INPUT_FASTQ1="s3://keisuke-singapore/sample/exome/5929_tumor_100/100percent_5929_R1.fastq.gz"
export INPUT_FASTQ1="/scratch/AWS_DATA/keisuke-singapore/sample/exome/5929_tumor_100/100percent_5929_R1.fastq.gz"
export S3_INPUT_FASTQ2="s3://keisuke-singapore/sample/exome/5929_tumor_100/100percent_5929_R2.fastq.gz"
export INPUT_FASTQ2="/scratch/AWS_DATA/keisuke-singapore/sample/exome/5929_tumor_100/100percent_5929_R2.fastq.gz"
export S3_OUTPUT_DIR="s3://keisuke-singapore/sample/exome/5929_tumor_100/sam/"
export OUTPUT_DIR="/scratch/AWS_DATA/keisuke-singapore/sample/exome/5929_tumor_100/sam/"
export S3_REFERENCE="s3://keisuke-singapore/_GRCh38/reference/GRCh38.d1.vd1/"
export REFERENCE="/scratch/AWS_DATA/keisuke-singapore/_GRCh38/reference/GRCh38.d1.vd1/"
export BWA_OPTION="-t 8 -T 0 -K 100000000 -Y"
export EVAL_CONDITION="-t 8 -T 0 -K 100000000 -Y (3)"
