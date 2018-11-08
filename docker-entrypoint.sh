#!/bin/bash

[ -z "${PYTHONPATH}" ] || PYTHONPATH="${PYTHONPATH}:"

export PYTHONPATH=${PYTHONPATH}$(JARS=(/usr/local/lib/*.jar) ; IFS=:; echo "${JARS[*]}")

: ${DEFAULT_DEPTH:=24}

if [[ $RESOLUTION =~ ^([0-9]+)x([0-9]+)(x([0-9]+))?$ ]] ; then
    RESOLUTION=${BASH_REMATCH[1]}x${BASH_REMATCH[2]}x${BASH_REMATCH[4]:-${DEFAULT_DEPTH}}
    FFMPEGRES=${BASH_REMATCH[1]}x${BASH_REMATCH[2]}
else
    cat 1>&2 <<EOF

ERROR: Incorrect format for \$RESOLUTION variable, should be <width>x<height>[x<depth>].

If <depth> is not specified, it will default to ${DEFAULT_DEPTH}.

E.g. 1024x768x16
     512x512
     640x480x8

EOF
    exit 1
fi

: ${VIDCAP_FPS:=30}

echo "Starting with resolution: ${RESOLUTION}."
echo "Recording video at ${VIDCAP_FPS} fps."

cd /home/robot

if [ "$1" == "-c" ] ; then
    shift
    CMD="$*"
else
    CMD="/usr/local/bin/robot -d output $*"
fi

xvfb-run -s "-screen 0 ${RESOLUTION}" -a bash -c "
  twm &
  ffmpeg -framerate ${VIDCAP_FPS} -video_size ${FFMPEGRES} -f x11grab -i \${DISPLAY} -vcodec libx264 -preset ultrafast -qp 0 -pix_fmt yuv444p -r 25 -filter:v \"setpts=4.0*PTS\" output/video-capture.mkv > output/ffmpeg.log 2>&1 & 
  x11vnc -nolookup -forever -usepw </dev/null >/dev/null 2>&1 &
  eval ${CMD}
  ROBOT_STATUS=\$?
  kill -INT \$(jobs -p)
  exit \$ROBOT_STATUS
"
