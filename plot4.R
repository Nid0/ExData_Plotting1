## Reading dataset from .txt file.
dataset <- read.csv("~/downloads/household_power_consumption.txt", header= TRUE, sep =";", 
                    na.strings="?" ,nrows= 2075259, check.names=F, stringsAsFactors=F, comment.char="", quote='\"')

## Defining date format.
dataset$Date <- as.Date(dataset$Date, format="%d/%m/%Y")

## Subsitting data to the data between the dates 2007-02-01 and 2007-02-02.
data <- subset(dataset, subset=(Date >= "2007-02-01" & Date <= "2007-02-02"))
rm(dataset)

## Converting date. 
datetime <- paste(as.Date(data$Date), data$Time)
data$datetime <- as.POSIXct(datetime)

## Plotting:
par(mfrow=c(2,2), mar=c(4,4,2,1), oma=c(0,0,2,0))
with(data, {
## topleft plot.
plot(data$Global_active_power~data$Datetime, type="l",
     xlab="", ylab="Global Active Power (kilowatts)")

## topright plot.
plot(data$Voltage~data$Datetime, type="l",
     xlab="datetime", ylab="Voltage")

## bottomleft plot.
plot(data$Sub_metering_1~data$Datetime, type="l",
     xlab="", ylab="Energy sub metering", col="black")
lines(data$Sub_metering_2~data$Datetime, col="red")
lines(data$Sub_metering_3~data$Datetime, col="blue")

legend("topright", bty="n", fill = 1:6, ncol=1, cex=0.75, lwd=1, lty=1,
       legend=c('Sub_metering_1', 'Sub_metering_2', 'Sub_metering_3'), 
       col=c('black', 'red', 'blue'))

## bottomright plot.
plot(data$Global_reactive_power~data$Datetime, type="l",
     xlab="datetime", ylab="Global_reactive_power")
})
## Saving the plot to a .png file.
dev.copy(png, file="~/documents/ExData_Plotting1/plot4.png", height=480, width=480)
dev.off()
