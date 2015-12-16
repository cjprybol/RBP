#!/bin/bash

BASE="$( dirname "$(pwd)" )"

INDIR="$BASE/SortedBam"
OUTDIR="$BASE/Mpileup"

if [ ! -d "$OUTDIR" ];
        then
                mkdir "$OUTDIR"
fi

REFERENCE_DIR="$BASE/Data"

parallel --plus --jobs $1 \
	samtools mpileup \
	--fasta-ref "$REFERENCE_DIR/Drosophila_melanogaster.BDGP6.dna.toplevel.fa" \
	--positions $REFERENCE_DIR/dm3_AG_sites_converted.bed \
	--VCF \
	--uncompressed \
	--output $OUTDIR/{/...}.pileup.vcf \
	{} \
	::: $(ls "$INDIR"/*.sorted.filtered.bam)


