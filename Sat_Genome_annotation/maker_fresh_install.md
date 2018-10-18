
Perl is good at default (v. 5.16.3, 5.8 required). However, bioperl module is dependent on v 5.24.1 so just load bioperl (1.6 is required by maker).

module load bioinfo-tools BioPerl/1.7.2_Perl5.24.1 blast/2.7.1+ snap/2013-11-29 RepeatMasker/4.0.7_Perl5.24.1 exonerate/2.2.0 augustus/3.2.3_Perl5.24.1 GeneMark/4.33-es_Perl5.24.1

module load  gcc/8.2.0
module load openmpi/3.1.1

cp -av /sw/apps/bioinfo/GeneMark/4.33-es/rackham/gm_key $HOME/.gm_key
export LD_PRELOAD=$MPI_ROOT/lib/libmpi.so

perl Build.PL
#note it says that DBD::pg is missing. So run this accepting all defaults. First spit an error about location of pg_config, so loaded postgres module:
module load PostgreSQL/10.3
./Build installdeps
#works. ok see if any exes needed (should all be pre loaded)
./Build installexes

##take 2

module load

module load bioinfo-tools blast/2.7.1+ snap/2013-11-29 exonerate/2.2.0
repeat masker
bioperl
augustus
genemark


#Trying to install bioperl
module load perl/5.26.2 bioinfo-tools
perl -MCPAN -e shell
install Bundle::CPAN
install Module::Build
install Bundle::BioPerl
#maybe above werent neccessary? just load below if trying again
module load perl/5.26.2 bioinfo-tools
module load gcc/8.2.0
module load PostgreSQL/10.3
module load openmpi/3.1.1

cd maker/src/
perl Build.PL
./Build installdeps


export ZOE=/home/eenbody/ruff/ruff_software/SNAP/Zoe # sh, bash, etc
#had to manually install SNAP which required gcc 7
#https://github.com/KorfLab/SNAP
module load gcc/7.3.0

export LD_PRELOAD=$MPI_ROOT/lib/libmpi.so
cd /home/eenbody/ruff/Genome_annotation/01_maker_evi_based_partial_sat
mpiexec -n 2 /home/eenbody/ruff/ruff_software/maker_perl5.26.2/maker/bin/maker -h

mpiexec -mca btl ^openib -n 4 /home/eenbody/ruff/ruff_software/maker_perl5.26.2/maker/bin/maker -base test_Maker_MPI


#still would need to add SNAP to the path and eventually install Augustus locally
#but this gives exact same error. Looks like openMPI is associated with gcc8, so tried loading that and re running
#nope still doesnt work
#IMO email uppmax to say I tried install locally

#no error fixing from:
https://groups.google.com/forum/#!searchin/maker-devel/intelmpi%7Csort:date/maker-devel/ZdaZgVuGvso/XPpukVxECQAJ
mpiexec -mca btl vader,tcp,self --mca vader,tcp,self --mca btl_tcp_if_include eth0 -n 1 /home/eenbody/ruff/ruff_software/maker_perl5.26.2/maker/bin/maker -base test_Maker_MPI


##Trying with intelMPI. Installed on r369.

module load intelmpi/18.3

#re ran build in previous directory (ignore intelmpi dir)
-binding pin=disable    #what is this? couldnt get it to do anything

#options to load
export I_MPI_PIN_DOMAIN=node #otherwise MAKER calls to BLAST and other programs which are parallelized independent of MPI may not work
export I_MPI_FABRICS=shm:tcp  #avoid potential complication with OpenFabrics libraries (they block system calls because of how they use registered memory, i.e. MAKER calling BLAST would fail)
export I_MPI_HYDRA_IFACE=ib0  #set to eth0 if you don’t have an infiniband over ip inerface (required because of the above I_MPI_FABRICS change)

maker_opts_run1.ctl maker_bopts.ctl maker_exe.ctl maker_evm.ctl


cd /home/eenbody/ruff/Genome_annotation/01_maker_evi_based_partial_sat

/home/eenbody/ruff/ruff_software/maker_perl5.26.2/maker/bin/maker -CTL

srun -n 4 /home/eenbody/ruff/ruff_software/maker_perl5.26.2/maker/bin/maker maker_opts_run1.ctl maker_bopts.ctl maker_exe.ctl maker_evm.ctl -base test_Maker_MPI_4

#but problem with repeeatmasker. Error about a cpan module so ran:
cpan Text::Soundex

#trying fresh intelMPI install. was no MPI communication in that previous attempt
module load bioinfo-tools
module load RepeatMasker/4.0.7
module load snap
module load intelmpi/18.3
module load BioPerl/1.6.924_Perl5.18.4
module load blast/2.7.1+
module load exonerate/2.2.0
module load PostgreSQL/10.3




cd /home/eenbody/ruff/Genome_annotation/01_maker_evi_based_partial_sat

export I_MPI_PIN_DOMAIN=node #otherwise MAKER calls to BLAST and other programs which are parallelized independent of MPI may not work
export I_MPI_FABRICS=shm:tcp  #avoid potential complication with OpenFabrics libraries (they block system calls because of how they use registered memory, i.e. MAKER calling BLAST would fail)
export I_MPI_HYDRA_IFACE=ib0  #set to eth0 if you don’t have an infiniband over ip inerface (required because of the above I_MPI_FABRICS change)
export I_MPI_PMI_LIBRARY=/usr/lib64/libpmi.so

/home/eenbody/ruff/ruff_software/maker_intelmpi/maker/bin/maker -CTL

srun -n 2 /home/eenbody/ruff/ruff_software/maker_intelmpi/maker/bin/maker -h

srun -n 2 /home/eenbody/ruff/ruff_software/maker_intelmpi/maker/bin/maker maker_opts_run1.ctl maker_bopts.ctl maker_exe.ctl maker_evm.ctl -base test_Maker_MPI_6
