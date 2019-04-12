set -ex
pwd

SCRIPT_ENVM_NAME=`basename ${SCRIPT_ENVM_PATH}`
SCRIPT_EXEC_NAME=`basename ${SCRIPT_EXEC_PATH}`

aws s3 cp ${SCRIPT_ENVM_PATH} ${SCRIPT_ENVM_NAME} --only-show-errors
aws s3 cp ${SCRIPT_EXEC_PATH} ${SCRIPT_EXEC_NAME} --only-show-errors

source ${SCRIPT_ENVM_NAME}
df -h

if test -n "$INPUT_BAM"; then aws s3 cp --only-show-errors  $S3_INPUT_BAM $INPUT_BAM; fi


# exec
/bin/bash ${SCRIPT_EXEC_NAME}

#if [ $? -gt 0 ]; then exit $?; fi

# upload
if test -n "$OUTPUT_DIR"; then aws s3 cp --only-show-errors --recursive $OUTPUT_DIR $S3_OUTPUT_DIR; fi

