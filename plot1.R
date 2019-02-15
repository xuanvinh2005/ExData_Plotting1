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

## Plot 1
hist(data$Global_active_power, main="Global Active Power", xlab="Global Active Power (kilowatts)", ylab="Frequency", col="Red", cex.sub=0.8)

## export file
dev.copy(png, file="plot1.png", height=480, width=480)
dev.off()