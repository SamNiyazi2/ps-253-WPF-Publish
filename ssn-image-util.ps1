
# Used in container to define the primary publishing web site.

write-host "ssn-image-util" -ForegroundColor Yellow

import-module IISAdministration


# # RUN Remove-WebSite -Name 'Default Web Site'  

write-host "remove-iissite..." -ForegroundColor Yellow

Remove-IISSite -Name 'Default Web Site'  -Confirm:$false

write-host "new-iissite..." -ForegroundColor Yellow

New-IISSite -Name 'Default Web Site' -PhysicalPath 'c:\app\publish_v04' -BindingInformation '*:80:' 

write-host "Done!" -ForegroundColor Yellow
  
