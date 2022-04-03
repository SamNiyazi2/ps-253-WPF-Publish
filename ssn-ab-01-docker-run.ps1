
# 04/01/2022 03:27 am - SSN 
# https://www.ntweekly.com/2017/06/09/create-an-iis-web-server-in-windows-container/
#
# https://hub.docker.com/_/microsoft-windows-nanoserver
#
# docker pull mcr.microsoft.com/windows/nanoserver
# docker run -it --name iisserver -p 80:80 -p 433:433 mcr.microsoft.com/windows/nanoserver
#
# https://hub.docker.com/r/nanoserver/iis
# docker run -d -p 80:80 nanoserver/iis ping -t localhost 
#
# docker run  --name ps-253-wpf-publisher -d -p 80:80 nanoserver/iis cmd waitfor forever 


# ping -t localhost  to keep server up



docker ps -a | where { $_ -like '*ps-253-wpf-publisher*' } | select @{ n = "ID"  ; e = { $_.substring(0, 12) } } | % {  
    write-host "docker rm  $($_.id) -f" 
    docker rm    $($_.id) -f 
}

docker run  --name ps-253-wpf-publisher-v01 -d -p 80:80 ps-253-wpf-publish-v01  ping -t localhost 

