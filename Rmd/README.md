# Before you start:

We provide here all the code to re-run the analysis and plots presented in Ressler et al. 2024. 
Before starting, you can chose to either request the raw data on [EGA](https://ega-archive.org/datasets/EGAD50000000371) and pre-process them following the instruction bellow, or download the pre-processed `R object` on [GEO]() and run the notebooks for each of the figure. 

## Start from raw data
The raw data can be downloaded here [EGA](https://ega-archive.org/datasets/EGAD50000000371) upon request.

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

The INIT file allow you to pre-process and annotated the raw single cell data, that you can download here:
The pre-processing includes:

- Ambiant RNA correction using SoupX: per samples, raw counts are corrected using SoupX with a manual list of specific genes.

- Seurat workflow: corrected counts are merge in a single Seurat object, filtered and normalized (SCTransform). 

- Clustering: After normalization, Ig genes are removed from the variable genes to avoid multiple B and plasma cells clusters driven by random varable chains.

- Reference mapping: single cell data are mapped to the Tabula Sapiens Skin reference and Azimuth PBMC reference using azimuth reference mapping.

This result to the construction of the fully annotated Seurat object which is the input of every other Rmd file.

## Start from the pre-processed `R objects`

You can download the pre-processed `Seurat`object (for single cell RNA-Seq data) and BCR- TCR- Seq combined tables on [GEO]()

# Figure 3

Figure 3 contains an overview of the immune microenvironment at the single cell level of TVEC treated BCC samples. 

`ressler2024_Figure3` contains the `Rmd` notebook that is used to generate Figure 3a and 3b plots, and the reports containing plots and codes in `.md` and `.html` format.

You can regenerate the reports using the following lines: 
```{r}
dir.create("ressler2024_Figure3")

rmarkdown::render(input = "Figure3.Rmd", 
                    output_format = "html_document",
                    output_file = "Figure3.html",
                    output_dir = "ressler2024_Figure3")
```

# Figure 5

Figure 5 allow the analysis of B and plasma cells. 

`ressler2024_Figure5` contains the `Rmd` notebook that is used to generate Figures 5 and the reports containing plots and codes in `.md` and `.html` format.

You can regenerate the reports using the following lines: 
```{r}
dir.create("ressler2024_Figure5")

rmarkdown::render(input = "Figure5.Rmd", 
                    output_format = "html_document",
                    output_file = "Figure5.html",
                    output_dir = "ressler2024_Figure5")
```


