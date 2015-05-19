#!/bin/bash
#########################################
#Usage:       sh cms_post.sh
#Author:      CMS Dev Team
#Company:     Aliyun Inc.
#Version:     1.0
#########################################

#parameters instructions
# $1: ali_uid, $2: metric_name, $3: metric_value, $4:fields

#convert current time to milliseconds
timestamp=`date +%s%N | cut -b1-13`
IFS=',' read -ra arr <<< "$4"
dimensions="{"
j=0
for i in "${arr[@]}"; do
    ((j = j + 1))
    IFS='=' read -ra kv <<< "$i"
    if [[ ! $j -eq ${#arr[@]} ]]; then
        dimensions=${dimensions}'"'${kv[0]}'":"'${kv[1]}'",'
    else
        dimensions=${dimensions}'"'${kv[0]}'":"'${kv[1]}'"'
    fi
done
dimensions=${dimensions}'}'
userId="$1"
namespace="acs/custom/$1"
metrics='[{"metricName":"'"$2"'","value":'"$3"',"unit":"None","timestamp":'"$timestamp"',"dimensions":'"$dimensions"'}]'
echo ${metrics}

url="http://open.cms.aliyun.com/metrics/put"
params="userId=$userId&namespace=$namespace&metrics=$metrics"
curl -G ${url} --data ${params}
