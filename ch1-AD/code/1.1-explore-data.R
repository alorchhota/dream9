## read raw data file
rawDataFile <- 'data/raw/AD1ChallengeClinicalFiles/ADNI_Training_Q1_May15.2014.csv'
rawData <- read.table(file=rawDataFile, header=T, quote='', sep=',', comment.char='', colClasses=c("character","character","factor","character","factor","numeric","factor","numeric","factor","numeric"))
head(rawData)

## make one row for patient
blRawData <- rawData[rawData$VISCODE=='bl',]
m24RawData <- rawData[rawData$VISCODE=='m24',]
processedData <- merge(x=blRawData, y=m24RawData, by='PTID', all=T, suffixes=c('.bl','.m24'))
processedData <- processedData[,c("PTID", "RID.bl", "EXAMDATE.bl", "EXAMDATE.m24", "DX.bl.bl", "AGE.bl", "PTGENDER.bl", "PTEDUCAT.bl", "APOE4.bl", "MMSE.bl", "MMSE.m24")]
names(processedData) <- c("PTID", "RID", "EXAMDATE.bl", "EXAMDATE.m24", "DX.bl", "AGE", "PTGENDER", "PTEDUCAT", "APOE4", "MMSE.bl", "MMSE.m24")


## see RAW MMSE patterns and its relation with APOE4.
par(mfrow=c(2,2))
hist(rawData$MMSE, breaks=15, main='All RAW MMSE')
hist(rawData$MMSE[rawData$APOE4==0], breaks=15, main='RAW MMSE with APOE4=0')
hist(rawData$MMSE[rawData$APOE4==1], breaks=15, main='RAW MMSE with APOE4=1')
hist(rawData$MMSE[rawData$APOE4==2], breaks=15, main='RAW MMSE with APOE4=2')
dev.copy(png, 'results/plot-Raw-MMSE-vs-APOE4.png')
dev.off()


## see relation between RAW MMSE and VISCODE.
par(mfrow=c(2,1))
hist(rawData$MMSE[rawData$VISCODE=='bl'], xlim=c(0,30), breaks=5, main='RAW MMSE at baseline')
hist(rawData$MMSE[rawData$VISCODE=='m24'], breaks=15, main='RAW MMSE after 24 months')
dev.copy(png, 'results/plot-Raw-MMSE-vs-VISCODE.png')
dev.off()

