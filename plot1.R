# The following two libraries are essential for the code to function properly. 
# Package "lubridate" might have to be installed : install.packages("lubridate")

library(data.table)
library(lubridate)

# The datafile should have been downloaded, variable "dataFile" below contains the (relative) reference 
# to the file in local filesystem

dataFile <- "./data/household_power_consumption.txt"

# The contents of the file are read and stored in "content". 
# The fread() function of the data.table library is used to only read
# the starting line and lines matching the patern corresponding 
# with date 1/2/2007 and 2/2/2007.
# Missing values or "?" values are considered NA.

content <- fread( input=paste("sed '1p;/^[12]\\/2\\/2007/!d'  ", dataFile), sep=";", header=TRUE, na.strings=c("?",""))

# The Date and Time columns are combined to make a POSIXct date, 
# the function dmy_hms() from lubridate library is used.
# The resulting date objects are stored in column "datetime".
 
content$datetime <- dmy_hms(paste(content$Date, content$Time, sep="-"))

png('./plot1.png',width=480,height=480,units="px",bg = "white")
par(mfrow=c(1,1))
hist(content$Global_active_power, col="red", xlab="Global Active Power (kilowatts)", main="Global Active Power")
dev.off()

###  PNG file created and saved at './plot1.png'
