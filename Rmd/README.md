# Before you start:

## Build the references for transfer of annotations

### Tabula Sapiens Skin reference:

Run in Rmd/INIT_TS_Skin_reference.Rmd

Website: https://cellxgene.cziscience.com/collections/e5f58829-1a66-40b5-a624-9046778e74f5

Publication: https://www.ncbi.nlm.nih.gov/pmc/articles/PMC9812260/

### human PBMC Azimuth reference:

Run in bash/get_ref_human_pbmc.sh

Website: https://azimuth.hubmapconsortium.org/references/#Human%20-%20PBMC

Publication: https://www.biorxiv.org/content/10.1101/2020.10.12.335331v1

# INIT.Rmd

The INIT file allow you to pre-process and annotated the raw single cell data, that you can download here:
The pre-processing includes:

- Ambiant RNA correction using SoupX: per samples, raw counts are corrected using SoupX with a manual list of specific genes.

- Seurat workflow: corrected counts are merge in a single Seurat object, filtered and normalized (SCTransform). 

- Clustering: After normalization, Ig genes are removed from the variable genes to avoid multiple B and plasma cells clusters driven by random varable chains.

- Reference mapping: single cell data are mapped to the Tabula Sapiens Skin reference and Azimuth PBMC reference using azimuth reference mapping.

This result to the construction of the fully annotated Seurat object which is the input of every other Rmd file.

# Figure 3

