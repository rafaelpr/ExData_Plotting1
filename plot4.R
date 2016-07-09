create_plot4 <- function() {
  
  ##Download and unzip original data from the web, if it was not found in the working directory
  if (!file.exists("household_power_consumption.txt")) {
    download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", destfile = "dataset.zip")
    unzip(zipfile = "dataset.zip")
  }
  
  ##Read the file and subset
  library(data.table)
  dt <- fread("household_power_consumption.txt", na.strings="?")
  dt$Date <- as.Date(dt$Date, "%d/%m/%Y")
  dt <- dt[(dt$Date == "2007-02-01") | (dt$Date == "2007-02-02"), ]
  
  ##Create a DateTime columm
  dateTime <- paste(dt$Date, dt$Time)
  dt <- dt[ , (1:2):=NULL]
  dt <- cbind(as.POSIXct(dateTime), dt)
  colnames(dt)[1] <- "DateTime"

  ##Create and export the graph
  png(filename = "plot4.png", width = 480, height = 480)
  par(mfrow = c(2,2), mar = c(4,4,2,1), oma = c(0,0,2,0))
  with(dt, {
    plot(Global_active_power ~ DateTime, type = "l", 
         ylab = "Global Active Power", xlab = "")
    plot(Voltage ~ DateTime, type = "l", 
         ylab = "Voltage", xlab = "datetime")
    plot(Sub_metering_1 ~ DateTime, type = "l", 
         ylab = "Energy sub metering", xlab = "")
    lines(Sub_metering_2 ~ DateTime, col = "red")
    lines(Sub_metering_3 ~ DateTime, col = "blue")
    legend("topright", col = c("black", "red", "blue"), lty = 1, lwd = 2, bty = "n",
           legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
    plot(Global_reactive_power ~ DateTime, type = "l", 
         ylab = "Global_reactive_power", xlab = "datetime")
  })
  dev.off()
}

