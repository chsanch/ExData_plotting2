# Load script to get data
source("getData.R")
# get data
NEI <- loadNEI()
# get plot data
emissionsByYear <- aggregate(NEI[c('Emissions')], list(Year = NEI$year), sum)
# Round data to display properly on plot
emissionsByYear$PM <- round(emissionsByYear$Emissions/1000,2)
# create plot object
png('plot1.png', width=480, height=480)
# create plot
plot(emissionsByYear$Year, emissionsByYear$PM, type = "l",
     main = "Total Emissions by year from PM2.5 in the US",
     xlab = "Year", ylab = "Emissions in Kilotons")
# closing plot file
dev.off()
