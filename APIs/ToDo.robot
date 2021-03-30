*** Settings ***
Documentation    Suite description
Library         REST    https://jsonplaceholder.typicode.com
Library     JSONLibrary
Resource        ../TestData/TestData.robot



*** Keywords ***
Verify Get To Do Item
    [Documentation]   ...  Test get to do item, return "userId": 1
    GET        https://jsonplaceholder.typicode.com/todos/1
    Integer  response status    200
    