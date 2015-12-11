#!/bin/bash

BASE="$( dirname "$(pwd)" )"

FASTQ_DIR="$BASE/LighterProcessedFastq"
GENOME_1_DIR="$BASE/STARGenome1"
PASS_1_DIR="$BASE/STARpass1"

if [ ! -d "$PASS_1_DIR" ];
        then
                mkdir "$PASS_1_DIR"
fi

num_cores=$1
total_memory=40
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
    $GENOME_1_DIR \
    $num_cores \
    "$PASS_1_DIR/"'{= s:.*/::; s:\.[^.]+$::; s:\.[^.]+$::; s:\.[^.]+$::; s:\.[^.]+$::; =}.' \
    ::: $(ls "$FASTQ_DIR"/*.1.cor.fq.gz)
