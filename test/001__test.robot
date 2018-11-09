*** Settings ***
Library           RemoteSwingLibrary    debug=True
Library           Screenshot
Resource          resources.txt

*** Test Cases ***
Test simple operations and take screenshot
   Start Test Application
   Present Dialup Dialog
   Take Screenshot
   Sleep  1
   Close Application