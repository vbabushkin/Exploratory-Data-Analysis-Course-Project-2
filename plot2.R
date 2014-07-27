NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")


newNEI<-NEI[NEI$fips == 24510,]
newData<-aggregate(newNEI$Emissions, list(newNEI$year), sum)

#second plot
X<-newData$Group.1
Y<-newData$x
Years<-c("1999","2002","2005","2008")

plot(X,Y,type="b", xlab="Year", ylab="Total PM2.5 Emissions (tonns)",col = "red",main = " Total emissions from PM2.5 in the Baltimore City, Maryland ",xaxt='n')
axis(side = 1, at=X)

dev.copy(png, file="plot2.png",width=480,height=480)
dev.off()