#!/bin/bash

# Add your Blitz conviguration variables
BLITZ_SERVICE_ID=""
BLITZ_USER_ID=""
BLITZ_SERVICE_KEY=""

# Get the unicode char for the service/host status
case "${3}" in
   "CRITICAL")  ICON="U+2757" ;;
   "UNREACHABLE")   ICON="U+2757" ;;
   "DOWN") ICON="U+2757" ;;
   "WARNING")      ICON="U+26A0" ;;
   "OK")  ICON=":white_check_mark:" ;;
   "UP")  ICON="U+2705" ;;
   "UNKNOWN") ICON="U+2754" ;;
   *) ICON="U+2B1C" ;;
esac

#Send message to Blitz
curl -X POST --data "${ICON} HOST: ${1} SERVICE: ${2} MESSAGE: ${4}" "http://api.blitzalert.me/send?service=${BLITZ_SERVICE_ID}&user=${BLITZ_USER_ID}&auth=${BLITZ_SERVICE_KEY}"
