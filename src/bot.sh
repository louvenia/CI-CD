#!/bin/bash

CHAT_ID="325802494"
BOT_ID="5774186048:AAE86k3YhY77d2uVU_5K2MXvRGQl8MaRKj0"
JOB_NUMBER=$1

EMOJI=""
if [[ $CI_JOB_STATUS == "success" ]]; then
    EMOJI="✅"
elif [[ $CI_JOB_STATUS == "failed" ]]; then
    EMOJI="🚫"
fi

MESSAGE_TEXT="PROJECT+%24$CI_PROJECT_NAME+status%3A+JOB+($JOB_NUMBER+of+4)+JOB+NAME%3A+$CI_JOB_STAGE+STATUS%3A+$CI_JOB_STATUS+$EMOJI+TRIGGERED+BY%3A+$CI_COMMIT_AUTHOR"
MESSAGE="chat_id=$CHAT_ID&text=$MESSAGE_TEXT"
URL="https://api.telegram.org/bot$BOT_ID/sendMessage"

curl -s -m 12 -d $MESSAGE $URL > /dev/null
