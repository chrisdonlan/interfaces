#! /usr/bin/env bash
MDLOADER=/home/cdonlan/interface/mdloader
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
cd $MDLOADER && sudo ./mdloader_linux --first --download ${hex} --restart
