#!/bin/bash

this="${BASH_SOURCE-$0}"
bin=$(cd -P -- "$(dirname -- "$this")" && pwd -P)
if [ -f "${bin}/../conf/env.sh" ]; then
  set -a
    echo
	echo
	echo Running ${bin}/../conf/env.sh  
  . "${bin}/../conf/env.sh"
  set +a
fi
echo
echo
COMPRESS_GLOBAL=0
APP=streaming
INPUT_HDFS=${DATA_HDFS}/LinearRegression/Input
OUTPUT_HDFS=${DATA_HDFS}/${APP}/Output
if [ ${COMPRESS_GLOBAL} -eq 1 ]; then
    INPUT_HDFS=${INPUT_HDFS}-comp
    OUTPUT_HDFS=${OUTPUT_HDFS}-comp
fi

# either stand alone or yarn cluster
APP_MASTER=${SPARK_MASTER}

set_gendata_opt
set_run_opt

#input benreport

function print_config(){
               get_config_values $1 $2 $3 $4 $5 $6
}


function get_config_fields(){
local report_field=$(get_report_field_name)
echo -n "#${report_field},AppType,nExe,driverMem,exeMem,exeCore,nPar,nIter,memoryFraction,NUM_OF_EXAMPLES,NUM_OF_FEATURES,NUM_OF_PARTITIONS,class_c,class-r, impurity-c,impurity-c, maxDepth-c,maxDepth-r, maxbin-c,maxbin-r, mode-c,modeR"
echo -en "\n"

}
function get_config_values(){
      gen_report $1 $2 $3 $4 $5 $6
      echo -n ",${APP}-MLlibConfig,$nexe,$dmem,$emem,$ecore,${NUM_OF_EXAMPLES},${NUM_OF_FEATURES},${EPS},${NUM_OF_PARTITIONS},${INTERCEPTS},${MAX_ITERATION},${memoryFraction},${STEP_SIZE},$noise,${lambda},${miniBatch},${sparseness},${convergenceTol}"
       echo -en "\n"
       return 0
}

