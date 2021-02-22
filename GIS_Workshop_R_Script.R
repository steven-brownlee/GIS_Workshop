###

# E2O GIS Workshop, February 23 2021
# Steven Brownlee

###

# Goal of this exercise is to explore some of the fun funcitonality of R
# and 

# 1.) Install or call in packages required, set working directory.

install.packages('ggplot2')
install.packages('ggmap')
install.packages('sf')
install.packages('tmap')
install.packages('sp')
install.packages('raster')
install.packages('ggspatial')
install.packages('rasterVis')
install.packages('rgeos')

setwd('C:\\Users\\sbrow\\Google Drive\\Moore Lab\\GIS Workshop')

library(ggplot2)
library(ggmap)
library(sf)
library(sp)
library(raster)
library(tmap)
library(ggspatial)
library(rasterVis)

# There are three main packages for hadling spatial data in R: 'sp', 'sf'
# and 'raster'. 'sp' and 'sf' handle vector data using the same ancient set 
# of code from GDAL (as does Python!), while 'raster' handles raster data.
# between all three you can do a reasonable job of replicating the functions
# of a desktop GIS platform like ArcMap.
#

# 2.) Bring in our field site locations from the .csv file. Double check to make
# sure that the fields where the coordinates are stored are formatted correctly! 
# GIS R packages and even ArcMap are really bad at interpreting longitude/latitude,
# and  if there are mistakes in the formatting like extra spaces or missing 
# apostrophes it can prevent them being loaded properly.

fieldsites <- read.csv('RMRM_Population_Sites.csv')

# Remember to check the coordinate system when you bring in spatial data! This 
# is in WGS 1984 since it was collected by GPS. If you have GIS data from other
# sources you'd like to use instead by all means bring them in here instead.

# 3.) Transform the table into an 'sf' object for plotting - specify the columns
# where the coordinates are stored (x,y) and the coordinate system.

fieldsites_spatial <- st_as_sf(fieldsites, coords = c("Longitude", "Latitude"), crs = 4326)

# Note the CRS number: Every CRS in the world is assigned a numerical call number
# by the European Petroleum Survey Group (EPSG). Googling the EPSG # of an unknown 
# coordinate system is a great way to find out more info about it and get snippets
# of code or files that will let you define the coordinate system and transform 
# it into other things. (www.spatialreference.org)

# If we decide we want to change this into a different coordinate system you can 
# use the 'st_transform' function to change the projection of our 'sf' object. As 
# above, all we need to do is look up the EPSG number of the coordinate system
# we want and insert it into the code.

# 4.) Now we get to call in everyone's favourite package family, ggplot, to do 
# the fun part of GIS - making pretty maps! 

# We can get a basemap through ggmap by calling in a basemap through some of 
# Google's cloud services - just remember to include the API key below, otherwise 
# it won't work!

## Note: my own personal API has been removed below, you can sign up for your own here: 
## https://developers.google.com/maps/documentation/javascript/get-api-key

register_google(key = '')

ok_basemap <- get_map(location=c(lon = -119.529439, lat = 49.2888044), zoom = 14,
                      maptype = 'satellite', source = 'google')

ggmap(ok_basemap)

