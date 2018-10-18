#/bin/bash

#If you use a virtual env - source it here
#source /hgsc_software/PBSuite/pbsuiteVirtualEnv/bin/activate

#This is the path where you've install the suite.
export SWEETPATH=/crex/proj/uppstore2017195/users/erik/ruff/ruff_code/PBSuite_15.8.24
#for python modules
export PYTHONPATH=$PYTHONPATH:$SWEETPATH
#for executables
export PATH=$PATH:$SWEETPATH/bin/
