export SAMPLE="5929_tumor"
export S3_INPUT_FASTQ1="s3://keisuke-singapore/sample/exome/5929_tumor_100/100percent_5929_R1.fastq.gz"
export INPUT_FASTQ1="/scratch/AWS_DATA/keisuke-singapore/sample/exome/5929_tumor_100/100percent_5929_R1.fastq.gz"
export S3_INPUT_FASTQ2="s3://keisuke-singapore/sample/exome/5929_tumor_100/100percent_5929_R2.fastq.gz"
export INPUT_FASTQ2="/scratch/AWS_DATA/keisuke-singapore/sample/exome/5929_tumor_100/100percent_5929_R2.fastq.gz"
export S3_REFERENCE="s3://keisuke-singapore/_GRCh38/reference/GRCh38.d1.vd1/"
export REFERENCE="/scratch/AWS_DATA/keisuke-singapore/_GRCh38/reference/GRCh38.d1.vd1/"
export S3_OUTPUT_DIR="s3://keisuke-singapore/sample/exome/5929_tumor_100/temp/"
export OUTPUT_DIR="/scratch/AWS_DATA/keisuke-singapore/sample/exome/5929_tumor_100/temp/"
export BWA_OPTION="-T 0 -K 100000000 -Y -t 8"
export SAMTOOLS_VIEW_OPTION="-Sbhu --threads 8"
export SAMBAMBA_VIEW_OPTION="-S -h --format=bam -t 8"
export SAMTOOLS_SORT_OPTION="-n --threads 8 -T /scratch/5959_tumor"
export SAMBAMBA_SORT_OPTION="-n -l 1 --tmpdir /scratch/ -t 8"
export BIOBAMBAM_OPTION="inputformat=sam outputformat=bam outputthreads=8 tmpfile=/scratch/5929_tumor SO=queryname"
export TOOL_COMBINATION="4"
export EVAL_CONDITION="bwa mem | biobambam/bamsort (t=8,8) (comp=yes)"
