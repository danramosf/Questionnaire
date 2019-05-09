#Author: Daniel Ferreira
# 08-05-2019

# .NET 4.5 download url
#	$url_45 = "https://download.microsoft.com/download/B/A/4/BA4A7E71-2906-4B2D-A0E1-80CF16844F5F/dotNetFx45_Full_setup.exe"
# .NET 4.5 file name
#	$file_45 = "$PSScriptRoot\dotNetFx45_Full_setup.exe"

# Downloading .NET 4.5
#	(New-Object System.Net.WebClient).DownloadFile($url, $output)



#Arguments for starting the process of installation
$args = " /q /norestart"

#Checking if .NET CORE 2.2.203 is already installed...
$disp_name_core = "Microsoft .NET Core SDK 2.2.203 (x64)"
$installed_core = (Get-ItemProperty HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\* | Where { $_.DisplayName -eq $disp_name_core }) -ne $null

If(-Not $installed_core){

	# .NET Core download url
	$url_core = "https://download.visualstudio.microsoft.com/download/pr/3c43f486-2799-4454-851c-fa7a9fb73633/673099a9fe6f1cac62dd68da37ddbc1a/dotnet-sdk-2.2.203-win-x64.exe"
	# .NET Core file name
	$file_core = "$PSScriptRoot\dotnet-sdk-2.2.203-win-x64.exe"

	Write-Host "Downloading .NET Core 2.2.203"

	# Downloading .NET Core
	(New-Object System.Net.WebClient).DownloadFile($url_core, $file_core)

	Write-Host "Installing .NET Core 2.2.203"
	#Installing .NET Core
	Start-Process -FilePath $file_core -ArgumentList $args -Wait

}else{
	Write-Host ".NET Core 2.2.203 is already installed."
}