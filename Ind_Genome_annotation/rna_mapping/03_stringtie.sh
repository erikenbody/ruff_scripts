#!/bin/bash -l
#SBATCH -A snic2017-1-623
#SBATCH -p core
#SBATCH -t 5:00:00
#SBATCH -J stringtie
#SBATCH -e stringtie_%A_%a.err            # File to which STDERR will be written
#SBATCH -o stringtie_%A_%a.out
#SBATCH --mail-type=all
#SBATCH --mail-user=erik.enbody@gmail.com


module load bioinfo-tools StringTie/1.3.3 samtools/1.8


WORK_D=/home/eenbody/ruff/Ind_Genome_annotation/rna_mapping
cd $WORK_D

FILENAME=`ls -1 *.bam | awk -v line=$SLURM_ARRAY_TASK_ID '{if (NR == line) print $0}'`
SAMPLE="${FILENAME%.*}"

stringtie $FILENAME -l $SAMPLE -p 20 -o ${SAMPLE}.gtf
