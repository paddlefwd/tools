#!/bin/bash
if [ $# -ne 1 ] ; then
    echo "wrong args"
else
    pip freeze > $1.requirements.txt
fi
