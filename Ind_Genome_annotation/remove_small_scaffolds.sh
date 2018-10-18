module load python/2.7.15
module load bioinfo-tools HISAT2/2.1.0 samtools

samtools faidx  --transform chromsizes pseudohap2.1.SatInversionScaffold.fasta | awk '{if ($2>=1400) print }' > pseudohap2.1.SatInversionScaffold_gr1400.fasta


awk '{if ($2>=1400) print }' pseudohap2.1.SatInversionScaffold.fasta > pseudohap2.1.SatInversionScaffold_gr1400.fasta


bioawk -c fastx '(length($seq) > 1400){ print ">"$name; print $seq }' pseudohap2.1.SatInversionScaffold.fasta > pseudohap2.1.SatInversionScaffold_gr1400.fasta
