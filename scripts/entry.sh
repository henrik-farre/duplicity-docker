#!/bin/bash

if [ -e /opt/scripts/$1 ]; then
    /opt/scripts/$@
else
    "$@"
fi
