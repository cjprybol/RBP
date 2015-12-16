ftp://ftp.ensembl.org/pub/release-83/gtf/drosophila_melanogaster/Drosophila_melanogaster.BDGP6.83.gtf.gz
ftp://ftp.ensembl.org/pub/release-83/gff3/drosophila_melanogaster/Drosophila_melanogaster.BDGP6.83.gff3.gz
ftp://ftp.ensembl.org/pub/release-83/fasta/drosophila_melanogaster/dna/Drosophila_melanogaster.BDGP6.dna.toplevel.fa.gz
ftp://ftp.ensembl.org/pub/release-83/fasta/drosophila_melanogaster/cdna/Drosophila_melanogaster.BDGP6.cdna.all.fa.gz

mart_export.txt
    - http://uswest.ensembl.org/biomart/martview
    - choose a database: Ensembl genes 83
    - choose a dataset: Drosophila melanogaster genes (BDGP6)
    - results
    - export all results to:
        - file
        - tsv
        - unique results only

Fly_AG_all_dm3_v2.txt
- http://web.stanford.edu/~gokulr/database/Fly_AG_all_dm3_v2.txt
- by comparing http://web.stanford.edu/~gokulr/database/Fly_AG_all_dm3.bed and http://web.stanford.edu/~gokulr/database/Fly_AG_all_dm3_v2.txt could determine that start, end should be pos-1, pos, and not pos, pos+1 in order to convert v2 to bed
- `awk '{FS="\t"}{OFS="\t"}{print $1, $2-1, $2, $3, 0, $4}' Fly_AG_all_dm3_v2.txt | sed "1d" > Fly_AG_all_dm3_v2.converted.bed`
- run Fly_AG_all_dm3_v2.converted.bed through https://genome.ucsc.edu/cgi-bin/hgLiftOver
	- Original Genome: D. melanogaster
	- Original Assembly: Apr. 2006 (BDGP R5/dm3)
	- New Genome: D. melanogaster
	- New Assembly: Aug. 2014 (BDGP Release 6 + ISO1 MT/dm6)
	- choose file -- choose Fly_AG_all_dm3_v2.converted.bed
	- submit file
	- download results and rename file to dm3_AG_sites_converted.bed
		- downloaded file was named `hglft_genome_64dc_b0590.bed` in my particular case
