#! /usr/bin/env bash
# cronch.sh

idleTimeoutMinutes=3     # {minutes} - how long to wait before sending keystroke to prevent sleep (and reset idle time (HIDIdleTime))
scriptTimeoutHours=12    # {hours} - when to stop running as a failsafe in case we forgot to stop this script manually
key=60                   # {keycode} - keycode to send (60 is right shift)

if [ -n "$1" ]
then
  scriptTimeoutHours=$1
fi

idleTimeout=$(echo "$idleTimeoutMinutes * 60" | bc)
end=$(echo "$scriptTimeoutHours * 60 * 60 / 1" | bc)

# date command works differently between bsd/linux/mac
endDate=$(date -d "+${end}Seconds" 2>/dev/null || date -v "+${end}S")

echo
echo "CRONCH will exit after $scriptTimeoutHours hours at $endDate"
echo

while [ $SECONDS -lt "$end" ]
do
  idleTime=$(ioreg -c IOHIDSystem | awk '/HIDIdleTime/ {print int($NF/1000000000); exit}')
  if [ "$idleTime" -gt "$idleTimeout" ]
  then
    echo -e "\n$(date) -- CRONCH -- $idleTime\n"
    osascript -e "tell application \"System Events\" to key code $key"
  else
    echo "$(date) -- NO CRONCH -- $idleTime"
  fi
  sleep 59
done

echo "$(date) -- script has been running for $SECONDS seconds.  exiting now."

exit
