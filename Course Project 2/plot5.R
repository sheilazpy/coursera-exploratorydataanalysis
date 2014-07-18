# Load Data if not already loaded
if( !exists("NEI") ){
    NEI <- readRDS("summarySCC_PM25.rds")
    SCC <- readRDS("Source_Classification_Code.rds") 
}

# Subset Baltimore Motorvehicle Consumption
data <- NEI[(NEI$fips == "24510") & (NEI$type == "ON-ROAD"),]

# Create the plot
library(ggplot2)
png(filename="plot5.png", height = 480, width = 480)

g <- ggplot(data, aes(x=factor(year), y=Emissions, fill=type)) 
g <- g + stat_summary(fun.y="sum", geom="bar")
g <- g + ggtitle(expression('Motor Vehicle PM'[2.5]*' Emission in Baltimore'))
g <- g + xlab("Year") + ylab("Emission")
print(g) 
dev.off()
print("Plot 5 was created with success!!!")