ARG BASE_CONTAINER=jupyter/scipy-notebook:python-3.9
#ARG BASE_CONTAINER=jupyter/datascience-notebook:r-3.6.3
FROM $BASE_CONTAINER

SHELL ["/bin/bash", "-o", "pipefail", "-c"]
USER root


#RUN pip install shapely && \
#    pip install geopandas && \
#    pip install rasterio && \
#    pip install ipyleaflet && \
#    pip install scikit-learn && \
#    pip install scikit-image && \
#    pip install xgboost && \
#    pip install torch torchvision && \
#    pip install Keras && \
#    pip install tensorflow && \
#    pip install pcse

RUN apt-get update && \ 
    apt-get install software-properties-common -y  && \
    add-apt-repository ppa:ubuntugis/ubuntugis-unstable && \
    apt-get update --yes && \
    # r prereq \
    apt-get install --yes --no-install-recommends \
                                      fonts-dejavu \ 
                                      unixodbc \
                                      unixodbc-dev \
                                      r-cran-rodbc \
                                      gfortran \
                                      gcc \
                                      openssl && \
    apt-get install --yes \
                                      unrar \ 
                                      lftp \
                                      libproj-dev \
                                      libgdal-dev \
                                      libpq-dev \
                                      gdal-bin \
                                      proj-bin  && \ 
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* && \
    apt-get remove pkg-config -y



RUN export CPLUS_INCLUDE_PATH=/usr/include/gdal && export C_INCLUDE_PATH=/usr/include/gdal

ENV PROJ_LIB="/opt/conda/share/proj"

# R packages including IRKernel which gets installed globally.
# r-e1071: dependency of the caret R package
RUN pip install --upgrade --no-cache-dir setuptools==57.5.0 && \
    pip install GDAL==$(gdal-config --version | awk -F'[.]' '{print $1"."$2}') && \
    pip install pyrasterframes

RUN mamba install --quiet --yes 'r-base=3.6.3' && \
    mamba install --quiet --yes 'r-velox' && \
    mamba install --quiet --yes 'jupyterhub' && \ 
    mamba install --quiet --yes 'jupyterlab' && \
    mamba install --quiet --yes 'r-rjava' && \
    mamba install --quiet --yes 'r-caret' && \
    mamba install --quiet --yes 'r-crayon' && \
    mamba install --quiet --yes 'r-devtools' && \
    mamba install --quiet --yes 'r-e1071'  && \
    mamba install --quiet --yes 'r-hmisc' && \  
    mamba install --quiet --yes 'r-forecast' && \
    mamba install --quiet --yes 'r-hexbin' && \
    mamba install --quiet --yes 'r-htmltools' && \
    mamba install --quiet --yes 'r-htmlwidgets' && \
    mamba install --quiet --yes 'r-irkernel' && \
    mamba install --quiet --yes 'r-randomforest' && \
    mamba install --quiet --yes 'r-rcurl' && \
    mamba install --quiet --yes 'r-rmarkdown' && \
    mamba install --quiet --yes 'r-rodbc' && \
    mamba install --quiet --yes 'r-rsqlite' && \
    mamba install --quiet --yes 'r-shiny' && \
    mamba install --quiet --yes 'r-tidymodels' && \ 
    mamba install --quiet --yes 'r-tidyverse'  && \
    mamba install --quiet --yes 'unixodbc' && \
    mamba install --quiet --yes 'openjdk' && \
    mamba install --quiet --yes 'r-rgdal' && \
    mamba install --quiet --yes 'r-rgeos' && \
    mamba install --quiet --yes 'r-geojsonio' && \
    mamba install --quiet --yes 'r-spdep' && \
    mamba install --quiet --yes 'r-rcolorbrewer' && \
    mamba install --quiet --yes 'r-ncdf4' && \
    mamba install --quiet --yes 'r-lwgeom' && \
    mamba install --quiet --yes 'r-stars' && \
    mamba install --quiet --yes 'r-gstat' && \
    mamba install --quiet --yes 'r-systemfonts' && \
    mamba install --quiet --yes 'r-rmysql' && \
    mamba install --quiet --yes 'r-svglite' && \
    mamba install --quiet --yes 'r-devtools' && \
    mamba install --quiet --yes 'r-textshaping' && \
    mamba install --quiet --yes 'r-pkgdown' && \
    mamba install --quiet --yes 'r-dismo' && \
    mamba install --quiet --yes 'r-gam' && \
    mamba clean --all -f -y && \
    fix-permissions "${CONDA_DIR}" && \
    fix-permissions "/home/${NB_USER}" && \
    Rscript -e 'update.packages(ask=F, repos = "https://cran.mi2.ai/")'

#RUN mamba install --quiet --yes 'r-carret'

COPY libraries.R libraries.R
RUN Rscript libraries.R 2>&1 > ./install_libs.log || true

ADD extra/maxent.jar /opt/conda/lib/R/library/dismo/java/maxent.jar
