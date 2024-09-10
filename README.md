# Code repository for the analysis of single-cell RNA-seq, TCR- and BCR-Seq data presented in Ressler JM et al., 2024
Maud Plaschka and Florian Halbritter
St. Anna Children's Cancer Research Institute (CCRI), Vienna, Austria

# Repository structure

•	project.Dockerfile defines the environment used to carry out all experiments

•	config.yaml is used to set paths

•	notebook_template/ holds R markdown documents for the individual steps of the project, corresponding to each of the figure of the [manuscript]()

•	notebook/ holds `html` and `md` reports for the individual steps of the project, corresponding to each of the figure of the [manuscript](), generated with the corresponding `notebook_template`

•	bash/ holds shell scripts to build and run the docker image, and to parse the config file

•	metadata/ holds custom geneset definitions


# Reproducing the results

Paths in the config.yaml file starting with "/path/to/" will have to be set, as well as paths in `run_ressler2024.R`.

The figures of the [manuscript]() can be reproduced runing the [`run_ressler2024.R` script](https://github.com/cancerbits/ressler2024_neobcc/blob/main/run_ressler2024.R). 

To achieve high reproducibility, we recommand to start with the pre-processed `Seurat` object available on [GEO]().  

If you like to start from the raw data, you can request access here [EGA](https://ega-archive.org/datasets/EGAD50000000371). 
Please note that before being able to run `run_ressler2024.R`, you will have to go through few pre-processing steps: 

### Build the references for transfer of annotations

#### Tabula Sapiens Skin reference:

Run in Rmd/INIT_TS_Skin_reference.Rmd

Website: https://cellxgene.cziscience.com/collections/e5f58829-1a66-40b5-a624-9046778e74f5

Publication: https://www.ncbi.nlm.nih.gov/pmc/articles/PMC9812260/

#### human PBMC Azimuth reference:

Run in bash/get_ref_human_pbmc.sh

Website: https://azimuth.hubmapconsortium.org/references/#Human%20-%20PBMC

Publication: https://www.biorxiv.org/content/10.1101/2020.10.12.335331v1

### INIT.Rmd

The INIT file allow you to pre-process and annotated the raw single cell data.
The pre-processing includes:

- Ambiant RNA correction using `SoupX` per samples, raw counts are corrected using SoupX with a manual list of specific genes.

- `Seurat` workflow: corrected counts are merge in a single Seurat object, filtered and normalized (`SCTransform`). 

- Clustering: After normalization, Ig genes are removed from the variable genes to avoid multiple B and plasma cells clusters driven by random varable chains.

- Reference mapping: single cell data are mapped to the Tabula Sapiens Skin reference and Azimuth PBMC reference using `azimuth` reference mapping.

This result to the construction of the fully annotated Seurat object which is the input of every other Rmd file.


Please note that due to confidentiality and possible patient identification with genomic data, BCR- and TCR-Seq data are only available upon request on [EGA](https://ega-archive.org/datasets/EGAD50000000371).

As default, plots requiring BCR- or TCR-Seq data won't be run. 
Code is however available in the reports. 
You can change the non-run default changing the `accessibility` parameter to `unlock` on top of `run_ressler2024.R` script.



# Links

## Paper: 

## Data files: 

Raw data files are available at The European Genome-phenome Archive [EGA](https://ega-archive.org/datasets/EGAD50000000371)

Counts are available in the [GEO platform]()


