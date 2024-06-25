#!/bin/bash
#SBATCH --job-name=mpileup
#SBATCH -n 4
#SBATCH -N 1
#SBATCH --mem=48G
#SBATCH --qos=workstation
#SBATCH --time=6-23:00:00
#SBATCH --mail-type=END
#SBATCH --mail-user=taylork@umd.edu
#SBATCH -o ./errandout/mpileup%j.out
#SBATCH -e ./errandout/mpileup%j.err

cd /fs/cbcb-lab/mfritz13/aligned/cross_parents/

~/miniconda3/bin/bcftools mpileup -f /fs/cbcb-lab/mfritz13/reference_genomes/H_zea/Hz_GAR_r1.0.fa -b ./bam_list.txt -I --threads 4 -O u -o ./parents.bcf

~/miniconda3/bin/bcftools call -vmO v ./parents.bcf -o ./parents.vcf 
