# Load Data if not already loaded
if(!exists("NEI")){
    NEI <- readRDS("summarySCC_PM25.rds")
    SCC <- readRDS("Source_Classification_Code.rds") 
}

# Determine SCCs that contain Coal-components
entriesThatContainCoal <- grepl("Coal", SCC$EI.Sector)
selectedSCC <- SCC[entriesThatContainCoal,]

# Subset Emissions that contain "Coal"
coalNEI <- NEI[(NEI$SCC %in%  selectedSCC$SCC),]

# Calculate total Doal-emission in US per year
data <- sapply(split(coalNEI, coalNEI$year), function(x) sum(x["Emissions"]))

## Open Graphics device
png("plot4.png", width=480, height=480)

# Plot Data
barplot(names.arg=as.numeric(names(data)), 
        height=as.numeric(data), 
        xlab = "Year", 
        ylab = "Emission", 
        main = expression('Coal-based PM'[2.5]*' Emission in US'),
        col="blue",
        ylim=c(0,600000))

# Turn Off the Graphics Device
dev.off()
