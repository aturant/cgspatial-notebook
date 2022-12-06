ARG BASE_CONTAINER=jupyter/datascience-notebook:notebook-6.5.2
FROM $BASE_CONTAINER

USER root

##########################################################################################
RUN apt-get update && \
    apt-get install software-properties-common -y && \  
    add-apt-repository ppa:ubuntugis/ubuntugis-unstable

RUN apt-get update && \
    apt-get install unrar -y && \
    apt-get install lftp -y && \
    apt-get install gdal-bin -y && \
    apt-get install libgdal-dev -y && \
    apt-get install libproj-dev -y && \
    apt-get install proj-bin -y && \
    apt-get install libudunits2-dev -y && \
    apt-get install libgeos-dev -y && \
    apt-get clean && \    
    apt-get autoremove --purge && \
    apt-get remove pkg-config -y

RUN export CPLUS_INCLUDE_PATH=/usr/include/gdal && export C_INCLUDE_PATH=/usr/include/gdal


##########################################################################################

COPY requirements.txt libraries.R ./
RUN pip install -r requirements.txt
##########################################################################################

RUN jupyter lab build

##########################################################################################

ENV PROJ_LIB="/opt/conda/share/proj"

##########################################################################################
RUN pip install GDAL==$(gdal-config --version | awk -F'[.]' '{print $1"."$2}') && \
    pip install pyrasterframes>=0.8.5

##########################################################################################

RUN mamba install --quiet --yes \
    'r-caret' \
    'r-rjava' \
    'openjdk' \
    'r-rgdal' \
    'r-rgeos' \
    'r-geojsonio' \
    'r-spdep' \
    'r-ncdf4' \
    'r-sf' \
    'jupyterlab' && \
    mamba clean --all -f -y && \
    fix-permissions "${CONDA_DIR}" && \
    fix-permissions "/home/${NB_USER}"


#RUN Rscript libraries.R

ADD extra/maxent.jar /opt/conda/lib/R/library/dismo/java/maxent.jar