# Load script to get data
source("getData.R")
# get data
NEI <- loadNEI()
# get Baltimore City data
dataBC <- subset(NEI, fips=='24510')
# get plot data
BCByYear <- aggregate(dataBC[c('Emissions')], list(Year = dataBC$year), sum)
# create plot object
png('plot2.png', width=480, height=480)
# create plot
plot(BCByYear$Year, BCByYear$Emissions, type = "l",
     main = "Total Emissions by year from PM2.5 in Baltimore City",
     xlab = "Year", ylab = "Emissions")
# closing plot file
dev.off()