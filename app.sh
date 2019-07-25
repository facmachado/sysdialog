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

function do_about() {
  trap 'do_main_menu' INT
  win_msgbox null 'Sobre' "$APPTITLE\ngit: $(head -c 8 .git/refs/heads/master)"
  do_main_menu
}

function do_change_passwd() {
  trap 'do_main_menu' INT
  win_change_passwd
  do_main_menu
}

function do_login() {
  trap 'clear && exit' INT
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
      win_msgbox error 'Falha na autenticação'          \
        'Verifique suas credenciais e tente novamente'
      values=()
    fi
  done
}

function do_logout() {
  trap 'do_main_menu' INT
  option=$(win_msgbox question 'Sair' 'Deseja mesmo finalizar a sessão?')
  if (($option == 0)); then
    clear && exit 0
  else
    do_main_menu
  fi
}

function do_main_menu() {
  trap 'do_logout' INT
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
    7) do_about ;;
    *) do_logout ;;
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
