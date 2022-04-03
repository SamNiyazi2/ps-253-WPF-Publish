
# 04/01/2022 02:54 am - SSN 
# https://docs.microsoft.com/en-us/dotnet/core/docker/build-container?tabs=windows

docker image ls -a 

#docker build -t ps-253-wpf-publish-v01 -f Dockerfile . --no-cache
docker build -t ps-253-wpf-publish-v01 -f Dockerfile .  

docker image ls -a 
