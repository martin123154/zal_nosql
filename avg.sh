#!/bin/bash

convertsecs() {
 h=$(bc -l <<< "${1}/3600")
 m=$(bc -l <<< "(${1}%3600)/60")
 s=$(bc -l <<< "${1}%60")
 printf "%02d:%02d" $h $m
}


calc(){ awk "BEGIN { print $* }"; }
for ((i=1; $i<=5; i++));do
line1=($(head -n 1 $1/"czas_"$i".txt"))
temp_line2=($(head -n 2 $1/"czas_"$i".txt"))
line2="${temp_line2[3]}"
line3=($(tail -n 1 $1/"czas_"$i".txt"))


real_time=${line1[1]}
user_time=$line2
sys_time=${line3[1]}

# REAL TIME
sekundy=$(echo "$real_time" | grep -Po '(?<=(m)).*(?=s)')
minuty=$(echo "$real_time" | grep -Po '.*(?=m)')
min_to_s=$[$[minuty]*60]
sum_time=$(echo "$min_to_s+$sekundy" | bc)
sum_real+=("$sum_time")


# USER TIME
sekundy2=$(echo "$user_time" | grep -Po '(?<=(m)).*(?=s)')
minuty2=$(echo "$user_time" | grep -Po '.*(?=m)')
min_to_s2=$[$[minuty2]*60]
sum_time2=$(echo "$min_to_s2+$sekundy2" | bc)
sum_user+=("$sum_time2")



# SYS TIME
sekundy3=$(echo "$sys_time" | grep -Po '(?<=(m)).*(?=s)')
minuty3=$(echo "$sys_time" | grep -Po '.*(?=m)')
min_to_s3=$[$[minuty3]*60]
sum_time3=$(echo "$min_to_s3+$sekundy3" | bc)
sum_sys+=("$sum_time3")

done


all_sum_real_time=$(echo "${sum_real[0]}+${sum_real[1]}+${sum_real[2]}+${sum_real[3]}+${sum_real[4]}" | bc)
all_sum_user_time=$(echo "${sum_user[0]}+${sum_user[1]}+${sum_user[2]}+${sum_user[3]}+${sum_user[4]}" | bc)
all_sum_sys_time=$(echo "${sum_sys[0]}+${sum_sys[1]}+${sum_sys[2]}+${sum_sys[3]}+${sum_sys[4]}" | bc)

liczba_ele=5
srednia_real=$(calc $all_sum_real_time/$liczba_ele)
srednia_user=$(calc $all_sum_user_time/$liczba_ele)
srednia_sys=$(calc $all_sum_sys_time/$liczba_ele)

rm -f $1/srednia.txt


date -d@"$srednia_real" -u +%Mm%Ss >> $1/srednia.txt
date -d@"$srednia_user" -u +%Mm%Ss >> $1/srednia.txt
date -d@"$srednia_sys" -u +%Mm%Ss >> $1/srednia.txt