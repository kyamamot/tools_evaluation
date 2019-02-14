#!/bin/bash

script_directory=$(cd $(dirname ${0}) && pwd)

for eval_directory in $(ls -1d ${script_directory}/../eval_*/eval_*)
do
	eval_name=$(basename ${eval_directory})
	metrics_directory=${eval_directory}/log/${eval_name}/metrics
	output_directory=${eval_directory}/output

	if [ ! -d ${metrics_directory} ]; then
		continue
	fi

	if [ ! -d ${output_directory} ]; then
		continue
	fi

	echo "re-plotting: ${eval_name}"
	Rscript ${script_directory}/R/plot.R ${metrics_directory} ${output_directory}
done


