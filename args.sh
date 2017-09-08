#!/bin/bash
EPOCH=40
MINN=3
MAXN=10
BUCKET=70000
DIM=400
INPUT_PATH="../data"
OUTPUT_PATH="."
SCRIPT_PATH="."
echo $@
while getopts "hb:d:e:m:x:i:o:s:" OPTION; do
    case $OPTION in
        h)  echo "$(basename $0) [-h] [-b BUCKET] [-d DIM] [-e EPOCH] [-m MINN] [-x MAXN] [promptId1 [...]]"
            echo ""
            echo "Run 'fasttext supervised' on the all/given prompts."
            echo ""
            echo "Options:"
            echo "  -b BUCKET"
            echo "      number of buckets [$BUCKET]"
            echo "  -d DIM"
            echo "      size of word vectors [$DIM]"
            echo "  -e EPOCH"
            echo "      number of epochs [$EPOCH]"
            echo "  -m MINN"
            echo "      min length of char ngram [$MINN]"
            echo "  -x MAXN"
            echo "      max length of char ngram [$MAXN]"
            echo ""
            echo "Path Options:"
            echo "  -i INPUT_PATH"
            echo "      path to the input train/test set files [$INPUT_PATH]"
            echo "  -o OUTPUT_PATH [$OUTPUT_PATH]"
            echo "      path to write results file(s) to [$OUTPUT_PATH]"
            echo "  -s SCRIPT_PATH [$SCRIPT_PATH]"
            echo "      full path to your [/your/path/here]/111-research/topics2017/alerts_modeling/src"
            exit 0
            ;;  
        e)  EPOCH=$OPTARG ;;
        m)  MINN=$OPTARG ;;
        x)  MAXN=$OPTARG ;;
        b)  BUCKET=$OPTARG ;;
        d)  DIM=$OPTARG ;;
        i)  INPUT_PATH=$OPTARG ;;
        o)  OUTPUT_PATH=$OPTARG ;;
        s)  SCRIPT_PATH=$OPTARG ;;
    esac
done
shift $(expr $OPTIND - 1 )
if [ -z `which fasttext` ] ; then
    echo "'fasttext' must be available in your PATH"
fi
if [ ! -f "${SCRIPT_PATH}/get_results.py" ] ; then
    echo "get_results.py not found under $SCRIPT_PATH directory. Use '-s' to specify loaction."
fi 
if [ $# -eq 0 ] ; then
    fastText supervised -input ${INPUT_PATH}/first_read_alerts_data_set_.train -output first_read_alerts -epoch ${EPOCH} -minn ${MINN} -maxn ${MAXN} -bucket ${BUCKET} -dim ${DIM}
    fastText predict-prob first_read_alerts.bin ${INPUT_PATH}/first_read_alerts_data_set_.test > ${OUTPUT_PATH}/results.txt
    python ${SCRIPT_PATH}/get_results.py --input-file ${INPUT_PATH}/first_read_alerts_data_set_.test
else
    while [ $# -gt 0 ] ; do
        fastText supervised -input ../data/alerts_data_set_$1.train  -output first_read_alerts -epoch ${EPOCH} -minn ${MINN} -maxn ${MAXN} -bucket ${BUCKET} -dim ${DIM}
        fastText predict-prob alerts_model_$1.bin ${INPUT_PATH}/alerts_data_set_$1.test > ${OUTPUT_PATH}/results.txt
        python ${SCRIPT_PATH}/get_results.py --input-file ${INPUT_PATH}/alerts_data_set_$1.test
        shift
    done
fi
