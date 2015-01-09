## read data into R, initializing Date/Time as character (all others numeric)
data <- read.table("C:/Users/tcaprio/Documents/R/household_power_consumption.txt",
                   na.strings="?", sep=";", header=TRUE,
                   colClasses=c("character", "character", "numeric","numeric",
                                "numeric", "numeric", "numeric", "numeric",
                                "numeric"))

## create copy of initial dataset and convert Date and Time columns to Date, 
## POSIXlt format
data2 <- data
data2$DateTime <- paste(data2$Date, data2$Time)
data2$DateTime <- strptime(data2$DateTime, format="%d/%m/%Y %H:%M:%S")

## convert Date to Date format and subset data by Date == 2007-02-01 or 
## 2007-02-02
data2$Date <- as.Date(data2$Date, format="%d/%m/%Y")
data2 <- subset(data2, Date=="2007-02-01" | Date=="2007-02-02")

## plot dateTime on x and energy sub metering 1-3 on y with legend
png(filename="plot3.png", width=480, height=480)
x <- data2$DateTime
y1 <- data2$Sub_metering_1
y2 <- data2$Sub_metering_2
y3 <- data2$Sub_metering_3

plot(x,y1, ylab="Energy sub metering", xlab="", type="l")
lines(x,y2, col="red")
lines(x,y3, col="blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       col=c("black", "red", "blue"), lty=1 )
dev.off()

