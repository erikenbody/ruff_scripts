## Trying to fix PBJelly

From Jason:
```
Hey Erik,

The jelly runs have been done here:
/proj/uppstore2017195/users/jasonh/ruff/assembly_runs/PBjelly
ind, sat, etc., are the various runs I've tried.  The files specifying
the files and settings are variously *Protocol.xml.
Using fasta reference and fastq reads, or a fasta + qual references and
fasta + qual reads makes no difference. All quality scores are fake and
set at 40 since the pbsubreads_ruff.fasta and references had no quality
scores.

The basic pipeline is in runJelly.sh

The example data is in
/proj/uppstore2017195/users/jasonh/tools/PBSuite_15.8.24/docs/jellyExample

In order to run the local install instead of the uppmax module first you
need to source
/proj/uppstore2017195/users/jasonh/tools/PBSuite_15.8.24/setup.sh

Results are summarized in gap_fill_status.txt and output.err in each
output directory. In all cases so far the result has been a whole list
of "unimproved gap"

Good hunting,
Jason
```

First trying to run with my own install

Looking at the PBJelly page, I can see I need to install my own networkx installation
Following: https://www.uppmax.uu.se/support/user-guides/python-modules-guide/
To set up local python env from home directory (lazy)

Then following: https://networkx.github.io/documentation/networkx-1.11/install.html
```
wget https://github.com/networkx/networkx/archive/networkx-1.11.tar.gz
#tar -xvf networkx-1.11.tar.gz
#cd networkx-networkx-1.11/
#python setup.py install
#this was stupid i meant 1.1
pip install networkx==1.1
#this works
pip install numpy
#check if networkx version is correct
pip install show
pip show networkx
#is correct
```

Some deep buried documentation suggests that networkx 1.7 should work too


Then spent some time trying to install blasr, which requires conda. Tried some lazy things but just installing miniconda on my own worked best:
https://conda.io/docs/user-guide/install/linux.html
```
conda install -c bioconda blasr
````

Next I tested an install on my macbook and this failed.

Some further digging revealed its a deeper problem that PBSuite has not updated with Blasr updates and the documentation does not reflect this.

tried fixing blasr flags : https://www.biostars.org/p/198519/
*fixed in many places, changed from - to --*

this eventually worked

on upmax had to install pyparsing
```
pip install pyparsing
```
