## Trying to fix PBJelly

The UPPMAX module for PBSuite is not able to fill gaps on the example data provided with the software for Jelly.py. From internet searching, it is clear that PBSuite has not kept pace with udpates to both Blasr and Networkx. Blasr is the bigger issue. Here are some notes on how I got Jelly.py to run on Uppmax.

Because I am recently arrived, the below is notes on setting this up from scratch.

### User specific install Networkx version 1.1
Following: https://www.uppmax.uu.se/support/user-guides/python-modules-guide/
To set up local 2.7.6 python env from home directory. Also requires numpy and pyparsing.

```
#this was stupid i meant 1.1
pip install networkx==1.1
#this works
pip install numpy
#check if networkx version is correct
pip install show
pip show networkx
#is correct
pip install pyparsing
```

Some deep buried documentation suggests that networkx 1.7 should work too.

###  User specific install Blasr

I initially did a local install for Blasr in hopes I could install the old version, but I suspect loading the Uppmax module work work with the patches I made to the PBsuite scripts.

First installed miniconda
https://conda.io/docs/user-guide/install/linux.html
```
conda install -c bioconda blasr
````

### Specific notes on edits to PBSuite scripts

The reason Jelly.py fails is that Blasr switched to using -- flags for commands that are full words : https://www.biostars.org/p/198519/

This repository contains the PBSuite where I switch all the - flags to -- for Blasr ONLY FOR COMMANDS RELATING TO PBJELLY. Not the other PBSuite modules.

I looked long enough to get the example code to work, but there may be other places this software is broken that I didn't find.

PBSuite was developed by A. English: https://sourceforge.net/projects/pb-jelly/

### For others to install on UPPMAX

1) clone this repository
2) Edit setup.sh to have a path to the folder containing PBsuite
3) In your bash profile source setup.sh and also your .bash_profile (so that the script will load your own python environment)
4) Make sure Protocol.xml includes -- flags for blasr commands

An example of a script can be found under EDE_example 
