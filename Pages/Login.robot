*** Settings ***
Documentation    Suite description
Library         SeleniumLibrary
Resource   ../Common/resource.robot

*** Variables ***
${lnkLogin}  xpath=//a[contains(@href,'login')]
${txtUserName}  id=login-username
${txtPassword}  id=login-password
${btnLogin}  id=btn-login
${chkLoginSuccess}  xpath=//div[@class='info']
${divUser}      xpath=//div[@class='user']/div[@class='info']
${lnkLogout}      xpath=//a[descendant::span[text()='Logout']]
${divError}      xpath=//div[@class='alert alert-danger' and contains(text(),'Bad Credentials')]]


*** Keywords ***
Navigate To Login Page
    Go To  https://uatc.walem.io/home
    wait until page contains element    ${lnkLogin}
    Click link  ${lnkLogin}

Valid Login
    [Arguments]  ${UserDetails}
    Input text   ${txtUserName}   ${UserDetails.UserName}
    Input text   ${txtPassword}   ${UserDetails.Password}
    click button  ${btnLogin}
    wait until page contains element   ${chkLoginSuccess}


Logout
    ${status}   ${value} =   Run keyword and ignore error  Page should contain Element      ${divUser}  5 seconds
    Run Keyword if  '${status}' == 'PASS'  Do Logout

Do Logout
    Click Element   ${divUser}
    Click Link      ${lnkLogout}