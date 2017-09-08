#!/bin/bash
EPOCH=10
MINN=3
args=( )
PROMPTS=( )
for arg in "$@"; do
    case "$arg" in
        --help)     args+=( -h ) ;;
        --epoch)    args+=( -e ) ;;
        --minn)     args+=( -m );;
    esac
done

set -- "${args[@]}"
echo $@
echo "OPTIND $OPTIND"
while getopts "he:m:" OPTION; do
    case $OPTION in
        h)  echo "$0 [--epoch|-e <number of epochs> --minn|-m <min N> [promptId1 promptId2 ...]]"
            exit 0
            ;;  
        e)  EPOCH=$OPTARG ;;
        m)  MINN=$OPTARG ;;
        *)  PROMPTS+=$OPTION ;;
    esac
    echo "OPTIND $OPTIND $# $PROMPTS"
done
echo "E $EPOCH"
echo "M $MINN"
if [ $# -eq 0 ] ; then
    echo "generic"
else
    echo $@
    echo "OPTIND $OPTIND $#"
    shift $((OPTIND - 1))
    echo "OPTIND $OPTIND $#"
    echo $@
    while [ $# -ne 0 ] ; do
       echo ">> $1"
    done 
fi
