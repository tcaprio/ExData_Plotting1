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


#### create 4 plots 2x2 fill by row
png(filename="plot4.png", width=480, height=480)

par(mfrow=c(2,2), cex.lab=0.9, mgp=c(2.5,1,0))
x <- data2$DateTime #consistent x axis for all plots

## plot a
yA <- data2$Global_active_power

plot(x,yA, ylab="Global Active Power", xlab="", type="l")

## plot b
yB <- data2$Voltage

plot(x, yB, xlab="datetime", ylab="Voltage", type="l")


## plot c
yC1 <- data2$Sub_metering_1
yC2 <- data2$Sub_metering_2
yC3 <- data2$Sub_metering_3

plot(x,yC1, ylab="Energy sub metering", xlab="", type="l")
lines(x,yC2, col="red")
lines(x,yC3, col="blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       col=c("black", "red", "blue"), lty=1, bty="n", xjust=0, bg="transparent", box.col="transparent", cex=0.8)

## plot d
yD <- data2$Global_reactive_power

plot(x,yD, xlab="datetime", ylab="Global_reactive_power", type="l")

dev.off()

