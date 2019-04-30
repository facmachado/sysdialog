#!/bin/bash

test ! -x "$(which curl)"                               \
  -o ! -x "$(which dialog)"                             \
  -o ! -x "$(which jq)"                                 \
  && echo 'This program requires curl, dialog and jq.'  \
  && exit 1

# readonly name="$(basename $0|cut -d. -f1)"
# readonly config="$(dirname $0)/$name.conf"
# readonly pidfile="/var/run/$name.pid"

source lib/api.sh
source lib/window.sh

APPTITLE='Sistema de aprendizado v.0.1'
DIALOGRC="$(readlink -f lib/normal.dialogrc)"
export DIALOGRC

function do_login() {
  declare -a values
  while :; do
    while IFS=$'\n' read -r line; do
      if [ $line ]; then
        values+=("$(printf '%s' $line|sha1sum -b|awk '{print $1}')")
      fi
    done < <(win_logon "$APPTITLE")
    if [ ${#values[@]} -gt 1 ]; then
      echo "${values[@]}"
      break
    else
      win_msgbox error                  \
        'Usuário e senha obrigatórios'  \
        'Falha na autenticação'         \
        "$APPTITLE"
      values=()
    fi
  done
}

do_login

# win_logon "$APPTITLE"
# win_read_code "$APPTITLE"
# win_msgbox error                                  \
#   'Verifique suas credenciais e tente novamente'  \
#   'Falha na autenticação'                         \
#   "$APPTITLE"
# win_change_passwd "$APPTITLE"
# win_menu                      \
#   "$APPTITLE"                 \
#   'Menu principal'            \
#   'Escolha a opção desejada'  \
#   item1 'desc1'               \
#   item2 'desc2'               \
#   item3 'desc3'               \
#   item4 'desc4'               \
#   item5 'desc5'               \
#   item6 'desc6'

exit 0
