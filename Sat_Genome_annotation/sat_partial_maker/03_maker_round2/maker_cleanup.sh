#!/bin/bash -l
#SBATCH -A snic2018-8-57
#SBATCH -p core -n 1
#SBATCH -t 0-23:00:00
#SBATCH -J cleanm
#SBATCH -e cleanm_%A.err            # File to which STDERR will be written
#SBATCH -o cleanm_%A.out
#SBATCH --mail-type=all
#SBATCH --mail-user=erik.enbody@gmail.com

GENE=RSAT
SP=RSAT
MPRE=sn180416_satscaf

cd /home/eenbody/ruff/Genome_annotation/02_maker_ab_initio_partial_sat/sn180416_satscaf.maker.output


module load bioinfo-tools maker/3.01.2-beta

#fasta_merge -d *index.log
#gff3_merge -d *index.log

maker_map_ids --prefix ${GENE} --justify 6 ${MPRE}.all.gff > ${SP}.id.map
cp ${MPRE}.all.gff ${SP}.genome.orig.gff
cp ${MPRE}.all.maker.proteins.fasta ${MPRE}.all.maker.proteins.orig.fasta
cp ${MPRE}.all.maker.transcripts.fasta ${MPRE}.all.maker.transcripts.orig.fasta

map_fasta_ids ${SP}.id.map ${MPRE}.all.maker.proteins.fasta
map_fasta_ids ${SP}.id.map ${MPRE}.all.maker.transcripts.fasta
map_gff_ids ${SP}.id.map ${MPRE}.all.gff

#map_data_ids ${SP}.id.map ${SP}.renamed.iprscan
