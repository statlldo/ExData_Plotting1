plot2<- function ()   {
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
  #correct time format
  
  #dataset$DayAndTime<- paste(dataset$Date, dataset$TIme)
 
  #dataset$DayAndTime <- strftime(dataset$DayAndTime, format = "%d/%m/%Y %H:%M:%S")
  
  #subset on date rangedayan
  newdata<-dataset[dataset$Date=="2007-02-01" | dataset$Date== "2007-02-02",]
  #debug
  #head(paste(newdata$Date, newdata$Time, sep=" "))
  
  #create day and time variable in seconds since start of time format
  newdata$DayAndTime<- as.POSIXct(paste(newdata$Date, newdata$Time, sep=" "), template = "%e/%m/%Y %H:%M:%S", tz = Sys.timezone())
  
  #debugging          head(dataset)
  #open the device 
  png("plot2.png", width = 480, height = 480, units = "px")
  plot(x=newdata$DayAndTime, y= newdata$Global_active_power,  type= "l",xlab = "", ylab = "Global active power (kilowatts)")
  #close it off
  dev.off(dev.cur())
}