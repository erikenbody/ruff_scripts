#!/bin/bash -l
#SBATCH -A snic2018-8-57
#SBATCH -p node
#SBATCH -n 4
#SBATCH -t 0-23:00:00
#SBATCH -e pbjelly_%A.err
#SBATCH -o pbjelly_%A.out
#SBATCH --mail-user=erik.enbody@gmail.com
#SBATCH --mail-type=ALL

#installed locally for EDE. It might work with the blasr module loaded from Uppmax.
#python 2.7.6
#blasr 5.3.2
#networkx 1.1

#source ~/ruff/ruff_software/PBSuite_repaired/PBSuite_15.8.24/setup.sh
source ~/ruff_code/PBSuite_15.8.24/setup.sh #using the version I'm updating from local
source ~/.bash_profile #required to run the correct python + networkx

WORK_D=/home/eenbody/ruff/pbjelly/readsubset_supernova_round2/
cd $WORK_D

PROTOCOL=~/ruff_code/pbjelly/readsubset_supernova_round2_Protocol.xml

Jelly.py setup $PROTOCOL
Jelly.py mapping $PROTOCOL
Jelly.py support $PROTOCOL
Jelly.py extraction $PROTOCOL
Jelly.py assembly $PROTOCOL
Jelly.py output $PROTOCOL
