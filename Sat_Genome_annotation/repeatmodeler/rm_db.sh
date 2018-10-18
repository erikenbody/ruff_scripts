#!/bin/bash -l
#SBATCH -A snic2018-8-57
#SBATCH -p core -n 1
#SBATCH -t 24:00:00
#SBATCH -J repeatmod
#SBATCH -e repeatmod_A%.err            # File to which STDERR will be written
#SBATCH -o repeatmod_A%.out
#SBATCH --mail-type=all
#SBATCH --mail-user=erik.enbody@gmail.com

module load bioinfo-tools RepeatModeler/1.0.8_RM4.0.7

WORK_D=/home/eenbody/ruff/Genome_annotation/repeatmodeler

REF=/home/eenbody/data_ruff/assembly_seqs/inversion_seqs

cd $WORK_D

#ln -s $REF/sn2_SatInv.fa .

#BuildDatabase -name "sn2_SatInv_db" -engine ncbi sn2_SatInv.fa

#BuildDatabase -name "Ruff.scafSeq_db" -engine ncbi Ruff.scafSeq.fa

#ln -s /proj/uppstore2017195/users/jasonh/ruff/assembly_seqs/pseudohaps_Supernova2/pseudohap2.1.SatInversionScaffold.fasta .

BuildDatabase -name "pseudohap2.1.SatInversionScaffold" -engine ncbi pseudohap2.1.SatInversionScaffold.fasta
