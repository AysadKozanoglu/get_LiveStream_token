#! /bin/bash
#
#  Author: Aysad Kozanoglu
#   email: aysadx@gmail.com
#
#  description: only for testing to find a way to deft token based live stream links

# link source  http://www.canlitvlive.tv/izle/atv.html
sleeptime=50
serverlink="http://www.canlitvlive.co/izle"
path="/usr/local/nginx/html/iptv/CTVLstream/"
tmppath=$path"tmp.file"
saveto=$path"link"

sublink=("halk-tv" "atv-canli-izle" "kanal-d-izle" "star-tv" "show-tv" "fox-turkiye" "tv-8" "ntv" "sky-turk" "kanal-24" "kanal-7-avrupa"
"a-haber" "cnn-turk" "haber-turk" "planet-pembe" "tv2" "flash-tv" "kanal-a" "tv-net" "tgrt-haber" "cine5" "cartoon-network-turkiye" "minika-go" 
"minika-cocuk" "yaban-tv" "planet-cocuk" "tgrt-belgesel" "nr1" "kanal-a" "tgrt-eu" "tv5" "trt-3-spor" 
"ntv-spor" "a-spor" "ulke-tv" "trt-muzik" "sports-tv" "kral-tv" "power-turk" "dream-tv")
#echo $sublink[*]
savetofile (){
	filetosave=$saveto"/"$kanal".m3u8"
        echo "#EXTM3U" > $filetosave
        echo "#EXT-X-STREAM-INF:PROGRAM-ID=1" >> $filetosave
        echo $streamlink >>$filetosave

}

for kanal in "${sublink[@]}"
do
       # echo $kanal;
	curl -s -A "Mozilla/5.0 (Macintosh; Intel Mac OS X 10.8; rv:21.0) Gecko/20100101 Firefox/40.0" $serverlink"/"$kanal".html" > $tmppath
	streamlink=$(grep -Po "(?<=file:\").*(?=\s*\"}]}],abouttext)" $tmppath)
	echo $streamlink 
	savetofile
done
cur=$(date)
echo " all.sh tv kannalar son yenileme: "$cur
sleep $sleeptime
clear
. $path"all.sh"
