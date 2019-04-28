#!/bin/bash

test ! -x "$(which xdotool)"                          \
  -o ! -x "$(which xterm)"                            \
  && echo 'This program requires xdotool and xterm.'  \
  && exit 1

logfile="log/logfile.txt"

function printlog() {
  echo "[$(date +'%Y-%m-%d %H-%M-%S')] $1" >>$logfile
}

#
# Start test
#
printlog "Automated test suite started"

#
# User interface test
#
printlog "User interface test started"
xdotool mousemove 100 100
for test in test/????-*.xdo; do
  xdotool              \
    mousemove 120 120  \
    mousemove 100 100
  xdotool $test
  printlog "--> $(basename $test)"
done
printlog "User interface test finished"

#
# TODO: API Test
#

#
# Finish test
#
printlog "Automated test suite finished"
