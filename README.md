# cronch.sh

mac script to prevent sleep due to inactivity

## how it works

- every 59 seconds, check how long the system has been idle (no user activity/input)
- if the idle time exceeds the configured timeout (default is 3 minutes), it sends the configured keystroke (default is right shift key) to reset the idle time and thus prevents the system from going to sleep
- if the script is not stopped, it will eventually stop itself once it reaches the configured timeout (default is 12 hours)

it will also print to the terminal the time, whether it sends a keystroke (indicated with `CRONCH` or `NO CRONCH`), and the idle time in seconds

### example output

```sh
$ ./cronch.sh

CRONCH will exit after 12 hours (43200 seconds)

Tue May 31 12:12:48 CDT 2022 -- NO CRONCH -- 0
Tue May 31 12:13:47 CDT 2022 -- NO CRONCH -- 42
Tue May 31 12:14:46 CDT 2022 -- NO CRONCH -- 101
Tue May 31 12:15:45 CDT 2022 -- NO CRONCH -- 160

Tue May 31 12:16:44 CDT 2022 -- CRONCH -- 219

Tue May 31 12:17:43 CDT 2022 -- NO CRONCH -- 59
```

## configure

modify the variables at the top of the script to your liking:

```sh
idleTimeoutMinutes=3     # {minutes} - how long to wait before sending keystroke to prevent sleep (and reset idle time (HIDIdleTime))
scriptTimeoutHours=12    # {hours} - when to stop running as a failsafe in case we forgot to stop this script manually
key=60                   # {keycode} - keycode to send (60 is right shift)
```

you can also specify `scriptTimeoutHours` as an argument. for example:

```sh
$ ./cronch.sh 3

CRONCH will exit after 3 hours (10800 seconds)
```

## but why?

for long running tests, the system going to sleep or being idle for a long time can interrupt the test run, or affect test performance.  this script prevents that.

### "cronch" tho?

no particular reason.  gotta call the script something.  might as well be the sound of a [gator](https://en.wikipedia.org/wiki/Alligator) chomping down on something.

## license

GPL-3.0
