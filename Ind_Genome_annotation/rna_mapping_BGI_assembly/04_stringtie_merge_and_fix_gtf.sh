
module load bioinfo-tools StringTie/1.3.3 samtools/1.8

stringtie --merge -p 20 -o ruff_stringtie_merged.gtf mergelist.txt

source /crex/proj/uppstore2017195/users/erik/ruff/ruff_software/GAAS/activate_rackham_env
