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


## plot global active power on y and dateTime on x
png(filename="plot2.png", width=480, height=480)
x <- data2$DateTime
y <- data2$Global_active_power

plot(x,y, type="n")
plot(x,y, ylab="Global Active Power (Kilowatts)", xlab="", type="l")
dev.off()


