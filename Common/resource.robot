*** Settings ***
Library  OperatingSystem

Documentation     A resource file with reusable keywords and variables.

Library           SeleniumLibrary

*** Variables ***
${SERVER}         id.uatc.walem.io
${BROWSER}        Chrome
${DELAY}          20
${VALID USER}     walemuatadmin
${VALID PASSWORD}    Aa123456
${LOGIN URL}      https://${SERVER}/id/login
${WELCOME URL}    https://${SERVER}/welcome.html
${ERROR URL}      https://${SERVER}/error.html
${txtUserName}  id=login-username
${txtPassword}  id=login-username
${btnLogin}  id=btn-login

*** Keywords ***
Open Browser To Login Page
    SeleniumLibrary.Open Browser    ${LOGIN URL}    ${BROWSER}
    SeleniumLibrary.Maximize Browser Window
    SeleniumLibrary.Set Selenium Speed    ${DELAY}
    Login Page Should Be Open

Login Page Should Be Open
    Title Should Be    Identity

Go To Login Page
    Go To    ${LOGIN URL}
    Login Page Should Be Open

Input Username
    [Arguments]    ${username}
    Input Text  ${txtUserName}    ${username}

Input Password
    [Arguments]    ${password}
    Input Text    ${txtPassword}    ${password}

Submit Credentials
    Click Button    ${btnLogin}

Welcome Page Should Be Open
    Location Should Be    ${WELCOME URL}
    Title Should Be    Welcome Page
