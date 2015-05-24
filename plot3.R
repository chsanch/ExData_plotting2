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

# get Baltimore City data
dataBC <- subset(NEI, fips=='24510')
# get plot data
BCByTypeYear <- aggregate(dataBC[c('Emissions')], list(Type = dataBC$type, Year = dataBC$year), sum)
# create plot object
png('plot3.png', width=480, height=480)
# create plot
ggplot(BCByTypeYear, aes(x=Year, y=Emissions, colour=Type)) +
    geom_point(alpha=.3) +
    geom_smooth(alpha=.2, size=1, method="loess") +
    ggtitle("Total Emissions by Type in Baltimore City")
# closing plot file
dev.off()


