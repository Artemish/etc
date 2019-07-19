# Print the nth column of output
cols() {
  awk '{ print $'"$1"' }'
}

mr() { mpg123 --pitch $1 -Z ~/Music/weeaboo/*; }

function countdown () {
   date1=$((`date +%s` + $1)); 
   while [ "$date1" -ne `date +%s` ]; do 
     echo -ne "$(date -u --date @$(($date1 - `date +%s`)) +%H:%M:%S)\r";
     sleep 0.1
   done
}

function stopwatch(){
  date1=`date +%s`; 
   while true; do 
    echo -ne "$(date -u --date @$((`date +%s` - $date1)) +%H:%M:%S)\r"; 
    sleep 0.1
   done
}
