#!/bin/bash
#
#  Author: Aysad Kozanoglu
#   email: aysadx@gmail.com
#
#  description: only for testing to find a way to deft token based live stream links

# link source  http://www.canlitv.com

# wget to tmp && grep file && cut first " && cut last ",
#wget -q -O tmp "https://www.canlitv.com/canli-atv" && \
#t=$(cat tmp | grep "file:") && v=$(echo $t | cut -d\" -f2) && echo $v | cut -d\" -f1

tmp_file=$(mktemp)

channels=("ulusal-kanal" "fox-tv" "canli-atv" "show-tv" "kanal-7" "canli-a-haber"
	  	"disney-channel" "tv-4" "trt-belgesel" 
		"ntv" "halk-tv" "tlc" "canli-a2-izle" "kanala")


for kanal in "${channels[@]}"
  do
  	wget -q -O $tmp_file "https://www.canlitv.com/${kanal}"
	t=$(cat $tmp_file | grep "file:")
	v=$(echo $t | cut -d\" -f2)
	tokenLink=$(echo $v | cut -d\" -f1)
	echo $tokenLink
  done


