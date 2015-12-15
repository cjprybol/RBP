#!/bin/bash

BASE="$( dirname "$(pwd)" )"

INDIR="$BASE/STARpass2"
OUTDIR="$BASE/STARpass2Flagstat"

if [ ! -d "$OUTDIR" ];
        then
                mkdir "$OUTDIR"
fi

parallel --jobs $1 --plus \
	samtools \
	flagstat \
	{} \
	'>' $OUTDIR/'{/...}'.flagstat.out \
	::: "$(ls "$INDIR"/*.Aligned.out.bam)"
