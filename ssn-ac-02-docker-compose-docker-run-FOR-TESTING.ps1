

docker ps -a | where { $_ -like '* ps-253-wpf-publisher-web *' } | select @{ n = "ID"  ; e = { $_.substring(0, 12) } } | % {  
    write-host "docker rm  $($_.id) -f" 
    docker rm    $($_.id) -f 
}

# docker run  --name ps-253-wpf-publisher-web -d -p 80:80 ps-253-wpf-publish-v01 ping -t localhost 
docker run  --name ps-253-wpf-publisher-web -d  ps-253-wpf-publish-v01 ping -t localhost 

