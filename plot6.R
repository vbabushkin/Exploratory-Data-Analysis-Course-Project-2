NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
library(ggplot2)

motorData <- NEI[NEI$SCC %in% SCC[grep("Mobile", SCC$EI.Sector), 1], ]
motorDataBaltimore<-motorData[motorData$fips == "24510",]
#motor data for LA works only if 06037 is in quotes...
motorDataLA<-motorData[motorData$fips == "06037",]

newBMData<-aggregate(motorDataBaltimore$Emissions, list(motorDataBaltimore$year), sum)
newLAData<-aggregate(motorDataLA$Emissions, list(motorDataLA$year), sum)
newBMData<-cbind(newBMData,"Baltimore")
newLAData<-cbind(newLAData,"Los-Angeles")

names(newBMData)[1]="Year"
names(newBMData)[2]="Emissions"
names(newBMData)[3]="Cities"

names(newLAData)[1]="Year"
names(newLAData)[2]="Emissions"
names(newLAData)[3]="Cities"

df<- rbind(newBMData,newLAData)
ggplot(df, aes(newBMData$Year)) + geom_line(aes(y=newBMData$Emissions), colour="red")+geom_line(aes(y=newLAData$Emissions), colour="green")  

plt <- ggplot(df, aes(x = Year, y = Emissions, fill = Cities))
plt + geom_bar(stat = "identity", position = position_dodge()) + xlim(1997, 2010)


plotData<- merge(newData, SCC[, c(1, 4)], by.x = "SCC", by.y = "SCC")[, c(4, 6, 7)]

#comment if aircrafts and ships are considered as motor vehicles
plotData <- plotData[which((plotData$EI.Sector !="Mobile - Aircraft" )&(plotData$EI.Sector != "Mobile - Commercial Marine Vessels")), ]

png('plot5.png',width=1440,height=480)
qplot(plotData$year,plotData$Emissions,xlab="Year",ylab="PM2.5 Emissions(tonns)", main="Emissions by Different Types of Sources from Motor Vehicles in Baltimore City", data=plotData,facets=.~ EI.Sector)+ geom_smooth(method = "lm")
dev.off()