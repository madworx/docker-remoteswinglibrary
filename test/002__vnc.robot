*** Settings ***
Library           RemoteSwingLibrary    debug=True
Library           Process

*** Test Cases ***
Start application and take a screenshot via VNC
   Start Application  Test  java -cp /home/robot MinimalSwingApplication   30    close_security_dialogs=True
   Select Main Window
   Push Button        OK
   Dialog Should Be Open    Dialup
   Select Dialog            Dialup

   ${result} =     Run Process   ./vnccapture.py   timeout=10
   Log Many	stdout: ${result.stdout}	stderr: ${result.stderr}

   Push Button        OK
   Close Window       Test Frame
