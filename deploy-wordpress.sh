#!/bin/bash

set -uo pipefail

if [ -f .env ]; then
  export $(grep -v "^#" .env | xargs)
else
  echo ".env file not found!"
  exit 1
fi

mkdir -p logs

EXLUDE_PATTERNS=(
  "public/.htaccess"
  "app.php"
  "composer.json"
  "composer.lock"
  "*/wp-content/"
  "vendor/"
)

LOG_FILE="logs/wordpress-update.log"
TMPFILE=$(mktemp)

EXLUDE_COMMANDS=""
for pattern in "${EXLUDE_PATTERNS[@]}"; do
  EXLUDE_COMMANDS+="--exclude-glob \"$pattern\" "
done

cat > "$TMPFILE" <<EOF
open --user "$FTP_USER" --password "$FTP_PASS" $FTP_HOST;
mirror -R --verbose=3 \
$EXLUDE_COMMANDS \
$FTP_SOURCE_DIR $FTP_REMOTE_DIR;
quit
EOF

echo "lftp commands: " | tee -a "$LOG_FILE"
cat "$TMPFILE" | tee -a "$LOG_FILE"
echo "-----------------------"

if lftp -f "$TMPFILE" > "$LOG_FILE" 2>&1; then
  echo "deployment finished logs are in $LOG_FILE." | tee -a "$LOG_FILE";
else
  echo "deployment error logs are in $LOG_FILE." | tee -a "$LOG_FILE";
fi

rm "$TMPFILE"
