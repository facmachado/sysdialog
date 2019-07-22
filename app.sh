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

function do_change_passwd() {
  win_change_passwd
  do_main_menu
}

function do_login() {
  declare -a values
  while :; do
    while IFS=$'\n' read -r line; do
      if [ $line ]; then
        values+=("$(printf '%s' $line|sha1sum -b|awk '{print $1}')")
      fi
    done < <(win_logon)
    bar=$(win_read_code)
    if ((${#values[@]} > 1 && ${#bar} > 0)); then
      # echo "${values[@]}"
      do_main_menu
      break
    else
      win_msgbox error                  \
        'Usuário e senha obrigatórios'  \
        'Falha na autenticação'
      values=()
    fi
  done
}

function do_main_menu() {
  trap 'do_main_menu' INT
  declare -p list
  readarray -t lines < <(jq -c '.menus[0].items[]' lib/menu.json | tr -d \")
  list=()
  for k in "${!lines[@]}"; do
    list+=($((k + 1)) "${lines[k]}")
  done
  option=$(win_menu             \
    'Menu principal'            \
    'Escolha a opção desejada'  \
    "${list[@]}")
  case $option in
    1|2|3|4|5) do_main_menu ;;
    6) do_change_passwd ;;
  esac
}

do_login

# win_logon "$APPTITLE"
# win_read_code "$APPTITLE"
# win_msgbox error                                  \
#   'Verifique suas credenciais e tente novamente'  \
#   'Falha na autenticação'                         \
#   "$APPTITLE"
# win_change_passwd "$APPTITLE"

# exit 0
