# Load Data if not already loaded
if(!exists("NEI")){
  NEI <- readRDS("summarySCC_PM25.rds")
  SCC <- readRDS("Source_Classification_Code.rds") 
  # Coerce "year-column" to factor
  NEI$year <- as.factor(NEI$year)
}

# Calculate total emissions per year
data_sub <- NEI[NEI$fips == "24510",]
data <- sapply(split(data_sub, data_sub$year), function(x) sum(x["Emissions"]))

# create x and y data to be plotted
x <- as.numeric(names(data))
y <- as.numeric(data)


## Open Graphics device
png("plot2.png", width=480, height=480)

# Plot data points
barplot(height=y,
        names.arg=x,
        xlab = "Year",
        ylab = "Emission (tons)",
        main = "Total PM2.5 emission in Baltimore City, Maryland",
        col = "red")


# Turn Off the Graphics Device
dev.off()
print("Plot 2 was created with success!!!")