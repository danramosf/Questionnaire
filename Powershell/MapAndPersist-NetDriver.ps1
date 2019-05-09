# Author: Daniel Ferreira
# 2019-05-09

# This function receives a driver letter and a network share path as a parameter
# and maps and persists a network drive with the specified parameters.

function MapAndPersist-NetDriver
{
    Param (
        [Parameter(Mandatory = $true)][Char] $driver_letter,
        [Parameter(Mandatory = $true)][String] $netshare_path
    )

    Write-Host "Driver Letter: $driver_letter , Network Share Path: $netshare_path"
    New-PSDrive -Name $driver_letter -PSProvider FileSystem -Root $netshare_path -Persist
}