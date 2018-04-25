#!/bin/bash
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
real_table+=("$real_time")


# USER TIME
user_table+=("$user_time")


# SYS TIME
sys_table+=("$sys_time")
done

readarray avg_table < $1/srednia.txt



rm -f $1/tab.adoc

echo "[width='100%',cols='>s,^,^,^,^,^,^',options='header']" >> $1/tab.adoc
echo "|==========================" >> $1/tab.adoc
echo "|      5+|$2 | Average" >> $1/tab.adoc
echo "|real time       |${real_table[0]}  |${real_table[1]} |${real_table[2]} |${real_table[3]} |${real_table[4]} |${avg_table[0]}" >> $1/tab.adoc
echo "|user time       |${user_table[0]}  |${user_table[1]} |${user_table[2]} |${user_table[3]} |${user_table[4]} |${avg_table[1]}" >> $1/tab.adoc
echo "|sys time        |${sys_table[0]}  |${sys_table[1]} |${sys_table[2]} |${sys_table[3]} |${sys_table[4]} |${avg_table[2]}" >> $1/tab.adoc
echo "|==========================" >> $1/tab.adoc