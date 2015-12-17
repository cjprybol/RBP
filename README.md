# Li Lab rotation, RNA binding protein knockdown

to run scripts on scg3, see Src/commands_to_run.md

otherwise, just run scripts in order:
- Src/s01.merge_fastq.sh
	- merges each fastq, split between 4 lanes, into a single fastq
- Src/s10.fastqc_pre.sh {num_parallel_jobs}
	- quality control before lighter read correction/trimming
- Src/s11.lighter.sh {num_parallel_jobs}
	- or, to submit each file to scg3 individually, each using multiple cores
	- ./s11.lighter_individual.sh {num_cores_per_job}
	- trims/corrects reads

- Src/s12.fastqc_post.sh {num_parallel_jobs}
	- view quality of fastq files after trimming/correction
- Src/s13.star_create_genome1.sh {num_cores}
	- generate reference indexed genome to map to

- Src/s14.star_pass1.sh {num_cores_per_job}
	- note this script will only submit jobs to scg3
	- map

- Src/s15.prep_SJ.sh
	- join de novo splice junctions detected during first mapping
- Src/s16.star_create_genome2.sh {num_cores}
	- create new genome to map to, including detected splice junctions from first mapping
- Src/s17.star_pass2.sh {num_cores_per_job}
	- note this script will only submit jobs to scg3
	- remap to new genome, with de novo predictions from 1st mapping included
- Src/s18.pre_filter_flagstat.sh {num_parallel_jobs}
	- see how the mapping went
- Src/s19.bam_filter.sh {num_parallel_jobs}
	- filter, sort, and index
- Src/s20.post_filter_flagstat.sh {num_parallel_jobs}
	- check bams after filtering
- Src/s22.freebayes_individual.sh {num_parallel_jobs}
- run Src/DEseq.R in R studio session
- run Src/vcf_to_editing_levels.ipynb in jupyter session with python3 kernel
	- recommended: install Anaconda with python 3 from Continuum Analytics
	- required packages to install with conda:
		- pandas
		- scipy
	- install plotly with pip (requires signing up for plotly account)

- All other scripts are just there because I made them, realized I didn't need them, but they work and I'm keeping them here in case I need them later


- Software needed in path
	- GNU Parallel
	- bedtools
	- STAR
	- samtools
	- fastqc
	- [lighter](https://github.com/mourisl/Lighter)
	- R
		- libraries: DEseq2
