#!/bin/bash

set -o errexit
set -o nounset

mkdir -p ${OUTPUT_DIR}

BAM_FILE=${OUTPUT_DIR}/${SAMPLE}.bam
BAI_FILE=${BAM_FILE}.bai

if [ "${SORT_TOOL}" == "samtools" ]; then
	if [ "${SORT_KEY}" == "name" ]; then
		time /usr/local/bin/samtools view ${SAMTOOLS_VIEW_OPTION} -@ ${THREAD} ${SAM_FILE} | /usr/local/bin/samtools sort -n -@ ${THREAD} -m ${SORT_MEMORY} - > ${BAM_FILE}
	elif [ "${SORT_KEY}" == "coordinate" ]; then
		time /usr/local/bin/samtools view ${SAMTOOLS_VIEW_OPTION} -@ ${THREAD} ${SAM_FILE} | /usr/local/bin/samtools sort -@ ${THREAD} -m ${SORT_MEMORY} - > ${BAM_FILE}
	fi

elif [ "${SORT_TOOL}" == "sambamba" ]; then
	if [ "${SORT_KEY}" == "name" ]; then
		time /usr/local/bin/samtools view ${SAMTOOLS_VIEW_OPTION} -@ ${THREAD} ${SAM_FILE} | /usr/local/bin/sambamba-0.6.8-linux-static sort -n -t ${THREAD} -m ${SORT_MEMORY} -o ${BAM_FILE} /dev/stdin
	elif [ "${SORT_KEY}" == "coordinate" ]; then
		time /usr/local/bin/samtools view ${SAMTOOLS_VIEW_OPTION} -@ ${THREAD} ${SAM_FILE} | /usr/local/bin/sambamba-0.6.8-linux-static sort -t ${THREAD} -m ${SORT_MEMORY} -o ${BAM_FILE} /dev/stdin
	fi
fi

echo $?

ls -l ${BAM_FILE}
ls -l ${BAM_FILE}.bai

rm -f ${BAM_FILE}
rm -f ${BAM_FILE}.bai
