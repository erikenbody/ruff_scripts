#!/bin/bash -l
#SBATCH -A snic2018-8-57
#SBATCH -p node -n 20
#SBATCH -t 6-23:00:00
#SBATCH -J maker1
#SBATCH -e maker_%A.err            # File to which STDERR will be written
#SBATCH -o maker_%A.out
#SBATCH --mail-type=all
#SBATCH --mail-user=erik.enbody@gmail.com


cd /home/eenbody/ruff/Ind_Genome_annotation/01_maker_evidence_based

module load bioinfo-tools maker/3.01.2-beta
maker -c 20
#
