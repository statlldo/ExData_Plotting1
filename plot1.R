plot1<- function ()   {
  #download data from web
  download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", destfile="HHdata.zip", method="curl")
  #unzip it
  unzip ("HHdata.zip")
  #read it into an object in R
  dataset<- read.table("household_power_consumption.txt", header = TRUE, sep = ";", na.strings = c("?", ""))
  #check it's OK
  
  #correct date format
  dataset$Date<-as.Date(dataset$Date, "%e/%m/%Y" )
  #correct time format
  dataset$Time<-strptime(dataset$Time, format = "%H:%M:%S")
  #subset on date range
  newdata<-dataset[dataset$Date=="2007-02-01" | dataset$Date== "2007-02-02",]
                  head(dataset)
  #open the device 
  png("plot1.png", width = 480, height = 480, units = "px")
  hist(newdata$Global_active_power, col="red", main = "Global Active Power", xlab = "Global active power (kilowatts)")
  #close it off
  dev.off(dev.cur())
}