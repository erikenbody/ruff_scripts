#!/bin/bash -l
#SBATCH -A snic2017-1-623
#SBATCH -p core -n 20
#SBATCH -t 24:00:00
#SBATCH -J preprocess_RNAseq
#SBATCH -e preprocess_RNAseq_%A_%a.err            # File to which STDERR will be written
#SBATCH -o preprocess_RNAseq_%A_%a.out
#SBATCH --mail-type=all
#SBATCH --mail-user=erik.enbody@gmail.com


SAMPLEDIR=/home/eenbody/ruff/raw_RNAseq
WORK_D=/home/eenbody/ruff/Genome_annotation/RNAseq_input

cd $SAMPLEDIR
FILENAME=`ls -1 *1.fastq.gz | awk -v line=$SLURM_ARRAY_TASK_ID '{if (NR == line) print $0}'`
SAMPLE=$(echo $FILENAME | rev | cut -c 12- | rev | uniq)
cd $WORK_D

mkdir rCorr
cd rCorr
perl /home/eenbody/ruff/ruff_software/rcorrector/run_rcorrector.pl -t 20 -1 $SAMPLEDIR/${SAMPLE}_1.fastq.gz -2 $SAMPLEDIR/${SAMPLE}_2.fastq.gz
cd ..

echo 'done with rcorrector'

module load python/2.7.11

python ~/ruff_code/Genome_annotation/RNAseq_input/FilterUncorrectabledPEfastq.py -1 rCorr/${SAMPLE}_1.cor.fq.gz -2 rCorr/${SAMPLE}_2.cor.fq.gz -o fixed 2>&1 > rmunfixable_${SAMPLE}.out

echo 'done with kmerfix'

module load bioinfo-tools TrimGalore/0.4.4

trim_galore --paired --retain_unpaired --phred33 --output_dir . --fastqc --gzip --length 36 -q 5 --stringency 1 -e 0.1 fixed_${SAMPLE}_1.cor.fq fixed_${SAMPLE}_2.cor.fq

echo 'dome with trimgalore'
