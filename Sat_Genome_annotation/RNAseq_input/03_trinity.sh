#!/bin/bash -l
#SBATCH -A snic2017-1-623
#SBATCH -p node
#SBATCH -t 3-00:00:00
#SBATCH -J trinity
#SBATCH -e trinity_%A.err            # File to which STDERR will be written
#SBATCH -o trinity_%A.out
#SBATCH --mail-type=all
#SBATCH --mail-user=erik.enbody@gmail.com

module load bioinfo-tools trinity/2.8.2 Salmon jellyfish bowtie2 samtools

Trinity --seqType fq --SS_lib_type RF --max_memory 120G --CPU 20 --min_kmer_cov 1 --left hf_fixed_ERR1018134_1.cor_val_1.fq.gz,hf_fixed_ERR1018135_1.cor_val_1.fq.gz,hf_fixed_ERR1018136_1.cor_val_1.fq.gz,hf_fixed_ERR1018137_1.cor_val_1.fq.gz,hf_fixed_ERR1018138_1.cor_val_1.fq.gz,hf_fixed_ERR1018139_1.cor_val_1.fq.gz,hf_fixed_ERR1018140_1.cor_val_1.fq.gz,hf_fixed_ERR1018141_1.cor_val_1.fq.gz,hf_fixed_ERR1018142_1.cor_val_1.fq.gz,hf_fixed_ERR1018143_1.cor_val_1.fq.gz,fixed_QL-1682-Ruff-skin2_S17_L002_R1_001.cor_val_1.fq.gz --right hf_fixed_ERR1018134_2.cor_val_2.fq.gz,hf_fixed_ERR1018135_2.cor_val_2.fq.gz,hf_fixed_ERR1018136_2.cor_val_2.fq.gz,hf_fixed_ERR1018137_2.cor_val_2.fq.gz,hf_fixed_ERR1018138_2.cor_val_2.fq.gz,hf_fixed_ERR1018139_2.cor_val_2.fq.gz,hf_fixed_ERR1018140_2.cor_val_2.fq.gz,hf_fixed_ERR1018141_2.cor_val_2.fq.gz,hf_fixed_ERR1018142_2.cor_val_2.fq.gz,hf_fixed_ERR1018143_2.cor_val_2.fq.gz,fixed_QL-1682-Ruff-skin2_S17_L002_R2_001.cor_val_2.fq.gz --output ruff_trinity_noJC

#Trinity --seqType fq --jaccard_clip --SS_lib_type RF --max_memory 120G --CPU 20 --min_kmer_cov 1 --left fixed2_reduc_R1.fq --right fixed2_reduc_R2.fq --output test_trinity2
#Trinity --seqType fq --jaccard_clip --SS_lib_type RF --max_memory 120G --CPU 20 --min_kmer_cov 1 --left  hf_fixed_ERR1018134_1.cor_val_1.fq.gz --right  hf_fixed_ERR1018134_2.cor_val_2.fq.gz --output trinity_header_test
]
