#!/bin/bash

CHAT_ID="1120505307"
TELEGRAM_BOT_TOKEN="5976818915:AAGV-4d85-iV8JUqD10zfreArVI-9TsPYYI"
JOB_NUMBER=$1
TIME="15"
TEXT="PROJECT%3A%20$CI_PROJECT_NAME%0AURL%3A%20$CI_PROJECT_URL/pipelines/$CI_PIPELINE_ID/%0ABranch%3A%20$CI_COMMIT_REF_SLUG%0A$CI_JOB_STAGE%20status%3A%20JOB%20NUMBER%20$JOB_NUMBER%0ASTATUS%3A%20$CI_JOB_STATUS%0AAUTHOR%20$CI_COMMIT_AUTHOR"
DATA="chat_id=$CHAT_ID&disable_web_page_preview=1&text=$TEXT"
URL="https://api.telegram.org/bot$TELEGRAM_BOT_TOKEN/sendMessage"

curl -s --max-time $TIME -d $DATA $URL > /dev/null