ARG BASE_CONTAINER=jupyter/datascience-notebook:notebook-6.5.2
FROM $BASE_CONTAINER

#ARG BASE_CONTAINER=jupyter/datascience-notebook:notebook-6.5.2

USER root


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
RUN add-apt-repository ppa:ubuntugis/ubuntugis-unstable && apt-get update && apt-get upgrade
RUN apt-get install gdal-bin -y && apt-get install libgdal-dev -y
RUN export CPLUS_INCLUDE_PATH=/usr/include/gdal && export C_INCLUDE_PATH=/usr/include/gdal

RUN pip install GDAL==$(gdal-config --version | awk -F'[.]' '{print $1"."$2}') && \
    pip install pyrasterframes && \
    pip install jupyterhub

#RUN pip install GDAL==$(gdal-config --version | awk -F'[.]' '{print $1"."$2}') && \
#    pip install pyrasterframes==0.8.5 && \
#    pip install jupyterhub==1.0.0

RUN apt-get install unrar -y && \
    apt-get install lftp -y && \
    apt-get install libproj-dev -y && \
    apt-get install libgdal-dev -y && \
        apt-get install gdal-bin -y && \
        apt-get install proj-bin -y

#RUN conda install -c conda-forge r-velox && \
#    conda install -c conda-forge r-rjava

RUN conda remove  r-base && \
    conda install r-base=3.6.3

RUN conda install -c conda-forge r-rjava 

RUN apt-get remove pkg-config -y

ENV PROJ_LIB="/opt/conda/share/proj"

#RUN  conda install -c conda-forge openjdk=8.0.192=h14c3975_1003 && \
RUN  conda install -c conda-forge openjdk && \
     conda install --quiet --yes -c conda-forge  'r-rgdal' && \
     conda install --quiet --yes -c conda-forge  'r-rgeos' && \
     conda install --quiet --yes -c conda-forge  'r-geojsonio' && \
     conda install --quiet --yes -c conda-forge  'r-spdep' && \
     conda install --quiet --yes -c conda-forge  'r-rcolorbrewer' && \
     conda install --quiet --yes -c conda-forge  'r-ncdf4'

ADD libraries.R libraries.R
RUN Rscript libraries.R

ADD extra/maxent.jar /opt/conda/lib/R/library/dismo/java/maxent.jar