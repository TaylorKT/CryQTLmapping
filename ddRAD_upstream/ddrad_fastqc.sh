#!/bin/bash
#SBATCH --job-name=fastqc
#SBATCH -n 1
#SBATCH -N 1
#SBATCH --mem=1G
#SBATCH --qos=throughput
#SBATCH --time=12:00:00
#SBATCH --mail-type=END
#SBATCH --mail-user=taylork@umd.edu
#SBATCH -o ./errandout/fastqc%j.out
#SBATCH -e ./errandout/fastqc%j.err
#SBATCH --array=[0-21]%21

cd /fs/cbcb-lab/mfritz13/rawdata/ktaylor/fastqc

# make a list of input files
FILES=($(ls -1 /fs/cbcb-lab/mfritz13/rawdata/ktaylor/NVS139B_Taylor_L4_R2/*))

INFILE=${FILES[$SLURM_ARRAY_TASK_ID]}

~/miniconda3/bin/fastqc $INFILE
