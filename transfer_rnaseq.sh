#!/bin/bash -l
#SBATCH -A snic2018-8-57
#SBATCH -p core -n 1
#SBATCH -t 24:00:00
#SBATCH -J extract_GQDP
#SBATCH -e GQ.err            # File to which STDERR will be written
#SBATCH -o GQ.out
#SBATCH --mail-type=all
#SBATCH --mail-user=erik.enbody@gmail.com



wget ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR101/004/ERR1018134/ERR1018134_2.fastq.gz
wget ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR101/005/ERR1018135/ERR1018135_1.fastq.gz
wget ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR101/005/ERR1018135/ERR1018135_2.fastq.gz
wget ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR101/006/ERR1018136/ERR1018136_1.fastq.gz
wget ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR101/006/ERR1018136/ERR1018136_2.fastq.gz
wget ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR101/007/ERR1018137/ERR1018137_1.fastq.gz
wget ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR101/007/ERR1018137/ERR1018137_2.fastq.gz
wget ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR101/008/ERR1018138/ERR1018138_1.fastq.gz
wget ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR101/008/ERR1018138/ERR1018138_2.fastq.gz
wget ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR101/009/ERR1018139/ERR1018139_1.fastq.gz
wget ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR101/009/ERR1018139/ERR1018139_2.fastq.gz
wget ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR101/000/ERR1018140/ERR1018140_1.fastq.gz
wget ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR101/000/ERR1018140/ERR1018140_2.fastq.gz
wget ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR101/001/ERR1018141/ERR1018141_1.fastq.gz
wget ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR101/001/ERR1018141/ERR1018141_2.fastq.gz
wget ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR101/002/ERR1018142/ERR1018142_1.fastq.gz
wget ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR101/002/ERR1018142/ERR1018142_2.fastq.gz
wget ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR101/003/ERR1018143/ERR1018143_1.fastq.gz
wget ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR101/003/ERR1018143/ERR1018143_2.fastq.gz
