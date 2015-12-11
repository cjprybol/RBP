#!/bin/bash

#  k-mer size of 19 (see Figure 5 of paper)
# -K kmer_length genom_size: in this case, the genome size should be relative accurate
# -od set out directory
# -trim: allow trimming at ends of low-quality
# -t num_of_threads: number of threads to use (default: 1)
lighter \
	-r $1 \
	-K $2 $3 \
	-od $4 \
	-trim \
	2>> $5 \
	-t $6 \
