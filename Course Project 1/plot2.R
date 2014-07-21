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

# CREATE PLOT 2
## Open Graphics device
png("plot2.png", width=480, height=480)

## Create the plot and set the attributes
plot(dataSet$Time, dataSet$Global_active_power,
     xlab="",
     ylab="Global Active Power (kilowatts)",
     type="l")

## Turn Off the Graphics Device
dev.off()
print("Plot 2 was created with success!!!")