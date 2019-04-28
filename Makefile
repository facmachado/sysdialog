.RECIPEPREFIX=.

cleanlog:
. @>log/logfile.txt

run:
. @bash app.sh

runtest:
. @xvfb-run xterm -e bash test/runtest.sh

runtestview:
. @xterm -e bash test/runtest.sh
