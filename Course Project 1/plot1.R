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

# CREATE PLOT 1
## Open Graphics device
png("plot1.png", width=480, height=480)

## Create the histogram and set the attributes
hist(dataSet$Global_active_power,
     col="red",
     main="Global Active Power",
     xlab="Global Active Power (kilowatts)",
     ylab="Frequency")

## Turn Off the Graphics Device
dev.off()
print("Plot 1 was created with success!!!")




 