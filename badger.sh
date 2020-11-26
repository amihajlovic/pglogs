# !/bin/bash

DB=${1}
test -d ${DB}/badger || mkdir ${DB}/badger
pgbadger/pgbadger -O ${DB}/badger -I ${DB}/logs/* 
#pgbadger/pgbadger -E -O ${DB}/badger -J 6 -j 6 -f stderr -p '%t:%r:%u@%d:[%p]:' -I ${DB}/logs/*
#pgbadger/pgbadger -E -O ${DB}/badger -J 6 -j 6 -f rds  -I ${DB}/logs/*

PDIR=/mnt/c/inetpub/wwwroot/${DB}
test -d ${PDIR} || mkdir ${PDIR}
rm -rf ${PDIR}/*
GLOBIGNORE='*.bin'
cp -r  ${DB}/badger/* ${PDIR}
