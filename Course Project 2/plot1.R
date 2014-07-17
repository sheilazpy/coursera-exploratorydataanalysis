# Load Data if not already loaded
if(!exists("NEI")){
    NEI <- readRDS("summarySCC_PM25.rds")
    SCC <- readRDS("Source_Classification_Code.rds") 
    # Coerce "year-column" to factor
    NEI$year <- as.factor(NEI$year)
}

# Calculate total emissions per year
data <- sapply(split(NEI, NEI$year), function(x) sum(x["Emissions"]))

# create x and y data to be plotted
x <- as.numeric(names(data))
y <- as.numeric(data)


## Open Graphics device
png("plot1.png", width=480, height=480)

# Plot data points
plot(x,y,
     xlab = "Year",
     ylab = "Emission (tons)",
     main = "Total PM2.5 emission in US",
     type = "p",
     col = "red",
     bg = "red",
     pch = 24,
     cex = 3)

# Create a fit through the data
fit <-  lm(y ~ x)
abline(fit, lwd = 2)

legend("topright",
       legend=c("Emission Data Points", "Linear Fit"),
       col=c("red", "black"),
       lty=1)

# Turn Off the Graphics Device
dev.off()
print("Plot 1 was created with success!!!")