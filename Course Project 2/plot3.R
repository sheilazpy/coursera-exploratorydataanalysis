# Load Data if not already loaded
if(!exists("NEI")){
    NEI <- readRDS("summarySCC_PM25.rds")
    SCC <- readRDS("Source_Classification_Code.rds") 
}

# Subset data from Baltimore
data <- NEI[NEI$fips == "24510",]

# Open Graphics device
library(ggplot2)
png(filename="plot3.png", height = 480, width = 750)

# Plot Data
g <- ggplot(data, aes(x=year, y=Emissions, fill=type)) 
g <- g + facet_grid(. ~ type)
g <- g + stat_summary(fun.y="sum", geom="bar")
g <- g + ggtitle(expression('PM'[2.5]*' Emission in Baltimore City per Source Type'))
g <- g + xlab("Year") + ylab("Emission")
print(g)

# Turn Off the Graphics Device
dev.off()
