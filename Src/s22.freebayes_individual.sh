#!/bin/bash

BASE="$( dirname "$(pwd)" )"

INDIR="$BASE/SortedBam"
OUTDIR="$BASE/Mpileup"

if [ ! -d "$OUTDIR" ];
        then
                mkdir "$OUTDIR"
fi

REFERENCE_DIR="$BASE/Data"

#	parallel --plus --jobs $1 \
#		freebayes \
#		--fasta-reference "$REFERENCE_DIR/Drosophila_melanogaster.BDGP6.dna.toplevel.fa" \
#		--targets $REFERENCE_DIR/dm3_AG_sites_converted.bed \
#		'{}' '>' $OUTDIR/'{/...}'.freebayes.vcf \
#		::: $(ls "$INDIR"/*.sorted.filtered.bam)

parallel --plus --jobs $1 \
	grep -v "^#" '{}' '>' '{..}'.headerless.vcf \
	::: $(ls "$OUTDIR"/*.freebayes.vcf)
