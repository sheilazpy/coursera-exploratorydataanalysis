## For this script to work, make sure the file named 
## "household_power_consumption.txt" finds itself inside your working directory.

## Load data into the dataSet object, but only if not already done so!!!
if (!exists("dataSet")){
        
        # Load the entire data file into the dataSet variable
        print("Reading the data into the dataSet object. Patience, please...!!!")
        fileName <- "household_power_consumption.txt"
        dataSet <- read.table(	fileName, 
                               sep=";", 
                               header=TRUE,
                               colClasses=c(rep("character",2), rep("numeric",7)),
                               na="?")
        
        # convert date and time variables to Date/Time class
        dataSet$Time <- strptime(paste(dataSet$Date,  dataSet$Time), "%d/%m/%Y %H:%M:%S")
        dataSet$Date <- as.Date( dataSet$Date, "%d/%m/%Y")
        
        # subset the dataSet
        dates <- as.Date(c("2007-02-01", "2007-02-02"), "%Y-%m-%d")
        dataSet <- subset(dataSet, dataSet$Date %in% dates)
        
}

# CREATE PLOT 4
## Open Graphics device
png("plot4.png", width=480, height=480)

### Define 2x2 plot grid
par(mfrow=c(2,2))

### Add plot 1
plot(dataSet$Time, dataSet$Global_active_power,
     xlab="",
     ylab="Global Active Power",
     type="l")

### Add plot 2
plot(dataSet$Time, dataSet$Voltage,
     xlab="datetime",
     ylab="Voltage",
     type="l")


### Add plot 3
plot(dataSet$Time, dataSet$Sub_metering_1,
     col="black",
     xlab="",
     ylab="Energy sub metering",
     type="l")
lines(dataSet$Time,dataSet$Sub_metering_2, col="red")
lines(dataSet$Time,dataSet$Sub_metering_3, col="blue")
legend("topright",
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       col=c("black", "red", "blue"),
       lty=1,
       bty="n")

### Add plot 4
plot(dataSet$Time, dataSet$Global_reactive_power,
     xlab="datetime",
     ylab="Global_reactive_power",
     type="l")


## Turn Off the Graphics Device
dev.off()
print("Plot 4 was created with success!!!")