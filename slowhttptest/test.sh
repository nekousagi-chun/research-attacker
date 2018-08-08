#!/bin/sh

#conections_per_secondsの最大値
max_per_seconds=1000

#number_of_conectionsの最大値
max_conections=5000

#conections_per_secondsの初期値
conections_per_seconds=200

#number_of_conectionsの初期値
number_of_conections=2500

while [ "$number_of_conections" -le "$max_conections" ]
do
	mkdir -p $number_of_conections
	while [ "$conections_per_seconds" -le "$max_per_seconds" ]
	do
        	echo "conections per seconds=$conections_per_seconds" 
		echo "number_of_conections=$number_of_conections"  
        	slowhttptest -c $number_of_conections -X -g -o slow_read_stats -r $conections_per_seconds -w 512 -y 1024 -n 5 -z 32 -k 3 -u http://10.1.200.100 -p 3 -l 240 &&

		#csvファイルの名前を変更
        	mv slow_read_stats.csv ./$number_of_conections/slow_read_stats_${conections_per_seconds}_${number_of_conections}.csv &&
		python /home/sumire/slowhttptest/test_graph1.py ./$number_of_conections/slow_read_stats_${conections_per_seconds}_${number_of_conections}.csv  &&
		mv slow_read_stats_${conections_per_seconds}_${number_of_conections}.png ./$number_of_conections/		

        	conections_per_seconds=`expr $conections_per_seconds + 100` 
	done
	conections_per_seconds=200
	number_of_conections=`expr $number_of_conections + 500` 

done
