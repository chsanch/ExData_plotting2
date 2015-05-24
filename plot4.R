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

# Create Data
CC <- grep("coal",SCCdata$EI.Sector,value=T,ignore.case=T)
SCCdata.CC <- subset(SCCdata, SCCdata$EI.Sector %in% CC, select=SCC)
NEI.CC <- subset(NEI, NEI$SCC %in%  SCCdata.CC$SCC)
coalData <- aggregate(NEI.CC[c("Emissions")], list(Year = NEI.CC$year), sum)

# create plot object
png('plot4.png', width=480, height=480)
# create plot
ggplot(coalData, aes(x=Year, y=Emissions)) +
    geom_point(alpha=.3) +
    geom_smooth(alpha=.2, size=1) +
    ggtitle("Total PM2.5 Coal Combustion Emissions in the US")
# closing plot file
dev.off()
