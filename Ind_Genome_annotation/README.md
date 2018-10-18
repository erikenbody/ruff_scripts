#### RNAseq input

Using reads from other Nature paper trimmed using my standard pipeline
Also one satellite male skin sample from recent RNAseq (Sample_QL-1682-Ruff-skin2)


#### input data

For TopHat, I ran the following processing steps after running Tophat


```
cd /crex/proj/uppstore2017195/users/erik/ruff/Genome_annotation/RNAseq_input/tophat_nogtf
awk '{if($5 >= 5) print $0}' junctions.bed > high_quality_junctions.bed
module load bioinfo-tools maker/3.01.2-beta

tophat2gff3 high_quality_junctions.bed > high_quality_junctions.gff
```

For formatting the mapped files I had to setup the GAAS (Uppsala annotation tools) environment. Directions here:
https://github.com/NBISweden/GAAS
Directions on running the gtf convertor here:
https://scilifelab.github.io/courses/annotation/2017/practical_session/ExcerciseEvidence
They actually use the tophat output rather than hisat for generating bam files for stringtie. Not sure what advantages if any this offers.

```
source /crex/proj/uppstore2017195/users/erik/ruff/ruff_software/GAAS/profiles/activate_rackham_env
module load perl  
module load perl_modules  
module load BioPerl/1.6.924_Perl5.18.4
cd /home/eenbody/ruff/Genome_annotation/rna_mapping
gxf_to_gff3.pl -g ruff_stringtie_merged.gtf -o ruff_stringtie_merged.gff3 --gff_version 2
```

### Post maker run 1 (evidence based)

Now need to train gene predictors. First check output:

Generally following assemblage pipeline:
https://github.com/sujaikumar/assemblage/blob/master/README-annotation.md


```
cd /home/eenbody/ruff/Genome_annotation/01_maker_evi_based_partial_sat/sn180416_satscaf.maker.output
grep 'FINISHED' sn180416_satscaf_master_datastore_index.log | wc -l
>1
#should only be 1

fasta_merge -d sn180416_satscaf_master_datastore_index.log
gff3_merge -d sn180416_satscaf_master_datastore_index.log
```

Next run SNAP

```
#train SNAP
cd .. #maker wd
mkdir trainsnap
cd trainsnap/
cp ../*output/*.gff .

maker2zff *gff
fathom genome.ann genome.dna -gene-stats > gene-stats.log 2>&1
cat gene-stats.log
1 sequences
0.415091 avg GC fraction (min=0.415091 max=0.415091)
858 genes (plus=409 minus=449)
10 (0.011655) single-exon
848 (0.988345) multi-exon
155.335403 mean exon (min=1 max=3150)
1847.300781 mean intron (min=20 max=139913)

fathom genome.ann genome.dna -validate > validate.log 2>&1
fathom genome.ann genome.dna -categorize 1000 #> categorize.log 2>&1
fathom -export 1000 -plus uni.ann uni.dna #> uni-plus.log 2>&1
forge export.ann export.dna #> forge.log 2>&1

hmm-assembler.pl sat .> sat.hmm
```
Setup for retraining in augustus

```
cd ..
mkdir train_augustus
cd train_augustus/
cp ../trainsnap/genome* .

zff2gff3.pl ./genome.ann | perl -plne 's/\t(\S+)$/\t\.\t$1/' > sat.gff3

#augustus config path looks okay, test with
echo $AUGUSTUS_CONFIG_PATH
#ok but didnt work see uppmax documentation on augustus:

source $AUGUSTUS_CONFIG_COPY
new_species.pl --species=sat

#make genbank
gff2gbSmallDNA.pl sat.gff3 ./genome.dna 1000 sat.gb

#Randomly split the set of annotated sequences in a training and a test set
randomSplit.pl sat.gb 200

#This generates a file myspecies.gb.test with 100 randomly chosen loci and a disjoint file myspecies.gb.train with the rest of the loci from genes.gb:
cat sat.gb | grep "LOCUS" | wc -l
>sat.gb:216

#initial etraining
etraining --species=sat sat.gb.train

#check contents of species
ls -ort $AUGUSTUS_CONFIG_PATH/species/sat/

#Now we make a first try and predict the genes in genes.gb.train ab initio.
augustus --species=sat sat.gb.test | tee firsttest.out # takes ~1m

*******      Evaluation of gene prediction     *******

---------------------------------------------\
                 | sensitivity | specificity |
---------------------------------------------|
nucleotide level |        0.35 |       0.724 |
---------------------------------------------/

----------------------------------------------------------------------------------------------------------\
           |  #pred |  #anno |      |    FP = false pos. |    FN = false neg. |             |             |
           | total/ | total/ |   TP |--------------------|--------------------| sensitivity | specificity |
           | unique | unique |      | part | ovlp | wrng | part | ovlp | wrng |             |             |
----------------------------------------------------------------------------------------------------------|
           |        |        |      |                331 |               1512 |             |             |
exon level |    533 |   1714 |  202 | ------------------ | ------------------ |       0.118 |       0.379 |
           |    533 |   1714 |      |  163 |   39 |  129 |  166 |   53 | 1293 |             |             |
----------------------------------------------------------------------------------------------------------/

----------------------------------------------------------------------------\
transcript | #pred | #anno |   TP |   FP |   FN | sensitivity | specificity |
----------------------------------------------------------------------------|
gene level |   152 |   200 |    3 |  149 |  197 |       0.015 |      0.0197 |
----------------------------------------------------------------------------/

------------------------------------------------------------------------\
            UTR | total pred | CDS bnd. corr. |   meanDiff | medianDiff |
------------------------------------------------------------------------|
            TSS |         27 |              0 |         -1 |         -1 |
            TTS |         13 |              0 |         -1 |         -1 |
------------------------------------------------------------------------|
            UTR | uniq. pred |    unique anno |      sens. |      spec. |
------------------------------------------------------------------------|
                |  true positive = 1 bound. exact, 1 bound. <= 20bp off |
 UTR exon level |          0 |              0 |       -nan |       -nan |
------------------------------------------------------------------------|
 UTR base level |          0 |              0 |       -nan |       -nan |
------------------------------------------------------------------------/
nucUTP= 0 nucUFP=0 nucUFPinside= 0 nucUFN=0
# total time: 331
# command line:
# augustus --species=sat sat.gb.test

#is ok but not great  I think
```

after submitting train_augustus.sh
```
etraining --species=sat sat.gb.train
```
then check accuracy
```
#randomSplit.pl sat.gb.train 100
augustus --species=sat sat.gb.train | tee secondtest.out

*******      Evaluation of gene prediction     *******

---------------------------------------------\
                 | sensitivity | specificity |
---------------------------------------------|
nucleotide level |       0.893 |       0.942 |
---------------------------------------------/

----------------------------------------------------------------------------------------------------------\
           |  #pred |  #anno |      |    FP = false pos. |    FN = false neg. |             |             |
           | total/ | total/ |   TP |--------------------|--------------------| sensitivity | specificity |
           | unique | unique |      | part | ovlp | wrng | part | ovlp | wrng |             |             |
----------------------------------------------------------------------------------------------------------|
           |        |        |      |                 22 |                 22 |             |             |
exon level |    119 |    119 |   97 | ------------------ | ------------------ |       0.815 |       0.815 |
           |    119 |    119 |      |   11 |    1 |   10 |   11 |    1 |   10 |             |             |
----------------------------------------------------------------------------------------------------------/

----------------------------------------------------------------------------\
transcript | #pred | #anno |   TP |   FP |   FN | sensitivity | specificity |
----------------------------------------------------------------------------|
gene level |    14 |    16 |    3 |   11 |   13 |       0.188 |       0.214 |
----------------------------------------------------------------------------/

------------------------------------------------------------------------\
            UTR | total pred | CDS bnd. corr. |   meanDiff | medianDiff |
------------------------------------------------------------------------|
            TSS |          3 |              0 |         -1 |         -1 |
            TTS |          2 |              0 |         -1 |         -1 |
------------------------------------------------------------------------|
            UTR | uniq. pred |    unique anno |      sens. |      spec. |
------------------------------------------------------------------------|
                |  true positive = 1 bound. exact, 1 bound. <= 20bp off |
 UTR exon level |          0 |              0 |       -nan |       -nan |
------------------------------------------------------------------------|
 UTR base level |          0 |              0 |       -nan |       -nan |
------------------------------------------------------------------------/
nucUTP= 0 nucUFP=0 nucUFPinside= 0 nucUFN=0
# total time: 14.2
# command line:
# augustus --species=sat sat.gb.train
```

again maybe not great?

## Check maker round 2

```
cat sn180416_satscaf.all.gff | awk '{ if ($3 == "gene") print $0 }' | awk '{ sum += ($5 - $4) } END { print NR, sum / NR }'
>385 46779.6
grep -cP '\tgene\t' sn180416_satscaf.all.gff
>385

#check AED range. Its pretty bad with only 73% with AED < 0.5
AED_cdf_generator.pl -b 0.025 sn180416_satscaf.all.gff

AED     sn180416_satscaf.all.gff
0.000   0.007
0.025   0.016
0.050   0.053
0.075   0.083
0.100   0.139
0.125   0.193
0.150   0.257
0.175   0.292
0.200   0.352
0.225   0.382
0.250   0.428
0.275   0.479
0.300   0.524
0.325   0.552
0.350   0.585
0.375   0.618
0.400   0.655
0.425   0.680
0.450   0.705
0.475   0.712
0.500   0.726
0.525   0.733
0.550   0.743
0.575   0.747
0.600   0.750
0.625   0.750
0.650   0.750
0.675   0.750
0.700   0.752
0.725   0.753
0.750   0.758
0.775   0.759
0.800   0.759
0.825   0.761
0.850   0.762
0.875   0.762
0.900   0.769
0.925   0.774
0.950   0.774
0.975   0.774
1.000   1.000


##inspect quality trimming
quality_filter.pl -d sn180416_satscaf.all.gff  > sn180416_satscaf.all.default.gff

grep -cP '\tgene\t' sn180416_satscaf.all.default.gff
>234
AED_cdf_generator.pl -b 0.025 sn180416_satscaf.all.default.gff


interproscan.sh -appl PfamA -iprlookup -goterms -f tsv -i sn180416_satscaf.all.maker.proteins.fasta

ipr_update_gff sn180416_satscaf.all.gff sn180416_satscaf.all.maker.proteins.fasta.tsv > sn180416_satscaf.all_ipr.gff

quality_filter.pl -s sn180416_satscaf.all_ipr.gff  > sn180416_satscaf.all.standard_ipr.gff
grep -cP '\tgene\t' sn180416_satscaf.all.standard_ipr.gff
>234

AED_cdf_generator.pl -b 0.025 sn180416_satscaf.all.standard_ipr.gff

AED     sn180416_satscaf.all.standard_ipr.gff
0.000   0.009
0.025   0.021
0.050   0.067
0.075   0.107
0.100   0.178
0.125   0.247
0.150   0.330
0.175   0.375
0.200   0.451
0.225   0.491
0.250   0.549
0.275   0.614
0.300   0.672
0.325   0.708
0.350   0.751
0.375   0.792
0.400   0.841
0.425   0.873
0.450   0.904
0.475   0.914
0.500   0.931
0.525   0.940
0.550   0.953
0.575   0.959
0.600   0.963
0.625   0.963
0.650   0.963
0.675   0.963
0.700   0.964
0.725   0.966
0.750   0.972
0.775   0.974
0.800   0.974
0.825   0.976
0.850   0.978
0.875   0.978
0.900   0.987
0.925   0.993
0.950   0.993
0.975   0.993
1.000   1.000

iprscan2gff3 sn180416_satscaf.all.maker.proteins.fasta.tsv sn180416_satscaf.all.standard_ipr.gff > visible_iprscan_domains.gff

```

Put in jbrowse:

```
cd /Library/WebServer/Documents/jbrowse/JBrowse-1.12.3rc2
mkdir data/json/ruff_sat
bin/prepare-refseqs.pl --out data/json/ruff_sat/ --fasta /Users/erikenbody/Google_Drive/Uppsala/Projects/inProgress/Ruff/output/maker/sn180416_satscaf.fasta

bin/maker2jbrowse /Users/erikenbody/Google_Drive/Uppsala/Projects/inProgress/Ruff/output/maker/sn180416_satscaf.all.gff -o data/json/ruff_sat/

bin/generate-names.pl --verbose --out data/json/ruff_sat
```
available here:

http://localhost/jbrowse/JBrowse-1.12.3rc2/index.html?data=data/json/ruff_sat

Make a filtered by AED and pfam (IPR)
```
cd /Library/WebServer/Documents/jbrowse/JBrowse-1.12.3rc2
mkdir data/json/ruff_sat_filt
bin/prepare-refseqs.pl --out data/json/ruff_sat_filt/ --fasta /Users/erikenbody/Google_Drive/Uppsala/Projects/inProgress/Ruff/output/maker/sn180416_satscaf.fasta

bin/maker2jbrowse /Users/erikenbody/Google_Drive/Uppsala/Projects/inProgress/Ruff/output/maker/sn180416_satscaf.all.standard_ipr.gff -o data/json/ruff_sat_filt/

bin/maker2jbrowse /Users/erikenbody/Google_Drive/Uppsala/Projects/inProgress/Ruff/output/maker/visible_iprscan_domains.gff  -o data/json/ruff_sat_filt/

bin/generate-names.pl --verbose --out data/json/ruff_sat_filt
```
http://localhost/jbrowse/JBrowse-1.12.3rc2/index.html?data=data/json/ruff_sat_filt




### Prepare some summaries

```
module load BEDTools/2.27.1
#nano regions.bed #then add sat 5543082 9660324
bedtools intersect -a regions.bed -b sn180416_satscaf.all.standard_ipr.gff -wa -wb > sn180416_satscaf.all.standard_ipr_INV.gff
grep -cP '\tgene\t' sn180416_satscaf.all.standard_ipr_INV.gff
>94
grep -cP '\tmRNA\t' sn180416_satscaf.all.standard_ipr_INV.gff
>201

AED_cdf_generator.pl -b 0.025 sn180416_satscaf.all.standard_ipr_INV.gff
>96% AED > 0.5

##Original
grep -cP '\tmRNA\t' /home/eenbody/data_ruff/annotation/liftover/Ruff_scafSeq_scaf28_GalGeneNames_invOnly.gff
>102

grep -cP '\tmRNA\t' /home/eenbody/data_ruff/annotation/liftover/Ruff_scafSeq.genenames.gff
>102
grep -cP '\tmRNA\t' /home/eenbody/data_ruff/annotation/liftover/indInv.gff
>93

```

check Illumina

```
cd /home/eenbody/ruff/Genome_annotation
bedtools intersect -a regions.bed -b ref_ASM143184v1_scaffolds.gff3 -wa -wb >  ref_ASM143184v1_scaffolds_INV.gff3
grep -cP '\tgene\t' ref_ASM143184v1_scaffolds_INV.gff3
>108


```

```
for FILENAME in *.bam
  do
  samtools flagstat $FILENAME > ${FILENAME}.stats
  done
```
