#
# Renames a file to a backup file
#
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
		Rename-Item -Path $Path -NewName $newName
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

