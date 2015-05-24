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

#  Create Plot Data 
VEH <- grep("vehicle",SCCdata$EI.Sector,value=T,ignore.case=T)
SCCdata.VEH <- subset(SCCdata, SCCdata$EI.Sector %in% VEH, select=SCC)
# Data from Baltimore and Los Angeles
BC.LA <- subset(NEI, fips == "24510"|fips == "06037")
NEI.VEH <- subset(BC.LA, BC.LA$SCC %in%  SCCdata.VEH$SCC)
plotdata <- aggregate(NEI.VEH[c("Emissions")], list(fips = NEI.VEH$fips, year = NEI.VEH$year), sum)
plotdata$city <- rep(NA, nrow(plotdata))
plotdata[plotdata$fips == "06037", ][, "city"] <- "Los Angles County"
plotdata[plotdata$fips == "24510", ][, "city"] <- "Baltimore City"
#  Create Plot object
png('plot6.png', width=480, height=480)
# create plot
ggplot(plotdata, aes(x=year, y=Emissions, colour=city)) +
    geom_point(alpha=.3) +
    geom_smooth(alpha=.2, size=1, method="loess") +
    ggtitle("Vehicle Emissions in Baltimore vs. Los Angeles County")
# closing plot file
dev.off()
