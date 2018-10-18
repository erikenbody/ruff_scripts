#/bin/bash

#If you use a virtual env - source it here
#source /hgsc_software/PBSuite/pbsuiteVirtualEnv/bin/activate

#This is the path where you've install the suite.
export SWEETPATH=/Users/erikenbody/Google_Drive/Tulane/WSFW_Data/Genomics_DNA_RNA/Bioinformatics_Software/PBSuite_15.8.24
#for python modules 
export PYTHONPATH=$PYTHONPATH:$SWEETPATH
#for executables 
export PATH=$PATH:$SWEETPATH/bin/
