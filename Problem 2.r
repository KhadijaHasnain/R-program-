# Load necessary libraries
library(ggplot2)
library(maps)
library(mapdata)

# Load the dataset
state_data <- read.csv("state_health_insurance_coverage_2021.csv", stringsAsFactors = FALSE)

# Define color palette
colors <- c("skyblue", "blue4")

# Set up ggplot with the map data
p = ggplot() +
  geom_map(data = map_data("state"), map = map_data("state"),
           aes(x = long, y = lat, map_id = region),
           fill = "white", color = "black", size = 0.1) +
  coord_fixed(1.3)

# Add the data to the plot
p = p +
  geom_map(data = state_data_map, map = state_data_map,
           aes(fill = Uninsured, map_id = region),
           color = "black", size = 0.1) +
  scale_fill_gradient(low = colors[1], high = colors[2],
                      name = "Uninsured rate",
                      breaks = seq(0, 0.2, by = 0.05),
                      labels = c("0.00", "0.05", "0.10", "0.15", "0.20")) +
  labs(title = "Percentage of residents without health insurance coverage in the U.S., 2021") +
  theme_void()

# Display the plot
print(p)