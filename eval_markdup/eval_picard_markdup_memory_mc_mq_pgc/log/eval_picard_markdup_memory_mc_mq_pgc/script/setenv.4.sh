export SAMPLE="5929_tumor"
export S3_INPUT_BAM="s3://keisuke-nccj-otsuka/sample/exome/5929_tumor_100/bam/5929_tumor.samblaster_matetag.namesort.bam"
export INPUT_BAM="/scratch/AWS_DATA/keisuke-nccj-otsuka/sample/exome/5929_tumor_100/bam/5929_tumor.samblaster_matetag.namesort.bam"
export S3_OUTPUT_DIR="s3://keisuke-nccj-otsuka/sample/exome/5929_tumor_100/bam/"
export OUTPUT_DIR="/scratch/AWS_DATA/keisuke-nccj-otsuka/sample/exome/5929_tumor_100/bam/"
export JAVA_OPTION="-XX:-UseContainerSupport -Xms1g -Xmx1g -XX:+UseParallelGC"
export EVAL_CONDITION="-Xms1g -Xmx1g -XX:+UseParallelGC"
