#!/bin/bash -l
#SBATCH -A snic2018-8-57
#SBATCH -p core -n 20
#SBATCH -t 6-24:00:00
#SBATCH -J repeatmod
#SBATCH -e repeatmod.err            # File to which STDERR will be written
#SBATCH -o repeatmod.out
#SBATCH --mail-type=all
#SBATCH --mail-user=erik.enbody@gmail.com

module load bioinfo-tools
module load RepeatModeler/1.0.8_RM4.0.7

WORK_D=/home/eenbody/ruff/Ind_Genome_annotation/repeatmodeler

cd $WORK_D

RepeatModeler -engine ncbi -pa 20 -database pseudohap2.1.IndInversionScaffold >& pseudohap2.1.IndInversionScaffold.out
