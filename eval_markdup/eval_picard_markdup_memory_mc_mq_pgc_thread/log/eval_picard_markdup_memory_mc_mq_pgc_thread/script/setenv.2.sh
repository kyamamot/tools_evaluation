export SAMPLE="5929_tumor"
export S3_INPUT_BAM="s3://keisuke-singapore/sample/exome/5929_tumor_100/bam/5929_tumor.samblaster.namesort.bam"
export INPUT_BAM="/scratch/AWS_DATA/keisuke-singapore/sample/exome/5929_tumor_100/bam/5929_tumor.samblaster.namesort.bam"
export S3_OUTPUT_DIR="s3://keisuke-singapore/sample/exome/5929_tumor_100/bam/"
export OUTPUT_DIR="/scratch/AWS_DATA/keisuke-singapore/sample/exome/5929_tumor_100/bam/"
export JAVA_OPTION="-Xmx1g -XX:+UseParallelGC -XX:ParallelGCThreads=4"
export EVAL_CONDITION="-Xmx1g,-XX:PGC,-XX:PGCThread=4"
