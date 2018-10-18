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

#source ~/ruff/ruff_software/PBSuite_repaired/PBSuite_15.8.24/setup.sh
source ~/ruff_code/PBSuite_15.8.24/setup.sh #using the version I'm updating from local
source ~/.bash_profile

#WORK_D=/home/eenbody/ruff/pbjelly/ind_browncode
WORK_D=/home/eenbody/ruff/pbjelly/ind_fixed
cd $WORK_D

#Jelly.py setup ~/ruff_code/pbjelly/ind_Protocol.xml
Jelly.py mapping ~/ruff_code/pbjelly/ind_Protocol.xml
Jelly.py support ~/ruff_code/pbjelly/ind_Protocol.xml
Jelly.py extraction ~/ruff_code/pbjelly/ind_Protocol.xml
Jelly.py assembly ~/ruff_code/pbjelly/ind_Protocol.xml
Jelly.py output ~/ruff_code/pbjelly/ind_Protocol.xml
