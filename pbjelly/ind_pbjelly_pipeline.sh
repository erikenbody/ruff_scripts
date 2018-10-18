#!/bin/bash -l
#SBATCH -A snic2018-8-57
#SBATCH -p node
#SBATCH -n 1
#SBATCH -t 0-23:00:00
#SBATCH -e pbjelly_%A.err
#SBATCH -o pbjelly_%A.out
#SBATCH --mail-user=erik.enbody@gmail.com
#SBATCH --mail-type=ALL

#installed locally for EDE. It might work with the blasr module loaded from Uppmax.
#python 2.7.6
#blasr 5.3.2
#networkx 1.1

source ~/ruff/ruff_software/PBSuite_repaired/PBSuite_15.8.24/setup.sh
source ~/.bash_profile

WORK_D=/home/eenbody/ruff/pbjelly/ind_browncode
cd $WORK_D

Jelly.py setup Protocol.xml
Jelly.py mapping Protocol.xml
Jelly.py support Protocol.xml
Jelly.py extraction Protocol.xml
Jelly.py assembly Protocol.xml
Jelly.py output Protocol.xml
