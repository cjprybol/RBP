#!/bin/bash

BASE="$( dirname "$(pwd)" )"

FASTQ_DIR="$BASE/FastqCombined"
OUT_DIR="$BASE/LighterProcessedFastq"

GENOME_SIZE=122653977
NUM_CORES=$1

# if output folder does not exist, create it
if [ ! -d "$OUT_DIR" ];
        then
                mkdir "$OUT_DIR"
fi

# write to a blank file to append ligther log output to
> "$OUT_DIR/lighter.out"

#  k-mer size of 19 (see Figure 5 of paper)
# -K kmer_length genom_size: in this case, the genome size should be relative accurate
# -od set out directory
# -trim: allow trimming at ends of low-quality
parallel --plus\
	qsub \
	-S /bin/sh \
	-cwd \
	-R y \
	-V \
	-w e \
	-N {/} \
	-m bea -M $USER@stanford.edu \
	-l h_vmem=5G \
	-pe shm $NUM_CORES \
	lighter.sh \
	{} \
	19 $GENOME_SIZE \
	"$OUT_DIR" \
	"$OUT_DIR/lighter.out" \
	$NUM_CORES \
	::: "$(ls "$FASTQ_DIR"/*.fastq.gz)"
