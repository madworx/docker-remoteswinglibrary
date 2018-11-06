*** Settings ***
Library           RemoteSwingLibrary    debug=True
Library           Screenshot

*** Test Cases ***
Test simple operations and take screenshot
   Start Application  Test  java -cp /home/robot MinimalSwingApplication   30    close_security_dialogs=True
   Select Main Window
   Push Button        OK
   Dialog Should Be Open    Dialup
   Select Dialog            Dialup
   Push Button        OK
   Close Window       Test Frame

   Start Application  Test  java -cp /home/robot MinimalSwingApplication   30    close_security_dialogs=True
   Select Main Window
   Push Button        OK
   Dialog Should Be Open    Dialup
   Select Dialog            Dialup

   Take Screenshot


   Push Button        OK
   Close Window       Test Frame
