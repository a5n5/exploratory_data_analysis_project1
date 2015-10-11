#set libraries
library(datasets)
library(graphics)
library(grDevices)
library(lattice)
library(grid)

#Set working directory. Download the data file and unzip it.
setwd("~/Documents/Data Science/RCodes/mo4/week1/plotting_assign_mo4we1")
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",
              destfile="power.zip",method="curl")
unzip("power.zip")


#read the data file and subset it
data <-read.table("household_power_consumption.txt",header = TRUE,sep=";",stringsAsFactors=FALSE, dec=".")
df<-data[data$Date %in% c("1/2/2007","2/2/2007"),]
#str(data)
#convert date & time
#data$Date<-as.Date(data$Date,'%Y-%M-%D')
datetime <- strptime(paste(df$Date, df$Time, sep=" "), "%d/%m/%Y %H:%M:%S") 

#create PNG in working directory
png(filename ="plot3.png",width = 480,height = 480) 

#create the plot
df$Global_active_power<-as.numeric(df$Global_active_power)
subMetering1 <- as.numeric(df$Sub_metering_1)
subMetering2 <- as.numeric(df$Sub_metering_2)
subMetering3 <- as.numeric(df$Sub_metering_3)

plot(datetime,subMetering1,type="l",xlab="",ylab="Global Active Power (kilowatts)")
lines(datetime,subMetering2,type="l",col="red")
lines(datetime,subMetering3,type="l",col="blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=1, lwd=2.5, col=c("black", "red", "blue"))
#close the PNG
dev.off() 