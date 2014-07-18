# Load Data if not already loaded
if( !exists("NEI") ){
  NEI <- readRDS("summarySCC_PM25.rds")
  SCC <- readRDS("Source_Classification_Code.rds") 
  # Coerce "year-column" to factor
  NEI$year <- as.factor(NEI$year)
}

# Subset data from Baltimore
data_sub <- NEI[NEI$fips == "24510",]

# Create the plot
library(ggplot2)
png(filename="plot3.png", height = 400, width = 700)

g <- ggplot(data_sub, aes(x=year, y=Emissions, fill=type)) 
g <- g + facet_grid(. ~ type)
g <- g + stat_summary(fun.y="sum", geom="bar")
g <- g + ggtitle("Yearly emission of PM2.5 in Baltimore for all source types")
print(g) 
dev.off()
print("Plot 3 was created with success!!!")