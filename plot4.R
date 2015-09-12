alldata <- read.csv("household_power_consumption.txt", header=T, sep=';', na.strings="?",
                    nrows=2075259, check.names=F, stringsAsFactors=F, comment.char="", 
                    quote='\"')
alldata$Date <- as.Date(alldata$Date, format="%d/%m/%Y")

dio <- subset(alldata, subset=(Date >= "2007-02-01" & Date <= "2007-02-02"))
rm(alldata)

datvri <- paste(as.Date(dio$Date), dio$Time)
dio$datvri <- as.POSIXct(datvri)

par(mfrow=c(2,2), mar=c(4,4,2,1), oma=c(0,0,2,0))
with(dio, {
  plot(Global_active_power~datvri, type="l", 
       ylab="Global Active Power", xlab="")
  plot(Voltage~datvri, type="l", 
       ylab="Voltage", xlab="datetime")
  plot(Sub_metering_1~datvri, type="l", 
       ylab="Energy sub metering", xlab="")
  lines(Sub_metering_2~datvri,col='red')
  lines(Sub_metering_3~datvri,col='blue')
  legend(cex=0.6, "topright", col=c("black", "red", "blue"), lty=1, lwd=2, bty="n",
         legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
  plot(Global_reactive_power~datvri, type="l", 
       ylab="Global_reactive_power",xlab="datetime")
})

dev.copy(png, file="plot4.png", height=480, width=480)
dev.off()