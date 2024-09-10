# Code repository for the analysis of single-cell RNA-seq, TCR- and BCR-Seq data presented in Ressler JM et al., 2024
Maud Plaschka and Florian Halbritter
St. Anna Children's Cancer Research Institute (CCRI), Vienna, Austria

# Repository structure

•	project.Dockerfile defines the environment used to carry out all experiments

•	config.yaml is used to set paths

•	R/ holds R function definitions and misc utility scripts

•	Rmd/ holds R markdown documents for the individual steps of the project

•	bash/ holds shell scripts to build and run the docker image, and to parse the config file

•	metadata/ holds custom geneset definitions


# Reproducing the results
Paths in the config.yaml file starting with "/path/to/" will have to be set.

# Links

## Paper: 
## Data files: 

Raw data files are available at The European Genome-phenome Archive [EGA](https://ega-archive.org/datasets/EGAD50000000371)

Counts are available in the [GEO platform]()
