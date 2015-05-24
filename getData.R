# function to load the data 
loadNEI <- function() {
    datanei <- readRDS("./data/summarySCC_PM25.rds")
    return(datanei)
}

loadSCC <- function() {
    datascc <- readRDS("./data/Source_Classification_Code.rds")
    return(datascc)
}