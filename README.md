[![Build Status](https://travis-ci.org/SCiO-systems/cgspatial-notebook.svg?branch=master)](https://travis-ci.org/SCiO-systems/cgspatial-notebook) [![License: CC0-1.0](https://img.shields.io/badge/License-CC0%201.0-lightgrey.svg)](http://creativecommons.org/publicdomain/zero/1.0/)
[![maintainer:SCiO](https://img.shields.io/badge/maintainer-SCiO-blue)](https://scio.systems)



# cgspatial-notebook
`cgspatial-notebook` is a community Jupyter Docker Stack image. The image includes major geospatial Python &amp; R libraries  on top of the datascience-notebook image. It also contains libraries that allow operations over climatic data.



## Try it on Binder

Click on the following badge to launch a notebook on the `https://mybinder.org` service.

[![Binder](https://mybinder.org/badge_logo.svg)](https://mybinder.org/v2/gh/SCiO-systems/cgspatial-notebook/master)

## Docker Hub
* Docker Hub [hub.docker.com/r/scioquiver/notebooks](https://hub.docker.com/r/scioquiver/notebooks)

Docker Pull Command for Docker image.
```
docker pull scioquiver/notebooks:cgspatial-notebook
```


## R Libraries

* [analogues](https://github.com/CIAT-DAPA/analogues "analogues")
* [devtools](https://CRAN.R-project.org/package=devtools "devtools")
* [dismo](https://cran.r-project.org/package=dismo "dismo")
* [dplyr](https://cran.r-project.org/package=dplyr "dplyr")
* [fields](https://cran.r-project.org/package=fields "fields")
* [geosphere](https://cran.r-project.org/package=geosphere "geosphere")
* [gstat](https://cran.r-project.org/package=gstat "gstat")
* [kernlab](https://cran.r-project.org/package=kernlab "kernlab")
* [landsat](https://cran.r-project.org/package=landsat "landsat")
* [latticeExtra](https://cran.r-project.org/package=latticeExtra "latticeExtra")
* [maptools](https://cran.r-project.org/package=maptools "maptools")
* [raster](https://cran.r-project.org/package=raster "raster")
* [rasterVis](https://cran.r-project.org/package=rasterVis "rasterVis")
* [rgdal](https://cran.r-project.org/package=rgdal "rgdal")
* [rgeos](https://cran.r-project.org/package=rgeos "rgeos")
* [RStoolbox](https://cran.r-project.org/package=RStoolbox "RStoolbox")
* [Rwofost](https://rdrr.io/rforge/Rwofost/man/Rwofost-package.html "Rwofost")
* [sp](https://cran.r-project.org/package=sp "sp")
* [spatstat](https://cran.r-project.org/package=spatstat "spatstat")
* [tidyr](https://cran.r-project.org/package=tidyr "tidyr")

## Python Libraries

* [Shapely](https://pypi.org/project/Shapely/"Shapely")
* [geopandas](https://pypi.org/project/geopandas/"geopandas")
* [rasterio](https://pypi.org/project/rasterio/"rasterio")
* [PCSE](https://pypi.org/project/PCSE/"PCSE")
* [GDAL](https://pypi.org/project/GDAL/ "GDAL")

# References

## Jupyter Docker Stacks - Community Stack version
This project is developed with the helpful guide of [Jupyter Docker Stacks](https://jupyter-docker-stacks.readthedocs.io/en/latest/). The base container is **jupyter/datascience-notebook** and this **Community Stack** is setup [via the guide.](https://jupyter-docker-stacks.readthedocs.io/en/latest/contributing/stacks.html)
