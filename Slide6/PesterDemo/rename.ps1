#
# Renames a file to a backup file
#
[CmdLetBinding()]
Param (
[Parameter(Mandatory=$true)]
[String] $Path
)
$failed= $false
function invoke-Rename ($path)
{
	try
	{
		$newPath=$path +".bak"
		Rename-Item -Path $Path -NewName $newPath
	}
	catch
	{
		$failed=$true
	}
}

invoke-rename $Path
if ($failed)
{
	Write-Output "Failed to rename $path"
} 

