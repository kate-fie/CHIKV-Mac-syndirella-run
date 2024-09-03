#!/bin/bash

# Check if the user provided a JOB_LIST file as an argument
if [ "$#" -ne 1 ]; then
    echo "Usage: $0 job_list_file"
    exit 1
fi

# Use the first argument as the JOB_LIST file
JOB_LIST="$1"

# Log file to store job IDs
LOG_FILE="/opt/xchem-fragalysis-2/kfieseler/logs/CHIKV_first10_job_ids.log"

# Clear the log file if it already exists
> $LOG_FILE

# Loop through each job script in the list
while IFS= read -r job_script; do
    if [[ -f "$job_script" ]]; then
        # Submit the job and capture the job ID
        job_id=$(sbatch "$job_script" | awk '{print $4}')

        # Log the job ID with the corresponding script name
        echo "$job_script: $job_id" >> $LOG_FILE

        # Wait for 30 seconds before submitting the next job
        sleep 30
    else
        echo "Job script $job_script not found!" >> $LOG_FILE
    fi
done < "$JOB_LIST"

