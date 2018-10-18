
#cant run until confident in our assembly

REF=/home/eenbody/Enbody_WD/WSFW_DDIG/Reference_Genome_WSFW

tophat --library-type fr-secondstrand -p 20 --no-sort-bam --no-convert-bam $REF/WSFW_ref_noIUB 27-47816-moretoni-M-Chest_S26_clp.fq.1.gz,28-47816-moretoni-M-SP_S27_clp.fq.1.gz 27-47816-moretoni-M-Chest_S26_clp.fq.2.gz,28-47816-moretoni-M-SP_S27_clp.fq.2.gz
