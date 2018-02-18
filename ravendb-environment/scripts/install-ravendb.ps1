PARAM(
    [Parameter(Mandatory=$true)]    
    [string] $installerUrl
)

$installerTempPath = "C:\vagrant\software\$([System.IO.Path]::GetFileName($($installerUrl)))"

Write-Host "Downloading Installer $installerUrl"	

if(!(Test-Path $installerTempPath))
{
	if($installerUrl.Contains("http")){
		Invoke-WebRequest -Uri $installerUrl  -OutFile $installerTempPath
	}
	else
	{
		Copy-Item -Path $installerUrl -Destination $installerTempPath -Force
		Unblock-File $installerTempPath
	}
}

Write-Host "Installing..."	

$installLog = "$env:SystemRoot\Temp\raven_log.txt"

Start-Process $installerTempPath -ArgumentList "/quiet /log $installLog /msicl `"RAVEN_TARGET_ENVIRONMENT=DEVELOPMENT TARGETDIR=C:\ INSTALLFOLDER=C:\RavenDB RAVEN_INSTALLATION_TYPE=SERVICE REMOVE=IIS ADDLOCAL=Service`"" -Wait

$installLogContent = Get-Content $installLog -Raw

if($installLogContent -match "RavenDB -- (Configuration|Installation) completed successfully")
{
    Write-Host "Installation successful !"
}
else
{
    Write-Error "Installation failed !"
}


	

