charts(){
  
  setwd("D:/2016/Pers/Learning/Course 4 - Exploratory Data Analysis/Week 1 project")

  house_power<-read.table("household_power_consumption.txt", sep = ";", header = TRUE)
  # transorm the date using as.Date()
  house_power_date<-transform(house_power, Date= as.Date(Date,"%d/%m/%Y"))

  #subset the data for the below dates
  house_2days_power<-subset(house_power_date, house_power_date$Date>=as.Date("2007-02-01") & house_power_date$Date<=as.Date("2007-02-02"))

  # create a new column merging date and time information
  house_2days_power$DateTime<-paste(house_2days_power$Date,house_2days_power$Time)

  # remove the na values
  house_2days_power<-house_2days_power[complete.cases(house_2days_power),]

  # convert datetime column into a time class using POSIT function
  house_2days_power$DateTime<-as.POSIXct(house_2days_power$DateTime)

  # convert few of the columns to numeric type  
  house_2days_power$Global_active_power<-as.numeric(as.character(house_2days_power$Global_active_power))
  house_2days_power$Global_reactive_power<-as.numeric(as.character(house_2days_power$Global_reactive_power))
  house_2days_power$Voltage<-as.numeric(as.character(house_2days_power$Voltage))
  house_2days_power$Sub_metering_1<-as.numeric(as.character(house_2days_power$Sub_metering_1))
  house_2days_power$Sub_metering_2<-as.numeric(as.character(house_2days_power$Sub_metering_2))
  house_2days_power$Sub_metering_3<-as.numeric(as.character(house_2days_power$Sub_metering_3))

  #Plot 4
  par(mar = c(4, 4, 2, 2))
  par(mfrow = c(2,2))

  with(house_2days_power, plot(DateTime, Global_active_power, type = "n", xlab="", ylab = "Global Active Power (kilowatts)"))
  axis(1, at=c(as.numeric(min(house_2days_power$DateTime)), as.numeric(min(house_2days_power$DateTime))+86400, as.numeric(min(house_2days_power$DateTime))+2*86400), labels=c("Thu", "Fri", "Sat"))
  with(house_2days_power, points(DateTime, Global_active_power, type = "l"))  
  
  with(house_2days_power, plot(DateTime, Voltage, xlab = "datetime", ylab = "Voltage", type = "l"))
  
  with(house_2days_power, plot(DateTime, Sub_metering_1, xlab = "",ylab = "Energy sub metering", type = "n"))
  with(house_2days_power, points(DateTime, Sub_metering_1, type = "l"))
  with(house_2days_power, points(DateTime, Sub_metering_2, type = "l", col = "red"))  
  with(house_2days_power, points(DateTime, Sub_metering_3, type = "l", col = "blue"))
  legend("topright", cex=0.75, bty = "n",col=c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty = 1, lwd = 2)

  with(house_2days_power, plot(DateTime, Global_reactive_power, xlab = "datetime", type = "l")) 
  dev.copy(png, file = "Plot4.png")
  dev.off()

}