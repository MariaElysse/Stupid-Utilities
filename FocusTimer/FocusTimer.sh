#!/bin/bash 
function ask_to_end_pomodoros  {
    if zenity --question --text="$1 Done. Ready for break" --title="Timer" \
            --ok-label="Stop Pomodoros" --cancel-label="Continue Pomodoros"; then
            zenity --warning --text "Ending Pomodoros"
            cp default.action_noblock /etc/privoxy/default.action 
            exit
     fi 

}
if whoami | xargs test "root" != ;
then 
   echo "run this script as root"
  exit 0 
fi 

while true; do 

	if [[ time -eq 25 ]]; then
		su maria -c "play -q /usr/share/sounds/gnome/default/alerts/glass.ogg"
		notify-send "Back to work!"
		cp default.action_block /etc/privoxy/default.action
		echo 'Working'
		let time=5
		service privoxy restart
		for i in $(seq 1 100); do 
			sleep 15
			echo $i
			mins_rem="$(echo "(1500-(15*$i)) / 60 " | bc )"
			secs_rem="$(echo "(1500-(15*$i)) % 60 " | bc )" 
			echo "# $mins_rem m, $secs_rem s work remaining"
            echo "$mins_rem m, $secs_rem s work remaining" >&2 
        done | zenity --auto-close --progress --no-cancel --text="You are working"
        ask_to_end_pomodoros "Work"
    else 
		notify-send "Take a break!"
        su maria -c "play -q /usr/share/sounds/gnome/default/alerts/glass.ogg"
		cp default.action_noblock /etc/privoxy/default.action
		echo 'Taking a break'
		service privoxy restart
		let time=25
		for i in $(seq 1 100); do
			sleep 3
			echo $i
			mins_rem="$(echo "(300-(3*$i)) / 60 " | bc )"
			secs_rem="$(echo "(300-(3*$i)) % 60 " | bc )" 
			echo "# $mins_rem m, $secs_rem s break remaining"
            echo "$mins_rem m, $secs_rem s break remaining" >&2
		done | zenity --progress --auto-close --no-cancel --text="You are on a break"
        ask_to_end_pomodoros "Break"
	fi
done 
