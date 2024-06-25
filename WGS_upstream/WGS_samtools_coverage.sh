#!/bin/bash
#SBATCH --job-name=calc_coverage
#SBATCH -n 1
#SBATCH -N 1
#SBATCH --mem=20G
#SBATCH --qos=throughput
#SBATCH --time=17:00:00
#SBATCH --mail-type=END
#SBATCH --mail-user=taylork@umd.edu
#SBATCH -o ./errandout/calc_coverage%j.out
#SBATCH -e ./errandout/calc_coverage%j.err

cd /fs/cbcb-lab/mfritz13/aligned/cross_parents/
/fs/cbcb-lab/mfritz13/miniconda3/bin/samtools depth -H -b region.bed -f /fs/cbcb-lab/mfritz13/aligned/cross_parents/bam_list.txt

cd /fs/cbcb-lab/mfritz13/rawdata/wgs
/fs/cbcb-lab/mfritz13/miniconda3/bin/samtools depth -H -b region.bed -f /fs/cbcb-lab/mfritz13/rawdata/wgs/bams.txt


