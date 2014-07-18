# Load Data if not already loaded
if( !exists("NEI") ){
    NEI <- readRDS("summarySCC_PM25.rds")
    SCC <- readRDS("Source_Classification_Code.rds") 
}

# Subset data Baltimore and Los Angeles and substitute fips by county name
data <- NEI[((NEI$fips == "06037") | (NEI$fips == "24510")) & (NEI$type == "ON-ROAD"),]
data$fips[data$fips == "06037"] = "Los Angeles"
data$fips[data$fips == "24510"] = "Baltimore"
names(data)[1] = "County"

# Create the plot
library(ggplot2)
png(filename="plot6.png", height = 600, width = 600)

g <- ggplot(data, aes(x=factor(year), y=Emissions, fill=County)) 
g <- g + stat_summary(fun.y="sum", geom="bar")
g <- g + facet_grid(County ~ . , scales="free")
g <- g + ggtitle(expression('Motor Vehicle PM'[2.5]*' Emission in Baltimore & Los Angeles'))
g <- g + xlab("Year") + ylab("Emission")

print(g) 
dev.off()
print("Plot 6 was created with success!!!")
