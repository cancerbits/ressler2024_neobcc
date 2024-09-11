############################### PATH TO DATA ############################################
# change the path to data you downloaded from GEO, or the pre-processed `Seurat` object
# we recommend having it in the `data` subfolder
##########################################################################################
local_path_to_single_cell_data <- file.path("..","data","20241005_Ressler2024_NeoBCC.Rds")
##########################################################################################

############################### BCR- TCR- Seq accessibility ##############################
# change the path to the TCR and BCR-Seq data
# Please note that due to confidentiality and possible patient identification with genomic data, BCR- and TCR-Seq data are only available upon request (EGA)
# As default, plots requiring BCR- or TCR-Seq data won't be run. 
# Code is however available. 
# You can change the non-run default changing the `accessibility` parameter to `unlock`.
##########################################################################################
accessibility <- "unlock"
##########################################################################################
local_path_to_BCR_data <- file.path("..","data","100_CombinedBCR.Rds")
local_path_to_TCR_data <- file.path("..","data","100_CombinedTCR.Rds")
############################### PATH TO DATA ############################################
# if you cloned the github repository, you don't need to change anything here
# path to the McPAS table
path_to_McPAS <- file.path("..","metadata","McPAS-TCR.csv")
# path to CBioplanet gene sets for enrichment analysis
path_to_CBioplanet <- file.path("..","metadata","CBioPlanet.csv")
##########################################################################################

##########################################################################################
############################### RUN the analysis #########################################
##########################################################################################

# create a directory to save all notebooks figure by figure

dir.create("notebook")
notebook_dir <- "notebook"


rmarkdown::render(input = file.path("notebook_template","Figure3.Rmd"), 
                  params = list(path_to_data = local_path_to_single_cell_data),
                  output_format = "html_document",
                  output_file = "Figure3.html",
                  output_dir = notebook_dir)

rmarkdown::render(input = file.path("notebook_template","Figure4.Rmd"), 
                  params = list(path_to_data = local_path_to_single_cell_data, 
                                accessibility = accessibility, 
                                path_to_TCR = local_path_to_TCR_data,
                                McPAS = path_to_McPAS),
                  output_format = "html_document",
                  output_file = "Figure4.html",
                  output_dir = notebook_dir)

rmarkdown::render(input = file.path("notebook_template","Figure5.Rmd"), 
                  params = list(path_to_data = local_path_to_single_cell_data, 
                                accessibility = accessibility, 
                                path_to_BCR = local_path_to_BCR_data),
                  output_format = "html_document",
                  output_file = "Figure5.html",
                  output_dir = notebook_dir)


rmarkdown::render(input = file.path("notebook_template","ExtendedData_Figure6.Rmd"), 
                  params = list(path_to_data = local_path_to_single_cell_data),
                  output_format = "html_document",
                  output_file = "ExtendedData_Figure6.html",
                  output_dir = notebook_dir)


rmarkdown::render(input = file.path("notebook_template","ExtendedData_Figure7.Rmd"), 
                  params = list(path_to_data = local_path_to_single_cell_data, 
                                accessibility = accessibility, 
                                path_to_TCR = local_path_to_TCR_data,
                                McPAS = path_to_McPAS),
                  output_format = "html_document",
                  output_file = "ExtendedData_Figure7.html",
                  output_dir = notebook_dir)

rmarkdown::render(input = file.path("notebook_template","ExtendedData_Figure8.Rmd"), 
                  params = list(path_to_data = local_path_to_single_cell_data,
                                path_to_CBioplanet = path_to_CBioplanet),
                  output_format = "html_document",
                  output_file = "ExtendedData_Figure8.html",
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
