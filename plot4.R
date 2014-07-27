NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
library(ggplot2)
coalData <- NEI[NEI$SCC %in% SCC[grep("Coal", SCC$EI.Sector), 1], ]
png('plot4.png',width=720,height=480)
qplot(coalData$year,coalData$Emissions,xlab="Year",ylab="PM2.5 Emissions(tonns)", main="Emissions by Different Types of Coal Related Sources", data=coalData,facets=.~type)+ geom_smooth(method = "lm")
dev.off()