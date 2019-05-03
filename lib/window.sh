#!/bin/bash

#
# Caixa de alteração de senha de usuário
# @param {string} backtitle
# @returns {number}
#
function win_change_passwd() {
  dialog --colors --stdout --insecure                \
    --backtitle    "$1"                              \
    --title        '\Z0──\Zr Alterar senha \Zn'      \
    --passwordform '\nEntre com seus dados' 13 32 0  \
      'Senha atual' 1 2 '' 1 14 12 0                 \
      ''            2 2 '' 2 14  0 0                 \
      'Nova senha'  3 2 '' 3 14 12 0                 \
      ''            4 2 '' 4 14  0 0                 \
      'Confirmar'   5 2 '' 5 14 12 0
}

#
# Caixa de logon de usuário
# @param {string} backtitle
# @returns {number}
#
function win_logon() {
  dialog --colors --stdout --insecure                 \
    --no-ok --no-cancel                               \
    --backtitle "$1"                                  \
    --title     '\Z0──\Zr Entre com seus dados \Zn'   \
    --mixedform '\n Use ENTER (Ctrl+C: Sair)' 9 30 0  \
      'Usuário' 1 3 '' 1 11 12 0 0                    \
      ''        2 3 '' 2 11  0 0 2                    \
      'Senha'   3 3 '' 3 11 12 0 1
}

#
# Caixa de mensagens genérica
# @param {string} type (error|normal|question)
# @param {string} message
# @param {string} title
# @param {string} backtitle
# @returns {number}
#
function win_msgbox() {
  dialogrc='lib/normal.dialogrc'
  type='msgbox'
  case $1 in
    error)
      dialogrc='lib/error.dialogrc'
    ;;
    question)
      type='yesno'
    ;;
  esac
  DIALOGRC=$dialogrc dialog        \
    --colors --stdout              \
    --backtitle "$4"               \
    --title     "\Z0──\Zr $3 \Zn"  \
    --$type     "\n$2\n " 0 0
  code=$?
  test $1 == 'question' && echo $code
}

#
# Caixa de leitura de código de barras ou QR
# @param {string} backtitle
# @returns {number}
#
function win_read_code() {
  dialog --colors --stdout --insecure                  \
    --no-ok --no-cancel                                \
    --backtitle   "$1"                                 \
    --title       '\Z0──\Zr Entre com seus dados \Zn'  \
    --passwordbox '\n Passe o cartão na leitora' 7 50
}

#
# Menu genérico
# @param {string} backtitle
# @param {string} title
# @param {string} message
# @param {array}  items
# @returns {number}
#
function win_menu() {
  items=$((($# - 3) / 2))
  height=$((items + 10))
  dialog --colors --stdout            \
    --backtitle    "$1"               \
    --title        "\Z0──\Zr $2 \Zn"  \
    --cancel-label 'Sair'             \
    --menu         "\n$3\n "          \
    $height 70 $items "${@:4}"
}
