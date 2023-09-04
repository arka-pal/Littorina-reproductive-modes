#!/bin/bash

##### written by Arka Pal, update: 24 May 2022
##### Usage: sbatch --array=1-n job-trimvcf.slurm.sh <input.vcf.file> <output.vcf.file>

#SBATCH --job-name=trimvcf
#SBATCH --output=job-trimvcf.slurm-%A.out
#SBATCH --error=job-trimvcf.slurm-%A.err

#SBATCH --partition=defaultp
#SBATCH --time=12:00:00
#SBATCH -c 1
#SBATCH --mem-per-cpu=10G
#SBATCH --ntasks-per-node=1
#SBATCH --ntasks=1

#SBATCH --mail-user=arka.pal@ist.ac.at
#SBATCH --mail-type=ALL

#SBATCH --no-requeue
#SBATCH --export=NONE
unset SLURM_EXPORT_ENV

## Set the number of threads to the SLURM internal variable
export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK

## load any module you need here
module load bcftools

## run commands on SLURM's srun
srun bcftools view -a -I -O z -o $2 $1
srun bcftools stats $2 > ${2/.vcf.gz/.stats}
