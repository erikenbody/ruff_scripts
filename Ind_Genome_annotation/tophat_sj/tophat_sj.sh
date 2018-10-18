#!/bin/bash -l
#SBATCH -A snic2018-8-57
#SBATCH -p core -n 20
#SBATCH -t 23:00:00
#SBATCH -J tophat
#SBATCH -e tophat_%A.err            # File to which STDERR will be written
#SBATCH -o tophat_%A.out
#SBATCH --mail-type=all
#SBATCH --mail-user=erik.enbody@gmail.com

module load bioinfo-tools tophat/2.1.1 bowtie2/2.3.4.1

WORK_D=/home/eenbody/ruff/Ind_Genome_annotation/tophat
cd $WORK_D
REF=/home/eenbody/data_ruff/assembly_seqs/pseudohaps_Supernova2/pseudohap2.1.IndInversionScaffold.fasta


#bowtie2-build $REF pseudohap2.1.IndInversionScaffold
#soft link raw
tophat --library-type fr-firststrand -p20 -o ./tophat --no-sort-bam --no-convert-bam pseudohap2.1.IndInversionScaffold hf_fixed_ERR1018134_1.cor_val_1.fq.gz,hf_fixed_ERR1018135_1.cor_val_1.fq.gz,hf_fixed_ERR1018136_1.cor_val_1.fq.gz,hf_fixed_ERR1018137_1.cor_val_1.fq.gz,hf_fixed_ERR1018138_1.cor_val_1.fq.gz,hf_fixed_ERR1018139_1.cor_val_1.fq.gz,hf_fixed_ERR1018140_1.cor_val_1.fq.gz,hf_fixed_ERR1018141_1.cor_val_1.fq.gz,hf_fixed_ERR1018142_1.cor_val_1.fq.gz,hf_fixed_ERR1018143_1.cor_val_1.fq.gz,fixed_QL-1682-Ruff-skin2_S17_L002_R1_001.cor_val_1.fq.gz,hf_fixed_ERR1018134_2.cor_val_2.fq.gz,hf_fixed_ERR1018135_2.cor_val_2.fq.gz,hf_fixed_ERR1018136_2.cor_val_2.fq.gz,hf_fixed_ERR1018137_2.cor_val_2.fq.gz,hf_fixed_ERR1018138_2.cor_val_2.fq.gz,hf_fixed_ERR1018139_2.cor_val_2.fq.gz,hf_fixed_ERR1018140_2.cor_val_2.fq.gz,hf_fixed_ERR1018141_2.cor_val_2.fq.gz,hf_fixed_ERR1018142_2.cor_val_2.fq.gz,hf_fixed_ERR1018143_2.cor_val_2.fq.gz,fixed_QL-1682-Ruff-skin2_S17_L002_R2_001.cor_val_2.fq.gz
