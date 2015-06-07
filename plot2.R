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
png(filename = "plot2.png", width = 480, height = 480)

# Plot
plot(x, data$Global_active_power, xlab="", ylab = "Global Active Power (kilowats)", type = "l")

# Close graphic device
dev.off()