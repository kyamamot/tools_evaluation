set -ex
pwd

SCRIPT_SETENV_NAME=`basename ${SCRIPT_SETENV_PATH}`
SCRIPT_RUN_NAME=`basename ${SCRIPT_RUN_PATH}`
SCRIPT_DOWNLOADER_NAME=`basename ${SCRIPT_DOWNLOADER_PATH}`
SCRIPT_UPLOADER_NAME=`basename ${SCRIPT_UPLOADER_PATH}`

aws s3 cp  ${SCRIPT_SETENV_PATH} ${SCRIPT_SETENV_NAME} --only-show-errors
aws s3 cp  ${SCRIPT_RUN_PATH} ${SCRIPT_RUN_NAME} --only-show-errors
aws s3 cp  ${SCRIPT_DOWNLOADER_PATH} ${SCRIPT_DOWNLOADER_NAME} --only-show-errors
aws s3 cp  ${SCRIPT_UPLOADER_PATH} ${SCRIPT_UPLOADER_NAME} --only-show-errors

source ${SCRIPT_SETENV_NAME}
df -h

/bin/bash ${SCRIPT_DOWNLOADER_NAME}

# run main script
/bin/bash ${SCRIPT_RUN_NAME}

#if [ $? -gt 0 ]; then exit $?; fi

# upload
/bin/bash ${SCRIPT_UPLOADER_NAME}
