#/usr/bin/env bash
#
if [ ! -d $1 ]; then
  echo "Directory '$1' does not exist... exiting"
  exit 1
fi
mkdir -p $2
cp -r $1/* $2/
