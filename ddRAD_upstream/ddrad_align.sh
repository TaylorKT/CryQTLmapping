#!/bin/bash
#SBATCH --job-name=align
#SBATCH -n 4
#SBATCH -N 1
#SBATCH --mem=1G
#SBATCH --qos=throughput
#SBATCH --time=12:00:00
#SBATCH --mail-type=END
#SBATCH --mail-user=taylork@umd.edu
#SBATCH -o ./errandout/align%j.out
#SBATCH -e ./errandout/align%j.err
#SBATCH --array=[0-834]%100

PATH=$PATH:/fs/cbcb-lab/mfritz13/miniconda3/bin/bowtie2

cd /fs/cbcb-lab/mfritz13/aligned/cry_qtl

FILES=($(ls -1 /fs/cbcb-scratch/taylork/demultiplexed/*.rem.1.fq.gz))

FILE_3=${FILES[$SLURM_ARRAY_TASK_ID]}
FILE_1=$(echo $FILE_3 | sed 's/.rem.1.fq.gz/.1.fq.gz/')
FILE_2=$(echo $FILE_3 | sed 's/.rem.1.fq.gz/.2.fq.gz/')
FILE_4=$(echo $FILE_3 | sed 's/.rem.1.fq.gz/.rem.2.fq.gz/')
OUTPUT1=$(echo $FILE_3 | sed 's/.rem.1.fq.gz/.sam/')

path_old='/fs/cbcb-scratch/taylork/demultiplexed/'
path_new='/fs/cbcb-lab/mfritz13/aligned/cry_qtl/'

OUTPUT=$(echo $OUTPUT1 | sed "s%$path_old%$path_new%")

echo the reads in $FILE_1 $FILE_2 $FILE_3 $FILE_4 were aligned to HZ_GAR reference genome and results were output in the same files $OUTPUT

/fs/cbcb-lab/mfritz13/miniconda3/bin/bowtie2 -x /fs/cbcb-lab/mfritz13/reference_genomes/H_zea/Hz_GAR -1 $FILE_1 -2 $FILE_2 -U $FILE_3,$FILE_4 -S $OUTPUT --very-sensitive --threads 4
