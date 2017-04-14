#!/bin/bash

echo "========== preparing ${APP} data =========="
# configure
bin=`dirname "$0"`
bin=`cd "$bin"; pwd`
DIR=`cd $bin/../; pwd`
. "${DIR}/../bin/config.sh"
. "${DIR}/bin/config.sh"


# paths check
#tmp_dir=${APP_DIR}/tmp
RM ${INPUT_HDFS}
MKDIR ${APP_DIR}
MKDIR ${INPUT_HDFS}
#RM $tmp_dir

START_TS=`get_start_ts`;
#MKDIR $tmp_dir
srcf=file:///${DIR}/src/resources/sample_data_set
echo  Copying from: srcf=file:///${DIR}/src/resources/sample_data_set
echo  to $INPUT_HDFS

START_TIME=`timestamp`
echo STARt Time: $START_TIME

echo "================================ "
echo CPFROM $srcf ${INPUT_HDFS}
echo "================================ "
echo
echo
CPFROM $srcf ${INPUT_HDFS}
echo
echo

res=$?;
END_TIME=`timestamp`

DU ${INPUT_HDFS} SIZE 
get_config_fields >> ${BENCH_REPORT}
print_config  ${APP} ${START_TIME} ${END_TIME} ${SIZE} ${START_TS} ${res}>> ${BENCH_REPORT};
exit 0



