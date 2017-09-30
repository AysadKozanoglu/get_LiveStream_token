#!/bin/bash

# wget to tmp && grep file && cut first " && cut last ",
#wget -q -O tmp "https://www.canlitv.com/canli-atv" && \
#t=$(cat tmp | grep "file:") && v=$(echo $t | cut -d\" -f2) && echo $v | cut -d\" -f1

tmp_file=$(mktemp)

#channels=("fox-tv" "canli-atv" "show-tv" "star-tv" "kanal-7" "canli-a-haber" "ntv" "halk-tv" "tlc" "canli-a2-izle" "kanala")

channels=("fox-tv" "canli-atv")

for kanal in "${channels[@]}"
  do
  	wget -q -O $tmp_file "https://www.canlitv.com/${kanal}"
	t=$(cat $tmp_file | grep "file:")
	v=$(echo $t | cut -d\" -f2)
	tokenLink=$(echo $v | cut -d\" -f1)
	echo $tokenLink
  done


