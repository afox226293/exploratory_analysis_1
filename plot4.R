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
data <- mutate(data, datetime = paste(data$Date, data$Time, sep = " ")) #Create extra date/time column
data$datetime <- ymd_hms(data$datetime) #Convert new column to dttm format

## Create fourth plot

## Set canvas / parameters
png("plot4.png", width = 480, height = 480, units = "px") #Open file device
par(mfrow = c(2, 2), bg = NA) #Set plot parameters

# Create 1/4
plot(data$datetime, data$Global_active_power, type = "l", pch = NA,
     xlab = "", ylab = "Global Active Power")
# Create 2/4
with(data, plot(datetime, Voltage, type = "l", pch = NA))
# Create 3/4
with(data, plot(x = datetime, y = Sub_metering_1, type = "l", pch = NA,
                xlab = "", ylab = "Energy sub metering")) #Create plot
with(data, points(x = datetime, y = Sub_metering_2, type = "l", pch = NA, col = "Red")) #Add points
with(data, points(x = datetime, y = Sub_metering_3, type = "l", pch = NA, col = "Blue")) #Add points
legend("topright", 
       lty = 1,
       col = c("Black", "Red", "Blue"),
       legend = colnames(data[7:9])
)
# Create 4/4
with(data, plot(datetime, Global_reactive_power, type = "l", pch = NA))

dev.off() #Close file device