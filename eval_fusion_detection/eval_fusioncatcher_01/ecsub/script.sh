#!/bin/bash

set -o errexit
set -o nounset

input_directory=$(dirname ${FASTQ_LEFT})

time /tools/fusioncatcher/bin/fusioncatcher \
    --config=${CONFIG} \
    --data=${DATABASE} \
    --input=${input_directory} \
    --output=${OUTPUT_DIRECTORY}
