ARG BASE_CONTAINER=jupyter/datascience-notebook:notebook-6.5.2
FROM $BASE_CONTAINER

USER root


RUN mamba remove --yes 'r-base' && \
    mamba install --quiet --yes 'r-base=3.6.3'
RUN mamba install --quiet --yes \
    'r-caret' \
    'r-crayon' \
    'r-devtools' \
    'r-e1071' \
    'r-forecast' \
    'r-hexbin' \
    'r-htmltools' \
    'r-htmlwidgets' \
    'r-irkernel' \
    'r-nycflights13' \
    'r-randomforest' \
    'r-rcurl' \
    'r-rmarkdown' \
    'r-rodbc' \
    'r-rsqlite' \
    'r-shiny' \
    'r-tidyverse' \
    'unixodbc' \
    'r-tidymodels' \
    'r-rjava' \
    'openjdk' && \
    mamba clean --all -f -y && \
    fix-permissions "${CONDA_DIR}" && \
    fix-permissions "/home/${NB_USER}"



RUN pip install shapely && \
    pip install geopandas && \
    pip install rasterio && \
    pip install ipyleaflet && \
    pip install scikit-learn && \
    pip install scikit-image && \
    pip install xgboost && \
    pip install pcse    
#    pip install torch torchvision && \
#    pip install Keras && \
#    pip install tensorflow && \


RUN apt-get update && apt-get install software-properties-common -y
RUN add-apt-repository ppa:ubuntugis/ubuntugis-unstable && apt-get update
RUN apt-get install gdal-bin -y && apt-get install libgdal-dev -y
RUN export CPLUS_INCLUDE_PATH=/usr/include/gdal && export C_INCLUDE_PATH=/usr/include/gdal

RUN pip install GDAL==$(gdal-config --version | awk -F'[.]' '{print $1"."$2}') && \
    pip install pyrasterframes==0.8.5 && \
    pip install jupyterhub==1.0.0

RUN apt-get install unrar -y && \
    apt-get install lftp -y && \
    apt-get install libproj-dev -y && \
    apt-get install libgdal-dev -y && \
    apt-get install gdal-bin -y && \
    apt-get install proj-bin -y


RUN apt-get remove pkg-config -y

ENV PROJ_LIB="/opt/conda/share/proj"

RUN  conda install --quiet --yes 'r-rgdal' && \
     conda install --quiet --yes 'r-rgeos' && \
     conda install --quiet --yes 'r-geojsonio' && \
     conda install --quiet --yes 'r-spdep' && \
     conda install --quiet --yes 'r-rcolorbrewer' && \
     conda install --quiet --yes 'r-ncdf4'

ADD libraries.R libraries.R
RUN Rscript libraries.R

ADD extra/maxent.jar /opt/conda/lib/R/library/dismo/java/maxent.jar