library(dplyr)
library(ggplot2)

annualConc <- read.csv("~/Downloads/annual_conc_by_monitor_2016.csv")
adviz <- read.csv("~/Downloads/ad_viz_plotval_data.csv")

weekdayLevels <- c("Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday")
monthLevels <- c("January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December")

dailyFilePattern <- "daily_42401_.*.csv"
#dailyFilePattern <- "daily_42401_2016.csv"

dailyFiles <- list.files(pattern=dailyFilePattern, path="~/Downloads/")
dailyFilePaths <- paste(c("~/Downloads/"), dailyFiles, sep="")
daily <- lapply(dailyFilePaths, readr::read_csv) %>% 
  bind_rows() %>% 
  mutate(
    date.date = as.POSIXct(`Date Local`, format="%Y-%m-%d"),
    weekday = factor(strftime(date.date, format="%A"), weekdayLevels),
    month = factor(strftime(date.date, format="%B"), monthLevels)
  )


table(daily$month)
table(annualConc$State.Name)
table(annualConc$Parameter.Name)

table(annualConc$Certification.Indicator)

View(adviz)

table(adviz$Daily.Max.8.hour.CO.Concentration)

table(adviz$DAILY_AQI_VALUE)
table(adviz$AQS_SITE_ID)
table(adviz$AQS_PARAMETER_CODE)


ggplot(adviz, aes(x=as.POSIXct(Date, format="%m/%d/%Y"), y=Daily.Max.8.hour.CO.Concentration, color=as.factor(AQS_SITE_ID))) + geom_point() + geom_smooth() + theme(legend.position = "none")


ggplot(adviz, aes(x=as.POSIXct(Date, format="%m/%d/%Y"), y=DAILY_AQI_VALUE, color=as.factor(AQS_SITE_ID))) + geom_point() + geom_smooth() + theme(legend.position = "none")


#ggplot(daily %>% filter(AQI > 50), aes(x=date.date, y=AQI)) + geom_point(aes(color=as.factor(`Site Num`))) + geom_smooth() + theme(legend.position = "none")

ggplot(daily %>% filter(AQI > 100), aes(x=date.date)) + geom_histogram() + theme(legend.position = "none")


ggplot(daily %>% filter(AQI > 50), aes(x=X1st.Max.Hour, color=as.factor(Site.Num))) + geom_bar(stat="count") + theme(legend.position = "none") + coord_polar() + ylim(c(0, 200)) + xlim(c(12,24))

ggplot(daily %>% filter(AQI > 50), aes(x=X1st.Max.Hour, color=as.factor(Site.Num))) + geom_bar(stat="count") + theme(legend.position = "none") + coord_polar() + ylim(c(0, 200)) + xlim(c(12,24))


AQICuts <- c(-1,50,100,150, 200)
AQILabels <- c("Good","Moderate","Unhealthy (Sens)","Unhealthy")

dailyAgg <- daily %>% filter(!is.na(AQI)) %>% mutate(AQI.GROUP = cut(AQI, AQICuts, AQILabels) ) %>% group_by(date.date, AQI.GROUP) %>% summarise(
  count = n(),
  numSites = length(unique(`Site Num`)),
  norm = count / numSites,
) %>% mutate(     
  weekday = factor(strftime(date.date, format="%A"), weekdayLevels),
  month = factor(strftime(date.date, format="%B"), monthLevels)
)
dailyAgg %>% head()
ggplot(dailyAgg %>% filter(AQI.GROUP != "Good"), aes(x=date.date, y=count, color=AQI.GROUP)) + geom_point(alpha=0.1) + facet_wrap(~weekday, ncol=7) + geom_smooth(method="lm")
ggplot(dailyAgg %>% filter(AQI.GROUP != "Good"), aes(x=date.date, y=count, color=AQI.GROUP)) + geom_point(alpha=0.05) + facet_wrap(~month, ncol=12) + geom_smooth(method="lm")


table(daily$AQI)
table(daily$X1st.Max.Hour)
nrow(table(daily$X1st.Max.Hour))



library(ggplot)
library(forcats)

table(daily$date.date)
table(daily$`State Name`)


length(unique(daily$Site.Num))

ggplot(daily, aes(x=AQI)) + geom_histogram()
table(daily$AQI > 50)

#yLimit <- max(daily$count) + 30
ggplot(daily %>% filter(AQI > 50), aes(x=date.date)) + geom_point(stat="count") + #geom_smooth(method="lm", stat="count") + # geom_smooth() + 
  ggtitle("Count of datapoints over KPI limit, over time") + xlab("Date") + facet_wrap(~weekday, ncol=7) #+ ylim(c(0, yLimit))

ggplot(daily %>% filter(AQI > 50), aes(x=date.date)) + geom_point(stat="count") + #geom_smooth(method="lm", stat="count") + # geom_smooth() + 
  ggtitle("Count of datapoints over KPI limit, over time") + xlab("Date") + facet_wrap(~month, ncol=12) #+ ylim(c(0, yLimit))


ggplot(daily %>% filter(AQI > 50), aes(x=date.date, color=AQI)) + geom_point(stat="count") + #geom_smooth(method="lm", stat="count") + # geom_smooth() + 
  ggtitle("Count of datapoints over KPI limit, over time") + xlab("Date") + facet_wrap(~`State Name`, ncol=4) #+ ylim(c(0, yLimit))

