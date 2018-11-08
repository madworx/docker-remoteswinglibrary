*** Settings ***
Library           RemoteSwingLibrary    debug=True
Library           Process
Resource          resources.txt

*** Test Cases ***
Start application and take a screenshot via VNC
   Start Test Application
   Present Dialup Dialog
   ${result} =     Run Process   ./vnccapture.py   timeout=10
   Log Many	stdout: ${result.stdout}	stderr: ${result.stderr}
   Sleep  1
   Close Application
   