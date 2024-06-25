#!/bin/bash
#SBATCH --job-name=filter_vcf
#SBATCH -n 1
#SBATCH -N 1
#SBATCH --mem=20G
#SBATCH --qos=throughput
#SBATCH --time=17:00:00
#SBATCH --mail-type=END
#SBATCH --mail-user=taylork@umd.edu
#SBATCH -o ./errandout/filter_vcf%j.out
#SBATCH -e ./errandout/filter_vcf%j.err

cd /fs/cbcb-lab/mfritz13/aligned/cry_qtl/

~/miniconda3/bin/bcftools view --min-alleles 2 --max-alleles 2 \
--include 'TYPE="snp" & QUAL>50 & F_MISSING<0.5 & MAF>0.05' \
Cry_QTL.vcf > Cry_QTL_filter.vcf

~/miniconda3/bin/bcftools stats Cry_QTL.vcf > Cry_QTL_stats.txt
~/miniconda3/bin/bcftools stats Cry_QTL_filter.vcf > Cry_QTL_filter_stats.txt