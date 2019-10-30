#!/bin/bash
# Turn off Hyperion before sunset and after sunrise

# Sunrise and sunset for every Monday of the year
sunriseWeekly="08:04 08:03 07:59 07:53 07:46 07:37 07:26 07:14 07:01 06:48 06:34 \
        06:19 07:05 06:50 06:36 06:23 06:09 05:57 05:46 05:36 05:27 05:21 05:16 \
        05:13 05:12 05:14 05:17 05:23 05:29 05:37 05:46 05:55 06:04 06:14 06:23 \
        06:33 06:43 06:52 07:02 07:12 07:22 07:32 07:42 06:53 07:04 07:15 07:25 \
        07:35 07:44 07:52 07:58 08:02 08:04"
sunsetWeekly="16:30 16:38 16:47 16:57 17:08 17:19 17:30 17:41 17:52 18:03 18:14 \
        18:24 19:34 19:44 19:54 20:05 20:15 20:25 20:34 20:44 20:53 21:01 21:07 \
        21:13 21:16 21:17 21:17 21:14 21:09 21:02 20:53 20:43 20:31 20:19 20:05 \
        19:51 19:37 19:23 19:08 18:53 18:39 18:25 18:12 17:00 16:49 16:39 16:31 \
        16:25 16:21 16:19 16:20 16:23 16:29"

# Adjust the sunrise/sunset times in minutes e.g. 20 minutes earlier: -20). Default: 0
adjustment=0
nowWeek=$(date +%-W)
nowSecs=$(date +%s)
let nowWeek=nowWeek+1	# for some reason we're one week off...

sunriseSecs=$(date +%s -d $(echo $sunriseWeekly | awk -v i=$nowWeek '{ print $i }' ))
sunsetSecs=$(date +%s -d $(echo $sunsetWeekly | awk -v i=$nowWeek '{ print $i }' ))

let sunriseSecs=sunriseSecs+adjustment*60
let sunsetSecs=sunsetSecs+adjustment*60

echo nowSecs: $nowSecs, nowWeek: $nowWeek -- sunrise: $sunriseSecs -- sunset: $sunsetSecs

# Is it after sunrise or before sunset? Stop hyperion.
if [ $nowSecs -gt $sunriseSecs ] || [ $nowSecs -gt $sunsetSecs ] ; then
        echo Hyperion OFF!
        sudo systemctl stop hyperion
else
        echo Hyperion ON!
        sudo systemctl start hyperion
fi
