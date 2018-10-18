#!/bin/bash -l
#SBATCH -A snic2018-8-57
#SBATCH -p core -n 4
#SBATCH -t 23:00:00
#SBATCH -J stringtie_format
#SBATCH -e stringtie_format_%A.err            # File to which STDERR will be written
#SBATCH -o stringtie_format_%A.out
#SBATCH --mail-type=all
#SBATCH --mail-user=erik.enbody@gmail.com

#module load bioinfo-tools StringTie/1.3.3 samtools/1.8

#make mergelist of all gtf files
#ls -1 *.gtf > mergelist.txt
#stringtie --merge -p 20 -o ruff_stringtie_merged.gtf mergelist.txt


source /crex/proj/uppstore2017195/users/erik/ruff/ruff_software/GAAS/profiles/activate_rackham_env
module load perl
module load perl_modules
module load BioPerl/1.6.924_Perl5.18.4

gxf_to_gff3.pl -g ruff_stringtie_merged.gtf -o ruff_stringtie_merged.gff3 --gff_version 2

gff3_sp_alignment_output_style.pl -g ruff_stringtie_merged.gff3 -o ruff_stringtie_merged_match.gff3
