#!/bin/bash
#SBATCH --job-name=samtobam
#SBATCH -n 4
#SBATCH -N 1
#SBATCH --mem=6G
#SBATCH --qos=throughput
#SBATCH --time=12:00:00
#SBATCH --mail-type=END
#SBATCH --mail-user=taylork@umd.edu
#SBATCH -o ./errandout/samtobam%j.out
#SBATCH -e ./errandout/samtobam%j.err
#SBATCH --array=[0-22]%23

cd /fs/cbcb-lab/mfritz13/aligned/ilHelZeax_cross_parents_aligned/

FILES=($(ls -1 /fs/cbcb-lab/mfritz13/aligned/ilHelZeax_cross_parents_aligned/*.sam))
INFILE=${FILES[$SLURM_ARRAY_TASK_ID]}
TEMPFILE=$(echo $INFILE | sed 's/.sam/.temp/')
OUTFILE=$(echo $INFILE | sed 's/.sam/.bam/')
STATSFILE=$(echo $INFILE | sed 's/.sam/stats.txt/')

echo the sam file $INFILE was sorted and converted to the sorted bam file $OUTFILE

/fs/cbcb-lab/mfritz13/miniconda3/bin/samtools view -@ 4 -S -h -u $INFILE | \
/fs/cbcb-lab/mfritz13/miniconda3/bin/samtools sort -@ 4 -T $TEMPFILE -> $OUTFILE

/fs/cbcb-lab/mfritz13/miniconda3/bin/samtools index $OUTFILE

/fs/cbcb-lab/mfritz13/miniconda3/bin/samtools stats $OUTFILE > $STATSFILE
