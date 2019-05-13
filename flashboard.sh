#! /usr/bin/env bash
ROOT=`pwd`
MDLOADER=${ROOT}/mdloader
args=false
hex="empty"
while getopts hx: opt ; do
  case ${opt} in
    h)
      echo "Usage: for use with a QMK keyboard"
      echo ""
      echo "-x local_path/<keyboard_keymap>.hex"
      echo ""
      exit 0
    ;;
    x) args=true; hex=${OPTARG}
    ;;
  esac
done

if ! $args ; then
  echo "Error: Invalid inputs."
  echo ""
  echo "    Please try \"-h\" for a usage statement."
  echo ""
  exit 0
fi

echo ${hex}
cd $MDLOADER && make && sudo build/mdloader --first --download ${hex} --restart
