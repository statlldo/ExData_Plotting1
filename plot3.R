plot3<- function ()   {
  library(plyr)
  #download data from web
  download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", destfile="HHdata.zip", method="curl")
  #unzip it
  unzip ("HHdata.zip")
  #read it into an object in R
  dataset<- read.table("household_power_consumption.txt", header = TRUE, sep = ";", na.strings = c("?", ""))
  #check it's OK
  
  #correct date format
  dataset$Date<-as.Date(dataset$Date, "%e/%m/%Y")
 
  #subset on date rangedayan
  newdata<-dataset[dataset$Date=="2007-02-01" | dataset$Date== "2007-02-02",]
  #debug
  #head(paste(newdata$Date, newdata$Time, sep=" "))
  
  #create day and time variable in seconds since start of time format
  newdata$DayAndTime<- as.POSIXct(paste(newdata$Date, newdata$Time, sep=" "), template = "%e/%m/%Y %H:%M:%S", tz = Sys.timezone())
  
  #debugging          head(dataset)
  #open the device 
  png("plot3.png", width = 480, height = 480, units = "px")
  #start with  blank canvas
  plot(x=newdata$DayAndTime, y= newdata$Sub_metering_1,  type= "n",xlab = "", ylab = "Energy sub metering")
  #add metering_1
  lines(x=newdata$DayAndTime, y= newdata$Sub_metering_1, type = "l", col="black")
  #add metering_2
  lines(x=newdata$DayAndTime, y= newdata$Sub_metering_2, type = "l", col="red")
  #add metering_3
  lines(x=newdata$DayAndTime, y= newdata$Sub_metering_3, type = "l", col="blue")
  #add legend
  legend("topright",  legend=c("sub_metering_1","sub_metering_2","sub_metering_3"),col=c("black", "red", "blue"), lty=1, lwd=1)
  #close it off
  dev.off(dev.cur())
}