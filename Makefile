.RECIPEPREFIX=.

cleanlog:
. @>log/logfile.txt

run:
. @./app.sh

runtest:
. @xvfb-run -n 99 -s '-ac -screen 0 1026x760x24' xterm -fg white -bg black -geometry 170x58+0+0 -e test/runtest.sh

runtestview:
. @make runtest & ffplay -f x11grab -draw_mouse 0 -video_size 1026x760 :99

setexe:
. @chmod +x app.sh test/runtest.sh
