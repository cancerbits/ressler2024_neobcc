---
title: "Figure 5"
author: 'rstudio'
date: 'September 10, 2024 13:19:17 CEST'
output:
  html_document: 
    toc: yes
    toc_float: yes
    code_folding: hide
    highlight: pygments
    df_print: kable
    keep_md: true
params:
  sample_name: ~
  sample_path: ~
  out_rds_path: ~
---




# Introduction


## Load libraries


```r
library(Seurat)
library(canceRbits)
library(dplyr)
library(patchwork)
library(DT)
library(SCpubr)
library(tibble)
library(dittoSeq)
library(scRepertoire)
library(reshape2)
library(viridis)
library(tidyr)

library(grDevices)
library(ggpubr)
library(ggplot2)
library(ggnewscale)

library(RColorBrewer)
library(scales)

library(enrichplot)
library(clusterProfiler)
library("org.Hs.eg.db")
library(DOSE)
library(msigdbr)
library(stringr)
```

## path to data


```r
# path to data, to be adapted - serve here to get raw data
path_to_data = file.path("mnt_data","BCC_2023-06/biomedical-sequencing.at/projects/BSA_0460_MF_BCC_1ab413522d3e4d2d959b1b8f2681cf06/COUNT/")


# Load seurat object containing single cell pre-processed and annotated data, in the metadata folder

srat <- readRDS( "20241005_Ressler2024_NeoBCC.Rds")
meta <- srat@meta.data
meta$WHO <- "SD"
meta$WHO[meta$patient %in% c("NeoBCC007_post", "NeoBCC008_post", "NeoBCC012_post", "NeoBCC017_post")] <- "CR"
meta$WHO[meta$patient %in% c("NeoBCC004_post", "NeoBCC006_post", "NeoBCC010_post", "NeoBCC011_post")] <- "PR"
srat <- AddMetaData(srat, meta$WHO, col.name = "WHO")
srat$WHO <- factor(srat$WHO, levels = c("CR", "PR", "SD"))
```

## colors


```r
colors_B <- c(
  "34" = "#ae017e",
  "7"  =  "#377eb8",
  "21" =  "#f781bf",  
  "38" = "#fed976",
  "15" = "#a6cee3" ,
  "22" = "#e31a1c"   ,
   "3" = "#9e9ac8",
 "4"   = "#fdb462" ,
 "24"  = "#b3de69"
)


colors_clonotype = c("Small (1e-04 < X <= 0.001)"   = "#8c6bb1",
           "Medium (0.001 < X <= 0.01)"   = "#41b6c4",
           "Large (0.01 < X <= 0.1)"      = "#fec44f",
           "Hyperexpanded (0.1 < X <= 1)" = "#ce1256"
)

colors_Ig = c("IGHA1" = "#addd8e",
           "IGHA2" = "#238443",
           "IGHM"  = "#dd3497" , 
           "IGHD"  =  "#41b6c4",
           "IGHG1" = "#fec44f",
           "IGHG2" = "#fe9929",
           "IGHG3" = "#ec7014",
           "IGHG4" = "#fee391"
)
```



# Figure 5a


```r
s   <- subset(srat, subset = anno_l1 %in% c("B cells","Plasma cells"))

s@meta.data$seurat_clusters <- factor(s@meta.data$seurat_clusters, levels=c("34","7", "21",  "38",
                                                                             "15", "22","3", "4", "24"))
    
p <- SCpubr::do_DimPlot(sample = s, 
                   reduction = "umap", 
                   label = TRUE, 
                   repel = TRUE, 
                   label.color = "black", 
                   legend.position = "none", 
                   group.by = "seurat_clusters", 
                   font.size = 25,
                   pt.size = 0.5, 
                   colors.use = colors_B) + theme_minimal()  + NoLegend() + theme(text = element_text(size=20))

p
```

<img src="/home/rstudio/ressler2024_Figure5/Figure5_files/figure-html/Figure5a-1.png" width="100%" />

```r
DT::datatable(p$data, 
              caption = ("Figure 5a"),
              extensions = 'Buttons', 
              options = list( dom = 'Bfrtip',
              buttons = c( 'csv', 'excel')))
```

```{=html}
<div class="datatables html-widget html-fill-item" id="htmlwidget-35df8e2dbbfbd64b7527" style="width:100%;height:auto;"></div>
```



# Figure 5b


```r
Idents(s) <- s$seurat_clusters

genes <- list( "B" = c("MS4A1", "CD19"),
               "Ag presentation" = c("HLA-DRA", "HLA-DRB1", "HLA-DPB1", "CD40"),
               "Cytotox" = c("GZMK", "PRF1"),
               "Mem" = "CD27",
               "Plasma" = c("IGKC", "IGHG1", "CD38", "SDC1", "JCHAIN"),
               "Cell state" = c("G2M.Score", "S.Score","percent.mito")  
               )

p <- SCpubr::do_DotPlot(sample = s, 
                        features = genes, 
                        font.size = 18, 
                        legend.length = 12,  
                        legend.type = "colorbar", 
                        dot.scale = 8,  
                        colors.use  = c("#7fbc41","#b8e186", "#f7f7f7","#fde0ef", "#c51b7d"), 
                        use_viridis = FALSE
) 

p
```

<img src="/home/rstudio/ressler2024_Figure5/Figure5_files/figure-html/Figure5b-1.png" width="100%" />

```r
DT::datatable(p$data, 
              caption = ("Figure 5b"),
              extensions = 'Buttons', 
              options = list( dom = 'Bfrtip',
              buttons = c( 'csv', 'excel')))
```

```{=html}
<div class="datatables html-widget html-fill-item" id="htmlwidget-fbfa5a227f54c881a315" style="width:100%;height:auto;"></div>
<script type="application/json" data-for="htmlwidget-fbfa5a227f54c881a315">{"x":{"filter":"none","vertical":false,"extensions":["Buttons"],"caption":"<caption>Figure 5b<\/caption>","data":[["MS4A1","CD19","HLA-DRA","HLA-DRB1","HLA-DPB1","CD40","GZMK","PRF1","CD27","IGKC","IGHG1","CD38","SDC1","JCHAIN","percent.mito","MS4A11","CD191","HLA-DRA1","HLA-DRB11","HLA-DPB11","CD401","GZMK1","PRF11","CD271","IGKC1","IGHG11","CD381","SDC11","JCHAIN1","percent.mito1","MS4A12","CD192","HLA-DRA2","HLA-DRB12","HLA-DPB12","CD402","GZMK2","PRF12","CD272","IGKC2","IGHG12","CD382","SDC12","JCHAIN2","percent.mito2","MS4A13","CD193","HLA-DRA3","HLA-DRB13","HLA-DPB13","CD403","GZMK3","PRF13","CD273","IGKC3","IGHG13","CD383","SDC13","JCHAIN3","percent.mito3","MS4A14","CD194","HLA-DRA4","HLA-DRB14","HLA-DPB14","CD404","GZMK4","PRF14","CD274","IGKC4","IGHG14","CD384","SDC14","JCHAIN4","percent.mito4","MS4A15","CD195","HLA-DRA5","HLA-DRB15","HLA-DPB15","CD405","GZMK5","PRF15","CD275","IGKC5","IGHG15","CD385","SDC15","JCHAIN5","percent.mito5","MS4A16","CD196","HLA-DRA6","HLA-DRB16","HLA-DPB16","CD406","GZMK6","PRF16","CD276","IGKC6","IGHG16","CD386","SDC16","JCHAIN6","percent.mito6","MS4A17","CD197","HLA-DRA7","HLA-DRB17","HLA-DPB17","CD407","GZMK7","PRF17","CD277","IGKC7","IGHG17","CD387","SDC17","JCHAIN7","percent.mito7","MS4A18","CD198","HLA-DRA8","HLA-DRB18","HLA-DPB18","CD408","GZMK8","PRF18","CD278","IGKC8","IGHG18","CD388","SDC18","JCHAIN8","percent.mito8"],[4.616707616707616,0.1965601965601965,2.663390663390663,2.375921375921376,1.422604422604423,0.1302211302211302,0.01965601965601966,0.002457002457002457,0.04914004914004914,0.04422604422604422,0.2481572481572482,0.07862407862407861,0.007371007371007371,0.01965601965601966,32107.07109236125,3.938091897579796,0.4693090143809189,12.17257102770958,6.787443002455279,4.231848474219572,0.3244475622588565,0.01473167309715889,0.003156787092248334,0.3035776920378814,0.04507190459487898,0.1141704665029814,0.008593475973342686,0.000526131182041389,0.07979656260961066,5356.558455823594,3.045627376425855,0.3307984790874525,9.483650190114069,4.957414448669201,3.292015209125475,0.2053231939163498,0.01901140684410646,0.006844106463878326,0.2813688212927756,0.1832699619771863,0.3847908745247147,0.00988593155893536,0.0007604562737642585,0.06996197718631178,8772.220636050326,2.668103448275862,0.3706896551724138,8.564655172413794,5.176724137931035,3.241379310344827,0.25,1.353448275862069,0.2801724137931034,0.5818965517241379,0,0,0,0,0,44.71961953320659,0.01627780792186652,0.02116115029842648,0.01247965274009767,0.01844818231144872,0.004883342376559956,0.02767227346717309,0.005968529571351058,0.006511123168746608,0.1779706999457406,15.32501356483994,31.58328811720022,0.9620184481823114,0.3385784047748236,0.4487249050461204,28487.06083995633,0.04849884526558891,0.05157813702848345,0.09083910700538876,0.08852963818321785,0.04772902232486528,0.04849884526558891,0.0161662817551963,0.008468052347959968,0.6889915319476519,52.95073133179369,51.13548883756736,0.5765973826020016,0.4311008468052347,2.923017705927637,17825.96938732161,0.005687771291722796,0.06600808262236192,0.002694207453973956,0.004939380332285585,0.0005987127675497679,0.04475377937434516,0.002095494686424188,0.002544529262086514,0.7085765603951504,57.55096542433768,52.24158060170633,0.4056279000149678,0.4532255650351744,0.8820535847926957,898.2585530240414,0.003654080389768575,0.07049330085261876,0.002436053593179049,0.01355054811205846,0.0004567600487210718,0.05496345919610231,0.0004567600487210718,0.003501827040194884,1.127131546894031,50.8871802679659,53.27222898903776,0.6396163215590742,0.6447929354445797,5.331303288672351,616.5066922543689,0.005361930294906165,0.09115281501340483,0,0.007149240393208221,0,0.06613047363717604,0,0.0008936550491510277,1.655942806076854,60.24843610366398,45.7882037533512,0.7631814119749776,0.8176943699731903,44.20554066130474,2.562737093143558],[80.83538083538083,14.98771498771499,57.73955773955773,55.77395577395578,52.82555282555283,11.05651105651106,1.474201474201474,0.2457002457002457,3.931203931203931,1.474201474201474,1.228501228501228,3.685503685503686,0.7371007371007371,1.474201474201474,97.54299754299754,90.24903542616626,33.98807435987373,98.33391792353559,94.68607506138197,90.44195019291476,25.27183444405472,0.7190459487898984,0.2630655910206945,23.11469659768502,0.2806032970887408,0.2279901788846019,0.6664328305857594,0.0526131182041389,5.278849526481936,99.91231146965977,82.9657794676806,25.24714828897338,96.1977186311787,88.66920152091254,83.34600760456273,17.11026615969581,0.988593155893536,0.6083650190114068,20.68441064638783,0.8365019011406843,0.8365019011406843,0.7604562737642585,0.07604562737642585,4.714828897338403,99.77186311787072,89.65517241379311,33.18965517241379,98.70689655172413,97.84482758620689,90.51724137931035,21.55172413793103,54.74137931034483,25.43103448275862,48.27586206896552,0,0,0,0,0,100,0.705371676614216,2.061855670103093,0.5425935973955507,1.085187194791101,0.3255561584373304,2.441671188279978,0.2170374389582203,0.5425935973955507,13.8903960933261,41.39989148128052,72.38198589256648,49.48453608247423,23.65708084644601,16.0607704829083,97.72110689093869,2.694380292532717,4.772902232486528,2.54041570438799,3.926096997690531,2.232486528098537,4.541955350269438,0.9237875288683602,0.6928406466512702,42.72517321016166,81.90916089299462,85.45034642032333,40.80061585835258,31.63972286374134,46.49730561970747,99.15319476520401,0.3592276605298608,6.466097889537495,0.0598712767549768,0.3442598413411166,0.0449034575662326,4.325699745547073,0.1347103726986978,0.224517287831163,45.86139799431223,69.94461906900165,83.25101032779524,34.0667564735818,34.39604849573417,37.44948361023799,98.47328244274809,0.243605359317905,6.881851400730817,0.0761266747868453,0.5633373934226552,0.03045066991473812,5.374543239951278,0.03045066991473812,0.2588306942752741,60.99269183922046,62.66747868453106,86.35809987819732,47.6857490864799,45.02131546894032,74.19305724725945,98.41656516443362,0.4468275245755138,8.936550491510276,0,0.3574620196604111,0,6.434316353887399,0,0.08936550491510277,75.87131367292224,58.266309204647,70.24128686327077,52.10008936550492,49.50848972296694,98.74888293118856,98.83824843610365],["MS4A1","CD19","HLA-DRA","HLA-DRB1","HLA-DPB1","CD40","GZMK","PRF1","CD27","IGKC","IGHG1","CD38","SDC1","JCHAIN","percent.mito","MS4A1","CD19","HLA-DRA","HLA-DRB1","HLA-DPB1","CD40","GZMK","PRF1","CD27","IGKC","IGHG1","CD38","SDC1","JCHAIN","percent.mito","MS4A1","CD19","HLA-DRA","HLA-DRB1","HLA-DPB1","CD40","GZMK","PRF1","CD27","IGKC","IGHG1","CD38","SDC1","JCHAIN","percent.mito","MS4A1","CD19","HLA-DRA","HLA-DRB1","HLA-DPB1","CD40","GZMK","PRF1","CD27","IGKC","IGHG1","CD38","SDC1","JCHAIN","percent.mito","MS4A1","CD19","HLA-DRA","HLA-DRB1","HLA-DPB1","CD40","GZMK","PRF1","CD27","IGKC","IGHG1","CD38","SDC1","JCHAIN","percent.mito","MS4A1","CD19","HLA-DRA","HLA-DRB1","HLA-DPB1","CD40","GZMK","PRF1","CD27","IGKC","IGHG1","CD38","SDC1","JCHAIN","percent.mito","MS4A1","CD19","HLA-DRA","HLA-DRB1","HLA-DPB1","CD40","GZMK","PRF1","CD27","IGKC","IGHG1","CD38","SDC1","JCHAIN","percent.mito","MS4A1","CD19","HLA-DRA","HLA-DRB1","HLA-DPB1","CD40","GZMK","PRF1","CD27","IGKC","IGHG1","CD38","SDC1","JCHAIN","percent.mito","MS4A1","CD19","HLA-DRA","HLA-DRB1","HLA-DPB1","CD40","GZMK","PRF1","CD27","IGKC","IGHG1","CD38","SDC1","JCHAIN","percent.mito"],["34","34","34","34","34","34","34","34","34","34","34","34","34","34","34","7","7","7","7","7","7","7","7","7","7","7","7","7","7","7","21","21","21","21","21","21","21","21","21","21","21","21","21","21","21","38","38","38","38","38","38","38","38","38","38","38","38","38","38","38","15","15","15","15","15","15","15","15","15","15","15","15","15","15","15","22","22","22","22","22","22","22","22","22","22","22","22","22","22","22","3","3","3","3","3","3","3","3","3","3","3","3","3","3","3","4","4","4","4","4","4","4","4","4","4","4","4","4","4","4","24","24","24","24","24","24","24","24","24","24","24","24","24","24","24"],[1.725745658912161,0.1794509376399948,1.298389129322143,1.2166682873397,0.8848431691600405,0.1224133040405457,0.01946533478810331,0.002453988961566712,0.04797082778602956,0.04327598348182184,0.2216682621358869,0.07568622763257635,0.0073439742557585,0.01946533478810331,10.3768627134125,1.596979001033293,0.3847922320343629,2.57813671520744,2.05251256497992,1.65476465238604,0.2809954383527193,0.0146242160634631,0.003151814901226281,0.2651125552526762,0.04408569127436159,0.1081101517939159,0.008556762241136884,0.0005259928235587118,0.07677265543859282,8.586263638314543,1.397636637723825,0.2857791223056948,2.349816918833732,1.784636569613912,1.45675636836084,0.1867477416995161,0.01883294833309213,0.006820791885088593,0.2479288981745972,0.168281760126472,0.325549135115743,0.009837385424514235,0.000760167273397585,0.06762311250252412,9.079459251253647,1.299674756907064,0.3153140111138669,2.258074551266284,1.820788056161862,1.444888525385943,0.2231435513142098,0.855881604078595,0.2469947671363897,0.4586244763882603,0,0,0,0,0,3.822527517221088,0.01614674477426523,0.02094036247550166,0.01240242373746585,0.01828007891668554,0.00487145753630141,0.02729631607620027,0.005950788455977181,0.006490017371712231,0.1637932122084685,2.792698506086495,3.483799522488992,0.6739737638422438,0.2916081588595334,0.3706837937244719,10.25724036058986,0.04735947003885813,0.05029202346013583,0.0869472230200809,0.08482782978591852,0.04662498598086653,0.04735947003885813,0.016036998909817,0.008432399524597688,0.5241316241645759,3.988071247345235,3.953845884577523,0.4552689694887989,0.3584439710508445,1.3668611805814,9.78846772374175,0.00567165699467265,0.06392090791224572,0.002690584582790252,0.004927221614502917,0.0005985336105662367,0.04378123983094084,0.002093302199795566,0.002541297428672581,0.5356606030384186,4.069897578794851,3.974839681322631,0.3404841068791362,0.3737856134446675,0.632363513017529,6.801570593816619,0.003647420457043477,0.06811957106689719,0.00243309122464159,0.01345956046843946,0.0004566557656037174,0.05350613049511713,0.0004566557656037174,0.003495709920455749,0.7547743805182227,3.949071751335906,3.994012659445578,0.4944622641966168,0.4976145011847207,1.845506105749007,6.425689906102302,0.005347606326595273,0.08723476579877945,0,0.007123805727851068,0,0.06403571378599088,0,0.0008932559772149941,0.9767996975257245,4.11493831609746,3.845631114599684,0.5671197977106901,0.5975688682965801,3.811219660328065,1.270529095841602],["B","B","Ag presentation","Ag presentation","Ag presentation","Ag presentation","Cytotox","Cytotox","Mem","Plasma","Plasma","Plasma","Plasma","Plasma","Cell state","B","B","Ag presentation","Ag presentation","Ag presentation","Ag presentation","Cytotox","Cytotox","Mem","Plasma","Plasma","Plasma","Plasma","Plasma","Cell state","B","B","Ag presentation","Ag presentation","Ag presentation","Ag presentation","Cytotox","Cytotox","Mem","Plasma","Plasma","Plasma","Plasma","Plasma","Cell state","B","B","Ag presentation","Ag presentation","Ag presentation","Ag presentation","Cytotox","Cytotox","Mem","Plasma","Plasma","Plasma","Plasma","Plasma","Cell state","B","B","Ag presentation","Ag presentation","Ag presentation","Ag presentation","Cytotox","Cytotox","Mem","Plasma","Plasma","Plasma","Plasma","Plasma","Cell state","B","B","Ag presentation","Ag presentation","Ag presentation","Ag presentation","Cytotox","Cytotox","Mem","Plasma","Plasma","Plasma","Plasma","Plasma","Cell state","B","B","Ag presentation","Ag presentation","Ag presentation","Ag presentation","Cytotox","Cytotox","Mem","Plasma","Plasma","Plasma","Plasma","Plasma","Cell state","B","B","Ag presentation","Ag presentation","Ag presentation","Ag presentation","Cytotox","Cytotox","Mem","Plasma","Plasma","Plasma","Plasma","Plasma","Cell state","B","B","Ag presentation","Ag presentation","Ag presentation","Ag presentation","Cytotox","Cytotox","Mem","Plasma","Plasma","Plasma","Plasma","Plasma","Cell state"]],"container":"<table class=\"display\">\n  <thead>\n    <tr>\n      <th> <\/th>\n      <th>avg.exp<\/th>\n      <th>pct.exp<\/th>\n      <th>features.plot<\/th>\n      <th>id<\/th>\n      <th>avg.exp.scaled<\/th>\n      <th>feature.groups<\/th>\n    <\/tr>\n  <\/thead>\n<\/table>","options":{"dom":"Bfrtip","buttons":["csv","excel"],"columnDefs":[{"className":"dt-right","targets":[1,2,5]},{"orderable":false,"targets":0},{"name":" ","targets":0},{"name":"avg.exp","targets":1},{"name":"pct.exp","targets":2},{"name":"features.plot","targets":3},{"name":"id","targets":4},{"name":"avg.exp.scaled","targets":5},{"name":"feature.groups","targets":6}],"order":[],"autoWidth":false,"orderClasses":false},"selection":{"mode":"multiple","selected":null,"target":"row","selectable":null}},"evals":[],"jsHooks":[]}</script>
```



# Figure 5c



```r
q1 <- SCpubr::do_BarPlot( s,
                         group.by = "seurat_clusters",
                         split.by = "WHO",
                         position = "fill",
                         flip = TRUE,
                         order=FALSE,
                         legend.position = "none",
                         font.size = 32 ,
                         colors.use = colors_B,
                         xlab = "",
                         ylab = ""
                          
                   ) + xlab("Response") + ylab("% of B and plasma cells")



q1
```

<img src="/home/rstudio/ressler2024_Figure5/Figure5_files/figure-html/Figure5c-1.png" width="100%" />

```r
DT::datatable(q1$data, 
              caption = ("Figure 5c"),
              extensions = 'Buttons', 
              options = list( dom = 'Bfrtip',
              buttons = c( 'csv', 'excel')))
```

```{=html}
<div class="datatables html-widget html-fill-item" id="htmlwidget-3fb7bda8acb4e5641368" style="width:100%;height:auto;"></div>
```



```r
q1 <- SCpubr::do_BarPlot( s,
                         group.by = "seurat_clusters",
                         split.by = "Pathological.Response",
                         position = "fill",
                         flip = TRUE,
                         order=FALSE,
                         legend.position = "none",
                         font.size = 32 ,
                         colors.use = colors_B,
                         xlab = "",
                         ylab = ""
                          
                   ) + xlab("Response") + ylab("% of B and plasma cells")



q1
```

<img src="/home/rstudio/ressler2024_Figure5/Figure5_files/figure-html/Figure5c.1-1.png" width="100%" />

```r
DT::datatable(q1$data, 
              caption = ("Figure 5c"),
              extensions = 'Buttons', 
              options = list( dom = 'Bfrtip',
              buttons = c( 'csv', 'excel')))
```

```{=html}
<div class="datatables html-widget html-fill-item" id="htmlwidget-cf69515aeb86c2352bfc" style="width:100%;height:auto;"></div>
```







# Open and pre-process clonotyoe data 





```r
combined <- readRDS("Ressler2024/metadata/100_CombinedBCR.Rds")

srat <- RenameCells(srat,new.names = paste0(srat$patient, "_",gsub("(_1|_2|_3|_4|_5|_6|_7|_8|_9)*", "",colnames(srat))))
srat <- RenameCells(srat,new.names = gsub("_post", "",colnames(srat)))

srat$sample <- gsub("_post", "",srat$patient)


seurat <- combineExpression(combined, srat, 
                  cloneCall = "strict", 
                  group.by = "sample", chain = "both",
                  proportion = TRUE,
                  filterNA = TRUE)



s   <- subset(seurat, subset = anno_l1 %in%  c("B cells","Plasma cells") )

#s@meta.data$anno_l1 <- droplevels(s@meta.data$anno_l1)
#s@meta.data$seurat_clusters <- droplevels(s@meta.data$seurat_clusters)

s@meta.data$cloneType <- factor(s@meta.data$cloneType, levels = unique(s$cloneType))
```


# Figure 5d


done on the highly confident B and plasma cells with exactly 2 IGH and IGL chains


```r
df <- s@meta.data

df <- df %>% 
    separate( CTgene, c("IGH", "IGL"), sep = "_") %>%
  separate( IGH, c("V", "D", "J", "C"), "\\.")
   
 
s <- AddMetaData(s, df$C, col.name = "Ig_level")
sss <- subset(s, subset = Ig_level != "NA")
dim(sss)
```

```
## [1] 27974 13045
```

```r
sss@meta.data$cloneType <- factor(sss@meta.data$cloneType, levels = c("Hyperexpanded (0.1 < X <= 1)", "Large (0.01 < X <= 0.1)", "Medium (0.001 < X <= 0.01)", "Small (1e-04 < X <= 0.001)"))

# define cell group membership
Idents(sss) <- sss$cloneType




sss@meta.data$Ig_level <- factor(sss@meta.data$Ig_level, levels = c("IGHA1",
         "IGHA2",
         "IGHM", 
         "IGHD",
         "IGHG1",
         "IGHG2",
         "IGHG3",
         "IGHG4"))


 

q1 <- SCpubr::do_BarPlot( sss,
                         group.by = "Ig_level",
                         split.by = "anno_l1",
                         position = "fill",
                         flip = TRUE,
                         order=FALSE,
                         legend.position = "right",
                         font.size = 30     , 
                         colors.use = colors_Ig) +
  xlab("") +
  ylab("Frequency of Ig isotypes")



q1
```

<img src="/home/rstudio/ressler2024_Figure5/Figure5_files/figure-html/Fig5d-1.png" width="100%" />

```r
DT::datatable(q1$data, 
              caption = ("Figure 5d"),
              extensions = 'Buttons', 
              options = list( dom = 'Bfrtip',
              buttons = c( 'csv', 'excel')))
```

```{=html}
<div class="datatables html-widget html-fill-item" id="htmlwidget-0c97ef64c704dd057d01" style="width:100%;height:auto;"></div>
```

```r
q1 <- SCpubr::do_BarPlot( sss,
                         group.by = "Ig_level",
                         split.by = "cloneType",
                         position = "fill",
                         flip = TRUE,
                         order=FALSE,
                         legend.position = "right",
                         font.size = 30     , 
                         colors.use = colors_Ig               ) +
  xlab("") +
  ylab("Frequency of Ig isotypes")



q1
```

<img src="/home/rstudio/ressler2024_Figure5/Figure5_files/figure-html/Fig5d-3.png" width="100%" />

```r
DT::datatable(q1$data, 
              caption = ("Figure 5d"),
              extensions = 'Buttons', 
              options = list( dom = 'Bfrtip',
              buttons = c( 'csv', 'excel')))
```

```{=html}
<div class="datatables html-widget html-fill-item" id="htmlwidget-afd4f888d7fafb5ddfc6" style="width:100%;height:auto;"></div>
```



# Figure 5f




```r
Idents(s) <- s$seurat_clusters
s@meta.data$seurat_clusters <- factor(s@meta.data$seurat_clusters, levels=c("34","7", "21",  "38",
                                                                             "15", "22","3", "4", "24"))

s@meta.data$cloneType <- factor(s@meta.data$cloneType, levels = c("Hyperexpanded (0.1 < X <= 1)", "Large (0.01 < X <= 0.1)", "Medium (0.001 < X <= 0.01)", "Small (1e-04 < X <= 0.001)"))

# define cell group membership
Idents(s) <- s$cloneType

de_markers <- DElegate::FindAllMarkers2(s, replicate_column = "patient", method = "edger", min_fc = 0, min_rate = 0.1)

signature_h <- de_markers$feature[de_markers$group1=="Hyperexpanded (0.1 < X <= 1)" ]
background <- rownames(s)
library(msigdbr)
library(clusterProfiler)
# enricher for cnet plot
GO_H_gene_sets = msigdbr(species = "human", category = "H")
msigdbr_t2g = GO_H_gene_sets %>% dplyr::distinct(gs_name, gene_symbol) %>% as.data.frame()

ego_h <- enricher(gene = signature_h, universe = background, TERM2GENE = msigdbr_t2g)

 
b <- barplot(ego_h, title = "Hallmarks´enrichment of hyperexpanded clones")


tmp <- b$data

tmp$ID <- str_trunc(tmp$ID, 100, "right")
tmp$ID <- factor(tmp$ID, levels = tmp$ID[order(tmp$Count)])

p <- ggplot(tmp, aes(Count, ID)) +
    geom_bar(stat = "identity", color="black", fill =  colors_clonotype["Hyperexpanded (0.1 < X <= 1)"]) +
   theme_classic()+ 
    geom_text(
        aes(label = (paste( "padj=", format(p.adjust,scientific = TRUE, digits = 2)))),
        color = "black",
        size = 6,
        hjust=1,
        position = position_dodge(0.5)  ) +
     theme(text = element_text(size=18)) +
  ggtitle("Hyperexpanded clones")


p
```

<img src="/home/rstudio/ressler2024_Figure5/Figure5_files/figure-html/Figure5f-1.png" width="100%" />

```r
DT::datatable(p$data, 
              caption = ("Figure 3I"),
              extensions = 'Buttons', 
              options = list( dom = 'Bfrtip',
              buttons = c( 'csv', 'excel')))
```

```{=html}
<div class="datatables html-widget html-fill-item" id="htmlwidget-910b66df82f19c095e03" style="width:100%;height:auto;"></div>
<script type="application/json" data-for="htmlwidget-910b66df82f19c095e03">{"x":{"filter":"none","vertical":false,"extensions":["Buttons"],"caption":"<caption>Figure 3I<\/caption>","data":[["HALLMARK_OXIDATIVE_PHOSPHORYLATION","HALLMARK_MYC_TARGETS_V1","HALLMARK_UNFOLDED_PROTEIN_RESPONSE","HALLMARK_MTORC1_SIGNALING","HALLMARK_PROTEIN_SECRETION","HALLMARK_REACTIVE_OXYGEN_SPECIES_PATHWAY","HALLMARK_ADIPOGENESIS","HALLMARK_INTERFERON_GAMMA_RESPONSE"],["HALLMARK_OXIDATIVE_PHOSPHORYLATION","HALLMARK_MYC_TARGETS_V1","HALLMARK_UNFOLDED_PROTEIN_RESPONSE","HALLMARK_MTORC1_SIGNALING","HALLMARK_PROTEIN_SECRETION","HALLMARK_REACTIVE_OXYGEN_SPECIES_PATHWAY","HALLMARK_ADIPOGENESIS","HALLMARK_INTERFERON_GAMMA_RESPONSE"],["HALLMARK_OXIDATIVE_PHOSPHORYLATION","HALLMARK_MYC_TARGETS_V1","HALLMARK_UNFOLDED_PROTEIN_RESPONSE","HALLMARK_MTORC1_SIGNALING","HALLMARK_PROTEIN_SECRETION","HALLMARK_REACTIVE_OXYGEN_SPECIES_PATHWAY","HALLMARK_ADIPOGENESIS","HALLMARK_INTERFERON_GAMMA_RESPONSE"],[0.2149901380670611,0.126232741617357,0.07692307692307693,0.09861932938856016,0.05325443786982249,0.03353057199211045,0.08284023668639054,0.07889546351084813],[0.04729250413809411,0.04634665405533223,0.02577441475526129,0.04681957909671317,0.02270040198628517,0.01158666351383306,0.04634665405533223,0.04681957909671317],[2.165137765495949e-51,3.689932486994223e-15,5.556648719254537e-11,9.932260730739113e-08,1.206998344188674e-05,2.73103288723763e-05,8.716778978694299e-05,0.000477133063458135],[1.039266127438056e-49,8.855837968786135e-14,8.890637950807259e-10,1.191871287688694e-06,0.0001158718410421127,0.0002184826309790104,0.0005977219871104661,0.00286279838074881],[8.204732585037282e-50,6.991451027989054e-14,7.018924698005731e-10,9.409510165963371e-07,9.147776924377318e-05,0.0001724862876150082,0.0004718857792977365,0.002260103984801692],["ECHS1/MRPL34/FDX1/MRPS12/UQCR10/ATP5F1C/MGST3/MRPS15/CYC1/COX6C/NDUFC1/ACADM/ATP6V1F/NDUFS6/ETFB/NDUFS7/NDUFS3/NDUFA2/IDH2/MDH2/NDUFB7/TIMM17A/NDUFB6/SLC25A4/NDUFA1/ATP5MC3/TIMM8B/NDUFS2/ISCU/ATP5PF/PRDX3/ATP5MF/COX7A2L/BCKDHA/ATP5F1A/NDUFB1/ACAT1/VDAC2/NDUFA7/NDUFB3/SURF1/ATP6V1G1/CYB5R3/NDUFV1/COX6A1/COX6B1/COX7A2/UQCRFS1/NDUFA3/HSD17B10/ATP6AP1/NDUFV2/NDUFS8/ATP5MC1/UQCR11/COX8A/COX7B/ATP6V0B/NDUFC2/COX5B/NDUFA9/NDUFB2/ATP6V0C/ATP5F1D/NDUFA6/UQCRQ/ATP5PD/ACAA1/NDUFB4/ATP5PO/NDUFA4/NDUFAB1/COX17/GPX4/MPC1/UQCRC1/NDUFB8/SDHA/LDHB/ECH1/UQCRH/ACADVL/COX5A/ATP5F1B/ATP5F1E/ATP5PB/ETFA/SLC25A3/ATP6V0E1/SLC25A5/SDHC/LDHA/IDH3G/ATP5MC2/ATP5ME/ACO2/NDUFB5/ATP5MG/TOMM22/SDHB/OXA1L/TCIRG1/SLC25A6/CYCS/COX7C/PHB2/HSPA9/COX4I1/UQCRB","SRM/ACP1/UBE2L3/NME1/SNRPG/CDK4/CYC1/PSMA6/ERH/C1QBP/CANX/TUFM/PSMD8/BUB3/RAN/PRDX3/SSBP1/PSMD7/CNBP/GLO1/PSMD3/EIF2S2/CCT7/PHB/NDUFAB1/TXNL4A/PSMA2/PPM1G/MRPS18B/PSMB3/PSMB2/LSM2/PSMC4/ILF2/ODC1/PRDX4/COX5A/GNL3/NHP2/SLC25A3/PGK1/SRSF2/HSPE1/YWHAE/LDHA/EIF1AX/STARD7/PTGES3/PSMA7/PABPC4/SERBP1/RPLP0/PHB2/AP3S1/RPS5/PCBP1/SNRPD2/EEF1B2/DDX18/PSMA1/EIF4A1/RACK1/HSPD1/LSM7","LSM1/PSAT1/GOSR2/YIF1A/MTHFD2/IMP3/PREB/PAIP1/WIPI1/DNAJC3/SLC1A4/PDIA5/KDELR3/SRPRA/SSR1/SPCS1/SRPRB/WFS1/SPCS3/HYOU1/ERN1/DNAJB9/PDIA6/CALR/NHP2/ATF4/SLC7A5/SERP1/SEC11A/HSP90B1/HSPA5/XBP1/HERPUD1/HSPA9/ATP6V0D1/SEC31A/EIF2AK3/EEF2/EIF4A1","CTSC/PSAT1/TPI1/PSMA3/UFM1/CANX/MTHFD2/SLC1A5/PSMB5/GLRX/EIF2S2/ATP5MC1/PSMD13/SHMT2/SLC1A4/PRDX1/RPN1/SSR1/RAB1A/IFI30/PSMC4/PPA1/CALR/PGK1/ARPC5L/HSPE1/SDF2L1/SLC7A5/SERP1/LDHA/TCEA1/FKBP2/SEC11A/HSP90B1/HSPA5/XBP1/BTG2/USO1/SLC9A3R1/ALDOA/TUBA4A/DDX39A/HSPA9/GLA/UBE2D3/PDK1/GAPDH/SQSTM1/CDKN1A/HSPD1","CTSC/GOSR2/GNAS/BET1/COPE/ARF1/LAMP2/RER1/SCAMP3/CD63/ARFGAP3/RAB2A/TMED10/ERGIC3/LMAN1/TMED2/NAPA/SEC22B/TPD52/COPB2/SEC24D/USO1/SOD1/AP3S1/GLA/SEC31A/SSPN","TXN/ATOX1/PRDX2/NDUFS2/GLRX/SELENOS/PRDX1/NDUFA6/NDUFB4/GPX4/PRDX4/LSP1/LAMTOR5/PRDX6/FTL/SOD1/PDLIM1","ECHS1/SLC66A3/UQCR10/MGST3/CYC1/ACADM/DHRS7/ETFB/NDUFS3/MDH2/MGLL/NDUFB7/LTC4S/PREB/SLC1A5/PRDX3/RTN3/BCKDHA/DNAJC15/COX6A1/TALDO1/UQCR11/COX8A/COX7B/GHITM/UQCRQ/ATP5PO/NDUFAB1/GPX4/UQCRC1/REEP5/ECH1/DNAJB9/SDHC/IDH3G/ACO2/SDHB/CHCHD10/UBC/ALDOA/SOD1/SSPN","ISOC1/PIM1/PSMA3/MTHFD2/PSMB8/IFNAR2/LAP3/ITGB7/PSME2/SLAMF7/BST2/CD38/IFI35/PSMA2/ISG20/TAPBP/PSMB2/IFI30/MVP/PSME1/LY6E/IRF7/PSMB10/ZBP1/TXNIP/UBE2L6/IRF1/CASP3/IRF4/HLA-B/HLA-G/PSMB9/B2M/APOL6/ST8SIA4/HLA-A/CDKN1A/HLA-DMA/IRF9/SSPN"],[109,64,39,50,27,17,42,40]],"container":"<table class=\"display\">\n  <thead>\n    <tr>\n      <th> <\/th>\n      <th>ID<\/th>\n      <th>Description<\/th>\n      <th>GeneRatio<\/th>\n      <th>BgRatio<\/th>\n      <th>pvalue<\/th>\n      <th>p.adjust<\/th>\n      <th>qvalue<\/th>\n      <th>geneID<\/th>\n      <th>Count<\/th>\n    <\/tr>\n  <\/thead>\n<\/table>","options":{"dom":"Bfrtip","buttons":["csv","excel"],"columnDefs":[{"className":"dt-right","targets":[3,4,5,6,7,9]},{"orderable":false,"targets":0},{"name":" ","targets":0},{"name":"ID","targets":1},{"name":"Description","targets":2},{"name":"GeneRatio","targets":3},{"name":"BgRatio","targets":4},{"name":"pvalue","targets":5},{"name":"p.adjust","targets":6},{"name":"qvalue","targets":7},{"name":"geneID","targets":8},{"name":"Count","targets":9}],"order":[],"autoWidth":false,"orderClasses":false},"selection":{"mode":"multiple","selected":null,"target":"row","selectable":null}},"evals":[],"jsHooks":[]}</script>
```







