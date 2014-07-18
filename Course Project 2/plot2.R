# Load Data if not already loaded
if(!exists("NEI")){
  NEI <- readRDS("summarySCC_PM25.rds")
  SCC <- readRDS("Source_Classification_Code.rds") 
  # Coerce "year-column" to factor
  NEI$year <- as.factor(NEI$year)
}

# Subset data from Baltimore, and calculate the total emission
data_sub <- NEI[NEI$fips == "24510",]
data <- sapply(split(data_sub, data_sub$year), function(x) sum(x["Emissions"]))

# create x and y data to be plotted
x <- as.numeric(names(data))
y <- as.numeric(data)

## Open Graphics device
png("plot2.png", width=480, height=480)

# Plot Data
barplot(height=y,
        names.arg=x,
        xlab = "Year",
        ylab = "Emission",
        main = expression('PM'[2.5]*' Emission in Baltimore City, MA'),
        col = "red")


# Turn Off the Graphics Device
dev.off()
print("Plot 2 was created with success!!!")