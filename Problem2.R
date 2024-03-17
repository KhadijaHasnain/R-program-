library(sp) 
library(sf) 
library(RColorBrewer) 

# Load data 
nc <- st_read(system.file("shape/nc.shp", package="sf")) 

# Convert sf object to sp object 
nc_sp <- as(nc, "Spatial") 

# Create choropleth map with spplot 
spplot(nc_sp, "SID74", main = "SID74", col.regions = brewer.pal(9, "YlOrRd"))

