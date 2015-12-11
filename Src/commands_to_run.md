preface with
pre=
qsub -S /bin/sh -cwd -R y -V -w e -m bea -M $USER@stanford.edu




$pre -l h_vmem=6G -pe shm 8 s10.fastqc_pre.sh 8
# $pre -l h_vmem=20G -pe shm 6 s11.lighter.sh 6
./s11.lighter_individual.sh 4
$pre -l h_vmem=6G -pe shm 8 s12.fastqc_post.sh 8
$pre -l h_vmem=10G -pe shm 4 s13.star_create_genome1.sh 4
./s14.star_pass1.sh 8
$pre s15.prep_SJ.sh
$pre -l h_vmem=10G -pe shm 4 s16.star_create_genome2.sh 4
./s17.star_pass2.sh 8
$pre -l h_vmem=8G -pe shm 8 s18.bam_filter.sh 8
$pre -l h_vmem=16G -pe shm 4 s19.flagstat.sh 4
$pre -l h_vmem=20G s20.kallisto_index.sh
$pre -l h_vmem=16G -pe shm 4 s21.kallisto_quantify.sh 4
