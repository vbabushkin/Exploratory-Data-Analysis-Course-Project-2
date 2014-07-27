
NEI <- readRDS("summarySCC_PM25.rds")
library(ggplot2)
png('plot3.png',width=720,height=480)
qplot(NEI$year,NEI$Emissions,xlab="Year",ylab="PM2.5 Emissions (tonns)", main="Emissions by Different Types of Sources", data=NEI,facets=.~type)+ geom_smooth(method = "lm")
dev.off()
