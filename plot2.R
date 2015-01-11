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

## Plotting: Plot2.
plot(data$Global_active_power~data$Datetime, type="l",
     xlab="", ylab="Global Active Power (kilowatts)")

## Saving the plot to a .png file.
dev.copy(png, file="~/documents/ExData_Plotting1/plot2.png", height=480, width=480)
dev.off()
