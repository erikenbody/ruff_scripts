#!/bin/bash -l
#SBATCH -A snic2017-1-623
#SBATCH -p core -n 20
#SBATCH -t 5:00:00
#SBATCH -J hisat2
#SBATCH -e hisat2_%A_%a.err            # File to which STDERR will be written
#SBATCH -o hisat2_%A_%a.out
#SBATCH --mail-type=all
#SBATCH --mail-user=erik.enbody@gmail.com

#for uppsala rnaseq
#opps fist time ran with only 1 core
module load bioinfo-tools HISAT2/2.1.0 samtools/1.8

SAMPLEDIR=/home/eenbody/ruff/Genome_annotation/RNAseq_input
WORK_D=/home/eenbody/ruff/Genome_annotation/rna_mapping

FILENAME=QL-1682-Ruff-skin2_S17_L002_R1_001.fastq.gz
SAMPLE=QL-1682-Ruff-skin2_S17_L002

cd $WORK_D


hisat2 -p 20 --dta -x Ruff_tran -1 $SAMPLEDIR/fixed_QL-1682-Ruff-skin2_S17_L002_R1_001.cor_val_1.fq.gz -2 $SAMPLEDIR/fixed_QL-1682-Ruff-skin2_S17_L002_R2_001.cor_val_2.fq.gz  -S ${SAMPLE}.sam

samtools sort -@ 20 -o ${SAMPLE}.bam ${SAMPLE}.sam
