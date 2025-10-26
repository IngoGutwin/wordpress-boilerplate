#!/bin/bash

set -euo pipefail

source .env

LOG_FILE="wordpress-update.log"

TMPFILE=$(mktemp)

cat > "$TMPFILE" <<EOF
# do a secure connection 
open -u "$FTP_USER","$FTP_PASS" sftp://$FTP_HOST;
mirror -R --verbose=3 \
$FTP_SOURCE_DIR $FTP_REMOTE_DIR;
quit
EOF

echo "lftp commands: " | tee -a "$LOG_FILE"
cat "$TMPFILE" | tee -a "$LOG_FILE"
echo "-----------------------"

lftp -f "$TMPFILE" > "$LOG_FILE" 2>&1;

if [ $? -eq 0 ]; then
  echo "deployment finished logs are in deployment.log";
else
  echo "deployment error logs are in deployment.log";
fi

rm "$TMPFILE"
