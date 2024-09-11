---
title: "Extended Data Figure 6"
author: 'rstudio'
date: 'September 11, 2024 14:12:33 CEST'
output:
  html_document: 
    toc: yes
    toc_float: yes
    code_folding: hide
    highlight: pygments
    df_print: kable
    keep_md: true
params:
  path_to_data: ~
---


```r
knitr::opts_chunk$set(
	echo=TRUE,
	message = FALSE,
	warning = FALSE,
	dev = c("png", "jpeg", "pdf")
)
```

# Introduction

## Load libraries



```r
library(Seurat)
library(canceRbits)
library(Seurat)
library(dplyr)
library(patchwork)
library(DT)
library(SCpubr)
library(tibble)
library(reshape2)
library(viridis)
library(ggpubr)
library(ggplot2)
library(SCpubr)
```


## Load data

Load the corrected (`SoupX`), normalized (`SCTransformed`) and annotated (Twice mapped - Tabula Sapiens Skin reference and PBMC azimuth reference) data.



# Define levels and colors



```r
srat@meta.data$anno_l1 <- factor(srat@meta.data$anno_l1, levels=c("other",
                                                                 "Mast cells",
                                                                 "Mono-Mac",
                                                                 "LC",
                                                                 "DC",
                                                                 "pDC",
                                                                 "Plasma cells",
                                                                 "B cells" ,
                                                                 "Proliferating cells",
                                                                 "Natural killer cells",
                                                                 "CD8+ T cells",
                                                                 "Tregs",
                                                                  "CD4+ T cells" ,
                                                                 "Melanocytes",
                                                                 "Endothelial cells",
                                                                 "Fibroblasts",
                                                                 "Keratinocytes",
                                                                 "Malignant cells"))

# Subset immune / non-immune cells
imm <- subset(srat, subset = anno_l1 %in% c("other",
                                                                 "Mast cells",
                                                                 
                                                                 "Mono-Mac",
                                                                 "LC",
                                                                 "DC",
                                                                 "pDC",
                                                                 "Plasma cells",
                                                                 "B cells" ,
                                                                 "Proliferating cells",
                                                                 "Natural killer cells",
                                                                 "CD8+ T cells",
                                                                 "Tregs",
                                                                  "CD4+ T cells" ))
imm$anno_l1 <- droplevels(imm$anno_l1)
```


# Extended Data Figure 6b


```r
df <- imm@meta.data %>%
  mutate_if(sapply(imm@meta.data, is.character), as.factor)  %>% 
  group_by( Pathological.Response, patient, anno_l1,    .drop = FALSE)%>% 
  summarise(Nb = n()) %>%
  mutate(C = sum(Nb)) %>%
  mutate(percent = Nb/C*100) %>%
  filter(percent != "NaN") %>%
  arrange(Pathological.Response, percent)


tmp <- df[df$anno_l1 %in% c("Mono-Mac", "LC", "DC", "pDC", "Mast cells"),]


p1 <- ggpaired(tmp, 
         x = "Pathological.Response", 
         y = "percent", 
         id="patient", 
         facet.by = "anno_l1", 
         color = "black", 
         fill = "Pathological.Response" , 
         palette= c("yellow", "#fec44f"), 
         point.size = 2, 
         xlab = "", 
         ylab = "Percentage (%)", ncol = 5) + 
  stat_compare_means( method = "wilcox.test", paired = FALSE, label.y = c(55, 50, 50), hide.ns = FALSE, label = "p.format",  bracket.size = 0.5,tip.length = 0.01 ,comparison = list(c("pCR", "non-pCR")), size =4)   +
  theme(text = element_text(size = 24),axis.text.x = element_text(angle = 90,  vjust=0.5)) + ylim(c(0,60))





tmp <- df[df$anno_l1 %in% c("Plasma cells", "B cells"),]


p2 <- ggpaired(tmp, 
         x = "Pathological.Response", 
         y = "percent", 
         id="patient", 
         facet.by = "anno_l1", 
         color = "black", 
         fill = "Pathological.Response" , 
         palette= c("#7bccc4", "#35978f"), 
         point.size = 2, 
         xlab = "", 
         ylab = "Percentage (%)", ncol = 5) + 
 stat_compare_means( method = "wilcox.test", paired = FALSE, label.y = c(55, 50, 50), hide.ns = FALSE, label = "p.format",  bracket.size = 0.5,tip.length = 0.01 ,comparison = list(c("pCR", "non-pCR")), size =4)   +
  theme(text = element_text(size = 24),axis.text.x = element_text(angle = 90,  vjust=0.5)) + ylim(c(0,60))



 

tmp <- df[df$anno_l1 %in% c("CD8+ T cells"),]


p3 <- ggpaired(tmp, 
         x = "Pathological.Response", 
         y = "percent", 
         id="patient", 
         facet.by = "anno_l1", 
         color = "black", 
         fill = "Pathological.Response" , 
         palette= c("#fa9fb5", "#df65b0"), 
         point.size = 2, 
         xlab = "", 
         ylab = "Percentage (%)", ncol = 5)+ 
  stat_compare_means( method = "wilcox.test", paired = FALSE, label.y = c(55, 50, 50), hide.ns = FALSE, label = "p.format",  bracket.size = 0.5,tip.length = 0.01 ,comparison = list(c("pCR", "non-pCR")), size =4)   +
  theme(text = element_text(size = 24),axis.text.x = element_text(angle = 90,  vjust=0.5))+ ylim(c(0,60))

tmp <- df[df$anno_l1 %in% c("Tregs"),]


p4 <- ggpaired(tmp, 
         x = "Pathological.Response", 
         y = "percent", 
         id="patient", 
         facet.by = "anno_l1", 
         color = "black", 
         fill = "Pathological.Response" , 
         palette= c("#ae017e", "#49006a"), 
         point.size = 2, 
         xlab = "", 
         ylab = "Percentage (%)", ncol = 5) + 
  stat_compare_means( method = "wilcox.test", paired = FALSE, label.y = c(55, 50, 50), hide.ns = FALSE, label = "p.format",  bracket.size = 0.5,tip.length = 0.01 ,comparison = list(c("pCR", "non-pCR")), size =4)   +
  theme(text = element_text(size = 24),axis.text.x = element_text(angle = 90,  vjust=0.5)) + ylim(c(0,60))


tmp <- df[df$anno_l1 %in% c("CD4+ T cells"),]


p5 <- ggpaired(tmp, 
         x = "Pathological.Response", 
         y = "percent", 
         id="patient", 
         facet.by = "anno_l1", 
         color = "black", 
         fill = "Pathological.Response" , 
         palette= c("#41ab5d", "#016c59"), 
         point.size = 2, 
         xlab = "", 
         ylab = "Percentage (%)", ncol = 5)+ 
  stat_compare_means( method = "wilcox.test", paired = FALSE, label.y = c(55, 50, 50), hide.ns = FALSE, label = "p.format",  bracket.size = 0.5,tip.length = 0.01 ,comparison = list(c("pCR", "non-pCR")), size =4)   +
  theme(text = element_text(size = 24),axis.text.x = element_text(angle = 90,  vjust=0.5)) + ylim(c(0,60))

p <- p1 + p2 + p3 + p4 + p5 + plot_layout(ncol=5, widths = c(1/2, 1/5, 1/10, 1/10, 1/10), guides= "collect") & NoLegend()

p
```

<img src="/home/rstudio/notebook/ExtendedData_Figure6_files/figure-html/unnamed-chunk-3-1.png" width="100%" />

```r
p1 <-  ggpaired(df, 
         x = "Pathological.Response", 
         y = "percent", 
         id="patient", 
         facet.by = "anno_l1", 
         color = "black", 
         fill = "Pathological.Response" , 
         point.size = 2, 
         xlab = "", 
         ylab = "Percentage (%)", ncol = 5)+ 
 stat_compare_means( method = "wilcox.test", paired = FALSE, label.y = c(55, 50, 50), hide.ns = FALSE, label = "p.signif",  bracket.size = 0.5,tip.length = 0.01 ,comparison = list(c("pCR", "non-pCR")), size =4)   +
  theme(text = element_text(size = 24),axis.text.x = element_text(angle = 90,  vjust=0.5)) + ylim(c(0,60))


DT::datatable(p1$data, 
              caption = ("Extended Data Figure 6b"),
              extensions = 'Buttons', 
              options = list( dom = 'Bfrtip',
              buttons = c( 'csv', 'excel')))
```

```{=html}
<div class="datatables html-widget html-fill-item" id="htmlwidget-dc07207e01cb9d85a74f" style="width:100%;height:auto;"></div>
<script type="application/json" data-for="htmlwidget-dc07207e01cb9d85a74f">{"x":{"filter":"none","vertical":false,"extensions":["Buttons"],"caption":"<caption>Extended Data Figure 6b<\/caption>","data":[["1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16","17","18","19","20","21","22","23","24","25","26","27","28","29","30","31","32","33","34","35","36","37","38","39","40","41","42","43","44","45","46","47","48","49","50","51","52","53","54","55","56","57","58","59","60","61","62","63","64","65","66","67","68","69","70","71","72","73","74","75","76","77","78","79","80","81","82","83","84","85","86","87","88","89","90","91","92","93","94","95","96","97","98","99","100","101","102","103","104","105","106","107","108","109","110","111","112","113","114","115","116","117","118","119","120","121","122","123","124","125","126","127","128","129","130","131","132","133","134","135","136","137","138","139","140","141","142","143","144","145","146","147","148","149","150","151","152","153","154","155","156"],["non-pCR","non-pCR","non-pCR","non-pCR","non-pCR","non-pCR","non-pCR","non-pCR","non-pCR","non-pCR","non-pCR","non-pCR","non-pCR","non-pCR","non-pCR","non-pCR","non-pCR","non-pCR","non-pCR","non-pCR","non-pCR","non-pCR","non-pCR","non-pCR","non-pCR","non-pCR","non-pCR","non-pCR","non-pCR","non-pCR","non-pCR","non-pCR","non-pCR","non-pCR","non-pCR","non-pCR","non-pCR","non-pCR","non-pCR","non-pCR","non-pCR","non-pCR","non-pCR","non-pCR","non-pCR","non-pCR","non-pCR","non-pCR","non-pCR","non-pCR","non-pCR","non-pCR","non-pCR","non-pCR","non-pCR","non-pCR","non-pCR","non-pCR","non-pCR","non-pCR","non-pCR","non-pCR","non-pCR","non-pCR","non-pCR","non-pCR","non-pCR","non-pCR","non-pCR","non-pCR","non-pCR","non-pCR","non-pCR","non-pCR","non-pCR","non-pCR","non-pCR","non-pCR","non-pCR","non-pCR","non-pCR","non-pCR","non-pCR","non-pCR","non-pCR","non-pCR","non-pCR","non-pCR","non-pCR","non-pCR","non-pCR","non-pCR","non-pCR","non-pCR","non-pCR","non-pCR","non-pCR","non-pCR","non-pCR","non-pCR","non-pCR","non-pCR","non-pCR","non-pCR","pCR","pCR","pCR","pCR","pCR","pCR","pCR","pCR","pCR","pCR","pCR","pCR","pCR","pCR","pCR","pCR","pCR","pCR","pCR","pCR","pCR","pCR","pCR","pCR","pCR","pCR","pCR","pCR","pCR","pCR","pCR","pCR","pCR","pCR","pCR","pCR","pCR","pCR","pCR","pCR","pCR","pCR","pCR","pCR","pCR","pCR","pCR","pCR","pCR","pCR","pCR","pCR"],["NeoBCC010_post","NeoBCC014_post","NeoBCC015_post","NeoBCC015_post","NeoBCC018_post","NeoBCC015_post","NeoBCC018_post","NeoBCC004_post","NeoBCC006_post","NeoBCC006_post","NeoBCC014_post","NeoBCC011_post","NeoBCC006_post","NeoBCC005_post","NeoBCC006_post","NeoBCC018_post","NeoBCC015_post","NeoBCC004_post","NeoBCC004_post","NeoBCC018_post","NeoBCC011_post","NeoBCC004_post","NeoBCC006_post","NeoBCC006_post","NeoBCC005_post","NeoBCC015_post","NeoBCC006_post","NeoBCC004_post","NeoBCC011_post","NeoBCC005_post","NeoBCC018_post","NeoBCC010_post","NeoBCC010_post","NeoBCC010_post","NeoBCC015_post","NeoBCC018_post","NeoBCC014_post","NeoBCC014_post","NeoBCC011_post","NeoBCC011_post","NeoBCC006_post","NeoBCC005_post","NeoBCC006_post","NeoBCC015_post","NeoBCC014_post","NeoBCC010_post","NeoBCC010_post","NeoBCC010_post","NeoBCC014_post","NeoBCC018_post","NeoBCC011_post","NeoBCC005_post","NeoBCC014_post","NeoBCC004_post","NeoBCC004_post","NeoBCC014_post","NeoBCC011_post","NeoBCC005_post","NeoBCC015_post","NeoBCC011_post","NeoBCC004_post","NeoBCC004_post","NeoBCC011_post","NeoBCC005_post","NeoBCC011_post","NeoBCC005_post","NeoBCC014_post","NeoBCC018_post","NeoBCC005_post","NeoBCC018_post","NeoBCC010_post","NeoBCC015_post","NeoBCC006_post","NeoBCC015_post","NeoBCC004_post","NeoBCC010_post","NeoBCC010_post","NeoBCC015_post","NeoBCC018_post","NeoBCC014_post","NeoBCC018_post","NeoBCC014_post","NeoBCC005_post","NeoBCC004_post","NeoBCC010_post","NeoBCC005_post","NeoBCC011_post","NeoBCC006_post","NeoBCC010_post","NeoBCC006_post","NeoBCC014_post","NeoBCC005_post","NeoBCC004_post","NeoBCC018_post","NeoBCC015_post","NeoBCC011_post","NeoBCC005_post","NeoBCC011_post","NeoBCC010_post","NeoBCC018_post","NeoBCC014_post","NeoBCC004_post","NeoBCC015_post","NeoBCC006_post","NeoBCC008_post","NeoBCC012_post","NeoBCC012_post","NeoBCC012_post","NeoBCC012_post","NeoBCC017_post","NeoBCC007_post","NeoBCC007_post","NeoBCC017_post","NeoBCC007_post","NeoBCC007_post","NeoBCC017_post","NeoBCC007_post","NeoBCC017_post","NeoBCC007_post","NeoBCC008_post","NeoBCC008_post","NeoBCC012_post","NeoBCC017_post","NeoBCC008_post","NeoBCC017_post","NeoBCC017_post","NeoBCC012_post","NeoBCC008_post","NeoBCC008_post","NeoBCC007_post","NeoBCC008_post","NeoBCC017_post","NeoBCC008_post","NeoBCC012_post","NeoBCC008_post","NeoBCC007_post","NeoBCC007_post","NeoBCC012_post","NeoBCC017_post","NeoBCC008_post","NeoBCC012_post","NeoBCC012_post","NeoBCC007_post","NeoBCC007_post","NeoBCC017_post","NeoBCC007_post","NeoBCC017_post","NeoBCC008_post","NeoBCC017_post","NeoBCC012_post","NeoBCC012_post","NeoBCC008_post","NeoBCC012_post","NeoBCC017_post","NeoBCC008_post","NeoBCC007_post"],["LC","other","other","LC","LC","Plasma cells","pDC","LC","Mast cells","pDC","LC","other","Proliferating cells","LC","LC","DC","DC","pDC","Natural killer cells","Proliferating cells","pDC","Mast cells","other","DC","pDC","pDC","Tregs","Proliferating cells","B cells","DC","B cells","Mast cells","pDC","Proliferating cells","Proliferating cells","Natural killer cells","pDC","Plasma cells","DC","Proliferating cells","Natural killer cells","Proliferating cells","B cells","B cells","DC","DC","Plasma cells","Natural killer cells","Proliferating cells","Tregs","LC","Mast cells","Natural killer cells","Tregs","DC","B cells","Natural killer cells","Tregs","Tregs","Tregs","other","B cells","Plasma cells","B cells","Mast cells","other","Mast cells","Mast cells","Natural killer cells","other","Tregs","Mono-Mac","Mono-Mac","Mast cells","CD8+ T cells","Mono-Mac","CD4+ T cells","Natural killer cells","CD8+ T cells","CD8+ T cells","Mono-Mac","Tregs","Mono-Mac","Mono-Mac","B cells","Plasma cells","CD8+ T cells","CD4+ T cells","CD8+ T cells","CD8+ T cells","CD4+ T cells","CD8+ T cells","CD4+ T cells","CD4+ T cells","CD4+ T cells","CD4+ T cells","CD4+ T cells","Mono-Mac","other","Plasma cells","Mono-Mac","Plasma cells","CD8+ T cells","Plasma cells","LC","other","LC","DC","Proliferating cells","LC","LC","DC","pDC","Mast cells","Proliferating cells","Proliferating cells","Tregs","Mast cells","pDC","DC","Proliferating cells","Tregs","DC","Tregs","Tregs","B cells","pDC","other","Mast cells","Natural killer cells","pDC","other","Plasma cells","Natural killer cells","Natural killer cells","Mono-Mac","other","Mast cells","Natural killer cells","Mono-Mac","B cells","Mono-Mac","Plasma cells","CD4+ T cells","Plasma cells","CD8+ T cells","CD4+ T cells","B cells","CD8+ T cells","CD4+ T cells","CD8+ T cells","CD8+ T cells","Plasma cells","Mono-Mac","CD4+ T cells","B cells"],[0,0,0,1,2,2,3,4,5,7,6,9,12,23,14,20,21,22,22,25,20,29,28,31,80,48,49,59,52,140,83,1,1,1,94,118,87,93,108,115,145,265,152,161,122,2,2,2,129,187,151,347,168,253,256,196,219,559,334,285,384,409,356,802,405,905,391,545,949,574,7,643,789,816,867,11,11,967,1019,790,1093,795,1919,1120,15,2294,1167,1447,18,1829,1430,3502,2297,2358,2308,1999,4561,2467,41,3483,2673,3773,3808,4565,0,0,0,0,0,0,6,10,11,23,24,23,31,35,48,7,7,4,60,10,80,95,8,22,22,174,24,153,35,21,44,377,381,31,473,80,49,65,1344,1459,1319,1648,1491,251,1714,157,159,367,244,3501,599,5391],[112,6880,9203,9203,9510,9203,9510,9495,9073,9073,6880,7353,9073,16346,9073,9510,9203,9495,9495,9510,7353,9495,9073,9073,16346,9203,9073,9495,7353,16346,9510,112,112,112,9203,9510,6880,6880,7353,7353,9073,16346,9073,9203,6880,112,112,112,6880,9510,7353,16346,6880,9495,9495,6880,7353,16346,9203,7353,9495,9495,7353,16346,7353,16346,6880,9510,16346,9510,112,9203,9073,9203,9495,112,112,9203,9510,6880,9510,6880,16346,9495,112,16346,7353,9073,112,9073,6880,16346,9495,9510,9203,7353,16346,7353,112,9510,6880,9495,9203,9073,1468,738,738,738,738,8955,10916,10916,8955,10916,10916,8955,10916,8955,10916,1468,1468,738,8955,1468,8955,8955,738,1468,1468,10916,1468,8955,1468,738,1468,10916,10916,738,8955,1468,738,738,10916,10916,8955,10916,8955,1468,8955,738,738,1468,738,8955,1468,10916],[0,0,0,0.01086602194936434,0.02103049421661409,0.02173204389872867,0.03154574132492114,0.0421274354923644,0.05510856387082552,0.07715198941915574,0.0872093023255814,0.1223990208078335,0.1322605532899813,0.1407072066560626,0.1543039788383115,0.2103049421661409,0.2281864609366511,0.2317008952080042,0.2317008952080042,0.2628811777076762,0.2719978240174079,0.3054239073196419,0.308607957676623,0.3416730959991183,0.4894163709776092,0.5215690535694882,0.5400639259340901,0.6213796735123749,0.7071943424452604,0.8564786492108161,0.8727655099894847,0.8928571428571428,0.8928571428571428,0.8928571428571428,1.021406063240248,1.240799158780231,1.26453488372093,1.351744186046512,1.468788249694003,1.563987488100095,1.59814835225394,1.62119172886333,1.675300341673096,1.749429533847658,1.773255813953488,1.785714285714286,1.785714285714286,1.785714285714286,1.875,1.966351209253418,2.053583571331429,2.12284350911538,2.441860465116279,2.664560294892048,2.696155871511322,2.848837209302326,2.978376172990616,3.419796892206044,3.629251331087688,3.875968992248062,4.044233807266982,4.30753027909426,4.84156126750986,4.906399119050532,5.507955936352509,5.536522696684204,5.683139534883721,5.73080967402734,5.805701700721889,6.035751840168244,6.25,6.98685211344127,8.696131378816268,8.8666739106813,9.131121642969985,9.821428571428571,9.821428571428571,10.50744322503532,10.71503680336488,11.48255813953488,11.4931650893796,11.55523255813953,11.7398751988254,11.79568193786203,13.39285714285714,14.03401443778294,15.87107303141575,15.94841838421691,16.07142857142857,20.15871266394798,20.78488372093023,21.42420163954484,24.19167983149026,24.79495268138801,25.07877865913289,27.18618251053991,27.90285085036095,33.55093159254726,36.60714285714285,36.62460567823344,38.85174418604651,39.73670352817273,41.37781158317939,50.3141188140637,0,0,0,0,0,0,0.05496518871381459,0.09160864785635764,0.1228364042434394,0.2106998900696226,0.2198607548552584,0.2568397543271915,0.2839868083547087,0.3908431044109436,0.4397215097105167,0.4768392370572207,0.4768392370572207,0.5420054200542005,0.6700167504187605,0.6811989100817438,0.893355667225014,1.060859854829704,1.084010840108401,1.498637602179836,1.498637602179836,1.593990472700623,1.634877384196185,1.708542713567839,2.384196185286104,2.845528455284553,2.997275204359673,3.453646024184683,3.490289483327226,4.200542005420054,5.281965382467895,5.449591280653951,6.639566395663957,8.807588075880759,12.31220227189447,13.36570172224258,14.72920156337242,15.09710516672774,16.6499162479062,17.09809264305177,19.14014517029592,21.27371273712737,21.54471544715447,25,33.06233062330624,39.09547738693468,40.80381471389646,49.3862220593624],["NeoBCC010_post","NeoBCC014_post","NeoBCC015_post","NeoBCC015_post","NeoBCC018_post","NeoBCC015_post","NeoBCC018_post","NeoBCC004_post","NeoBCC006_post","NeoBCC006_post","NeoBCC014_post","NeoBCC011_post","NeoBCC006_post","NeoBCC005_post","NeoBCC006_post","NeoBCC018_post","NeoBCC015_post","NeoBCC004_post","NeoBCC004_post","NeoBCC018_post","NeoBCC011_post","NeoBCC004_post","NeoBCC006_post","NeoBCC006_post","NeoBCC005_post","NeoBCC015_post","NeoBCC006_post","NeoBCC004_post","NeoBCC011_post","NeoBCC005_post","NeoBCC018_post","NeoBCC010_post","NeoBCC010_post","NeoBCC010_post","NeoBCC015_post","NeoBCC018_post","NeoBCC014_post","NeoBCC014_post","NeoBCC011_post","NeoBCC011_post","NeoBCC006_post","NeoBCC005_post","NeoBCC006_post","NeoBCC015_post","NeoBCC014_post","NeoBCC010_post","NeoBCC010_post","NeoBCC010_post","NeoBCC014_post","NeoBCC018_post","NeoBCC011_post","NeoBCC005_post","NeoBCC014_post","NeoBCC004_post","NeoBCC004_post","NeoBCC014_post","NeoBCC011_post","NeoBCC005_post","NeoBCC015_post","NeoBCC011_post","NeoBCC004_post","NeoBCC004_post","NeoBCC011_post","NeoBCC005_post","NeoBCC011_post","NeoBCC005_post","NeoBCC014_post","NeoBCC018_post","NeoBCC005_post","NeoBCC018_post","NeoBCC010_post","NeoBCC015_post","NeoBCC006_post","NeoBCC015_post","NeoBCC004_post","NeoBCC010_post","NeoBCC010_post","NeoBCC015_post","NeoBCC018_post","NeoBCC014_post","NeoBCC018_post","NeoBCC014_post","NeoBCC005_post","NeoBCC004_post","NeoBCC010_post","NeoBCC005_post","NeoBCC011_post","NeoBCC006_post","NeoBCC010_post","NeoBCC006_post","NeoBCC014_post","NeoBCC005_post","NeoBCC004_post","NeoBCC018_post","NeoBCC015_post","NeoBCC011_post","NeoBCC005_post","NeoBCC011_post","NeoBCC010_post","NeoBCC018_post","NeoBCC014_post","NeoBCC004_post","NeoBCC015_post","NeoBCC006_post","NeoBCC008_post","NeoBCC012_post","NeoBCC012_post","NeoBCC012_post","NeoBCC012_post","NeoBCC017_post","NeoBCC007_post","NeoBCC007_post","NeoBCC017_post","NeoBCC007_post","NeoBCC007_post","NeoBCC017_post","NeoBCC007_post","NeoBCC017_post","NeoBCC007_post","NeoBCC008_post","NeoBCC008_post","NeoBCC012_post","NeoBCC017_post","NeoBCC008_post","NeoBCC017_post","NeoBCC017_post","NeoBCC012_post","NeoBCC008_post","NeoBCC008_post","NeoBCC007_post","NeoBCC008_post","NeoBCC017_post","NeoBCC008_post","NeoBCC012_post","NeoBCC008_post","NeoBCC007_post","NeoBCC007_post","NeoBCC012_post","NeoBCC017_post","NeoBCC008_post","NeoBCC012_post","NeoBCC012_post","NeoBCC007_post","NeoBCC007_post","NeoBCC017_post","NeoBCC007_post","NeoBCC017_post","NeoBCC008_post","NeoBCC017_post","NeoBCC012_post","NeoBCC012_post","NeoBCC008_post","NeoBCC012_post","NeoBCC017_post","NeoBCC008_post","NeoBCC007_post"]],"container":"<table class=\"display\">\n  <thead>\n    <tr>\n      <th> <\/th>\n      <th>Pathological.Response<\/th>\n      <th>patient<\/th>\n      <th>anno_l1<\/th>\n      <th>Nb<\/th>\n      <th>C<\/th>\n      <th>percent<\/th>\n      <th>id<\/th>\n    <\/tr>\n  <\/thead>\n<\/table>","options":{"dom":"Bfrtip","buttons":["csv","excel"],"columnDefs":[{"className":"dt-right","targets":[4,5,6]},{"orderable":false,"targets":0},{"name":" ","targets":0},{"name":"Pathological.Response","targets":1},{"name":"patient","targets":2},{"name":"anno_l1","targets":3},{"name":"Nb","targets":4},{"name":"C","targets":5},{"name":"percent","targets":6},{"name":"id","targets":7}],"order":[],"autoWidth":false,"orderClasses":false},"selection":{"mode":"multiple","selected":null,"target":"row","selectable":null}},"evals":[],"jsHooks":[]}</script>
```



# Extended Data Figure 6d


```r
df <- imm@meta.data %>%
  mutate_if(sapply(imm@meta.data, is.character), as.factor)  %>% 
  group_by( WHO, patient, anno_l1,    .drop = FALSE)%>% 
  summarise(Nb = n()) %>%
  mutate(C = sum(Nb)) %>%
  mutate(percent = Nb/C*100) %>%
  filter(percent != "NaN") %>%
  arrange(WHO, percent)


tmp <- df[df$anno_l1 %in% c("Mono-Mac", "LC", "DC", "pDC", "Mast cells"),]


p1 <- ggpaired(tmp, 
         x = "WHO", 
         y = "percent", 
         id="patient", 
         facet.by = "anno_l1", 
         color = "black", 
         fill = "WHO" , 
         palette= c("white","yellow", "#fec44f"), 
         point.size = 2, 
         xlab = "", 
         ylab = "Percentage (%)", ncol = 5) + 
 stat_compare_means( method = "wilcox.test", paired = FALSE, label.y = c(55, 50, 50), hide.ns = FALSE, label = "p.format",  bracket.size = 0.5,tip.length = 0.01 ,comparison = list(c("CR", "SD"), c("SD", "PR"), c("CR", "PR")), size =4)   +
  theme(text = element_text(size = 24),axis.text.x = element_text(angle = 90,  vjust=0.5)) + ylim(c(0,60))





tmp <- df[df$anno_l1 %in% c("Plasma cells", "B cells"),]


p2 <- ggpaired(tmp, 
         x = "WHO", 
         y = "percent", 
         id="patient", 
         facet.by = "anno_l1", 
         color = "black", 
         fill = "WHO" , 
         palette= c("white","#7bccc4", "#35978f"), 
         point.size = 2, 
         xlab = "", 
         ylab = "Percentage (%)", ncol = 5) + 
 stat_compare_means( method = "wilcox.test", paired = FALSE, label.y = c(55, 50, 50), hide.ns = FALSE, label = "p.format",  bracket.size = 0.5,tip.length = 0.01 ,comparison = list(c("CR", "SD"), c("SD", "PR"), c("CR", "PR")), size =4)   +
  theme(text = element_text(size = 24),axis.text.x = element_text(angle = 90,  vjust=0.5)) + ylim(c(0,60))



 

tmp <- df[df$anno_l1 %in% c("CD8+ T cells"),]


p3 <- ggpaired(tmp, 
         x = "WHO", 
         y = "percent", 
         id="patient", 
         facet.by = "anno_l1", 
         color = "black", 
         fill = "WHO" , 
         palette= c("white","#fa9fb5", "#df65b0"), 
         point.size = 2, 
         xlab = "", 
         ylab = "Percentage (%)", ncol = 5)+ 
 stat_compare_means( method = "wilcox.test", paired = FALSE, label.y = c(55, 50, 50), hide.ns = FALSE, label = "p.format",  bracket.size = 0.5,tip.length = 0.01 ,comparison = list(c("CR", "SD"), c("SD", "PR"), c("CR", "PR")), size =4)   +
  theme(text = element_text(size = 24),axis.text.x = element_text(angle = 90,  vjust=0.5))+ ylim(c(0,60))

tmp <- df[df$anno_l1 %in% c("Tregs"),]


p4 <- ggpaired(tmp, 
         x = "WHO", 
         y = "percent", 
         id="patient", 
         facet.by = "anno_l1", 
         color = "black", 
         fill = "WHO" , 
         palette= c("white","#ae017e", "#49006a"), 
         point.size = 2, 
         xlab = "", 
         ylab = "Percentage (%)", ncol = 5) + 
  stat_compare_means( method = "wilcox.test", paired = FALSE, label.y = c(55, 50, 50), hide.ns = FALSE, label = "p.format",  bracket.size = 0.5,tip.length = 0.01 ,comparison = list(c("CR", "SD"), c("SD", "PR"), c("CR", "PR")), size =4)   +
  theme(text = element_text(size = 24),axis.text.x = element_text(angle = 90,  vjust=0.5)) + ylim(c(0,60))


tmp <- df[df$anno_l1 %in% c("CD4+ T cells"),]


p5 <- ggpaired(tmp, 
         x = "WHO", 
         y = "percent", 
         id="patient", 
         facet.by = "anno_l1", 
         color = "black", 
         fill = "WHO" , 
         palette= c("white","#41ab5d", "#016c59"), 
         point.size = 2, 
         xlab = "", 
         ylab = "Percentage (%)", ncol = 5)+ 
  stat_compare_means( method = "wilcox.test", paired = FALSE, label.y = c(55, 50, 50), hide.ns = FALSE, label = "p.format",  bracket.size = 0.5,tip.length = 0.01 ,comparison = list(c("CR", "SD"), c("SD", "PR"), c("CR", "PR")), size =4)   +
  theme(text = element_text(size = 24),axis.text.x = element_text(angle = 90,  vjust=0.5)) + ylim(c(0,60))

p <- p1 + p2 + p3 + p4 + p5 + plot_layout(ncol=5, widths = c(1/2, 1/5, 1/10, 1/10, 1/10), guides= "collect") & NoLegend()

p
```

<img src="/home/rstudio/notebook/ExtendedData_Figure6_files/figure-html/unnamed-chunk-4-1.png" width="100%" />

```r
p1 <-  ggpaired(df, 
         x = "WHO", 
         y = "percent", 
         id="patient", 
         facet.by = "anno_l1", 
         color = "black", 
         fill = "WHO" , 
         point.size = 2, 
         xlab = "", 
         ylab = "Percentage (%)", ncol = 5)+ 
  stat_compare_means( method = "wilcox.test", paired = FALSE, label.y = c(55, 50, 50), hide.ns = FALSE, label = "p.format",  bracket.size = 0.5,tip.length = 0.01 ,comparison = list(c("CR", "SD"), c("SD", "PR"), c("CR", "PR")), size =4)   +
  theme(text = element_text(size = 24),axis.text.x = element_text(angle = 90,  vjust=0.5)) + ylim(c(0,60))


DT::datatable(p1$data, 
              caption = ("Extended Data Figure 6d"),
              extensions = 'Buttons', 
              options = list( dom = 'Bfrtip',
              buttons = c( 'csv', 'excel')))
```

```{=html}
<div class="datatables html-widget html-fill-item" id="htmlwidget-d2f664d00324c43c5739" style="width:100%;height:auto;"></div>
<script type="application/json" data-for="htmlwidget-d2f664d00324c43c5739">{"x":{"filter":"none","vertical":false,"extensions":["Buttons"],"caption":"<caption>Extended Data Figure 6d<\/caption>","data":[["1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16","17","18","19","20","21","22","23","24","25","26","27","28","29","30","31","32","33","34","35","36","37","38","39","40","41","42","43","44","45","46","47","48","49","50","51","52","53","54","55","56","57","58","59","60","61","62","63","64","65","66","67","68","69","70","71","72","73","74","75","76","77","78","79","80","81","82","83","84","85","86","87","88","89","90","91","92","93","94","95","96","97","98","99","100","101","102","103","104","105","106","107","108","109","110","111","112","113","114","115","116","117","118","119","120","121","122","123","124","125","126","127","128","129","130","131","132","133","134","135","136","137","138","139","140","141","142","143","144","145","146","147","148","149","150","151","152","153","154","155","156"],["CR","CR","CR","CR","CR","CR","CR","CR","CR","CR","CR","CR","CR","CR","CR","CR","CR","CR","CR","CR","CR","CR","CR","CR","CR","CR","CR","CR","CR","CR","CR","CR","CR","CR","CR","CR","CR","CR","CR","CR","CR","CR","CR","CR","CR","CR","CR","CR","CR","CR","CR","CR","PR","PR","PR","PR","PR","PR","PR","PR","PR","PR","PR","PR","PR","PR","PR","PR","PR","PR","PR","PR","PR","PR","PR","PR","PR","PR","PR","PR","PR","PR","PR","PR","PR","PR","PR","PR","PR","PR","PR","PR","PR","PR","PR","PR","PR","PR","PR","PR","PR","PR","PR","PR","SD","SD","SD","SD","SD","SD","SD","SD","SD","SD","SD","SD","SD","SD","SD","SD","SD","SD","SD","SD","SD","SD","SD","SD","SD","SD","SD","SD","SD","SD","SD","SD","SD","SD","SD","SD","SD","SD","SD","SD","SD","SD","SD","SD","SD","SD","SD","SD","SD","SD","SD","SD"],["NeoBCC008_post","NeoBCC012_post","NeoBCC012_post","NeoBCC012_post","NeoBCC012_post","NeoBCC017_post","NeoBCC007_post","NeoBCC007_post","NeoBCC017_post","NeoBCC007_post","NeoBCC007_post","NeoBCC017_post","NeoBCC007_post","NeoBCC017_post","NeoBCC007_post","NeoBCC008_post","NeoBCC008_post","NeoBCC012_post","NeoBCC017_post","NeoBCC008_post","NeoBCC017_post","NeoBCC017_post","NeoBCC012_post","NeoBCC008_post","NeoBCC008_post","NeoBCC007_post","NeoBCC008_post","NeoBCC017_post","NeoBCC008_post","NeoBCC012_post","NeoBCC008_post","NeoBCC007_post","NeoBCC007_post","NeoBCC012_post","NeoBCC017_post","NeoBCC008_post","NeoBCC012_post","NeoBCC012_post","NeoBCC007_post","NeoBCC007_post","NeoBCC017_post","NeoBCC007_post","NeoBCC017_post","NeoBCC008_post","NeoBCC017_post","NeoBCC012_post","NeoBCC012_post","NeoBCC008_post","NeoBCC012_post","NeoBCC017_post","NeoBCC008_post","NeoBCC007_post","NeoBCC010_post","NeoBCC004_post","NeoBCC006_post","NeoBCC006_post","NeoBCC011_post","NeoBCC006_post","NeoBCC006_post","NeoBCC004_post","NeoBCC004_post","NeoBCC011_post","NeoBCC004_post","NeoBCC006_post","NeoBCC006_post","NeoBCC006_post","NeoBCC004_post","NeoBCC011_post","NeoBCC010_post","NeoBCC010_post","NeoBCC010_post","NeoBCC011_post","NeoBCC011_post","NeoBCC006_post","NeoBCC006_post","NeoBCC010_post","NeoBCC010_post","NeoBCC010_post","NeoBCC011_post","NeoBCC004_post","NeoBCC004_post","NeoBCC011_post","NeoBCC011_post","NeoBCC004_post","NeoBCC004_post","NeoBCC011_post","NeoBCC011_post","NeoBCC010_post","NeoBCC006_post","NeoBCC004_post","NeoBCC010_post","NeoBCC010_post","NeoBCC004_post","NeoBCC010_post","NeoBCC011_post","NeoBCC006_post","NeoBCC010_post","NeoBCC006_post","NeoBCC004_post","NeoBCC011_post","NeoBCC011_post","NeoBCC010_post","NeoBCC004_post","NeoBCC006_post","NeoBCC014_post","NeoBCC015_post","NeoBCC015_post","NeoBCC018_post","NeoBCC015_post","NeoBCC018_post","NeoBCC014_post","NeoBCC005_post","NeoBCC018_post","NeoBCC015_post","NeoBCC018_post","NeoBCC005_post","NeoBCC015_post","NeoBCC005_post","NeoBCC018_post","NeoBCC015_post","NeoBCC018_post","NeoBCC014_post","NeoBCC014_post","NeoBCC005_post","NeoBCC015_post","NeoBCC014_post","NeoBCC014_post","NeoBCC018_post","NeoBCC005_post","NeoBCC014_post","NeoBCC014_post","NeoBCC005_post","NeoBCC015_post","NeoBCC005_post","NeoBCC005_post","NeoBCC014_post","NeoBCC018_post","NeoBCC005_post","NeoBCC018_post","NeoBCC015_post","NeoBCC015_post","NeoBCC015_post","NeoBCC018_post","NeoBCC014_post","NeoBCC018_post","NeoBCC014_post","NeoBCC005_post","NeoBCC005_post","NeoBCC014_post","NeoBCC005_post","NeoBCC018_post","NeoBCC015_post","NeoBCC005_post","NeoBCC018_post","NeoBCC014_post","NeoBCC015_post"],["LC","other","LC","DC","Proliferating cells","LC","LC","DC","pDC","Mast cells","Proliferating cells","Proliferating cells","Tregs","Mast cells","pDC","DC","Proliferating cells","Tregs","DC","Tregs","Tregs","B cells","pDC","other","Mast cells","Natural killer cells","pDC","other","Plasma cells","Natural killer cells","Natural killer cells","Mono-Mac","other","Mast cells","Natural killer cells","Mono-Mac","B cells","Mono-Mac","Plasma cells","CD4+ T cells","Plasma cells","CD8+ T cells","CD4+ T cells","B cells","CD8+ T cells","CD4+ T cells","CD8+ T cells","CD8+ T cells","Plasma cells","Mono-Mac","CD4+ T cells","B cells","LC","LC","Mast cells","pDC","other","Proliferating cells","LC","pDC","Natural killer cells","pDC","Mast cells","other","DC","Tregs","Proliferating cells","B cells","Mast cells","pDC","Proliferating cells","DC","Proliferating cells","Natural killer cells","B cells","DC","Plasma cells","Natural killer cells","LC","Tregs","DC","Natural killer cells","Tregs","other","B cells","Plasma cells","Mast cells","Tregs","Mono-Mac","CD8+ T cells","Mono-Mac","CD4+ T cells","Mono-Mac","B cells","CD8+ T cells","CD4+ T cells","CD8+ T cells","CD8+ T cells","CD4+ T cells","CD4+ T cells","Mono-Mac","other","Plasma cells","Plasma cells","other","other","LC","LC","Plasma cells","pDC","LC","LC","DC","DC","Proliferating cells","pDC","pDC","DC","B cells","Proliferating cells","Natural killer cells","pDC","Plasma cells","Proliferating cells","B cells","DC","Proliferating cells","Tregs","Mast cells","Natural killer cells","B cells","Tregs","Tregs","B cells","other","Mast cells","Mast cells","Natural killer cells","other","Mono-Mac","Mast cells","Natural killer cells","CD8+ T cells","CD8+ T cells","Mono-Mac","Tregs","Mono-Mac","Plasma cells","CD4+ T cells","CD8+ T cells","CD4+ T cells","CD4+ T cells","CD4+ T cells","Plasma cells","Mono-Mac","CD8+ T cells"],[0,0,0,0,0,0,6,10,11,23,24,23,31,35,48,7,7,4,60,10,80,95,8,22,22,174,24,153,35,21,44,377,381,31,473,80,49,65,1344,1459,1319,1648,1491,251,1714,157,159,367,244,3501,599,5391,0,4,5,7,9,12,14,22,22,20,29,28,31,49,59,52,1,1,1,108,115,145,152,2,2,2,151,253,256,219,285,384,409,356,405,7,789,867,11,11,1120,15,1167,1447,18,1829,2297,1999,2467,41,3773,4565,0,0,1,2,2,3,6,23,20,21,25,80,48,140,83,94,118,87,93,265,161,122,129,187,347,168,196,559,334,802,905,391,545,949,574,643,816,967,1019,790,1093,795,1919,2294,1430,3502,2358,2308,4561,3483,2673,3808],[1468,738,738,738,738,8955,10916,10916,8955,10916,10916,8955,10916,8955,10916,1468,1468,738,8955,1468,8955,8955,738,1468,1468,10916,1468,8955,1468,738,1468,10916,10916,738,8955,1468,738,738,10916,10916,8955,10916,8955,1468,8955,738,738,1468,738,8955,1468,10916,112,9495,9073,9073,7353,9073,9073,9495,9495,7353,9495,9073,9073,9073,9495,7353,112,112,112,7353,7353,9073,9073,112,112,112,7353,9495,9495,7353,7353,9495,9495,7353,7353,112,9073,9495,112,112,9495,112,7353,9073,112,9073,9495,7353,7353,112,9495,9073,6880,9203,9203,9510,9203,9510,6880,16346,9510,9203,9510,16346,9203,16346,9510,9203,9510,6880,6880,16346,9203,6880,6880,9510,16346,6880,6880,16346,9203,16346,16346,6880,9510,16346,9510,9203,9203,9203,9510,6880,9510,6880,16346,16346,6880,16346,9510,9203,16346,9510,6880,9203],[0,0,0,0,0,0,0.05496518871381459,0.09160864785635764,0.1228364042434394,0.2106998900696226,0.2198607548552584,0.2568397543271915,0.2839868083547087,0.3908431044109436,0.4397215097105167,0.4768392370572207,0.4768392370572207,0.5420054200542005,0.6700167504187605,0.6811989100817438,0.893355667225014,1.060859854829704,1.084010840108401,1.498637602179836,1.498637602179836,1.593990472700623,1.634877384196185,1.708542713567839,2.384196185286104,2.845528455284553,2.997275204359673,3.453646024184683,3.490289483327226,4.200542005420054,5.281965382467895,5.449591280653951,6.639566395663957,8.807588075880759,12.31220227189447,13.36570172224258,14.72920156337242,15.09710516672774,16.6499162479062,17.09809264305177,19.14014517029592,21.27371273712737,21.54471544715447,25,33.06233062330624,39.09547738693468,40.80381471389646,49.3862220593624,0,0.0421274354923644,0.05510856387082552,0.07715198941915574,0.1223990208078335,0.1322605532899813,0.1543039788383115,0.2317008952080042,0.2317008952080042,0.2719978240174079,0.3054239073196419,0.308607957676623,0.3416730959991183,0.5400639259340901,0.6213796735123749,0.7071943424452604,0.8928571428571428,0.8928571428571428,0.8928571428571428,1.468788249694003,1.563987488100095,1.59814835225394,1.675300341673096,1.785714285714286,1.785714285714286,1.785714285714286,2.053583571331429,2.664560294892048,2.696155871511322,2.978376172990616,3.875968992248062,4.044233807266982,4.30753027909426,4.84156126750986,5.507955936352509,6.25,8.696131378816268,9.131121642969985,9.821428571428571,9.821428571428571,11.79568193786203,13.39285714285714,15.87107303141575,15.94841838421691,16.07142857142857,20.15871266394798,24.19167983149026,27.18618251053991,33.55093159254726,36.60714285714285,39.73670352817273,50.3141188140637,0,0,0.01086602194936434,0.02103049421661409,0.02173204389872867,0.03154574132492114,0.0872093023255814,0.1407072066560626,0.2103049421661409,0.2281864609366511,0.2628811777076762,0.4894163709776092,0.5215690535694882,0.8564786492108161,0.8727655099894847,1.021406063240248,1.240799158780231,1.26453488372093,1.351744186046512,1.62119172886333,1.749429533847658,1.773255813953488,1.875,1.966351209253418,2.12284350911538,2.441860465116279,2.848837209302326,3.419796892206044,3.629251331087688,4.906399119050532,5.536522696684204,5.683139534883721,5.73080967402734,5.805701700721889,6.035751840168244,6.98685211344127,8.8666739106813,10.50744322503532,10.71503680336488,11.48255813953488,11.4931650893796,11.55523255813953,11.7398751988254,14.03401443778294,20.78488372093023,21.42420163954484,24.79495268138801,25.07877865913289,27.90285085036095,36.62460567823344,38.85174418604651,41.37781158317939],["NeoBCC008_post","NeoBCC012_post","NeoBCC012_post","NeoBCC012_post","NeoBCC012_post","NeoBCC017_post","NeoBCC007_post","NeoBCC007_post","NeoBCC017_post","NeoBCC007_post","NeoBCC007_post","NeoBCC017_post","NeoBCC007_post","NeoBCC017_post","NeoBCC007_post","NeoBCC008_post","NeoBCC008_post","NeoBCC012_post","NeoBCC017_post","NeoBCC008_post","NeoBCC017_post","NeoBCC017_post","NeoBCC012_post","NeoBCC008_post","NeoBCC008_post","NeoBCC007_post","NeoBCC008_post","NeoBCC017_post","NeoBCC008_post","NeoBCC012_post","NeoBCC008_post","NeoBCC007_post","NeoBCC007_post","NeoBCC012_post","NeoBCC017_post","NeoBCC008_post","NeoBCC012_post","NeoBCC012_post","NeoBCC007_post","NeoBCC007_post","NeoBCC017_post","NeoBCC007_post","NeoBCC017_post","NeoBCC008_post","NeoBCC017_post","NeoBCC012_post","NeoBCC012_post","NeoBCC008_post","NeoBCC012_post","NeoBCC017_post","NeoBCC008_post","NeoBCC007_post","NeoBCC010_post","NeoBCC004_post","NeoBCC006_post","NeoBCC006_post","NeoBCC011_post","NeoBCC006_post","NeoBCC006_post","NeoBCC004_post","NeoBCC004_post","NeoBCC011_post","NeoBCC004_post","NeoBCC006_post","NeoBCC006_post","NeoBCC006_post","NeoBCC004_post","NeoBCC011_post","NeoBCC010_post","NeoBCC010_post","NeoBCC010_post","NeoBCC011_post","NeoBCC011_post","NeoBCC006_post","NeoBCC006_post","NeoBCC010_post","NeoBCC010_post","NeoBCC010_post","NeoBCC011_post","NeoBCC004_post","NeoBCC004_post","NeoBCC011_post","NeoBCC011_post","NeoBCC004_post","NeoBCC004_post","NeoBCC011_post","NeoBCC011_post","NeoBCC010_post","NeoBCC006_post","NeoBCC004_post","NeoBCC010_post","NeoBCC010_post","NeoBCC004_post","NeoBCC010_post","NeoBCC011_post","NeoBCC006_post","NeoBCC010_post","NeoBCC006_post","NeoBCC004_post","NeoBCC011_post","NeoBCC011_post","NeoBCC010_post","NeoBCC004_post","NeoBCC006_post","NeoBCC014_post","NeoBCC015_post","NeoBCC015_post","NeoBCC018_post","NeoBCC015_post","NeoBCC018_post","NeoBCC014_post","NeoBCC005_post","NeoBCC018_post","NeoBCC015_post","NeoBCC018_post","NeoBCC005_post","NeoBCC015_post","NeoBCC005_post","NeoBCC018_post","NeoBCC015_post","NeoBCC018_post","NeoBCC014_post","NeoBCC014_post","NeoBCC005_post","NeoBCC015_post","NeoBCC014_post","NeoBCC014_post","NeoBCC018_post","NeoBCC005_post","NeoBCC014_post","NeoBCC014_post","NeoBCC005_post","NeoBCC015_post","NeoBCC005_post","NeoBCC005_post","NeoBCC014_post","NeoBCC018_post","NeoBCC005_post","NeoBCC018_post","NeoBCC015_post","NeoBCC015_post","NeoBCC015_post","NeoBCC018_post","NeoBCC014_post","NeoBCC018_post","NeoBCC014_post","NeoBCC005_post","NeoBCC005_post","NeoBCC014_post","NeoBCC005_post","NeoBCC018_post","NeoBCC015_post","NeoBCC005_post","NeoBCC018_post","NeoBCC014_post","NeoBCC015_post"]],"container":"<table class=\"display\">\n  <thead>\n    <tr>\n      <th> <\/th>\n      <th>WHO<\/th>\n      <th>patient<\/th>\n      <th>anno_l1<\/th>\n      <th>Nb<\/th>\n      <th>C<\/th>\n      <th>percent<\/th>\n      <th>id<\/th>\n    <\/tr>\n  <\/thead>\n<\/table>","options":{"dom":"Bfrtip","buttons":["csv","excel"],"columnDefs":[{"className":"dt-right","targets":[4,5,6]},{"orderable":false,"targets":0},{"name":" ","targets":0},{"name":"WHO","targets":1},{"name":"patient","targets":2},{"name":"anno_l1","targets":3},{"name":"Nb","targets":4},{"name":"C","targets":5},{"name":"percent","targets":6},{"name":"id","targets":7}],"order":[],"autoWidth":false,"orderClasses":false},"selection":{"mode":"multiple","selected":null,"target":"row","selectable":null}},"evals":[],"jsHooks":[]}</script>
```


# Session Info


```r
sessionInfo()
```

```
## R version 4.3.0 (2023-04-21)
## Platform: x86_64-pc-linux-gnu (64-bit)
## Running under: Ubuntu 22.04.4 LTS
## 
## Matrix products: default
## BLAS:   /usr/lib/x86_64-linux-gnu/openblas-pthread/libblas.so.3 
## LAPACK: /usr/lib/x86_64-linux-gnu/openblas-pthread/libopenblasp-r0.3.20.so;  LAPACK version 3.10.0
## 
## locale:
##  [1] LC_CTYPE=en_US.UTF-8       LC_NUMERIC=C               LC_TIME=en_US.UTF-8        LC_COLLATE=en_US.UTF-8    
##  [5] LC_MONETARY=en_US.UTF-8    LC_MESSAGES=en_US.UTF-8    LC_PAPER=en_US.UTF-8       LC_NAME=C                 
##  [9] LC_ADDRESS=C               LC_TELEPHONE=C             LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C       
## 
## time zone: Europe/Vienna
## tzcode source: system (glibc)
## 
## attached base packages:
## [1] stats4    stats     graphics  grDevices utils     datasets  methods   base     
## 
## other attached packages:
##  [1] stringr_1.5.1         msigdbr_7.5.1         DOSE_3.26.2           org.Hs.eg.db_3.17.0  
##  [5] AnnotationDbi_1.62.2  IRanges_2.34.1        S4Vectors_0.38.2      Biobase_2.60.0       
##  [9] BiocGenerics_0.46.0   clusterProfiler_4.8.3 enrichplot_1.20.3     scales_1.3.0         
## [13] RColorBrewer_1.1-3    ggnewscale_0.4.10     tidyr_1.3.1           scRepertoire_1.10.1  
## [17] dittoSeq_1.12.2       canceRbits_0.1.6      ggpubr_0.6.0.999      ggplot2_3.5.1        
## [21] viridis_0.6.5         viridisLite_0.4.2     reshape2_1.4.4        tibble_3.2.1         
## [25] SCpubr_2.0.2          DT_0.32               patchwork_1.2.0       dplyr_1.1.4          
## [29] Seurat_5.0.3          SeuratObject_5.0.1    sp_2.1-3             
## 
## loaded via a namespace (and not attached):
##   [1] fs_1.6.4                    matrixStats_1.2.0           spatstat.sparse_3.0-3      
##   [4] bitops_1.0-7                HDO.db_0.99.1               httr_1.4.7                 
##   [7] doParallel_1.0.17           tools_4.3.0                 sctransform_0.4.1          
##  [10] backports_1.4.1             utf8_1.2.4                  R6_2.5.1                   
##  [13] vegan_2.6-4                 lazyeval_0.2.2              uwot_0.1.16                
##  [16] mgcv_1.9-1                  permute_0.9-7               withr_3.0.0                
##  [19] gridExtra_2.3               progressr_0.14.0            cli_3.6.2                  
##  [22] spatstat.explore_3.2-7      fastDummies_1.7.3           scatterpie_0.2.1           
##  [25] isoband_0.2.7               labeling_0.4.3              sass_0.4.9                 
##  [28] spatstat.data_3.0-4         ggridges_0.5.6              pbapply_1.7-2              
##  [31] yulab.utils_0.1.4           gson_0.1.0                  stringdist_0.9.12          
##  [34] parallelly_1.37.1           limma_3.56.2                RSQLite_2.3.5              
##  [37] VGAM_1.1-10                 rstudioapi_0.16.0           generics_0.1.3             
##  [40] gridGraphics_0.5-1          ica_1.0-3                   spatstat.random_3.2-3      
##  [43] crosstalk_1.2.1             car_3.1-2                   GO.db_3.17.0               
##  [46] Matrix_1.6-5                ggbeeswarm_0.7.2            fansi_1.0.6                
##  [49] abind_1.4-5                 lifecycle_1.0.4             edgeR_3.42.4               
##  [52] yaml_2.3.8                  carData_3.0-5               SummarizedExperiment_1.30.2
##  [55] qvalue_2.32.0               Rtsne_0.17                  blob_1.2.4                 
##  [58] grid_4.3.0                  promises_1.2.1              crayon_1.5.2               
##  [61] miniUI_0.1.1.1              lattice_0.22-6              cowplot_1.1.3              
##  [64] KEGGREST_1.40.1             pillar_1.9.0                knitr_1.45                 
##  [67] fgsea_1.26.0                GenomicRanges_1.52.1        future.apply_1.11.1        
##  [70] codetools_0.2-19            fastmatch_1.1-4             leiden_0.4.3.1             
##  [73] glue_1.7.0                  downloader_0.4              ggfun_0.1.5                
##  [76] data.table_1.15.2           treeio_1.24.3               vctrs_0.6.5                
##  [79] png_0.1-8                   spam_2.10-0                 gtable_0.3.5               
##  [82] assertthat_0.2.1            cachem_1.1.0                xfun_0.43                  
##  [85] S4Arrays_1.0.6              mime_0.12                   tidygraph_1.3.1            
##  [88] survival_3.5-8              DElegate_1.2.1              SingleCellExperiment_1.22.0
##  [91] pheatmap_1.0.12             iterators_1.0.14            fitdistrplus_1.1-11        
##  [94] ROCR_1.0-11                 nlme_3.1-164                ggtree_3.13.0.001          
##  [97] bit64_4.0.5                 RcppAnnoy_0.0.22            evd_2.3-6.1                
## [100] GenomeInfoDb_1.36.4         bslib_0.6.2                 irlba_2.3.5.1              
## [103] vipor_0.4.7                 KernSmooth_2.23-22          DBI_1.2.2                  
## [106] colorspace_2.1-0            ggrastr_1.0.2               tidyselect_1.2.1           
## [109] bit_4.0.5                   compiler_4.3.0              SparseM_1.81               
## [112] DelayedArray_0.26.7         plotly_4.10.4               shadowtext_0.1.3           
## [115] lmtest_0.9-40               digest_0.6.35               goftest_1.2-3              
## [118] spatstat.utils_3.0-4        rmarkdown_2.26              XVector_0.40.0             
## [121] htmltools_0.5.8             pkgconfig_2.0.3             sparseMatrixStats_1.12.2   
## [124] MatrixGenerics_1.12.3       highr_0.10                  fastmap_1.2.0              
## [127] rlang_1.1.4                 htmlwidgets_1.6.4           shiny_1.8.1                
## [130] farver_2.1.2                jquerylib_0.1.4             zoo_1.8-12                 
## [133] jsonlite_1.8.8              BiocParallel_1.34.2         GOSemSim_2.26.1            
## [136] RCurl_1.98-1.14             magrittr_2.0.3              GenomeInfoDbData_1.2.10    
## [139] ggplotify_0.1.2             dotCall64_1.1-1             munsell_0.5.1              
## [142] Rcpp_1.0.12                 evmix_2.12                  babelgene_22.9             
## [145] ape_5.8                     reticulate_1.35.0           truncdist_1.0-2            
## [148] stringi_1.8.4               ggalluvial_0.12.5           ggraph_2.2.1               
## [151] zlibbioc_1.46.0             MASS_7.3-60.0.1             plyr_1.8.9                 
## [154] parallel_4.3.0              listenv_0.9.1               ggrepel_0.9.5              
## [157] forcats_1.0.0               deldir_2.0-4                Biostrings_2.68.1          
## [160] graphlayouts_1.1.1          splines_4.3.0               tensor_1.5                 
## [163] locfit_1.5-9.9              igraph_2.0.3                spatstat.geom_3.2-9        
## [166] cubature_2.1.0              ggsignif_0.6.4              RcppHNSW_0.6.0             
## [169] evaluate_0.23               foreach_1.5.2               tweenr_2.0.3               
## [172] httpuv_1.6.15               RANN_2.6.1                  purrr_1.0.2                
## [175] polyclip_1.10-6             future_1.33.2               scattermore_1.2            
## [178] ggforce_0.4.2               broom_1.0.5                 xtable_1.8-4               
## [181] tidytree_0.4.6              RSpectra_0.16-1             rstatix_0.7.2              
## [184] later_1.3.2                 gsl_2.1-8                   aplot_0.2.3                
## [187] beeswarm_0.4.0              memoise_2.0.1               cluster_2.1.6              
## [190] powerTCR_1.20.0             globals_0.16.3
```


