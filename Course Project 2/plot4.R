# Load Data if not already loaded
if( !exists("NEI") ){
    NEI <- readRDS("summarySCC_PM25.rds")
    SCC <- readRDS("Source_Classification_Code.rds") 
}

# Determine which SCCs contain Coal-related components
entriesContainCoal <- grepl("Coal", SCC$EI.Sector)
containCoalSCC <- SCC[entriesContainCoal,]

# Subset Emissions that contain "Coal"
coalNEI <- NEI[(NEI$SCC %in%  containCoalSCC$SCC),]

# Calculate total emission (that contain Coal) in US per year
data <- sapply(split(coalNEI, coalNEI$year), function(x) sum(x["Emissions"]))

# create x and y data to be plotted
x <- as.numeric(names(data))
y <- as.numeric(data)

## Open Graphics device
png("plot4.png", width=480, height=480)

# Plot data points
barplot(names.arg=x, 
        height=y, 
        xlab = "Year", 
        ylab = "Emission", 
        main = expression('Coal-based PM'[2.5]*' Emission in US'),
        col="blue",
        ylim=c(0,600000))

# Turn Off the Graphics Device
dev.off()
print("Plot 4 was created with success!!!")