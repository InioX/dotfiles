hour=$(date +"%H")
 
if [ $hour -ge 0 -a $hour -lt 12 ]
then
  notify-send "  Good morning, $USER"!;
elif [ $hour -ge 12 -a $hour -lt 18 ] 
then
  notify-send "  Good afternoon, $USER"!; 
else
  notify-send "  Good evening, $USER!"
fi
 
echo $greet