#!/bin/sh
set -e

# These will be sent directly from HomeAssistant
CONTENT=${1:?"missing arg 1 for CONTENT"} 
TB_DEVICEID=${2:?"missing arg 2 for DEVICE ID"}
TB_TOKEN=${3:?"missing arg 3 for TOKEN"}
CONTENT_TYPE=${4:?"missing arg 4 for CONTENT_TYPE"}

rm -r /tmp/*

case "$CONTENT_TYPE" in
	"builtin") 
		ROOT_DIR=/opt/display ;;
	"custom")
		ROOT_DIR=/homeassistant/tidbyt ;;
esac

RENDER_PATH=/tmp/render.webp

cp $ROOT_DIR/$CONTENT.star /tmp/$CONTENT.star -f
/usr/local/bin/pixlet render /tmp/$CONTENT.star -o $RENDER_PATH

/usr/local/bin/pixlet push --api-token $TB_TOKEN $TB_DEVICEID $RENDER_PATH

exit 0
