#!/usr/bin/bash

INPUT_conections_per_seconds=$1
INPUT_number_of_conections=$2

slowhttptest -c $INPUT_number_of_conections -X -g -o slow_read_stats -r $INPUT_conections_per_seconds -w 512 -y 1024 -n 5 -z 32 -k 3 -u http://10.1.200.100 -p 3 -l 240 &&


mv slow_read_stats.csv ./solotest/slow_read_stats_${INPUT_conections_per_seconds}_${INPUT_number_of_conections}.csv &&


python /home/sumire/slowhttptest/test_graph1.py ./solotest/slow_read_stats_${INPUT_conections_per_seconds}_${INPUT_number_of_conections}.csv  &&

mv slow_read_stats_${INPUT_conections_per_seconds}_${INPUT_number_of_conections}.png ./solotest
