# Load required libraries
library(ggplot2)
library(dplyr)
library(readr)

# Read the CSV file
df <- read_csv("bank_stocks_2022_2023.csv")

# Convert 'date' column to date format
df$date <- as.Date(df$date, format = "%m/%d/%Y")

# Calculate average stock price for each date
avg_price <- df %>%
  group_by(date) %>%
  summarize(avg_price = mean(close_price))

# Plotting the line graph
ggplot(df, aes(x = date, y = close_price, color = bank_name)) +
  geom_line() +
  geom_line(data = avg_price, aes(y = avg_price), color = "Red", size = 1) +
  labs(title = "Stock performance of the four largest US banks, 2022-2023",
       x = "Date",
       y = "Stock Price ($)",
       color = "Banks") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))
