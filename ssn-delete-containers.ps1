

docker ps -a | where { $_ -like '*minutes*' -or $_ -like '*hour*' } | select @{ n = "ID"  ; e = { $_.substring(0, 12) } } | % {  
    write-host "docker rm  $($_.id) -f" 
    docker rm    $($_.id) -f 
}