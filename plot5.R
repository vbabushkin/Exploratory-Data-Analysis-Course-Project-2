NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
library(ggplot2)

motorData <- NEI[NEI$SCC %in% SCC[grep("Mobile", SCC$EI.Sector), 1], ]
newData<-motorData[motorData$fips == 24510,]
plotData<- merge(newData, SCC[, c(1, 4)], by.x = "SCC", by.y = "SCC")[, c(4, 6, 7)]

#comment if aircrafts and ships are considered as motor vehicles
plotData <- plotData[which((plotData$EI.Sector !="Mobile - Aircraft" )&(plotData$EI.Sector != "Mobile - Commercial Marine Vessels")), ]

png('plot5.png',width=1440,height=480)
qplot(plotData$year,plotData$Emissions,xlab="Year",ylab="PM2.5 Emissions(tonns)", main="Emissions by Different Types of Sources from Motor Vehicles in Baltimore City", data=plotData,facets=.~ EI.Sector)+ geom_smooth(method = "lm")
dev.off()