preface with
pre=
qsub -S /bin/sh -cwd -R y -V -w e -m bea -M $USER@stanford.edu

$pre -l h_vmem=6G -pe shm 8 s10.fastqc_pre.sh 8
# $pre -l h_vmem=20G -pe shm 6 s11.lighter.sh 6
./s11.lighter_individual.sh 4
$pre -l h_vmem=6G -pe shm 8 s12.fastqc_post.sh 8
$pre -l h_vmem=4G -pe shm 4 s13.star_create_genome1.sh 4
./s14.star_pass1.sh 8
$pre s15.prep_SJ.sh
$pre -l h_vmem=4G -pe shm 4 s16.star_create_genome2.sh 4
./s17.star_pass2.sh 8
$pre -l h_vmem=4G -pe shm 4 s18.pre_filter_flagstat.sh 4
$pre -l h_vmem=16G -pe shm 4 s19.bam_filter.sh 4

$pre -l h_vmem=12G -l h_rt=96:00:00 s22.freebayes.sh
$pre -l h_vmem=6G -pe shm 8 -l h_rt=96:00:00 s22.freebayes_individual.sh 8


$pre -l h_vmem=20G s30.kallisto_index.sh
./s31.kallisto_quantify.sh 8
