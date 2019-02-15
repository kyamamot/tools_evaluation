export SAMPLE="5929_tumor"
export S3_INPUT_FILE="s3://keisuke-singapore/sample/exome/5929_tumor_100/sam/5929_tumor.sam"
export INPUT_FILE="/scratch/AWS_DATA/keisuke-singapore/sample/exome/5929_tumor_100/sam/5929_tumor.sam"
export S3_OUTPUT_DIR="s3://keisuke-singapore/sample/exome/5929_tumor_100/bam/"
export OUTPUT_DIR="/scratch/AWS_DATA/keisuke-singapore/sample/exome/5929_tumor_100/bam/"
export VIEW_OPTION="-S -h --format=bam -t 8"
export EVAL_CONDITION="thread=8"
