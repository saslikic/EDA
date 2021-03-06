alldata <- read.csv("household_power_consumption.txt", header=T, sep=';', na.strings="?",
                    nrows=2075259, check.names=F, stringsAsFactors=F, comment.char="", 
                    quote='\"')
alldata$Date <- as.Date(alldata$Date, format="%d/%m/%Y")

dio <- subset(alldata, subset=(Date >= "2007-02-01" & Date <= "2007-02-02"))
rm(alldata)

datvri <- paste(as.Date(dio$Date), dio$Time)
dio$datvri <- as.POSIXct(datvri)

with(dio, {
  plot(Sub_metering_1~datvri, type="l",
       ylab="Energy sub metering", xlab="")
  lines(Sub_metering_2~datvri,col='red')
  lines(Sub_metering_3~datvri,col='blue')
})
legend(cex=0.6, "topright", col=c("black", "red", "blue"), lty=1, lwd=2, 
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

dev.copy(png, file="plot3.png", height=480, width=480)
dev.off()