## Coursera, Exploratory Analysis: Course Project Assignment 1
## Name: plot2.R (Line graph - power by day)
## Author: John Shomaker
## Description: Constructs various plots to .PNG files from the
## Electric Power Consumption file

## Install packages

install.packages("data.table")
library(data.table)

## Download and read the ZIP file and subset for two days in 2007

filename <- "epc_file.zip"

if (!file.exists(filename)){
      fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
      download.file(fileURL, filename, method="curl")
}  
if (!file.exists("household_power_consumption.txt")) { 
      unzip(filename) 
}

options(max.print=9999999)
epc <- fread("household_power_consumption.txt", na.strings = "?")
epc <- subset(epc, Date == "1/2/2007" | Date == "2/2/2007")

## Convert the Date and Time colummns into actual Date/Time classes
## and clean up columns, moving new Date_Time to first column

epc$Date_Time <- with(epc, as.POSIXct(paste(epc$Date, epc$Time), format="%d/%m/%Y %H:%M:%S"))
epc <- subset(epc, select=c(10,3:9))

## plot2: Plot of Global Active Power(kilowatts) by date/time

png(filename="plot2.png", width = 480, height = 480, units = "px")

with(epc, plot(Date_Time, Global_active_power, type = "l", ylab = "Global Active Power (kilowatts", xlab = ""))

dev.off()

##
