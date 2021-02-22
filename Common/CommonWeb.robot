*** Settings ***
Library     SeleniumLibrary
Library     Collections
Library     OperatingSystem
Library     String

*** Variables ***
#Configuration
${EnvironmentSheet}
${LoginSheet}
${dicItems}

#these vars are for the common web pages elements
${ddlReportStatus}	  id=selection
${btnSearch}		  xpath=//a[contains(@ng-click,'searchRequests()')]
${btnConfirmRequest}  xpath=//a[contains(@ng-click,'afterUserCreateRequest()')]
${tblSearchResults}   xpath=//table/descendant::td[contains(text(),'<SeqNo>')]
${divLoader}        xpath=(//div[contains(@class,'loader-wrapper')])[1]
#Common Web Elements
${lblSuccessMessage}    xpath=//div[contains(@class,'alert-success')]
${LogOut}           xpath=//a[@ng-click='logout()']
${elemNotExist}         xpath=//butt[contains(text(),'بنجاح')]
${MainConnectionString}      pymssql  ${DBName}  ${DBUser}  ${DBPass}  ${DBHost}  ${DBPort}

${DBHost}         000.000.00.00
${DBName}         dbuser
${DBPass}         dbPass
${DBPort}         1433
${DBUser}         admin
${btnCloseSuccessMessage}   xpath=(//button[@class='close'])[1]

*** Keywords ***

Begin Web Test
    #Set Global Variables
    Set Library Search Order  ExtendedSelenium2Library   Selenium2Library  SeleniumLibrary
    Create Webdriver    Chrome    executable_path=${CURDIR}/../Drivers/chromedriver.exe
    Go To  https://uatc.walem.io/home
    Maximize Browser Window
    #Set Selenium Speed	0.25 second
    Set Selenium Timeout	20 seconds
    Set Selenium Implicit Wait  20 seconds

End Web Test
    log  finished
    Close Browser
  
Element Exists
    [Documentation]  Determines if the desired element exists
    [Arguments]  ${xpath}
    ${elemCount} =  Get Matching Xpath Count  ${xpath}
    ${imageExists} =  Evaluate  ${elemCount} > 0
    log  ${imageExists}
    [Return]  ${imageExists}

Check Element Exists
    [Documentation]  Determines if the desired element exists
    [Arguments]  ${xpath}
    ${xpath} =  remove string  ${xpath}  xpath=
    log  ${xpath}
    ${imageCount} =  Get Matching Xpath Count  ${xpath}
    ${imageExists} =  Evaluate  ${imageCount} > 0
    [Return]  ${imageExists}

Read Excel sheets
    [Arguments]   ${SheetName}  ${Type}

    ${tuple} =     Read From Excel
                    ...  Microsoft Excel Driver (*.xls, *.xlsx, *.xlsm, *.xlsb)
                    ...  ${DATA_FOLDER}EFADA_RF_ControlFile.xlsx
                    ...  Select * from [${SheetName}]
                    ...  ${Type}
    return from keyword       ${tuple}
    set selenium timeout

Load Environment Sheet
    #Create dictionary   ${Environment}
    ${tuple}=   Read Excel sheets   Environment$    dict
    Set global variable  ${EnvironmentSheet}  ${tuple}
    log  ${tuple['RunType']}


Load Login Sheet
    #Create dictionary   ${Environment}
    ${tuple}=   Read Excel sheets   LogIn$  list
    Set global variable  ${LoginSheet}  ${tuple}
    log  ${LoginSheet}


Execute DataBase Script
    [Arguments]   ${sqlStatement}
     log  ${sqlStatement}
     Connect To Database         pymssql  ${DBName}  ${DBUser}  ${DBPass}  ${DBHost}  ${DBPort}
     execute sql string          ${sqlStatement}

Get Element Text
    [Arguments]  ${elem}
    wait until page contains element   ${elem}
    ${elemInnerText} =  get text  ${elem}
    should be equal  ${elemInnerText}  English
    [Return]  ${elemInnerText}

Wait Until Page Loads
    Wait Until Element Is Not Visible  ${divLoader}  7 seconds

JS Click
    [Arguments]  ${element}
    ${elemToBeChecked} =  Get WebElement    ${element}
    sleep   1 second
    Execute JavaScript	arguments[0].click(); 	ARGUMENTS	${elemToBeChecked}

Mouse Click
    [Arguments]  ${element}
    Mouse Down	${element}
    Mouse Up	${element}

Table Has Values
    [Arguments]  ${eleme}
    ${count} =	Get Element Count   ${eleme}
    [return]  ${count}

Close Susccess Message
    sleep   1 second
    Click Button    ${btnCloseSuccessMessage}


Select Option JS
    [Arguments]  ${Element}     ${Value}
    Scroll Element Into View  ${Element}
    Js Click   ${Element}
    Wait Until Element Is Visible   xpath=//span[contains(text(), '${Value}')]/parent::mat-option  10 Seconds
    Click Element   xpath=//span[contains(text(), '${Value}')]/parent::mat-option

Select Option
    [Arguments]  ${Element}     ${Value}
    Scroll Element Into View  ${Element}
    Click Element   ${Element}
    Wait Until Element Is Visible   xpath=(//span[contains(text(), '${Value}')]/ancestor::mat-option)[1]  10 Seconds
    Click Element   xpath=(//span[contains(text(), '${Value}')]/ancestor::mat-option)[1]
    # Click Element   xpath=(//span[contains(text(), '${Value}')]/parent::span/parent::mat-option)[1]
Click Next Button
    [Arguments]  ${Element}
    Execute Javascript      document.getElementsByClassName('btn btn-next btn-fill btn-rose btn-wd ladda-button')[1].click();

Scroll Then Click
    [Arguments]  ${element}
    Scroll Element Into View  ${element}
    Click Element   ${element}

Click Toggle
    [Arguments]  ${element}     ${value}
    ${itemClass} =  Run Keyword    Get Element Attribute	${element}	class
    Run Keyword Unless    "mat-checked" in "${itemClass}" and "${value}"=="FALSE"    Click Element   ${element}
    Run Keyword Unless    "mat-checked" not in "${itemClass}"   Click Element   ${element}
    # and ${value}=="TRUE"


Increment Variable
    [Arguments]  ${n}   ${seed}
    ${n} =  Convert To Integer  ${n}
    ${seed} =  Convert To Integer  ${seed}
    ${n} =  Set Variable    ${n+${seed}}
    [Return]   ${n}