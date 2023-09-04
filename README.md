Analysis for reproductive modes in __Littorina__ snails
============================

This repository contains scripts for analyses of evolution of live-birth transition in Littorina snails.
[Stankowski et al, 2023, bioRxiv](https://www.biorxiv.org/content/10.1101/2023.02.13.528213v3.abstract).

## ARG Inference

This section contains analysis scripts for inferring ancestral recombination graphs (ARGs) using [ARGweaver](https://github.com/mdrasmus/argweaver/). The marginal trees obtained from the ARG analysis is then used for topoloogy weighting. Path to main analysis - `ARG_inference/scripts/analysis.Rmd`.

    ARG_inference/scripts
    |-- analysis.Rmd                                    # R notebook for step-by-step analysis of ARGweaver output
    |-- bin
    |   |-- functions_from_argweaver.R                  # Functions for running analysis.Rmd (modified from original ARGweaver repo)
    |   |-- functions_v2.R                              # Functions for running analysis.Rmd (version 2, written by Arka Pal)
    |   `-- vcf2sites.R                                 # R function to convert .vcf to .sites format used by ARGweaver
    |-- notes.sh                                        # Notes on preprocessing steps ARGweaver
    |-- pipeline_Littorina.sh                           # Pipeline running ARGweaver on Littorina samples
    `-- slurm                                           # Folder containing SLURM scripts for submitting HPC cluster jobs
        |-- job-resumeArgweaver_masked.slurm            # Resume ARGweaver run on sequneces masked with missing sites 
        |-- job-resumeArgweaver.slurm                   # Resume ARGweaver run
        |-- job-runArgweaver_masked.slurm               # Initiate ARGweaver run on sequneces masked with missing sites
        `-- job-runArgweaver.slurm                      # Initiate ARGweaver run

## Phylogenetic Analysis

This section contains scripts to generate neighbour-joining (NJ) tree and Neighbor-Net (nNet) network of phylogenetic relationship among all _Littorina_ samples. This relates to the NJ tree in Fig 1. Path to main analysis - `phylogenetics/buildTrees.ipynb`

    phylogenetics/
    |-- buildTrees.ipynb                                # Pipeline for phylogenetic analysis (NB: R kernel in Jupyter notebook)
    |-- nNet_littorina.nex                              # Neighbor-Net network in NEXUS format 
    |-- samples.txt                                     # Sample information
    |-- treeNJ_littorina.tree                           # Neighbot-joining tree

## Estimation of past effective population size (N<sub>e</sub>)

    stairway-plot/scripts
    |-- calculating_SFS.ipynb                           # Script to calculate site-frequency-spectrum
    |-- job-subvcf.slurm                                # SLRUM script for VCF utilities
    |-- job-trimvcf.slurm                               # SLURM script for VCF utilities
    |-- pipeline_Littorina                              # pipeline for preprocessing files for Littorina samples
    `-- vcf2sfs_Littorina.R                             # R function to compute site-frequency-spectrum from vcf file 
