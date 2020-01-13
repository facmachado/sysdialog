#!/bin/bash

#
# Caixa de alteração de senha de usuário
# @returns {number}
#
function win_change_passwd() {
  dialog --colors --stdout --insecure --clear          \
    --ok-label     'OK'                                \
    --cancel-label 'Sair'                              \
    --backtitle    "$APPTITLE"                         \
    --title        '\Z7\Zr──\Zn\Zb Alterar senha \Zn'  \
    --passwordform '\nEntre com seus dados' 13 35 0    \
    'Senha atual' 1 3 '' 1 16 12 0                     \
    'Nova senha'  3 3 '' 3 16 12 0                     \
    'Confirmar'   5 3 '' 5 16 12 0
}

#
# Caixa de logon de usuário
# @returns {number}
#
function win_logon() {
  dialog --colors --stdout --insecure --clear  \
    --ok-label     'OK'                        \
    --cancel-label 'Sair'                      \
    --backtitle "$APPTITLE"                    \
    --title     '\Z7\Zr──\Zn\Zb Iniciar \Zn'   \
    --mixedform '' 9 31 0                      \
    'Usuário' 1 3 '' 1 12 12 0 0               \
    'Senha'   3 3 '' 3 12 12 0 1
}

#
# Menu genérico
# @param {string} title
# @param {string} message
# @param {array}  items
# @returns {number}
#
function win_menu() {
  items=$((($# - 2) / 2))
  height=$((items + 10))
  dialog --colors --stdout --clear               \
    --ok-label     'OK'                          \
    --cancel-label 'Sair'                        \
    --backtitle    "$APPTITLE"                   \
    --title        "\\Z7\\Zr──\\Zn\\Zb $1 \\Zn"  \
    --menu         "\\n$2\\n "                   \
    $height 60 $items "${@:3}"
}

#
# Caixa de mensagens genérica
# @param {string} type (null|error|question)
# @param {string} title
# @param {string} message
# @returns {number}
#
function win_msgbox() {
  dialogrc='lib/normal.dialogrc'
  type='msgbox'
  case $1 in
    error) dialogrc='lib/error.dialogrc' ;;
    question) type='yesno' ;;
  esac
  DIALOGRC=$dialogrc dialog                   \
    --colors --stdout --clear                 \
    --ok-label  'OK'                          \
    --backtitle "$APPTITLE"                   \
    --title     "\\Z7\\Zr──\\Zn\\Zb $2 \\Zn"  \
    --$type     "\\n$3\\n " 0 0
  code=$?
  test "$1" == 'question' && echo $code
}

#
# Caixa de leitura de código de barras ou QR
# @returns {number}
#
function win_read_code() {
  dialog --colors --stdout --insecure --clear   \
    --no-ok --no-cancel                         \
    --backtitle   "$APPTITLE"                   \
    --title       '\Z7\Zr──\Zn\Zb Iniciar \Zn'  \
    --passwordbox '\n Passe o cartão na leitora' 7 50
}
