#!/bin/bash
yyyy=$(date --date="yesterday" +"%Y")
mm=$(date --date="yesterday" +"%m")
dd=$(date --date="yesterday" +"%d")
hh=$(date --date="yesterday" +"%H")

hourly="$yyyy$mm$dd$hh"
daily="$yyyy$mm$dd"00
monthly="$yyyy$mm"0100
touch="sudo touch -m -t "
folder="/var/weewx/reports/live/json"

n05="05.00"
n10="10.00"
n15="15.00"
n20="20.00"
n25="25.00"
n30="30.00"
n35="35.00"
n40="40.00"
n45="45.00"
n50="50.00"
n55="55.00"

$touch$daily$n05 $folder/day.json
$touch$hourly$n10 $folder/week.json
$touch$daily$n15 $folder/month.json
$touch$daily$n20 $folder/year.json
$touch$daily$n30 $folder/annual.json
$touch$monthly$n35 $folder/summary.json

echo "Resets the modified date/time to yesterday for 6 files in $folder"
echo "This forces all graphs to be updated at the relevant minutes past the hour"
echo day.json     "    $daily$n05"
echo week.json    "   $hourly$n10"
echo month.json   "  $daily$n15"
echo year.json    "   $daily$n20"
echo annual.json  " $daily$n30" 
echo summary.json "$monthly$n35" 



