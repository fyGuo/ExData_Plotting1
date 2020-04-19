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
dt$Global_active_power<-as.numeric(dt$Global_active_power)
#create Rplot1
png(filename="Rplot1.png")
hist(dt$Global_active_power,main="Global Active Power",col="red",xlab="Global Active Power (kilowatts)")
dev.off()
