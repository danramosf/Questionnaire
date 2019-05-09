# Author: Daniel Ferreira
# 2019-05-09

# This function receives a stored procedure name and a sql server connection string as mandatory parameters
# you can also send an array with NameValuePairs with the stored procedure's parameters, where the name is the parameter name
# and the value is the parameter value, just in case the stored procedure has it.
# This stored procedure will be executed in this sql server, generaring a .csv as an output
# The .csv file will be generated in the same folder the script is saved.

<#
    Write a script to run a given stored procedure, against a given sql server. 
    Export output - if any - to a csv file at a given path.
#>

function RunProcedureOnSqlServer
{
    Param (
        [Parameter(Mandatory = $true)][String] $procedure_name,
        [Parameter(Mandatory = $true)][String] $sql_server_conn,
        $params = @() #optional
    )

    $conn = New-Object System.Data.SqlClient.SqlConnection
    $conn.ConnectionString = $sql_server_conn

    $cmd = New-Object System.Data.SqlClient.SqlCommand
    $cmd.CommandText = $procedure_name

    #Checking for parameters
    if($params.Length > 0){
        $cmd.CommandType = [System.Data.CommandType]::StoredProcedure
        foreach($par in $params){
            $cmd.Parameters.AddWithValue($par.Name, $par.Value)
        }
    }
    $cmd.Connection = $conn

    $SqlAdapter = New-Object System.Data.SqlClient.SqlDataAdapter
    $SqlAdapter.SelectCommand = $cmd

    #Creating and filling the DataSet
    $ds = New-Object System.Data.DataSet
    $SqlAdapter.Fill($ds)
    $conn.Close()
    #exporting the DataSet to .csv file
    $ds.Tables[0] | export-csv "$PSScriptRoot\stored-procedure-output.csv" -notypeinformation

}