# Script to download all RDS logs for a DB instance
# requires AWS cli and jq.

export AWS_DEFAULT_REGION="eu-west-1"
#export AWS_ACCESS_KEY_ID=""
#export AWS_SECRET_ACCESS_KEY=""
 
DB=${1}
 
if [ -z ${DB} ]; then
  echo "Please pass an argument for the database.  E.g.:"
  echo "  ${0} my_rds_db"
fi
 
 
if [ -z ${SKIP_LOGFILES} ]; then
  echo "Downloading list of logfiles"
  aws rds describe-db-log-files --db-instance-identifier ${DB} | \
    jq ".DescribeDBLogFiles[].LogFileName" -r > ${DB}/logfiles
fi
 
test -d ${DB}/logs || mkdir ${DB}/logs
 
delfile=$(ls -1rt ${DB}/logs | tail -n 1)
echo "Deleting ${DB}/logs/${delfile}"
rm -f ${DB}/logs/${delfile}
while IFS='' read -r file; do
  portion="${DB}/logs/$(basename ${file})"
  LOG_URL=$(rds-logs-download-url ${DB} ${file})
  if [ ! -f ${portion}.gz ]; then
    echo $LOG_URL
    echo "Downloading ${portion}"
    wget --quiet -O ${portion} ${LOG_URL} 
    gzip ${portion}
  else 
    echo "Skipping ${portion}"
  fi
done < ${DB}/logfiles
