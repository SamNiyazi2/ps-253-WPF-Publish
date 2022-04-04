
# 04/03/2022 10:45 pm - SSN 
# 

$ErrorActionPreference = "stop"
$Error.Clear()

. "C:\Sams\PS\azure\Storage_Blob\upload-to-static-web-app-util.ps1"


$bag = @{

    rgn                = "ps-312-tablestorage-20210515-rg"
    storageAccountName = "ps312storagetabe20210515"
    container          = '$web'
    rootPath           = 'C:\\Sams_P\\PS\\creating-flexible-wpf-business-application-screens-playbook\\ps-253-wpf-publish\\Publish\\'
    path               = "C:\Sams_P\PS\creating-flexible-wpf-business-application-screens-playbook\ps-253-wpf-publish\Publish"
    
    startDate          = get-date -Year 2022 -Month 4 -Day 4 -h 2 -Minute 13
}
 
 

upload-files @bag

 
 