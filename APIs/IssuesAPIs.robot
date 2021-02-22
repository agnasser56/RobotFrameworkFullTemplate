*** Settings ***
Documentation    Suite description
Library         REST    https://jsonplaceholder.typicode.com
Library     JSONLibrary
Resource        ../TestData/TestData.robot


*** Keywords ***
Verify Create Issue API
    [Arguments]  ${IssueDetails}
    [Documentation]   ...  Test issue creation when project code is  found, status code 201
    Set Headers     {"PRIVATE-TOKEN":"${IssueDetails.PrivateToken}"}
    ${newIssueDetails} =   POST        ${APIURLs.APIURL}/api/v4/projects/${IssueDetails.ProjectID}/issues?title=${IssueDetails.Title}
    Integer  response status    200
    String   response body title   "${IssueDetails.Title}"
    output     response
    ${newIssueDetails} =  Get Value From Json   ${newIssueDetails}    	 $.body.iid
    [Return]  ${newIssueDetails}[0]

Verify Create Issue When Project Is Not Found
    [Arguments]  ${IssueDetails}
    [Documentation]   ...  Test issue creation when project code is not found, status code 404
    Set Headers     {"PRIVATE-TOKEN":"${IssueDetails.PrivateToken}"}
    POST        ${APIURLs.APIURL}/api/v4/projects/${IssueDetails.ProjectID}/issues?title=${IssueDetails.Title}
    Integer  response status    404
    String   response body message   "404 Project Not Found"
    output     response

Verify Create Issue When User Is Not Authorized
    [Arguments]  ${IssueDetails}
    [Documentation]   ...  Test issue creation when project code is not found, status code 404
    Set Headers     {"PRIVATE-TOKEN":"${IssueDetails.PrivateToken}"}
    POST        ${APIURLs.APIURL}/api/v4/projects/${IssueDetails.ProjectID}/issues?title=${IssueDetails.Title}
    Integer  response status    401
    String   response body message   "401 Unauthorized"
    output     response

Verify Get Issue Details By ID
    [Arguments]  ${IssueDetails}
    [Documentation]   ...  Covered Test Case : Get Issue Details
    Set Headers     {"PRIVATE-TOKEN":"${IssueDetails.PrivateToken}"}
    GET        ${APIURLs.APIURL}/api/v4/projects/${IssueDetails.ProjectID}/issues/${IssueDetails.IssueId}
    Integer  response status    200
    Integer   response body iid   ${IssueDetails.IssueId}
    output     response

Verify Get All Project Issues
    [Arguments]  ${IssueDetails}
    [Documentation]   ...  Covered Test Case : Get All issues in a specific project Issue Details
    Set Headers     {"PRIVATE-TOKEN":"${IssueDetails.PrivateToken}"}
    GET        ${APIURLs.APIURL}/api/v4/projects/${IssueDetails.ProjectID}/issues
    Integer  response status    200
    output     response

Verify Close Issue
    [Arguments]  ${IssueDetails}
    [Documentation]   ...  Covered Test Case : update issue status to closed
    Set Headers     {"PRIVATE-TOKEN":"${IssueDetails.PrivateToken}"}
    PUT        ${APIURLs.APIURL}/api/v4/projects/${IssueDetails.ProjectID}/issues/${IssueDetails.IssueId}?state_event=close
    Integer  response status    200
    String   response body state   "closed"
    output     response
