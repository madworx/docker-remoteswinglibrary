*** Settings ***
Library           Process

*** Test Cases ***
Compare RF and VNC screenshots
   ${result} =     Run Process    compare  -metric  AE  -fuzz  8%   output/screenshot_1.jpg  output/vnc_screenshot.jpg   output/difference.png     timeout=10
   Log Many	stdout: ${result.stdout}	stderr: ${result.stderr}
   Should Be Equal As Integers	${result.rc}	0
   Log  <img src="difference.png" />  html=true
