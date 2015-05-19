#!/usr/bin/env bash

cd `dirname $0`

for f in $(ls monitors/*.py)
do 
cat <(crontab -l) <(echo "*/5 * * * * python $(pwd)/$f") | crontab - 
done;
