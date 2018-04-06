#!/bin/bash 
#SBATCH --nodes=1
#SBATCH --cpus-per-task=20 
#SBATCH --time=8:00:00 
#SBATCH --mem=62GB
#SBATCH --job-name=1

module purge 
module load methylpy/1.2.8 
module load bowtie2/intel/2.3.2 
module load samtools/intel/1.6 
module load bowtie/gnu/1.2.1.1 


methylpy single-end-pipeline \
--read-files /scratch/yw3452/Kawakatsu_et_al_methyl_data/raw_reads/*$1* \
--sample $1 \
--forward-ref /scratch/yw3452/methylpy_example/example_data/genome/tair10_f \
--reverse-ref /scratch/yw3452/methylpy_example/example_data/genome/tair10_r \
--ref-fasta /scratch/yw3452/methylpy_example/example_data/genome/tair10.fa \
--num-procs 20 \
--path-to-output /scratch/yw3452/Kawakatsu_et_al_methyl_data/results/403 \
--trim-reads False \
--unmethylated-control "chrom:chrC" \
--binom-test True
>log-err/log_$1_$SLURM_JOB_ID.txt 2>log_err/err_$1_$SLURM_JOB_ID.txt
       
