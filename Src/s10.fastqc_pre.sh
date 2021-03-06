#!/bin/bash

BASE="$( dirname "$(pwd)" )"

FASTQ_DIR="$BASE/FastqCombined"
OUT_DIR="$BASE/FastQCpreLighter"

# if output folder does not exist, create it
if [ ! -d "$OUT_DIR" ];
        then
                mkdir "$OUT_DIR"
fi

parallel --jobs $1 --plus \
        fastqc \
        --outdir $OUT_DIR \
        {} \
        ::: "$(ls "$FASTQ_DIR"/*.fastq.gz)"
