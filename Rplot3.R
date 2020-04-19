#load packages 
library(data.table)
library(pryr)
library(lubridate)
#download and unzip files
url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(url, file.path("dataFiles.zip"))
unzip(zipfile = "dataFiles.zip")
dt<-data.table::fread("household_power_consumption.txt")

#caculate memory required
object_size(dt)

#convert date to Date fromat
dt$Date<-as.Date(dt$Date,"%d/%m/%Y")
date1 <- as.Date("2007-02-01")
date2 <- as.Date("2007-02-02")

int <- interval(date1, date2)
dt<-dt[Date %within% int]
table(dt$Date)
#convert character type variable into numeric type
str(dt)
dt$Sub_metering_1<-as.numeric(dt$Sub_metering_1)
dt$Sub_metering_2<-as.numeric(dt$Sub_metering_2)
dt$Sub_metering_3<-as.numeric(dt$Sub_metering_3)
#create Rplot3
Time<-paste(dt$Date,dt$Time)
Time<-strptime(Time,"%Y-%m-%d %H:%M:%S")
png(filename="Rplot3.png")
plot(Time,dt$Sub_metering_1,type="l",xlab = NA,ylab="Energy sub metering")
lines(Time,dt$Sub_metering_2,col="red")
lines(Time,dt$Sub_metering_3,col="blue")
legend(x="topright",legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),col=c("black","blue","red"),lty = c(1,1,1))
dev.off()
