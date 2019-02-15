#Check to download
data_file <- "household_power_consumption.txt"
zip_file <- "data.zip"
if (!file.exists(data_file)) {
    download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", destfile = zip_file)
    unzip(zip_file)
    file.remove(zip_file)
}
#read data
data_full <- read.table(data_file, header=TRUE, na.strings="?", sep=";")

#sub data 2-day
data <- data_full[(data_full$Date=="1/2/2007" | data_full$Date=="2/2/2007" ), ]

#format date and time
data$Date <- as.Date(data$Date, format="%d/%m/%Y")
dateTime <- paste(data$Date, data$Time)
data$DateTime <- as.POSIXct(dateTime)

#plot4
par(mfrow=c(2,2), mar=c(4,4,2,1), oma=c(0,0,2,0))
with(data, {
    plot(Global_active_power~DateTime, type="l", 
         ylab="Global Active Power (kilowatts)", xlab="", cex=0.8)
    plot(Voltage~DateTime, type="l", 
         ylab="Voltage (volt)", xlab="", cex=0.8)
    plot(Sub_metering_1~DateTime, type="l", 
         ylab="Global Active Power (kilowatts)", xlab="", cex=0.8)
    lines(Sub_metering_2~DateTime,col='Red')
    lines(Sub_metering_3~DateTime,col='Blue')
    legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, bty="n",
           legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), cex=0.5)
    plot(Global_reactive_power~DateTime, type="l", 
         ylab="Global Rective Power (kilowatts)",xlab="", cex=0.8)
})
dev.copy(png, file="plot4.png", height=480, width=480)
dev.off()