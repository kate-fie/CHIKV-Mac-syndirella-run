# CHIKV-Mac-syndirella-run

Method for running:
1. All syndirella input csvs are in [csvs](csvs) (containing 1 scaffold as 1 row).
2. All job scripts are in [jobs](jobs) to run each csv.
3. The [run_jobs.sh](run_jobs.sh) script will submit all job scripts in [jobs](jobs) with 30 seconds sleep. 

Running the script:
```bash
chmod +x run_jobs.sh
./run_jobs.sh first_10_jobs.txt /opt/xchem-fragalysis-2/kfieseler/CHIKV-Mac-syndirella-run/jobs
```

Arguments:
```bash
export INPUT="/opt/xchem-fragalysis-2/kfieseler/CHIKV-Mac-syndirella-run/syndirella_input/inputNUM.csv"
export OUTPUT="/opt/xchem-fragalysis-2/kfieseler/CHIKV-Mac/"
export TEMPLATES="/opt/xchem-fragalysis-2/kfieseler/CHIKV-Mac-syndirella-run/fragments/templates";
export HITS="/opt/xchem-fragalysis-2/kfieseler/CHIKV-Mac-syndirella-run/fragments/A71EV2A_combined.sdf";
export METADATA="/opt/xchem-fragalysis-2/kfieseler/CHIKV-Mac-syndirella-run/fragments/metadata.csv";
```

Future headache:
1. Make a script that will read in all output csvs and combine them into one csv.