#!/bin/bash

/usr/bin/osascript <<-EOF

    tell application "Finder"
        activate

	# Crank the volume up
	set origVolume to output volume of (get volume settings)
	set volume output volume 100

	say "[[rate 160]]Time to catch the cal train"
	display alert "Time to catch the caltrain"

	# Make sure proper gems are loaded
	set tweets to do shell script "source ~/.rvm/scripts/rvm && ruby ~/Scripts/caltrain.rb"
	display alert tweets

	# Reset volume levels
	set volume output volume origVolume
    end tell

EOF

