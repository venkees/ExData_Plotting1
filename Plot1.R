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

  #plot 1
  hist(house_2days_power$Global_active_power,main = "Global Active Power", xlab = "Global Active Power (kilowatts)", col = "red")
  dev.copy(png, file = "Plot1.png")
  dev.off()

}