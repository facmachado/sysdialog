.RECIPEPREFIX=.

debug:
. @bash -x app.sh

run:
. @bash app.sh

runtest:
. @xdotool test/001-login.test.xdo
