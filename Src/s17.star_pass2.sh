#!/bin/bash

BASE="$( dirname "$(pwd)" )"

FASTQ_DIR="$BASE/LighterProcessedFastq"
GENOME_2_DIR="$BASE/STARGenome2"
PASS_2_DIR="$BASE/STARpass2"

if [ ! -d "$PASS_2_DIR" ];
        then
                mkdir "$PASS_2_DIR"
fi

num_cores=$1
total_memory=16
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
    star.sh \
    {} '{= s:\.[^.]+$::; s:\.[^.]+$::; s:\.[^.]+$::; s:\.[^.]+$::; =}.2.cor.fq.gz' \
    $GENOME_2_DIR \
    $num_cores \
    "$PASS_2_DIR/"'{= s:.*/::; s:\.[^.]+$::; s:\.[^.]+$::; s:\.[^.]+$::; s:\.[^.]+$::; =}.' \
    ::: $(ls "$FASTQ_DIR"/*.1.cor.fq.gz)
