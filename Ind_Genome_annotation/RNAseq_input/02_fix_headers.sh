#!/bin/bash -l
#SBATCH -A snic2017-1-623
#SBATCH -p core
#SBATCH -t 5:00:00
#SBATCH -J fixheader
#SBATCH -e fixheader.err            # File to which STDERR will be written
#SBATCH -o fixheader.out
#SBATCH --mail-type=all
#SBATCH --mail-user=erik.enbody@gmail.com

#tried a few different things to make headers work for trinity
#from https://www.biostars.org/p/162590/

for FILENAME in *.fq.gz
#for FILENAME in fixed_ERR1018140_1.cor_val_1.fq.gz fixed_ERR1018140_2.cor_val_2.fq.gz fixed_ERR1018141_1.cor_val_1.fq.gz fixed_ERR1018141_2.cor_val_2.fq.gz fixed_ERR1018142_1.cor_val_1.fq.gz fixed_ERR1018142_2.cor_val_2.fq.gz fixed_ERR1018143_1.cor_val_1.fq.gz fixed_ERR1018143_2.cor_val_2.fq.gz
do
  #zcat $FILENAME | sed -E 's/(@ERR).{11}/\@X/' | gzip > hf_${FILENAME}
  zcat $FILENAME | sed '/^@/{s/ /:/g}' | gzip > hf_${FILENAME}
done
#zcat test_reduc_R2.fq.gz | sed -E 's/(@ERR).{11}/\@X/' | gzip > pipetest.fq.g
