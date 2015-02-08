# cSqlPs
Community fork of the xSqlPs Resource Module

cSqlServerConfig USAGE:

Set MaxMemory on Default SQL Instance to 2048MB:

        cSqlServerConfig smallSQLDpeloy
			        {
				        SqlPropertyName = 'MaxServerMemory'
				        SqlPropertyValue = '2048'
			        }

Set MaxMemory to 8192 on the TEST SQL Instance:

        cSqlServerConfig mediumSQLDpeloy
				{
				        InstanceName = 'TEST'
				        SqlPropertyName = 'MaxServerMemory'
				        SqlPropertyValue = '8192'
			        }

Set MaxDegreeofParallelism to 4 on Default SQL Instance:

        cSqlServerConfig mediumSQLDpeloy
				{
				        SqlPropertyName = 'MaxDegreeofParallelism'
				        SqlPropertyValue = '4'
			        }	

EXAMPLE Config:

	Configuration sqltest
	{
	Import-DscResource  -module cSqlPs

		Node 'testsqlserver'
		 {
			
			cSqlServerConfig maxmem2048
				{
					SqlPropertyName = 'MaxServerMemory'
					SqlPropertyValue = '2048'
				}
			cSqlServerConfig maxdop4
				{
					SqlPropertyName = 'MaxDegreeofParallelism'
					SqlPropertyValue = '4'
				}
		}
	}

	sqltest

Start-DscConfiguration -Wait -Verbose -Path .\sqltest