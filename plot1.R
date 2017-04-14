library(tidyverse); library(data.table); library(lubridate)

## Download and unzip data file
url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
if(!file.exists("household_power_consumption.txt")){
download.file(url, destfile = "data.zip", method = "curl")
unzip("data.zip")
}

## Read into R
data <- fread("household_power_consumption.txt", na.strings = "?")

## Subset data from required date range
data$Date <- dmy(data$Date)
dates <- c("2007-02-01", "2007-02-02")
data <- filter(data, Date %in% as.Date(dates))
data <- as_tibble(data)

## Create first plot

png("plot1.png", width = 480, height = 480, units = "px") #Open file device
par(mfrow = c(1, 1), bg = NA) #Set plot parameters
hist(data$Global_active_power, col = "red", main = "Global Active Power",
     xlab = "Global Active Power (kilowatts)",
     ylab = "Frequency") #Create plot
dev.off() #Close file device


