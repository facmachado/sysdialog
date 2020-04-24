.RECIPEPREFIX=.

cleanlog:
. @>log/logfile.txt

run:
. @xterm -fg white -bg black -geometry 170x58+0+0 -e ./app.sh

runtest:
. @xterm -fg white -bg black -geometry 170x58+0+0 -e test/runtest.sh

setexes:
. @chmod +x app.sh test/runtest.sh
