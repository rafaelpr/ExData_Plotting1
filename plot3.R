create_plot3 <- function() {
  
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
  png(filename = "plot3.png", width = 480, height = 480)
  plot(dt$Sub_metering_1 ~ dt$DateTime, type = "l", xlab = "", ylab = "Energy sub metering")
  lines(dt$Sub_metering_2 ~ dt$DateTime, col = "red")
  lines(dt$Sub_metering_3 ~ dt$DateTime, col = "blue")
  legend("topright", col = c("black", "red", "blue"), lwd = c(1,1,1), c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
  dev.off()
}

