*** Settings ***
Documentation    Suite description
Resource   ../TestData/TestData.robot
Library    DateTime
*** Variables ***
${txtRestaurantName}    name=restaurantName
${txtRestaurantNameAr}  name=restaurantNameAr
${txtSearchRestaurant}      xpath=//input[@placeholder='Search Records']
${btnClose1}     xpath=(//descendant::button[contains(text(),'Close')])[1]
${btnCrop}     xpath=//button[descendant::span[contains(text(),'Crop')]]
${fileDisplayPicture}   name=displayPicture
${chkErrorMessage}      xpath=//span[contains(text(),'Form is not valid')]
${btnFinish}      xpath=//button[descendant::span[contains(text(),'Finish')]]


# Data entry section
${lnkDataEntry}      xpath=//a[contains(@href,'/restaurant/data-entry')]
${fileUploadMenu}       id=data-entry-picture
${btnSaveMenu}       xpath=//span[contains(text(),'Save')]/parent::button
${chkMenuUploadedSuccessfully}       xpath=//span[contains(text(),'Data Entry updated successfully.')]
${chkMenuImageRemovedSuccessfully}       xpath=//span[contains(text(),'File deleted successfully.')]


# Product Page Elements
${btnEditProduct}       xpath=(//div[@class='walem-ngx-datatable-wrapper ng-star-inserted']/descendant::button[descendant::i[text()='edit']])[1]
${imgProductPhoto}      name=image
${btnCropImage}         xpath=//span[contains(text(),'Crop')]/parent::button
${btnRemoveImage}       xpath=//a[contains(text(),'Remove')]
${ddlCategories}    //mat-select[@name='kitchen-categories']
${btnSaveAndFinish}     xpath=//button[descendant::span[text()='Save & Finish']]
${chkproductsavedsuccess}       xpath=//span[contains(text(),'Your item has been saved successfully')]
#################################################


*** Keywords ***

#Navigation
Go To Register Restaurant Page
    Go To   ${ApplicationURLs.CurrentEnvironment}/join
    Wait Until Page Contains Element    ${txtRestaurantName}

Open Data Entry Page
    Click Link       ${lnkDataEntry}

#Business Scenarios
Search Existing Restaurant
    [Arguments]     ${SearchKey}
    Input Text      ${txtSearchRestaurant}      ${SearchKey}
    Wait Until Page Contains Element     xpath=//ngx-datatable/descendant::span[text()='${SearchKey}']

Invalid Search
    [Arguments]     ${SearchKey}
    Input Text      ${txtSearchRestaurant}      ${SearchKey}
    Wait Until Page Contains Element     xpath=//div[text()='No data to display']

Open Restuarnat Details
    [Arguments]     ${SearchKey}
    Click Element       xpath=//span[text()='${SearchKey}']/ancestor::div[@class='datatable-row-center datatable-row-group ng-star-inserted']

Add Menu Image
    [Arguments]     ${TestData}
    Choose File	    ${fileUploadMenu}      	${TestData.DisplayPicture}       
    ${ImageName} =  Fetch From Right     ${TestData.DisplayPicture}     \\
    Wait Until Page Contains Element    xpath=//span[contains(text(),'${ImageName}')]/parent::td
    Click Button    ${btnSaveMenu}
    Wait Until Page Contains Element    ${chkMenuUploadedSuccessfully}

Remove Menu Image
    [Arguments]     ${TestData}
    ${ImageName} =  Fetch From Right     ${TestData.DisplayPicture}     \\
    ${ImageName} =  Fetch From Left     ${ImageName}     .jpg
    Wait Until Page Contains Element    xpath=//a[contains(text(),'${ImageName}')]/parent::td
    Click Button    xpath=(//a[contains(text(),'${ImageName}')]/ancestor::tr/descendant::button)[1]
    Wait Until Page Contains Element    ${chkMenuImageRemovedSuccessfully}