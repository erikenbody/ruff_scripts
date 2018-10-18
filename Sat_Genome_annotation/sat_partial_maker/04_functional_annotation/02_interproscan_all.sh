#!/bin/bash -l
#SBATCH -A snic2018-8-57
#SBATCH -p node -n 20
#SBATCH -t 0-23:00:00
#SBATCH -J maker1
#SBATCH -e ipr_%A.err            # File to which STDERR will be written
#SBATCH -o ipr_%A.out
#SBATCH --mail-type=all
#SBATCH --mail-user=erik.enbody@gmail.com

module load bioinfo-tools InterProScan/5.30-69.0

MAKER_HOME=/home/eenbody/ruff/Genome_annotation/02_maker_ab_initio_partial_sat/sn180416_satscaf.maker.output
WORK_D=/home/eenbody/ruff/Genome_annotation/02_maker_ab_initio_partial_sat/sn180416_satscaf.maker.output/functional_annotation/interproscan_all
cd $WORK_D
#
interproscan.sh -i $MAKER_HOME/sn180416_satscaf.all.maker.proteins.fasta -t p -dp -pa --goterms --iprlookup
#
