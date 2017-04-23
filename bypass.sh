#!/bin/bash

# 应用旁路系统入口，可以作一些应用初始化/运行状态变更/健康状态提交等

event=save;
app_name=${APP_NAME:-'k8stest'}
app_env=${APP_ENV:-'dev'}

url="http://local.cmdb.com?sBusiAlias=${app_name}&sEnv=${app_env}"

while true
do
    watcher=$(/data1/env/php-fpm/bin/php -f /data1/www/backend/vendor/bin/etcd-php etcd:watch /cmdb/${app_name}/${app_env});
    watcher=`echo ${watcher} | awk '{print $4}'`;
    if [ ${watcher} == $event ]; then
        echo ${watcher} >> /tmp/watcher.log
        wget "${url}" -O /data1/www/backend/.env
        env >> /data1/www/backend/.env
    else
        echo "Invalid parm:${watcher}"
    fi
done