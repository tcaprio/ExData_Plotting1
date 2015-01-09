## read data into R, initializing Date/Time as character (all others numeric)
data <- read.table("C:/Users/tcaprio/Documents/R/household_power_consumption.txt",
                   na.strings="?", sep=";", header=TRUE,
                   colClasses=c("character", "character", "numeric","numeric",
                                "numeric", "numeric", "numeric", "numeric",
                                "numeric"))

## convert Date column to date format
data$Date <- as.Date(data$Date, format="%d/%m/%Y")


## subset data by Date == 2007-02-01 or 2007-02-02
data2 <- subset(data, Date=="2007-02-01" | Date=="2007-02-02")

## create histogram plot
png(filename="plot1.png", width=480, height=480)
x <- data2$Global_active_power
par(mar=c(5, 4, 3, 2), mfrow=c(1,1))
hist(x, col="red", main="Global Active Power", 
     xlab="Global Active Power (kilowatts)", ylim=c(0, 1200))
dev.off()
