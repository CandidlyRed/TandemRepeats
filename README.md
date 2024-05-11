# Pathogenic Tandem Repeats Model Codebase

## Overview

This repository contains code for a model designed to identify pathogenic tandem repeats in genomic sequences. Tandem repeats are repetitive DNA sequences that are prone to expansion, leading to various genetic disorders.

Our work builds on previous work from the following papers:

  Trost, B., Engchuan, W., Nguyen, C.M. et al. Genome-wide detection of tandem DNA repeats that are expanded in autism. Nature 586, 80–86 (2020). https://doi.org/10.1038/s41586-020-2579-z 

  Fazal, S., Danzi, M.C., Xu, I. et al. RExPRT: a machine learning tool to predict pathogenicity of tandem repeat loci. Genome Biol 25, 39 (2024). https://doi.org/10.1186/s13059-024-03171-4

  Mitra, I., Huang, B., Mousavi, N. et al. Patterns of de novo tandem repeat mutations and their role in autism. Nature 589, 246–250 (2021). https://doi.org/10.1038/s41586-020-03078-7

## Usage

  Most code and processing was done on Google Colab, to use those files, import all the directories into google drive and run accordingly

  Some analysis was performed with R. To use, install R Studio and input our files and install all required dependencies. 
    
    Files are as follows:
    qc_and_liftover folder: code for cleaning downloaded TR data into a format that can be used by the RExPRT pipeline (/qc_and_liftover/clean_data.R).
    After doing liftover using the UCSC genome browser (https://genome.ucsc.edu/cgi-bin/hgLiftOver), there is additional code to 
    (1) clean output from the UCSC genome browser (/qc_and_liftover/clean_liftover_errors.py) 
    and (2) map hg38 coordinates to the new hg19 coordinates (/qc_and_liftover/merge_liftover.R).
    01_clean_data.R : R file that cleans null values and other inconsistencies in data
    RExPRT_scores_analysis.R : R file that utilizes Fazal's work to generate RExPRT scores for each row in data
    
    model.ipynb : Model training across 4 different algorithm models
    model_training_V2.ipynb : Parameter testing across different models
    training_NN.ipynb : Optimized parameter training for neural net
    validation_NN.ipynb : running trained model against Mitra's dataset
    LOOC_NN.ipynb : neural net training for leave-on-out-chromosome novel tandem repeat discovery
    
## Contributors

  Tim Gruenloh - gruenloh@wisc.edu
  Stephen Dorn - svdorn@wisc.edu
  Leo Cui - lzcui@wisc.edu
