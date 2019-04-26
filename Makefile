.RECIPEPREFIX=.

debug:
. @bash -x app.sh

run:
. @bash app.sh

runtest:
. @xdotool test/test.xdo
