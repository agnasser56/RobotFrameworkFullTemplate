*** Settings ***
Documentation    Suite description
Library  Collections
*** Variables ***
&{WalemUser}  UserName=de-super-uat    Password=Aa123456
&{WalemQASuper}  UserName=walemuatadmin    Password=Aa123456
&{WalemUser1}  UserName=de-1-uat    Password=Aa123456
&{WalemUser2}  UserName=qa-1-uat    Password=Aa123456
&{WalemRestaurantUser}  UserName=ryansmith@good-palmer.biz    Password=Aa123456

&{RestaurantDetails}    RestaurantId=23500   RestaurantName=Guthu   CategoryNameEn=Appetizers     DisplayPicture=${CURDIR}\\Files\\RestaurantMenu.jpg

#####################################APIS Test Data###############################################
&{APIURLs}      APIURL=https://git.toptal.com/
&{IssueDetails1}     PrivateToken=sbem_9ogHeoxovFgX6j8    ProjectID=17154      Title=This is a test bug 7
&{IssueDetails2}     PrivateToken=sbem_9ogHeoxovFgX6j8    ProjectID=4      Title=This is a test bug 7
&{IssueDetails3}     PrivateToken=sbem_9ogHeoxov          ProjectID=17154      Title=This is a test bug 7
&{IssueDetails4}     PrivateToken=sbem_9ogHeoxovFgX6j8    ProjectID=17154      IssueId=1
&{IssueDetails5}     PrivateToken=sbem_9ogHeoxovFgX6j8    ProjectID=17154      IssueId=2