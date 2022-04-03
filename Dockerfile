
# 04/01/2022 02:47 am - SSN 
# https://docs.microsoft.com/en-us/dotnet/core/docker/build-container?tabs=windows
# https://docs.microsoft.com/en-us/dotnet/core/docker/build-container?tabs=windows#create-the-dockerfile



FROM nanoserver/iis  AS build-env

SHELL ["POWERSHELL"]

WORKDIR /app

# Copy everything
# COPY ./Publish_v02 ./
COPY ./Publish ./publish
COPY ssn-image-util.ps1 .
copy ./sleep.ps1 .

RUN get-childitem -recurse -Depth 2

# Restore as distinct layers
#RUN dotnet restore
# Build and publish a release
#RUN dotnet publish -c Release -o out

# Build runtime image
FROM nanoserver/iis

SHELL ["POWERSHELL"]

WORKDIR /app



# https://docs.microsoft.com/en-us/powershell/module/packagemanagement/install-packageprovider?view=powershell-7.2#description
RUN ["powershell.exe", "Install-PackageProvider -Name NuGet -RequiredVersion 2.8.5.201 -Force"]
 



# https://docs.microsoft.com/en-us/powershell/module/powershellget/set-psrepository?view=powershell-7.2
RUN ["powershell.exe", "Set-PSRepository PSGallery -InstallationPolicy Trusted"]


# https://docs.microsoft.com/en-us/windows-server/get-started/deploy-nano-server

RUN ["powershell.exe", "Install-PackageProvider NanoServerPackage"]
RUN ["powershell.exe", "Import-PackageProvider NanoServerPackage"]


# # https://blog.sixeyed.com/1-2-3-iis-running-in-nano-server-in-docker-on-windows-server-2016/
# # does not work on nanoserver
# RUN ["powershell.exe", "Install-WindowsFeature NET-Framework-45-ASPNET"]  
# RUN ["powershell.exe", "Install-WindowsFeature Web-Asp-Net45"]

















# # https://docs.microsoft.com/en-us/windows-server/get-started/iis-on-nano-server
# didn't find NET-Framework-45-ASPNET
# RUN ["powershell.exe", "dism /Enable-Feature /online /featurename:NET-Framework-45-ASPNET"]
# RUN ["powershell.exe", "dism /Enable-Feature /online /featurename:Web-Asp-Net45"]













# Works
# Creates /app/app/publish_v03 with content
COPY --from=build-env /app/publish ./publish_v04
COPY --from=build-env /app/ssn-image-util.ps1 .
COPY --from=build-env /app/sleep.ps1 .
 
RUN get-childitem -recurse -Depth 2















SHELL ["POWERSHELL"]


# #RUN powershell New-Website -Name 'ps-253-wpf-publisher' -Port 80 -PhysicalPath 'c:\app\publish_v04' -ApplicationPool 'ps-253-wpf-publisher-pool'


# # https://www.ntweekly.com/2017/01/28/how-to-create-an-iis-site-on-windows-nano-server-2016/

# RUN  import-module iisadministration 
# RUN  SLEEP -SECONDS 5

# # RUN Remove-WebSite -Name 'Default Web Site'  
# RUN Remove-IISSite -Name 'Default Web Site'  

# RUN New-IISSite -Name 'Default Web Site' -BindingInformation '*:80:' –PhysicalPath 'c:\app\publish_v04'

# RUN New-Website -Name 'ps-253-wpf-publisher' -Port 80 -PhysicalPath 'c:\app\publish_v04' -ApplicationPool 'ps-253-wpf-publisher-pool'

RUN get-childitem -recurse -Depth 2

RUN ./ssn-image-util.ps1


RUN get-childitem -recurse -Depth 2










ENV DOTNET_EnableDiagnostics=0

ENTRYPOINT ["powershell", "/app/Sleep.ps1"] 