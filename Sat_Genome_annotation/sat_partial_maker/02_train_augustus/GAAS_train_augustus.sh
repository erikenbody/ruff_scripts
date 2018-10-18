
#following: https://scilifelab.github.io/courses/annotation/2017/practical_session/TrainingAbInitionpredictor.html

source /crex/proj/uppstore2017195/users/erik/ruff/ruff_software/GAAS/profiles/activate_rackham_env
module load bioinfo-tools maker/3.01.2-beta

module load bioinfo-tools
module load perl
module load perl_modules
module load BioPerl/1.6.924_Perl5.18.4
module load cufflinks/2.2.1

maker_gff3manager_JD_v8.pl -f sn180416_satscaf.all.gff -o sn180416_satscaf.all_clean
