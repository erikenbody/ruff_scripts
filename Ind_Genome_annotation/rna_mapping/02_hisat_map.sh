#!/bin/bash -l
#SBATCH -A snic2018-8-57
#SBATCH -p core -n 20
#SBATCH -t 24:00:00
#SBATCH -J hisat2
#SBATCH -e hisat2_%A_%a.err            # File to which STDERR will be written
#SBATCH -o hisat2_%A_%a.out
#SBATCH --mail-type=all
#SBATCH --mail-user=erik.enbody@gmail.com


#submit as array
#rerun
module load bioinfo-tools HISAT2/2.1.0 samtools

SAMPLEDIR=/home/eenbody/ruff/Genome_annotation/RNAseq_input/header_fixed
WORK_D=/home/eenbody/ruff/Ind_Genome_annotation/rna_mapping

cd $SAMPLEDIR
FILENAME=`ls -1 hf_*1.fq.gz | awk -v line=$SLURM_ARRAY_TASK_ID '{if (NR == line) print $0}'`
SAMPLE=$(echo $FILENAME | rev | cut -c 19- | rev | uniq)
cd $WORK_D


hisat2 -p 20 --dta -x Ind_Ruff_tran -1 $SAMPLEDIR/${SAMPLE}_1.cor_val_1.fq.gz -2 $SAMPLEDIR/${SAMPLE}_2.cor_val_2.fq.gz -S ${SAMPLE}.sam

samtools sort -@ 20 -o ${SAMPLE}.bam ${SAMPLE}.sam

rm ${SAMPLE}.sam
