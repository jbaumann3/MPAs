###mapping global database to global MPAs###

library(sp)
library(rgeos)
library(rgdal)



#read in data
a=read.csv('bztest.csv')
head(a)

#download the MPA database from here: https://www.protectedplanet.net/, it will be a .zip folder. Unzip it. 

#read in MPA shape file (find this file in the WDPA shapefile folder--not you need all the files in the folder in your directory, not just the shape file for this to work)
mpa<-readOGR("WDPA_Dec2018_marine-shapefile-polygons.shp", layer="WDPA_Dec2018_marine-shapefile-polygons")

#define new dataframe for appending to final data at the end
a2<-a
head(a)
#define long/lat coordinates to pull from coral data
coordinates(a)<-~long+lat
a1<-coordinates(a)
#transform to projection to match the mpa map data
#a<-spTransform(a, proj4string(mpa))
proj4string(a)<-proj4string(mpa)

#Find the MPA map data at each set of coordinates in the coral data
mpa_dat<-over(a, mpa)
mpa_dat=as.data.frame(mpa_dat)
head(mpa_dat)

#bind orginal coordinates and final mpa data together
a_dat=cbind(a2, mpa_dat)
head(a_dat)


