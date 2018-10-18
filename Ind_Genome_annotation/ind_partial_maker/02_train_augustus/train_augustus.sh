#!/bin/bash -l
#SBATCH -A snic2018-8-57
#SBATCH -p node -n 20
#SBATCH -t 6-23:00:00
#SBATCH -J augustus1
#SBATCH -e augustus1_%A.err            # File to which STDERR will be written
#SBATCH -o augustus1_%A.out
#SBATCH --mail-type=all
#SBATCH --mail-user=erik.enbody@gmail.com

module load bioinfo-tools maker/3.01.2-beta

WORK_D=/home/eenbody/ruff/Ind_Genome_annotation/01_maker_evidence_based/sn2_indscaf_reformed.maker.output
cd $WORK_D

fasta_merge -d sn2_indscaf_reformed_master_datastore_index.log
gff3_merge -d sn2_indscaf_reformed_master_datastore_index.log

cd .. #maker wd
mkdir trainsnap
cd trainsnap/
cp ../*output/*.gff .

maker2zff *gff
fathom genome.ann genome.dna -gene-stats > gene-stats.log 2>&1
cat gene-stats.log

fathom genome.ann genome.dna -validate > validate.log 2>&1
fathom genome.ann genome.dna -categorize 1000 #> categorize.log 2>&1
fathom -export 1000 -plus uni.ann uni.dna #> uni-plus.log 2>&1
forge export.ann export.dna #> forge.log 2>&1

hmm-assembler.pl ind .> ind.hmm

#augustus

cd ..
mkdir train_augustus
cd train_augustus/
cp ../trainsnap/genome* .

zff2gff3.pl ./genome.ann | perl -plne 's/\t(\S+)$/\t\.\t$1/' > ind.gff3

source $AUGUSTUS_CONFIG_COPY
new_species.pl --species=ind

gff2gbSmallDNA.pl ind.gff3 ./genome.dna 1000 ind.gb

randomSplit.pl ind.gb 200

cat ind.gb | grep "LOCUS" | wc -l

etraining --species=ind ind.gb.train

ls -ort $AUGUSTUS_CONFIG_PATH/species/ind/

augustus --species=ind ind.gb.test | tee firsttest.out # takes ~1m

optimize_augustus.pl --species=ind ind.gb.train --cpus=20

etraining --species=ind ind.gb.train

augustus --species=ind ind.gb.train | tee secondtest.out
