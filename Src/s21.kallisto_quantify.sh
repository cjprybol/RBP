#!/bin/bash

BASE="$( dirname "$(pwd)" )"

OUT_DIR="$BASE/Kallisto"

# kallisto 0.42.2
# Computes equivalence classes for reads and quantifies abundances
#
# Usage: kallisto quant [arguments] FASTQ-files
#
# Required arguments:
# -i, --index=STRING            Filename for the kallisto index to be used for
#                               quantification
# -o, --output-dir=STRING       Directory to write output to
#
# Optional arguments:
#     --single                  Quantify single-end reads
#     --bias                    Perform sequence based bias correction
# -l, --fragment-length=DOUBLE  Estimated average fragment length
#                               (default: value is estimated from the input data)
#     --pseudobam               Output pseudoalignments in SAM format to stdout
# -b, --bootstrap-samples=INT   Number of bootstrap samples (default: 0)
# -t, --threads=INT             Number of threads to use for bootstraping (default: 1)
#     --seed=INT                Seed for the bootstrap sampling (default: 42)
#     --plaintext               Output plaintext instead of HDF5

num_cores=$1
total_memory=20
mem_per_core=$(($total_memory/$num_cores))

parallel --plus \
    qsub \
    -N '{= s:.*/::; s:\.[^.]+$::; s:\.[^.]+$::; s:\.[^.]+$::; s:\.[^.]+$::; =}' \
    -S /bin/sh \
    -cwd \
    -R y \
    -V \
    -w e \
    -l h_vmem=$mem_per_core'G' \
    -pe shm $num_cores \
    -m bea -M $USER@stanford.edu \
    kallisto.sh \
    $OUT_DIR/index \
    $OUT_DIR/'{= s:.*/::; s:\.[^.]+$::; s:\.[^.]+$::; s:\.[^.]+$::; s:\.[^.]+$::; =}' \
    $num_cores \
    '{= s:\.[^.]+$::; s:\.[^.]+$::; s:\.[^.]+$::; s:\.[^.]+$::; =}'.1.cor.fq.gz \
    '{= s:\.[^.]+$::; s:\.[^.]+$::; s:\.[^.]+$::; s:\.[^.]+$::; =}'.2.cor.fq.gz \
    ::: $(ls $BASE/LighterProcessedFastq/*1.cor.fq.gz)
