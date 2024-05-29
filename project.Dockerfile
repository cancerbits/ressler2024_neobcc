# pull base image
FROM rocker/tidyverse:4.1.2

# who maintains this image
LABEL maintainer Maud Plaschka "maud.plaschka@ccri.at"
LABEL version 4.1.2-v1


# Change the default CRAN mirror
RUN echo "options(repos = c(CRAN = 'https://mran.microsoft.com/snapshot/2022-02-01'), download.file.method = 'libcurl')" >> ${R_HOME}/etc/Rprofile.site

RUN apt-get update -qq \
  && apt-get -y --no-install-recommends install \
  htop \
  nano \
  libigraph-dev \
  libcairo2-dev \
  libxt-dev \
  libcurl4-openssl-dev \
  libcurl4 \
  libxml2-dev \
  libxt-dev \
  openssl \
  libssl-dev \
  wget \
  curl \
  bzip2 \
  libbz2-dev \
  libpng-dev \
  libhdf5-dev \
  pigz \
  libudunits2-dev \
  libgdal-dev \
  libgeos-dev \
  libboost-dev \
  libboost-iostreams-dev \
  libboost-log-dev \
  libboost-system-dev \
  libboost-test-dev \
  libz-dev \
  libarmadillo-dev \
  libglpk-dev \
  jags \
  libgsl-dev \
  libharfbuzz-dev \
  libfribidi-dev \
  cmake \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# add nlopt (for muscat R package)
RUN git clone -b v2.7.1 --single-branch https://github.com/stevengj/nlopt.git \
  && cd nlopt \
  && mkdir build \
  && cd build \
  && cmake .. \
  && make \
  && make install \
  && cd ../.. \
  && rm -rf nlopt

RUN R -e "update.packages(ask = FALSE)"

RUN install2.r --error \
    DT \
    profvis \
    tictoc \
    markdown \
    plotly \
    bench \
    mclust 

RUN R -e "BiocManager::install(version = "3.14", ask = FALSE)"
RUN R -e "BiocManager::install(c('multtest', 'limma', 'Biobase', 'monocle', 'rtracklayer', 'IRanges', 'GenomeInfoDb', 'GenomicRanges', 'BiocGenerics', 'DESeq2', 'MAST', 'SingleCellExperiment', 'SummarizedExperiment', 'S4Vectors', 'splatter', 'GEOquery', 'infercnv', 'glmGamPoi', 'hypeR', 'fgsea', 'ComplexHeatmap', 'org.Hs.eg.db', 'plger/scDblFinder'), update = FALSE)"
RUN R -e "remotes::install_github(repo = 'satijalab/sctransform', ref = 'e9e52a4', dependencies = TRUE)"
RUN R -e "remotes::install_github(repo = 'satijalab/seurat', ref = 'v4.1.0', dependencies = TRUE)"        # Might be required to upgrade to version 5
RUN R -e "remotes::install_github(repo = 'satijalab/azimuth', ref = 'v0.4.3', dependencies = TRUE)"       # Might be required to upgrade to version 5
RUN R -e "devtools::install_github('constantAmateur/SoupX',ref='devel')"
RUN R -e "remotes::install_github('AllenInstitute/scrattch.io')"
RUN R -e "remotes::install_github('crazyhottommy/scclusteval')"
RUN R -e "devtools::install_github('kassambara/ggpubr')"
RUN R -e "devtools::install_github(c('GuangchuangYu/DOSE', 'GuangchuangYu/clusterProfiler'))"
RUN R -e "remotes::install_github('chris-mcginnis-ucsf/DoubletFinder')"
RUN R -e "BiocManager::install(c('ReactomeGSA', 'GenomicFeatures', 'TxDb.Hsapiens.UCSC.hg19.knownGene'))"
RUN R -e "remotes::install_github(repo = 'cancerbits/canceRbits')"
RUN R -e "devtools::install_github('neurorestore/Libra')"                                     # Not required for the analysis
RUN R -e "devtools::install_github('yanlinlin82/ggvenn')"                                     # Not required for the analysis
RUN R -e "devtools::install_github('eliocamp/ggnewscale@dev')"
RUN R -e "devtools::install_github('ncborcherding/scRepertoire')"
RUN R -e "devtools::install_github('dtm2451/dittoSeq')"
RUN R -e "devtools::install_github('marcalva/diem')"
RUN R -e "BiocManager::install('dbscan')"
RUN R -e "devtools::install_github('stephens999/ashr')"
RUN R -e "BiocManager::install(c('EnhancedVolcano', 'clusterProfiler'))"
RUN R -e "remotes::install_github('renozao/xbioc')"
RUN R -e "devtools::install_github('meichendong/SCDC')"                                       # Not required for the analysis
RUN R -e "BiocManager::install(c('SPOTlight', 'SpatialExperiment'))"                          # Not required for the analysis
RUN R -e "devtools::install_github('enblacar/SCpubr')"
RUN R -e "BiocManager::install('Nebulosa')"                                                   # Not required for the analysis
RUN R -e "devtools::install_github('MarioniLab/miloR')"                                       # Not required for the analysis
RUN R -e "BiocManager::install('decoupleR')"
RUN R -e "devtools::install_github('gaospecial/ggVennDiagram')"                               # Not required for the analysis
RUN R -e "BiocManager::install(c('dorothea', 'progeny'))"                                     # Not required for the analysis
RUN R -e "BiocManager::install('OmnipathR')"                                                  # Not required for the analysis
RUN R -e "devtools::install_github('hms-dbmi/UpSetR')"                                        # Not required for the analysis
RUN R -e "devtools::install_github('cferegrino/scWGCNA', ref='main')"
RUN R -e "BiocManager::install('apeglm')"
RUN R -e "devtools::install_github('AnthonyChristidis/PerformanceAnalytics')"
RUN R -e "remotes::install_github('cancerbits/DElegate')"
RUN R -e "remotes::install_github('moosa-r/rbioapi')"


RUN chmod -R a+rw ${R_HOME}/site-library # so that everyone can dynamically install more libraries within container
RUN chmod -R a+rw ${R_HOME}/library

# add custom options for rstudio sessions
# make sure sessions stay alive forever
RUN echo "session-timeout-minutes=0" >> /etc/rstudio/rsession.conf
# make sure we get rstudio server logs in the container
# RUN echo $'[*]\nlog-level=warn\nlogger-type=file\n' > /etc/rstudio/logging.conf

# make sure all R related binaries are in PATH in case we want to call them directly
ENV PATH ${R_HOME}/bin:$PATH

