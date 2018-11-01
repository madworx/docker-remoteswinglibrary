*** Settings ***
Library           Process

*** Test Cases ***
Test
   ${result} =     Run Process    compare  -metric  AE  -fuzz  15%  output/screenshot_2.jpg  output/vnc_screenshot.jpg   output/difference.png     timeout=10
   Log Many	stdout: ${result.stdout}	stderr: ${result.stderr}
