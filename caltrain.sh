#!/bin/bash

/usr/bin/osascript <<-EOF
    tell application "Finder"
        activate

	# Crank the volume up
	set origVolume to output volume of (get volume settings)
	set volume output volume 70

	say "[[rate 160]]Time to catch the cal train"

	# Make sure proper gems are loaded
	set tweets to do shell script "~/Code/scripts/CalTrain/rbenv-caltrain.sh"
	if tweets is not "" then
		display alert tweets
	else
		display alert "Time to catch the caltrain"
	end if

	# Reset volume levels
	set volume output volume origVolume
    end tell

EOF

