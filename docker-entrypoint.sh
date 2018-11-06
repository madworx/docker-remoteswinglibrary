#!/bin/bash

[ -z "${PYTHONPATH}" ] || PYTHONPATH="${PYTHONPATH}:"

export PYTHONPATH=${PYTHONPATH}$(JARS=(/usr/local/lib/*.jar) ; IFS=:; echo "${JARS[*]}")

: ${DEFAULT_DEPTH:=24}

if [[ $RESOLUTION =~ ^([0-9]+)x([0-9]+)(x([0-9]+))?$ ]] ; then
   RESOLUTION=${BASH_REMATCH[1]}x${BASH_REMATCH[2]}x${BASH_REMATCH[4]:-${DEFAULT_DEPTH}}
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

echo "Starting with resolution: ${RESOLUTION}."

cd /home/robot

xvfb-run -s "-screen 0 ${RESOLUTION}" -a bash -c "
  twm &
  ffmpeg -loglevel panic -hide_banner -framerate 25 -f x11grab -i \${DISPLAY} output/video-capture.mpg &
  x11vnc -nolookup -forever -usepw </dev/null >/dev/null 2>&1 & 
  /usr/local/bin/robot -d output '$@'
  ROBOT_STATUS=\$?
  kill \$(jobs -p)
  exit \$ROBOT_STATUS
"
