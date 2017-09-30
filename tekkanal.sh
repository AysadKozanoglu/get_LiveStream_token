#! /bin/sh

# link source  http://www.canlitvlive.tv/izle/fox-turkiye.html

channel="foxTR"
filepath="/tmp/"$channel"canlitv"
saveto="/usr/local/nginx/html/iptv/CTVLstream/link/"$channel".m3u8"
serverlink="http://www.canlitvlive.tv/izle/fox-turkiye.html"
wget -qO "$filepath" $serverlink --header="Accept: text/html" --user-agent="Mozilla/5.0 (Macintosh; Intel Mac OS X 10.8; rv:21.0) Gecko/20100101 Firefox/21.0"
streamlink=$(grep -Po "(?<=file:\").*(?=\s*\"}]}],abouttext)" $filepath)
echo $streamlink
echo "#EXTM3U" > $saveto
echo "#EXT-X-STREAM-INF:PROGRAM-ID=1" >> $saveto
echo $streamlink >>$saveto
d=$(date)
echo $link 
