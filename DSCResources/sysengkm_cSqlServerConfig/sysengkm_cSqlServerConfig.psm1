
# cSQLServerConfig: DSC resource to set Sql Server Configuration Values like MaxServerMemory, MaxDegreeofParallelism, etc.
#


#
# The Get-TargetResource cmdlet.
#
function Get-TargetResource
{
    [OutputType([hashtable])]
    param
    (	
	[parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [string] $SqlPropertyName,
		
        [string] $InstanceName = "Default",
                 
        [string] $SqlPropertyValue = '0'

        
    )
	if(!(Get-Module -ListAvailable -Name SQLPS))
	{
		Throw "Please ensure that SQLPS module is installed."
	}
	
    	Import-Module SQLPS -DisableNameChecking;
	$value=$(Get-Item sqlserver:\\sql\\localhost\\$InstanceName).Configuration.$SqlPropertyName.ConfigValue

	$returnValue = @{
        		InstanceName = $InstanceName
			SqlPropertyName = $SqlPropertyName
			SqlPropertyValue = $value
    			}

    return $returnValue
}


#
# The Set-TargetResource cmdlet.
#
function Set-TargetResource
{
    param
    (	
        [string] $InstanceName = "Default",
        
	[parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [string] $SqlPropertyName,

        [parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [string] $SqlPropertyValue

    )	
	# Check if SQLPS module is present 
	if(!(Get-Module -ListAvailable -Name SQLPS))
	{
		Throw "Please ensure that SQLPS module is installed."
	}
	
    Import-Module SQLPS -DisableNameChecking;
	$(Get-Item sqlserver:\\sql\\localhost\\$InstanceName).Configuration.$SqlPropertyName.ConfigValue=$SqlPropertyValue;
	$(Get-Item sqlserver:\\sql\\localhost\\$InstanceName).Alter()
}

#
# The Test-TargetResource cmdlet.
#
function Test-TargetResource
{
    [OutputType([bool])]
    param
    (	
        [string] $InstanceName = "Default",
        
	[parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [string] $SqlPropertyName,

        [parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [string] $SqlPropertyValue
    )
	# Check if SQLPS module is present 
	if(!(Get-Module -ListAvailable -Name SQLPS))
	{
		Throw "Please ensure that SQLPS module is installed."
	}
	
   	Import-Module SQLPS -DisableNameChecking;
   	If(($(Get-Item sqlserver:\\sql\\localhost\\$InstanceName).Configuration.$SqlPropertyName.ConfigValue -eq $SqlPropertyValue))  { $result =$true } else { $result = $false }
   
   	 return $result;
	
}




Export-ModuleMember -Function *-TargetResource



