#!/bin/sh

DIRNAME=$(dirname $1)
BASENAME=$(basename $1)
tar -h -C $DIRNAME --exclude=.git -h -czf - $BASENAME
