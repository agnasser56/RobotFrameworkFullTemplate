*** Settings ***
Documentation    Test Walem Web Portal
Library     Collections
Library     OperatingSystem
Resource   ${CURDIR}/../Common/CommonWeb.robot
Resource   ../TestData/TestData.robot
Resource   ../APIs/IssuesAPIs.robot


*** Variables ***

*** Test Cases ***

Verify Issues Scenarios
    [Tags]  api  TEST007
    [Documentation]  Covers Issues Scenarios(Create issue, get issue by id, get all issues, close issue)
    Verify Create Issue API   ${IssueDetails1}
    Verify Create Issue When Project Is Not Found   ${IssueDetails2}
    Verify Create Issue When User Is Not Authorized     ${IssueDetails3}
    Verify Get Issue Details By ID     ${IssueDetails4}
    Verify Get All Project Issues     ${IssueDetails4}
    Verify Close Issue     ${IssueDetails5}

Verify Issues Scenarios Chained
    [Tags]  api  TEST008
    [Documentation]  Covers User Login
    ${issueID} =  Verify Create Issue API   ${IssueDetails1}
    ${IssueDetails4.IssueId} =  Set Variable    ${issueID}
    Verify Get Issue Details By ID     ${IssueDetails4}
    ${IssueDetails5.IssueId} =  Set Variable    ${issueID}
    Verify Close Issue     ${IssueDetails5}