#!/bin/bash -l
#SBATCH -A snic2018-8-57
#SBATCH -p node -n 20
#SBATCH -t 0-23:00:00
#SBATCH -J blastp
#SBATCH -e blastp_%A.err            # File to which STDERR will be written
#SBATCH -o blastp_%A.out
#SBATCH --mail-type=all
#SBATCH --mail-user=erik.enbody@gmail.com

module load bioinfo-tools blast/2.7.1+

MAKER_HOME=/home/eenbody/ruff/Genome_annotation/02_maker_ab_initio_partial_sat/sn180416_satscaf.maker.output
WORK_D=/home/eenbody/ruff/Genome_annotation/02_maker_ab_initio_partial_sat/sn180416_satscaf.maker.output/functional_annotation

cd $WORK_D
mkdir sp_db_np

RELEASE=sprot
makeblastdb -in uniprot_sprot_20180928.fasta -out sp_db_np/uniprot_sprot -dbtype prot -title uniprot_sprot

#ORIGINAL RUN:
#blastp -db $WORK_D/sp_db_np/uniprot_sprot -query $MAKER_HOME/WSFW_assembly_maker2.all.maker.proteins.fasta -outfmt 6 -out WSFW_maker_blast_sprot_np.out -num_threads 20

#FOLLWING YANDELL:http://www.yandell-lab.org/publications/pdf/maker_current_protocols.pdf
blastp -db $WORK_D/sp_db_np/uniprot_sprot -query $MAKER_HOME/sn180416_satscaf.all.maker.proteins.fasta -out sn180416_satscaf_blast_sprot_np_STRICT.out -evalue .000001 -outfmt 6 -num_alignments 1 -seg yes -soft_masking true -lcase_masking -max_hsps 1 -num_threads 20
