*** Settings ***
Library           RemoteSwingLibrary    debug=True
Library           Screenshot

*** Test Cases ***
Test
   Start Application  Test  java -cp /home/robot MinimalSwingApplication   30    close_security_dialogs=True
   Select Main Window
   Take Screenshot
   Push Button        OK
   Dialog Should Be Open    Dialup
   Take Screenshot
