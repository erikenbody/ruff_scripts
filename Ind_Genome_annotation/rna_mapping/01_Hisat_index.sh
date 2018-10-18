#!/bin/bash -l
#SBATCH -A snic2017-1-623
#SBATCH -p core -n 20
#SBATCH -t 5:00:00
#SBATCH -J hisatindx
#SBATCH -e hisatindx.err            # File to which STDERR will be written
#SBATCH -o hisatindx.out
#SBATCH --mail-type=all
#SBATCH --mail-user=erik.enbody@gmail.com

module load bioinfo-tools HISAT2/2.1.0

WORK_D=/home/eenbody/ruff/Ind_Genome_annotation/rna_mapping
cd $WORK_D

REF=/home/eenbody/data_ruff/assembly_seqs/pseudohaps_Supernova2/pseudohap2.1.IndInversionScaffold.fasta

hisat2-build -p 20 $REF Ind_Ruff_tran
