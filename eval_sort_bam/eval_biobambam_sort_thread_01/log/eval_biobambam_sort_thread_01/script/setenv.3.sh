export SAMPLE="5929_tumor"
export S3_INPUT_FILE="s3://keisuke-singapore/sample/exome/5929_tumor_100/sam/5929_tumor.sam"
export INPUT_FILE="/scratch/AWS_DATA/keisuke-singapore/sample/exome/5929_tumor_100/sam/5929_tumor.sam"
export S3_REFERENCE="s3://keisuke-singapore/_GRCh38/reference/GRCh38.d1.vd1/"
export REFERENCE="/scratch/AWS_DATA/keisuke-singapore/_GRCh38/reference/GRCh38.d1.vd1/"
export S3_OUTPUT_DIR="s3://keisuke-singapore/sample/exome/5929_tumor_100/bam/"
export OUTPUT_DIR="/scratch/AWS_DATA/keisuke-singapore/sample/exome/5929_tumor_100/bam/"
export SORT_OPTION="inputformat=sam outputformat=bam outputthreads=8"
export EVAL_CONDITION="in=sam,o_thread=8"
