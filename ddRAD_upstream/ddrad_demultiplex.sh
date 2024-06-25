#!/bin/bash
#SBATCH --job-name=demultiplex
#SBATCH -n 8
#SBATCH -N 1
#SBATCH --mem=1G
#SBATCH --qos=throughput
#SBATCH --time=12:00:00
#SBATCH --mail-type=END
#SBATCH --mail-user=taylork@umd.edu
#SBATCH -o ./errandout/demultiplex%j.out
#SBATCH -e ./errandout/demultiplex%j.err
#SBATCH --array=[0-21]%21

cd /fs/cbcb-scratch/taylork/demultiplexed


FILES=($(ls -1 /fs/cbcb-lab/mfritz13/rawdata/ktaylor/NVS139B_Taylor_L4_R1/*fastq.gz))

FILE_1=${FILES[$SLURM_ARRAY_TASK_ID]}
FILE_2=$(echo $FILE_1 | sed 's/R1/R2/g')

BARCODES=($(ls -1 /fs/cbcb-lab/mfritz13/barcodes/replicated_cry_qtl/*))

BARCODE=${BARCODES[$SLURM_ARRAY_TASK_ID]}

echo files $FILE_1 and $FILE_2 were demultiplexed using barcode file $BARCODE by task number $SLURM_ARRAY_TASK_ID on $(date)

/cbcbhomes/taylork/miniconda3/bin/process_radtags \
-1 $FILE_1 \
-2 $FILE_2 \
--paired -b $BARCODE \
--out-path /fs/cbcb-scratch/taylork/demultiplexed \
-w 0.1 -s 20 --renz-1 'ecoRI' --renz-2 'mspI' \
--adapter_1 AATGATACGGCGACCACCGAGATCT --adapter_2 CAAGCAGAAGACGGCATACGAGAT --adapter_mm 2
