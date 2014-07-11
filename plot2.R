## DEPENDENCIES: sqldf
## EFF: read household_power_consumption.txt from current dir,
##      create time plot of Global Active Power (KW), and
##      output it as plot2.png

library(sqldf)
Sys.setlocale(category = "LC_TIME", locale = "C")
household <- read.csv2.sql("household_power_consumption.txt",
        "SELECT * FROM file WHERE Date = '1/2/2007' OR Date = '2/2/2007'",
        na.strings = "?")
date_time <- paste(household$Date, household$Time, sep = "/")
date_time <- strptime(date_time, "%d/%m/%Y/%H:%M:%S")
household$Date_time <- date_time

with(household, plot(Date_time, Global_active_power, type = "l", 
	xlab = "", ylab = "Global Active Power (kilowatts)"))
dev.copy(png, "plot2.png")
dev.off()

