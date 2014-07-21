# Load Data if not already loaded
if(!exists("NEI")){
    NEI <- readRDS("summarySCC_PM25.rds")
    SCC <- readRDS("Source_Classification_Code.rds") 
}

# Subset data from Baltimore, and calculate the total emission
data_sub <- NEI[NEI$fips == "24510",]
data <- sapply(split(data_sub, data_sub$year), function(x) sum(x["Emissions"]))

## Open Graphics device
png("plot2.png", width=480, height=480)

# Plot Data
barplot(height=as.numeric(data),
        names.arg=as.numeric(names(data)),
        xlab = "Year",
        ylab = "Emission",
        main = expression('PM'[2.5]*' Emission in Baltimore City, MA'),
        col = "red")

# Turn Off the Graphics Device
dev.off()
