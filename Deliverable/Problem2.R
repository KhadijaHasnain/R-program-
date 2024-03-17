library(maps)
library(mapproj)
library(tidyverse)

# Read CPI data from CSV
cpi_data <- read.csv("cpi.csv")

# Convert month and year columns to Date format
cpi_data$Date <- as.Date(paste(cpi_data$month, cpi_data$year), format = "%m/%d/%Y")

# Merge and sort CPI data
arrests.geo <- merge(states, arrests, sort = FALSE, by = "region")
arrests.geo <- arrests.geo[order(arrests.geo$order), ]

# Plot
ggplot(arrests.geo, aes(long, lat)) +
  geom_polygon(aes(group = group, fill = assault)) +
  coord_map() +
  theme_void() +  
  labs(title = "Percentage of Residents without health insurance coverage in the U.S.,2021") +
  scale_fill_continuous(name = "Uninsured Rate", limits = c(0.05 , 0.20))

