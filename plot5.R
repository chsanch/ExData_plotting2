# Load script to get data
source("getData.R")
# check if the package ggplot2 is installed
a<-installed.packages()
packages<-a[,1]
if (is.element("ggplot2", packages) == FALSE) {
    install.packages("ggplot2")
}
# load library ggplot2
library('ggplot2')
# get data
NEI <- loadNEI()
SCCdata <- loadSCC()
# create plot data
vehData <- grep("vehicle",SCCdata$EI.Sector,value=T,ignore.case=T)
SCCdata.vehData <- subset(SCCdata, SCCdata$EI.Sector %in% vehData, select=SCC)
BC <- subset(NEI, fips == "24510")
NEI.vehData <- subset(BC, BC$SCC %in%  SCCdata.vehData$SCC)
plotData <- aggregate(NEI.vehData[c("Emissions")], list(year = NEI.vehData$year), sum)


#  Create Plot object
png('plot5.png', width=480, height=480)
# create plot
plot(plotData$year, plotData$Emissions, type = "l", 
     main = "Total Emissions of motor vehicles in Baltimore City",
     xlab = "Year", ylab = "Emissions")
# closing plot file
dev.off()
