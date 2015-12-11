#!/bin/bash

BASE="$( dirname "$(pwd)" )"

INDIR="$BASE/SortedBam"

parallel --jobs $1 --plus \
	samtools \
	flagstat \
	{} \
	'>' '{..}'.flagstat.out \
	::: "$(ls "$INDIR"/*.filtered.bam)"
