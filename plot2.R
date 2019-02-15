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

#plot2
plot(data$Global_active_power~data$DateTime, type="l", ylab="Global Active Power (kilowatts)", xlab="")
dev.copy(png, file="plot2.png", height=480, width=480)
dev.off()