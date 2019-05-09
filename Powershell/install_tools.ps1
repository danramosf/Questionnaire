#Author: Daniel Ferreira
# 08-05-2019

#Arguments for starting the process of installation
$args = " /q /norestart"

#Checking if .NET 4.5 is already installed...
$disp_name_45 = "Microsoft .NET Framework 4.`[56789]`."
$installed_45 = (Get-ItemProperty HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\* | Where { $_.DisplayName -Match $disp_name_45 }) -ne $null

If(-Not $installed_45){

	# .NET 4.5 download url
	$url_45 = "https://download.microsoft.com/download/B/A/4/BA4A7E71-2906-4B2D-A0E1-80CF16844F5F/dotNetFx45_Full_setup.exe"
	# .NET 4.5 file name
	$file_45 = "$PSScriptRoot\dotNetFx45_Full_setup.exe"
	
	Write-Host "Downloading .NET Framework 4.5"
	# Downloading .NET 4.5
	(New-Object System.Net.WebClient).DownloadFile($url_45, $file_45)
	
	Write-Host "Installing .NET Framework 4.5"
	#Installing .NET 4.5
	Start-Process -FilePath $file_45 -ArgumentList $args -Wait

}else{
	Write-Host ".NET 4.5 Framework or a higher version is already installed."
}

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



#Allow inbound traffic on port 1433
$rules = Get-NetFirewallRule

if (-not ($rules.DisplayName.Contains("Allow port 1433"))){
	$params = @{
		 DisplayName = "Allow port 1433"
		 LocalPort = 1433
		 Direction="Inbound"
		 Protocol ="TCP"
		 Action = "Allow"
	}
	New-NetFirewallRule @params
} else {
	Write-Host "The rule 'Allow port 1433' already exists."
}



#Creating a new registry and adding a value to it
if( -not (Test-Path -Path HKCU:\Company -PathType Container)){
	New-Item -Path "HKCU:\" -Name Company
	New-ItemProperty -Path "HKCU:\Company" -Name "Company" -Value "MCU" -PropertyType "String"
}else {
	Write-Host "The registry with the key 'Company' already exists."
}