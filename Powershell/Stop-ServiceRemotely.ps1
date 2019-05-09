# Author: Daniel Ferreira
# 2019-05-09

# This function receives a computer name, list its services that are currently running,
# and provides the option to stop a specific service.

function Stop-ServiceRemotely($remote_computer_name)
{
    $choice = "";

    try 
    {
        
        Get-Service -ComputerName $remote_computer_name | Where-Object {$_.Status -EQ "Running"} | Select -property name
        Read-Host "Press ENTER to continue..."

    }catch {
        Write-Host "The specified computer name does not exist or you do not have access to it."
        return
    }

    Write-Host "------------------------------------------"
    Write-Host "Those are the services currently running at $remote_computer_name ."
    Write-Host "------------------------------------------"

    while (($choice -NotLike "Y") -AND ($choice -NotLike "N")){

        $choice = Read-Host -Prompt "Would you like to stop any service? (Y/N)"
    
    }

    if($choice -Like "Y")
    {
        
        $choice = Read-Host -Prompt "Enter the service name:"
        $service_found = (Get-Service -ComputerName $remote_computer_name | Where-Object {$_.Status -EQ "Running" -AND $_.Name -EQ $choice }) -ne $null
            
        if($service_found){

            Get-Service -ComputerName $remote_computer_name -Name $choice | Stop-Service -Force
            Write-Host "The service $choice has been stopped."

        } else {
            Write-Host "The service $choice is not currently running."
        }
    }
} 