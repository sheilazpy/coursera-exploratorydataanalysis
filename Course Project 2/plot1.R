# Load Data if not already loaded
if(!exists("NEI")){
    NEI <- readRDS("summarySCC_PM25.rds")
    SCC <- readRDS("Source_Classification_Code.rds") 
}

# Calculate total emission in US per year
data <- sapply(split(NEI, NEI$year), function(x) sum(x["Emissions"]))

## Open Graphics device
png("plot1.png", width=480, height=480)

# Plot Data
barplot(height=as.numeric(data), 
        names.arg=as.numeric(names(data)),
        xlab = "Year", 
        ylab = "Emission", 
        main = expression('PM'[2.5]*' Emission in US'),
        col = "green")

# Turn Off the Graphics Device
dev.off()
