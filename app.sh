#!/bin/bash

test ! -x "$(which curl)"                               \
  -o ! -x "$(which dialog)"                             \
  -o ! -x "$(which jq)"                                 \
  && echo 'This program requires curl, dialog and jq.'  \
  && exit 1

# readonly name="$(basename $0|cut -d. -f1)"
# readonly config="$(dirname $0)/$name.conf"
# readonly pidfile="/var/run/$name.pid"

source lib/app.conf
source lib/api.sh
source lib/window.sh

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
# win_menu                                             \
#   "$APPTITLE"                                        \
#   'Menu principal'                                   \
#   'Escolha a opção desejada'                         \
#   1 'Item correspondente à opção 1 (abre o menu 1)'  \
#   2 'Item correspondente à opção 2 (abre o menu 2)'  \
#   3 'Item correspondente à opção 3 (abre o menu 3)'  \
#   4 'Item correspondente à opção 4 (abre o menu 4)'  \
#   5 'Item correspondente à opção 5 (abre o menu 5)'  \
#   6 'Item correspondente à opção 6 (abre o menu 6)'  \
#   7 'Item correspondente à opção 7 (abre o menu 7)'  \
#   8 'Item correspondente à opção 8 (abre o menu 8)'  \
#   9 'Item correspondente à opção 9 (abre o menu 9)'  \
#   0 'Item correspondente à opção 0 (abre o menu 0)'

exit 0
