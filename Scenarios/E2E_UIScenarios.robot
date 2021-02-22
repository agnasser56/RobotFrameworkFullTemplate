*** Settings ***
Documentation    Test Walem Web Portal
Library     Collections
Library     OperatingSystem
Resource   ${CURDIR}/../Common/CommonWeb.robot
Resource   ../Pages/Login.robot
Resource   ../Pages/Restaurant.robot
Resource   ../TestData/TestData.robot
Resource   ../APIs/RestaurantDetails.robot
Resource   ../APIs/IssuesAPIs.robot
Test Setup  Begin Web Test
Test Teardown  End Web Test


*** Variables ***

*** Test Cases ***
Verify User Login
    [Tags]  ui  TEST001
    [Documentation]  Covers User Login
    Navigate To Login Page
    Valid Login     ${WalemUser}

Verify Search Restaurant By Name
    [Tags]  ui  TEST002
    [Documentation]  Covers Search Restaurant By Name
    Navigate To Login Page
    Valid Login     ${WalemUser}
    Search Existing Restaurant      ${RestaurantDetails.RestaurantName}

Verify Search Restaurant By ID
    [Tags]  ui  TEST003
    [Documentation]  Covers Search Restaurant By ID
    Navigate To Login Page
    Valid Login     ${WalemUser}
    Search Existing Restaurant      ${RestaurantDetails.RestaurantId}

Verify Invalid Search Restaurant
    [Tags]  uiNegative  TEST004
    [Documentation]  Covers Negative Scenario when Search Restaurant By invalid id or name
    Navigate To Login Page
    Valid Login     ${WalemUser}
    Invalid Search      11111
    Invalid Search      */-


Verify Add Menu Image
    [Tags]  ui  TEST005
    [Documentation]  Covers Login by restaurant user and upload menu image
    Navigate To Login Page
    Valid Login     ${WalemRestaurantUser}
    Open Data Entry Page
    Add Menu Image   ${RestaurantDetails}

Verify Remove Menu Image
    [Tags]  ui  TEST006
    [Documentation]  Covers Login by restaurant user and upload menu image then remove it
    Navigate To Login Page
    Valid Login     ${WalemRestaurantUser}
    Open Data Entry Page
    Add Menu Image   ${RestaurantDetails}
    Remove Menu Image      ${RestaurantDetails}