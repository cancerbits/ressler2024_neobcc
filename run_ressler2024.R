######################## PATH TO DATA ############################################
# change the path to data you downloaded from GEO, or the pre-processed `Seurat` object

local_path_to_single_cell_data <- file.path("20241005_Ressler2024_NeoBCC.Rds")

# change the path to the TCR and BCR-Seq data
# Please note that due to confidentiality and possible patient identification with genomic data, BCR- and TCR-Seq data are only available upon request (EGA)
# As default, plots requiring BCR- or TCR-Seq data won't be run. 
# Code is however available. 
# You can change the non-run default changing the `accessibility` parameter to `unlock`.

local_path_to_BCR_data <- file.path("Ressler2024/metadata/100_CombinedBCR.Rds")
local_path_to_TCR_data <- file.path("Ressler2024/metadata/100_CombinedTCR.Rds")


######################## BCR- TCR- Seq accessibility ##############################
accessibility <- "unlock"
###################################################################################

######################## RUN the analysis #########################################

# create a directory to save all notebooks figure by figure

dir.create("ressler2024_notebook")
notebook_dir <- "ressler2024_notebook"


rmarkdown::render(input = file.path("notebook_template","Figure3.Rmd"), 
                  params = list(path_to_data = local_path_to_single_cell_data),
                    output_format = "html_document",
                    output_file = "Figure3.html",
                    output_dir = notebook_dir)

rmarkdown::render(input = file.path("notebook_template","Figure5.Rmd"), 
                  params = list(path_to_data = local_path_to_single_cell_data, 
                                accessibility = accessibility, 
                                path_to_BCR = local_path_to_BCR_data),
                  output_format = "html_document",
                  output_file = "Figure5.html",
                  output_dir = notebook_dir)


rmarkdown::render(input = file.path("notebook_template","ExtendedData_Figure9.Rmd"), 
                  params = list(path_to_data = local_path_to_single_cell_data),
                  output_format = "html_document",
                  output_file = "ExtendedData_Figure9.html",
                  output_dir = notebook_dir)

rmarkdown::render(input = file.path("notebook_template","ExtendedData_Figure10.Rmd"), 
                  params = list(path_to_data = local_path_to_single_cell_data, 
                                accessibility = accessibility, 
                                path_to_BCR = local_path_to_BCR_data),
                  output_format = "html_document",
                  output_file = "ExtendedData_Figure10.html",
                  output_dir = notebook_dir)
