## DEPENDENCIES: sqldf
## EFF: read household_power_consumption.txt from current dir,
##      create time plots of global active power, 3 energy sub-meterings,
##		voltage, and global reactive power, and
##      output it as plot4.png

library(sqldf)
Sys.setlocale(category = "LC_TIME", locale = "C")
household <- read.csv2.sql("household_power_consumption.txt",
        "SELECT * FROM file WHERE Date = '1/2/2007' OR Date = '2/2/2007'",
        na.strings = "?")
date_time <- paste(household$Date, household$Time, sep = "/")
date_time <- strptime(date_time, "%d/%m/%Y/%H:%M:%S")
household$Date_time <- date_time


par(mfcol = c(2, 2))
## [1, 1] plot
with(household, plot(Date_time, Global_active_power, type = "l",
        xlab = "", ylab = "Global Active Power"))

## [2, 1] plot
par(yaxp = c(0, 40, 3))
with(household, plot(Date_time, Sub_metering_1, type = "l", 
	xlab = "", ylab = "Energy sub metering"))
lines(household$Date_time, household$Sub_metering_2, col = "red")
lines(household$Date_time, household$Sub_metering_3, col = "blue")
legend("topright", pch = NA, lwd = 1, box.lwd = 0, 
	col = c("black", "red", "blue"), 
	legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3")) 

## plot[1, 2] and plot[2, 2]
with(household, {
	plot(Date_time, Voltage, type = "l", xlab = "datetime")
	plot(Date_time, Global_reactive_power, type = "l", xlab = "datetime")
	})

dev.copy(png, "plot4.png")
dev.off()

