#!/bin/bash

[ -z "${PYTHONPATH}" ] || PYTHONPATH="${PYTHONPATH}:"

export PYTHONPATH=${PYTHONPATH}$(JARS=(/usr/local/lib/*.jar) ; IFS=:; echo "${JARS[*]}")

cd /home/robot
xvfb-run -s "-screen 0 ${RESOLUTION}" -a bash -c "
  twm &
  x11vnc -nolookup -forever -usepw </dev/null >/dev/null 2>&1 & 
  /usr/local/bin/robot -d output '$@'
  kill \$(jobs -p)
" <(echo '${VNCPASSWORD}')
