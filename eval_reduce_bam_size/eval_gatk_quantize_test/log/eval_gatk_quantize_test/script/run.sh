set -ex
pwd

SCRIPT_ENVM_NAME=`basename ${SCRIPT_ENVM_PATH}`
SCRIPT_EXEC_NAME=`basename ${SCRIPT_EXEC_PATH}`

aws s3 cp ${SCRIPT_ENVM_PATH} ${SCRIPT_ENVM_NAME} --only-show-errors
aws s3 cp ${SCRIPT_EXEC_PATH} ${SCRIPT_EXEC_NAME} --only-show-errors

source ${SCRIPT_ENVM_NAME}
df -h

if test -n "$INPUT_DIR"; then aws s3 cp --only-show-errors --recursive $S3_INPUT_DIR $INPUT_DIR; fi
if test -n "$DATABASE_DIR"; then aws s3 cp --only-show-errors --recursive $S3_DATABASE_DIR $DATABASE_DIR; fi
if test -n "$REFERENCE_DIR"; then aws s3 cp --only-show-errors --recursive $S3_REFERENCE_DIR $REFERENCE_DIR; fi


# exec
/bin/bash ${SCRIPT_EXEC_NAME}

#if [ $? -gt 0 ]; then exit $?; fi

# upload
if test -n "$OUTPUT_DIR"; then aws s3 cp --only-show-errors --recursive $OUTPUT_DIR $S3_OUTPUT_DIR; fi

