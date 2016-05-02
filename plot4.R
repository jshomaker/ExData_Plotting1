## Coursera, Exploratory Analysis: Course Project Assignment 1
## Name: plot4.R Multiple graphs per page (2 x 2)
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

## plot4: Plot of 4 separate graphs on the screen/file (2 x 2)

png(filename="plot4.png", width = 480, height = 480, units = "px")

## Establish multi-graph configuration: 2 x 2, by rows

par(mfrow=c(2,2))

## Graph #1 (upper left)

with(epc, plot(Date_Time, Global_active_power, type = "l", ylab = "Global Active Power", xlab = ""))

## Graph #2 (upper right)

with(epc, plot(Date_Time, Voltage, type = "l", ylab = "Voltage", xlab = "datetime"))

## Graph #3 (lower-left)

with(epc, plot(epc$Date_Time, Sub_metering_1, type='n', 
      ylab = "Energy Sub-Metering", xlab = ""))
lines(epc$Date_Time, epc$Sub_metering_1, lty=1, col = "black")
lines(epc$Date_Time, epc$Sub_metering_2, lty=1, col = "red")
lines(epc$Date_Time, epc$Sub_metering_3, lty=1, col = "blue")
legend("topright", c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
      lty=c(1,1,1), col=c("black", "red", "blue"), bty = "o")

## Graph #4 (lower right)

with(epc, plot(Date_Time, Global_reactive_power, type = "l", ylab = "Global_reactive_power", xlab = "datetime"))

dev.off()

##
