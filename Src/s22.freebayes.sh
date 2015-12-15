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

# output with removes any sites with estimated probability of not being polymorphic less than phred 20 (aka 0.01), or probability of polymorphism > 0.99

freebayes \
	--fasta-reference "$REFERENCE_DIR/Drosophila_melanogaster.BDGP6.dna.toplevel.fa" \
	$FILES > $OUTDIR/freebayes.out.vcf
