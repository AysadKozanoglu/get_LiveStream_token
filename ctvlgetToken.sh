#! /bin/bash
#! /bin/bash
#
#  Author: Aysad Kozanoglu
#   email: aysadx@gmail.com
#
#  description: only for testing to find a way to deft token based live stream links

#  TokenPool
# dieser Script macht ein request und holt den token link von der htm datei anhand grep funktion
# all.sh macht im gegensatz für jeden stream ein request was dazu führt dass der server mit request gespooft wird und auffalen wird.
# um den server schonen machen ich nur ein reuquest fum den token zu holen der dann für alle kaanäle gültig ist

#    eventl nachteil
# ich nehme an dass jede token einen max limit von connections erlauben wird 
# was dazu fürht dass der geholte token pool schnell voll sein wird
# lösung ist dass man mehrere tokens nimmt mit sleep nd wget function und so für jede channel ein token hat
# vor erst ein token für alle channel 

# link source  http://www.canlitvlive.tv/izle/atv.html
path="/usr/local/nginx/html/iptv/CTVLstream/"
tokenpool=""
scriptname="ctvlgetToken"$tokenpool".sh"
tmppath=$path"tmp"$tokenpool".file"
saveto=$path"linktoken"$tokenpool
sleeptime=60
serverlink="http://www.canlitvlive.tv/izle/atv.html"
  ##  bei grepServerLink beachten und dementsrepchen ebenfalls zum greppen anpassen

ChannelsWithToken=("atv" "kanald" "startv" "showtv" "foxtv" "tv8" "ntv" "kanal24" "cnnturk" "ahaber" "planetpembe"
 "tv2" "flashtv" "kanala" "tvnet" "tgrthaber" "cine5" "cartoonnetwork" "minikago" "minikacocuk" "planetcocuk")

savetofile (){
	filetosave=$saveto"/"$kanal".m3u8"
        echo "#EXTM3U" > $filetosave
        echo "#EXT-X-STREAM-INF:PROGRAM-ID=1" >> $filetosave
        echo "http://"$grepServerLink"/"$kanal"/live.m3u8?tkn="$grepStreamToken"&tms="$grepStreamTms >>$filetosave
#	echo "http://"$grepServerLink"/"$kanal"/live.m3u8?tkn="$grepStreamToken"&tms="$grepStreamTms

}

GetToken(){
        wget -qO $tmppath $serverlink --header="Accept: text/html" --user-agent="Mozilla/5.0 (Macintosh; Intel Mac OS X 10.8; rv:21.0) Gecko/20100101 Firefox/40.0"
        streamlink=$(grep -Po "(?<=file:\").*(?=\s*\"}]}],abouttext)" $tmppath)
	grepServerLink=$(grep -Po "(?<=file:\"http://).*(?=\s*/atv/live.m3u8)" $tmppath)
	grepStreamToken=$(grep -Po "(?<=tkn\=).*(?=\s*\&tms)" $tmppath)
	grepStreamTms=$(grep -Po "(?<=tms\=).*(?=\s*\"}]}],abouttext)" $tmppath)
#	echo $grepServerLink
#	echo $grepStreamToken
#	echo $grepStreamTms
}

GetToken

for kanal in "${ChannelsWithToken[@]}"
  do
	#echo $kanal
	streamlink=$(grep -Po "(?<=file:\").*(?=\s*\"}]}],abouttext)" $tmppath)
	savetofile
  done

statusShowSleepRestart(){
	cur=$(date)
	echo "pool: "$tokenpool
	echo "interval: "$sleeptime
	echo "son yenileme: "$cur
	echo "server:"$grepServerLink "token:"$grepStreamToken "tms:"$grepStreamTms
	sleep $sleeptime
	clear
	. $path$scriptname
}

statusShowSleepRestart

