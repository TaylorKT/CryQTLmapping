#!/bin/bash
#SBATCH --job-name=qualimap
#SBATCH -n 1
#SBATCH -N 1
#SBATCH --mem=20G
#SBATCH --qos=throughput
#SBATCH --time=17:00:00
#SBATCH --mail-type=END
#SBATCH --mail-user=taylork@umd.edu
#SBATCH -o ./errandout/qualimap%j.out
#SBATCH -e ./errandout/qualimap%j.err

cd /fs/cbcb-lab/mfritz13/rawdata/wgs
~/miniconda3/bin/qualimap multi-bamqc -r --data bams_qualimap.txt --java-mem-size=20000M

cd /fs/cbcb-lab/mfritz13/aligned/cross_parents
~/miniconda3/bin/qualimap multi-bamqc -r --data bam_list_qualimap.txt --java-mem-size=20000M
