#!/usr/bin/env bash
# templist="temp.m3u8"
templist="playlist.m3u8"
list="tv.m3u8"

set -x
curl http://cdn.ultra-tv.online:3289/$templist?token=knuro195 --output $templist

echo "" > $list

function filtration()
{
  local groupname=$1
  local channelname=$2
  local filter="group-title=\"${groupname}\".*(${channelname})"
  cat $templist | grep -EI "group-title=\"${groupname}\".*(${channelname})" -A 1 --no-group-separator  >> $list
}


cat $templist | head -n 1  >> $list


filtration "USA" 'Nick|Cart|Disn'
filtration "Россия" 'Москва 24|Пятница!$|Россия 24|Первый Канал$|Россия 2'
filtration "Документальные" 'HGTV'
filtration "Детские" "Baby TV"
filtration "Serbia"


rm $templist
