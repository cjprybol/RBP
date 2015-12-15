#!/bin/bash

BASE="$( dirname "$(pwd)" )"

INDIR="$BASE/SortedBam"
OUTDIR="$BASE/Mpileup"

if [ ! -d "$OUTDIR" ];
        then
                mkdir "$OUTDIR"
fi

REFERENCE_DIR="$BASE/Data"

FILES=$(ls $INDIR/*.bam)

# -t, --output-tags LIST
# Comma-separated list of FORMAT and INFO tags to output (case-insensitive): DP (Number of high-quality bases, FORMAT), DV (Number of high-quality non-reference bases, FORMAT), DPR (Number of high-quality bases for each observed allele, FORMAT), INFO/DPR (Number of high-quality bases for each observed allele, INFO), DP4 (Number of high-quality ref-forward, ref-reverse, alt-forward and alt-reverse bases, FORMAT), SP (Phred-scaled strand bias P-value, FORMAT) [null]

freebayes \
	--fasta-reference "$REFERENCE_DIR/Drosophila_melanogaster.BDGP6.dna.toplevel.fa" \
	$FILES > $OUTDIR/freebayes.out.vcf
