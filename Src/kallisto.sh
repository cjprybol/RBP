#!/bin/bash

BASE="$( dirname "$(pwd)" )"

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

kallisto \
    quant \
    --index=$1 \
    --output-dir=$2 \
    --bias \
    --threads=$3 \
    $4 $5
