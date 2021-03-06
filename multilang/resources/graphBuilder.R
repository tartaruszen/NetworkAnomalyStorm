#CumulativeProbability on real data V1

library("ggplot2")
partA <- read.csv("~/Documents/WordCountStorm/pc005.csv")
partB <- read.csv("~/Documents/WordCountStorm/pc01.csv")
partC <- read.csv("~/Documents/WordCountStorm/pc025.csv")
partA$time <- as.POSIXlt(as.character(partA$Timestamp), format="%H:%M:%S")
partB$time <- as.POSIXlt(as.character(partB$Timestamp), format="%H:%M:%S")
partC$time <- as.POSIXlt(as.character(partC$Timestamp), format="%H:%M:%S")

#timestamp correction
partA$time <- partA$time - 9658161
partB$time <- partB$time - 9658161
partC$time <- partC$time - 9658161

ggplot(partA, aes(x = time, y = Chi-zth)) + 
  geom_line(aes(y = partA$Chi.th, colour = "Chi-zth pc=0.005")) + 
  geom_line(aes(y = partB$Chi.th, colour = "Chi-zth pc=0.01")) + 
  geom_line(aes(y = partC$Chi.th, colour = "Chi-zth pc=0.025")) + 
  geom_line(aes(y = partA$Dissimilarity, colour = "Dissimilarity")) +
  theme(legend.title=element_blank()) + 
  ggtitle("decay=0.25, replace=0.001, W=5, tick=60 seconds")


#Histogram
require(MASS)
dissimilarity <- partA$Dissimilarity
hist(dissimilarity, breaks=50, xlab="Dissimilarity", ylab="Frequency")

#chi-squared curve fit
chiFit <- fitdistr(dissimilarity, "chi-squared", start=list(df=0.03))
curve( dchisq(x, df=chiFit$estimate), col='red', add=TRUE)


#CumulativeProbability on real data V2

library("ggplot2")
partA <- read.csv("~/Documents/WordCountStorm/dataOutput/hadoop-cumProb20.csv")
partB <- read.csv("~/Documents/WordCountStorm/dataOutput/hadoop-cumProb10.csv")
partC <- read.csv("~/Documents/WordCountStorm/dataOutput/hadoop-cumProb05.csv")
partD <- read.csv("~/Documents/WordCountStorm/dataOutput/hadoop-cumProb025.csv")
partA$time <- as.POSIXlt(as.character(partA$Timestamp), format="%H:%M:%S")
partB$time <- as.POSIXlt(as.character(partB$Timestamp), format="%H:%M:%S")
partC$time <- as.POSIXlt(as.character(partC$Timestamp), format="%H:%M:%S")
partD$time <- as.POSIXlt(as.character(partD$Timestamp), format="%H:%M:%S")

#timestamp correction
partA$time <- partA$time - (1426442149 - 1425055320)
partB$time <- partB$time - (1426442149 - 1425055320)
partC$time <- partC$time - (1426442149 - 1425055320)
partD$time <- partD$time - (1426442149 - 1425055320)

ggplot(partC, aes(x = time, y = Threshold)) + 
  #geom_line(aes(y = partA$Threshold, colour = "Pc = 0.20")) + 
  #geom_line(aes(y = partB$Threshold, colour = "Pc = 0.10")) + 
  geom_line(aes(y = partC$Threshold, colour = "Threshold")) + 
  #geom_line(aes(y = partD$Threshold, colour = "Pc = 0.025")) + 
  geom_line(aes(y = partC$Dissimilarity, colour = "Dissimilarity"), linetype = "dashed") +
  geom_vline(xintercept = as.numeric(as.POSIXlt(as.character("2015-02-27 16:42:00 GMT"))), color = "green", linetype="dotted") + 
  geom_vline(xintercept = as.numeric(as.POSIXlt(as.character("2015-02-27 16:46:00 GMT"))), color = "red", linetype="dotted") + 
  geom_vline(xintercept = as.numeric(as.POSIXlt(as.character("2015-02-27 16:48:00 GMT"))), color = "green", linetype="dotted") + 
  geom_vline(xintercept = as.numeric(as.POSIXlt(as.character("2015-02-27 16:50:00 GMT"))), color = "red", linetype="dotted") + 
  geom_vline(xintercept = as.numeric(as.POSIXlt(as.character("2015-02-27 16:52:00 GMT"))), color = "green", linetype="dotted") + 
  geom_vline(xintercept = as.numeric(as.POSIXlt(as.character("2015-02-27 16:53:44 GMT"))), color = "red", linetype="dotted") + 
  geom_vline(xintercept = as.numeric(as.POSIXlt(as.character("2015-02-27 16:57:00 GMT"))), color = "green", linetype="dotted") + 
  theme(legend.title=element_blank()) + 
  ggtitle("Hadoop Threshold & Dissimilarity\nvariables: decay = 1, window=6, replace threshold = 1, tick = 20, Pc = 0.05")

ggplot(partC, aes(x = time, y = Threshold, colour = Anomaly)) +
  geom_line(aes(y = partC$Dissimilarity, colour = "Dissimilarity"), linetype = "dashed", color = "violet") +
  geom_point() +
  geom_vline(xintercept = as.numeric(as.POSIXlt(as.character("2015-02-27 16:42:00 GMT"))), color = "green", linetype="dotted") + 
  geom_vline(xintercept = as.numeric(as.POSIXlt(as.character("2015-02-27 16:46:00 GMT"))), color = "red", linetype="dotted") + 
  geom_vline(xintercept = as.numeric(as.POSIXlt(as.character("2015-02-27 16:48:00 GMT"))), color = "green", linetype="dotted") + 
  geom_vline(xintercept = as.numeric(as.POSIXlt(as.character("2015-02-27 16:50:00 GMT"))), color = "red", linetype="dotted") + 
  geom_vline(xintercept = as.numeric(as.POSIXlt(as.character("2015-02-27 16:52:00 GMT"))), color = "green", linetype="dotted") + 
  geom_vline(xintercept = as.numeric(as.POSIXlt(as.character("2015-02-27 16:53:44 GMT"))), color = "red", linetype="dotted") + 
  geom_vline(xintercept = as.numeric(as.POSIXlt(as.character("2015-02-27 16:57:00 GMT"))), color = "green", linetype="dotted") + 
  ggtitle("Anomalies and Thresholds Over Time\nvariables: decay = 100%, window= 2min, replace threshold = 1, tick = 20s, Pc = 0.05")


#Histogram
require(MASS)
dissimilarity <- partA$Dissimilarity
hist(dissimilarity, breaks=50, xlab="Dissimilarity", ylab="Frequency", main="Distribution of Dissimilarity")
  

#chi-squared curve fit
chiFit <- fitdistr(dissimilarity, "chi-squared", start=list(df=0.03))
curve( dchisq(x, df=chiFit$estimate), col='red', add=TRUE)


##WINDOW LIVE

library("ggplot2")
partA <- read.csv("~/Documents/WordCountStorm/dataOutput/hadoop-W12.csv")
partB <- read.csv("~/Documents/WordCountStorm/dataOutput/hadoop-W9.csv")
partC <- read.csv("~/Documents/WordCountStorm/dataOutput/hadoop-W6.csv")
partD <- read.csv("~/Documents/WordCountStorm/dataOutput/hadoop-W3.csv")
partA$time <- as.POSIXlt(as.character(partA$Timestamp), format="%H:%M:%S")
partB$time <- as.POSIXlt(as.character(partB$Timestamp), format="%H:%M:%S")
partC$time <- as.POSIXlt(as.character(partC$Timestamp), format="%H:%M:%S")
partD$time <- as.POSIXlt(as.character(partD$Timestamp), format="%H:%M:%S")

#timestamp correction // not needed during testing
partA$time <- partA$time - (1426457348 - 1425055320)
partB$time <- partB$time - (1426457288 - 1425055320)
partC$time <- partC$time - (1426457228 - 1425055320) 
partD$time <- partD$time - (1426457168 - 1425055320) 

partA$var <- "W=12" 
partB$var <- "W=9"
partC$var <- "W=6" 
partD$var <- "W=3" #1 minute
#df = rbind(partD)
#df = rbind(partA, partB, partC)
df = rbind(partA, partB, partC, partD)
ggplot(df, aes(x = time, y = Threshold, color = var)) + 
  geom_line() + 
  geom_vline(xintercept = as.numeric(as.POSIXlt(as.character("2015-02-27 16:42:00 GMT"))), color = "green", linetype="dotted") + 
  geom_vline(xintercept = as.numeric(as.POSIXlt(as.character("2015-02-27 16:46:00 GMT"))), color = "red", linetype="dotted") + 
  geom_vline(xintercept = as.numeric(as.POSIXlt(as.character("2015-02-27 16:48:00 GMT"))), color = "green", linetype="dotted") + 
  geom_vline(xintercept = as.numeric(as.POSIXlt(as.character("2015-02-27 16:50:00 GMT"))), color = "red", linetype="dotted") + 
  geom_vline(xintercept = as.numeric(as.POSIXlt(as.character("2015-02-27 16:52:00 GMT"))), color = "green", linetype="dotted") + 
  geom_vline(xintercept = as.numeric(as.POSIXlt(as.character("2015-02-27 16:53:44 GMT"))), color = "red", linetype="dotted") + 
  geom_vline(xintercept = as.numeric(as.POSIXlt(as.character("2015-02-27 16:57:00 GMT"))), color = "green", linetype="dotted") + 
  theme(legend.title=element_blank()) + 
  ggtitle("Window Size Experiment\nfixed variables: Pc = 0.05, decay = 1, replace threshold = 1, tick = 20s")

#point plot
ggplot(partD, aes(x = time, y = Threshold, colour = Anomaly)) + 
  geom_line(aes(y = partD$Dissimilarity, colour = "Dissimilarity"), linetype = "dashed", color = "violet") +
  geom_point() +
  geom_vline(xintercept = as.numeric(as.POSIXlt(as.character("2015-02-27 16:42:00 GMT"))), color = "green", linetype="dotted") + 
  geom_vline(xintercept = as.numeric(as.POSIXlt(as.character("2015-02-27 16:46:00 GMT"))), color = "red", linetype="dotted") + 
  geom_vline(xintercept = as.numeric(as.POSIXlt(as.character("2015-02-27 16:48:00 GMT"))), color = "green", linetype="dotted") + 
  geom_vline(xintercept = as.numeric(as.POSIXlt(as.character("2015-02-27 16:50:00 GMT"))), color = "red", linetype="dotted") + 
  geom_vline(xintercept = as.numeric(as.POSIXlt(as.character("2015-02-27 16:52:00 GMT"))), color = "green", linetype="dotted") + 
  geom_vline(xintercept = as.numeric(as.POSIXlt(as.character("2015-02-27 16:53:44 GMT"))), color = "red", linetype="dotted") + 
  geom_vline(xintercept = as.numeric(as.POSIXlt(as.character("2015-02-27 16:57:00 GMT"))), color = "green", linetype="dotted")  +
ggtitle("Window Size Experiment\nfixed variables: Pc = 0.05, decay = 100%, replace threshold = 1, tick = 20s, Window = 1 min")


#DECAY LIVE

library("ggplot2")
partA <- read.csv("~/Documents/WordCountStorm/dataOutput/hadoop-decay100.csv")
partB <- read.csv("~/Documents/WordCountStorm/dataOutput/hadoop-decay75.csv")
partC <- read.csv("~/Documents/WordCountStorm/dataOutput/hadoop-decay50.csv")
partD <- read.csv("~/Documents/WordCountStorm/dataOutput/hadoop-decay25.csv")
partA$time <- as.POSIXlt(as.character(partA$Timestamp), format="%H:%M:%S")
partB$time <- as.POSIXlt(as.character(partB$Timestamp), format="%H:%M:%S")
partC$time <- as.POSIXlt(as.character(partC$Timestamp), format="%H:%M:%S")
partD$time <- as.POSIXlt(as.character(partD$Timestamp), format="%H:%M:%S")

partA$time <- partA$time - (1426352571 - 1425055320)
partB$time <- partB$time - (1426352571 - 1425055320)
partC$time <- partC$time - (1426352571 - 1425055320)
partD$time <- partD$time - (1426352571 - 1425055320)

partA$var <- "d=1"
partB$var <- "d=0.75"
partC$var <- "d=0.5"
partD$var <- "d=0.25"

ggplot(partA, aes(x = time, y = Threshold)) + 
  geom_line(aes(y = partA$Threshold, colour = "d=1")) + 
  geom_line(aes(y = partB$Threshold, colour = "d=0.75")) + 
  geom_line(aes(y = partC$Threshold, colour = "d=0.5")) + 
  geom_line(aes(y = partD$Threshold, colour = "d=0.25")) +
  #geom_line(aes(y = partA$Dissimilarity, colour = "diss(d=1)"), linetype="dashed") +  
  #geom_line(aes(y = partB$Dissimilarity, colour = "diss(d=0.75)"), linetype="dashed") + 
  #geom_line(aes(y = partC$Dissimilarity, colour = "diss(d=0.5)"), linetype="dashed") + 
  geom_line(aes(y = partD$Dissimilarity, colour = "diss(d=0.25)"), linetype="dashed") + 
  geom_vline(xintercept = as.numeric(as.POSIXlt(as.character("2015-02-27 16:46:00 GMT"))), color = "red", linetype="dotted") + 
  geom_vline(xintercept = as.numeric(as.POSIXlt(as.character("2015-02-27 16:48:00 GMT"))), color = "green", linetype="dotted") + 
  geom_vline(xintercept = as.numeric(as.POSIXlt(as.character("2015-02-27 16:50:00 GMT"))), color = "red", linetype="dotted") + 
  geom_vline(xintercept = as.numeric(as.POSIXlt(as.character("2015-02-27 16:52:00 GMT"))), color = "green", linetype="dotted") + 
  geom_vline(xintercept = as.numeric(as.POSIXlt(as.character("2015-02-27 16:53:44 GMT"))), color = "red", linetype="dotted") + 
  geom_vline(xintercept = as.numeric(as.POSIXlt(as.character("2015-02-27 16:57:00 GMT"))), color = "green", linetype="dotted") + 
  theme(legend.title=element_blank()) + 
  ggtitle("Decay Experiment\nfixed variables: cum.prob. = 0.05, window=6, replace threshold = 1, tick = 20")


#FrequencyB


#NB: partD has 60sec tick, 3 min window rather than 2 min
partA <- read.csv("~/Documents/WordCountStorm/dataOutput/frequencyB20.csv")
partB <- read.csv("~/Documents/WordCountStorm/dataOutput/frequencyB15.csv")
partC <- read.csv("~/Documents/WordCountStorm/dataOutput/frequencyB30.csv")
partD <- read.csv("~/Documents/WordCountStorm/dataOutput/frequencyB60.csv")
partA$time <- as.POSIXlt(as.character(partA$Timestamp), format="%F %H:%M:%S")
partB$time <- as.POSIXlt(as.character(partB$Timestamp), format="%F %H:%M:%S")
partC$time <- as.POSIXlt(as.character(partC$Timestamp), format="%F %H:%M:%S")
partD$time <- as.POSIXlt(as.character(partD$Timestamp), format="%F %H:%M:%S")

#timestamp correction
partA$time <- partA$time - (1427240919 - 1425055320)
partB$time <- partB$time - (1427240919 - 1425055320)
partC$time <- partC$time - (1427240919 - 1425055320)
partD$time <- partD$time - (1427240919 - 1425055320)

ggplot(partA, aes(x = time, y = Threshold)) + 
  #geom_line(aes(y = partA$Threshold, colour = "Pc = 0.20")) + 
  #geom_line(aes(y = partB$Threshold, colour = "Pc = 0.10")) + 
  geom_line(aes(y = partA$Threshold, colour = "Threshold")) + 
  #geom_line(aes(y = partD$Threshold, colour = "Pc = 0.025")) + 
  geom_line(aes(y = partA$Dissimilarity, colour = "Dissimilarity"), linetype = "dashed") +
  geom_vline(xintercept = as.numeric(as.POSIXlt(as.character("2015-02-27 16:42:00 GMT"))), color = "green", linetype="dotted") + 
  geom_vline(xintercept = as.numeric(as.POSIXlt(as.character("2015-02-27 16:46:00 GMT"))), color = "red", linetype="dotted") + 
  geom_vline(xintercept = as.numeric(as.POSIXlt(as.character("2015-02-27 16:48:00 GMT"))), color = "green", linetype="dotted") + 
  geom_vline(xintercept = as.numeric(as.POSIXlt(as.character("2015-02-27 16:50:00 GMT"))), color = "red", linetype="dotted") + 
  geom_vline(xintercept = as.numeric(as.POSIXlt(as.character("2015-02-27 16:52:00 GMT"))), color = "green", linetype="dotted") + 
  geom_vline(xintercept = as.numeric(as.POSIXlt(as.character("2015-02-27 16:53:44 GMT"))), color = "red", linetype="dotted") + 
  geom_vline(xintercept = as.numeric(as.POSIXlt(as.character("2015-02-27 16:57:00 GMT"))), color = "green", linetype="dotted") + 
  theme(legend.title=element_blank()) + 
  ggtitle("Hadoop Threshold & Dissimilarity\nvariables: decay = 1, window=2min, replace threshold = 1, tick = 20, Pc = 0.05")

ggplot(partA, aes(x = time, y = Threshold, colour = Anomaly)) +
  geom_line(aes(y = partA$Dissimilarity, colour = "Dissimilarity"), linetype = "dashed", color = "violet") +
  geom_point() +
  geom_vline(xintercept = as.numeric(as.POSIXlt(as.character("2015-02-27 16:42:00 GMT"))), color = "green", linetype="dotted") + 
  geom_vline(xintercept = as.numeric(as.POSIXlt(as.character("2015-02-27 16:46:00 GMT"))), color = "red", linetype="dotted") + 
  geom_vline(xintercept = as.numeric(as.POSIXlt(as.character("2015-02-27 16:48:00 GMT"))), color = "green", linetype="dotted") + 
  geom_vline(xintercept = as.numeric(as.POSIXlt(as.character("2015-02-27 16:50:00 GMT"))), color = "red", linetype="dotted") + 
  geom_vline(xintercept = as.numeric(as.POSIXlt(as.character("2015-02-27 16:52:00 GMT"))), color = "green", linetype="dotted") + 
  geom_vline(xintercept = as.numeric(as.POSIXlt(as.character("2015-02-27 16:53:44 GMT"))), color = "red", linetype="dotted") + 
  geom_vline(xintercept = as.numeric(as.POSIXlt(as.character("2015-02-27 16:57:00 GMT"))), color = "green", linetype="dotted") + 
  ggtitle("Anomalies and Thresholds Over Time\nvariables: decay = 100%, window= 2min, replace threshold = 1, tick = 20s, Pc = 0.05")







#NEW CUMPROB

library("ggplot2")
partA <- read.csv("~/Documents/WordCountStorm/dataOutput/cumProbB30.csv")
partB <- read.csv("~/Documents/WordCountStorm/dataOutput/cumProbB20.csv")
partC <- read.csv("~/Documents/WordCountStorm/dataOutput/cumProbB10.csv")
partD <- read.csv("~/Documents/WordCountStorm/dataOutput/cumProbB05.csv")
partA$time <- as.POSIXlt(as.character(partA$Timestamp), format="%F %H:%M:%S")
partB$time <- as.POSIXlt(as.character(partB$Timestamp), format="%F %H:%M:%S")
partC$time <- as.POSIXlt(as.character(partC$Timestamp), format="%F %H:%M:%S")
partD$time <- as.POSIXlt(as.character(partD$Timestamp), format="%F %H:%M:%S")

#timestamp correction
partA$time <- partA$time - (1427246537 - 1427205600)
partB$time <- partB$time - (1427246537 - 1427205600)
partC$time <- partC$time - (1427246537 - 1427205600)
partD$time <- partD$time - (1427246537 - 1427205600)

ggplot(partC, aes(x = time, y = Threshold)) + 
  #geom_line(aes(y = partA$Threshold, colour = "Pc = 0.20")) + 
  #geom_line(aes(y = partB$Threshold, colour = "Pc = 0.10")) + 
  geom_line(aes(y = partC$Threshold, colour = "Threshold")) + 
  #geom_line(aes(y = partD$Threshold, colour = "Pc = 0.025")) + 
  geom_line(aes(y = partC$Dissimilarity, colour = "Dissimilarity"), linetype = "dashed") +
  #geom_vline(xintercept = as.numeric(as.POSIXlt(as.character("2015-02-27 16:42:00 GMT"))), color = "green", linetype="dotted") + 
  #geom_vline(xintercept = as.numeric(as.POSIXlt(as.character("2015-02-27 16:46:00 GMT"))), color = "red", linetype="dotted") + 
  theme(legend.title=element_blank()) + 
  ggtitle("Hadoop Threshold & Dissimilarity\nvariables: decay = 1, window=2min, replace threshold = 1, tick = 20, Pc = 0.05")

ggplot(partC, aes(x = time, y = Threshold, colour = Anomaly)) +
  geom_line(aes(y = partC$Dissimilarity, colour = "Dissimilarity"), linetype = "dashed", color = "violet") +
  geom_point() +
  geom_vline(xintercept = as.numeric(as.POSIXlt(as.character("2015-03-24 14:11:25 GMT"))), color = "green", linetype="dotted") + 
  #geom_vline(xintercept = as.numeric(as.POSIXlt(as.character("2015-02-27 16:46:00 GMT"))), color = "red", linetype="dotted") + 
  ggtitle("Anomalies and Thresholds Over Time\nvariables: decay = 100%, window= 2min, replace threshold = 1, tick = 20s, Pc = 0.05")



