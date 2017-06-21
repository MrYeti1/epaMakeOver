R code to generate the below from the Daily Summary Data available at: https://aqsdr1.epa.gov/aqsweb/aqstmp/airdata/download_files.html#Raw

also hosted at: http://rpubs.com/mrYeti1/epaMakeOver


# Ozone Readings over time - Is it getting better?



If we plot the number of Ozone Air Quality Index readings at each level per day, we can see that the summer months often reach the "Very Unhealthy" AQI banding. On Friday 08 July, 1988 there were 189 readings in the "Very Unhealthy" band.

The good news is the frequency we reach these unhealthy levels have been trending down since 1980 (when records began). Recently, winter months rarely reach unhealty levels of ozone.

On first look it appears that there has been a dramatic increase in the number of Moderate and Good readings, far more than we gain from reducing number of readings at higher levels...

![](DailyAQA_files/figure-html/unnamed-chunk-3-1.png)<!-- -->



There are more monitoring sites now than in 1980. In 1980 there were 131 sites. By 2016 there were 264 sites. So we have the chance to learn so much more. But, this does skew our earlier results...

![](DailyAQA_files/figure-html/unnamed-chunk-5-1.png)<!-- -->


If we divide the daily counts by the number of stations that day, then we get this normalised chart where the change over time for Good and Moderate levels of ozone are trending as expected - the Good observations increase at a similar rate to the decrease of Unhealthy.

![](DailyAQA_files/figure-html/unnamed-chunk-6-1.png)<!-- -->

