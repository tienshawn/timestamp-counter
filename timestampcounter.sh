#!/bin/bash
echo "Add timestamp to the video stream..."
/usr/local/nginx/sbin/nginx
echo "Start time count..."
# Add timestamp to keep track of fps

start_function() {
    export SOURCE_STREAM_URL="$(getent hosts $SOURCE_STREAM_SERVICE | awk '{ print $1 ;exit }'):$SOURCE_STREAM_PORT"
    echo "exported url of source stream: $SOURCE_STREAM_URL"
    #Start adding timestamp-counter
    ffmpeg -re -y -i "rtmp://$SOURCE_STREAM_URL/live/stream" \
    		-vf "drawtext=text='%{pts\:hms}': \
                          x=(w-tw)/2: y=h-(2*lh): \
                          fontsize=36: fontcolor=white: \
                          box=1: boxcolor=0x00000000@1" \
                -f flv rtmp://localhost/live/stream
    return
}
start_function
while true
do :
exit_status=$?
if [ "${exit_status}" -eq 0 ];
then
    start_function
fi
sleep 1
done
while true; do :; done
while true; do :; done
