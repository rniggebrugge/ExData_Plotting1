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
 
png('./plot3.png',width=480,height=480,units="px",bg = "white")
par(mfrow=c(1,1))
with(content, plot(datetime, Sub_metering_1, type="n", xlab="", ylab="Energy sub metering"))
with(content, lines(datetime, Sub_metering_1))
with(content, lines(datetime, Sub_metering_2, col="red"))
with(content, lines(datetime, Sub_metering_3, col="blue"))
legend("topright", legend=c("Sub metering 1","Sub metering 2","Sub metering 3"), col=c("black","red","blue"), lty=c(1,1,1), lwd=c(1,1,1))
dev.off()

### PNG created and stored at ./plot3.png
