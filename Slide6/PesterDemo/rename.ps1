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
		$newName=Split-Path $newPath -Leaf
		Write-Verbose "renaming $path to $newName"
		Rename-Item -Path $Path -NewName $newName
		Write-Verbose "Rename done"
	}
	catch
	{
		Write-Verbose "Error was $_"
		$script:failed=$true
	}
}

invoke-rename $Path
if ($failed)
{
	Write-Output "Failed to rename $path"
} 

