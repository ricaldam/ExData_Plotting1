library(dplyr)
library(data.table)

# Download and uncompress data 
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileUrl, destfile = "compressed_data.zip", method = "curl")
unzip("compressed_data.zip")

# Create data.table with all data
dt <- fread("household_power_consumption.txt", na.strings = "?")

# Data to be analyzed
selection <- grep("^(1/2/2007)$|^(2/2/2007)$", dt$Date)
data <- dt[selection]

# Date and time in the rigth format
x <- with(data, strptime(paste(Date, Time), format="%d/%m/%Y %H:%M:%S"))

# Open graphic device
png(filename = "plot4.png", width = 480, height = 480)

# Parameters for displaying 2x2
par(mfrow = c(2,2))

# Plot in position (1,1)
plot(x, data$Global_active_power, xlab="", ylab = "Global Active Power (kilowats)", type = "l")

# Plot in position (1,2) 
plot(x, data$Voltage, xlab="datetime", type = "l")

# Plot in position (2,1)
plot(x, data$Sub_metering_1, xlab = "", ylab= "Energy sub metering", type = "l")
lines(x, data$Sub_metering_2, col = "red")
lines(x, data$Sub_metering_3, col = "blue")
legend("topright", 
       col = c("black", "red", "blue"),
       lty = 1,
       lwd = 2,
       bty = "n",
       legend = c("Sub_metering_1","Sub_metering_2", "Sub_metering_3"))

# Plot in position (2,2)
plot(x, data$Global_reactive_power, xlab="datetime", ylab = "Global_reactive_power", type = "l")

# Note: since my locale is French, instead of "Thu Fri Sat" we can read "Jeu Ven Sam"

# Close graphic device
dev.off()