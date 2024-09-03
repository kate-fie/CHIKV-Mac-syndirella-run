#!/bin/bash

#SBATCH --job-name=CHIKV
#SBATCH --chdir=/opt/xchem-fragalysis-2/kfieseler
#SBATCH --output=/opt/xchem-fragalysis-2/kfieseler/logs/slurm-log_%x_%j.log
#SBATCH --error=/opt/xchem-fragalysis-2/kfieseler/logs/slurm-error_%x_%j.log
# gpu partition is `gpu`
#SBATCH --partition=main
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=3GB
##SBATCH --time=01:00:00

# extras
##SBATCH --nodes=1
##SBATCH --exclusive
##SBATCH --mem-per-cpu=<memory>
##SBATCH --gres=gpu:1
##SBATCH --constraint=<constraint>
# this does nothing
#SBATCH --mail-type=END
#SBATCH --mail-user=kate.fieseler@stats.ox.ac.uk

# -------------------------------------------------------

export SUBMITTER_HOST=$HOST
export HOST=$( hostname )
export USER=${USER:-$(users)}
export HOME=$HOME
source /etc/os-release;

echo "Running $SLURM_JOB_NAME ($SLURM_JOB_ID) as $USER in $HOST which runs $PRETTY_NAME submitted from $SUBMITTER_HOST"
echo "Request had cpus=$SLURM_JOB_CPUS_PER_NODE mem=$SLURM_MEM_PER_NODE tasks=$SLURM_NTASKS jobID=$SLURM_JOB_ID partition=$SLURM_JOB_PARTITION jobName=$SLURM_JOB_NAME"
echo "Started at $SLURM_JOB_START_TIME"
echo "job_pid=$SLURM_TASK_PID job_gid=$SLURM_JOB_GID topology_addr=$SLURM_TOPOLOGY_ADDR home=$HOME cwd=$PWD"

# -------------------------------------------------------
# CONDA
source /opt/xchem-fragalysis-2/kfieseler/.bashrc
# debug
echo '$CONDA_PREFIX = ' $CONDA_PREFIX
echo '$LD_LIBRARY_PATH = ' $LD_LIBRARY_PATH
echo "which python = " `which python`
# test conda
echo -e "\nconda info: "
conda activate syndirella
conda info
# -------------------------------------------------------

cd $HOME2/syndirella
pwd;

export INPUT="/opt/xchem-fragalysis-2/kfieseler/CHIKV-Mac-syndirella-run/syndirella_input/syndirella_input338.csv"
export OUTPUT="/opt/xchem-fragalysis-2/kfieseler/CHIKV-Mac/"
export TEMPLATES="/opt/xchem-fragalysis-2/kfieseler/CHIKV-Mac-syndirella-run/fragments/templates";
export HITS="/opt/xchem-fragalysis-2/kfieseler/CHIKV-Mac-syndirella-run/fragments/CHIKV_Mac_combined.sdf";
export METADATA="/opt/xchem-fragalysis-2/kfieseler/CHIKV-Mac-syndirella-run/fragments/metadata.csv";

echo "Running input338.csv";

nice -19 python -m syndirella \
--input $INPUT \
--output $OUTPUT \
--templates $TEMPLATES \
--hits $HITS \
--metadata $METADATA;

echo 'COMPLETE'