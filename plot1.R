## DEPENDENCIES: sqldf
## EFF: read household_power_consumption.txt from current dir,  
##	create histogram of the frequencies of Global Active Power, and
##	output it as plot1.png

library(sqldf)
household <- read.csv2.sql("household_power_consumption.txt", 
	"SELECT * FROM file WHERE Date = '1/2/2007' OR Date = '2/2/2007'",
	na.strings = "?")
hist(household$Global_active_power, col = "red", main = "Global Active Power",
	xlab = "Global Active Power (kilowatts)")
dev.copy(png, file = "plot1.png")
dev.off()

