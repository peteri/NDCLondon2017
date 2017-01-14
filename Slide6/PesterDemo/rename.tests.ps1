$here = Split-Path -Parent $MyInvocation.MyCommand.Path
Set-Location $Here

Write-Host "Current Directory is $(Get-Location)"
Describe "Rename" {
	Context "Rename Item is called" {
		$filename= 'c:\temp\test.txt'
		Mock Rename-Item {}
		It "Runs" {
			.\Rename.ps1 -Path $filename
			Assert-MockCalled Rename-Item -ParameterFilter {$path -eq $filename -and $newName -eq 'c:\temp\test.txt.bak'}
		}
	}
	Context "Rename Integration" {
		$filename= 'TestDrive:\test.txt'
		New-item -Path $filename -Type File
		It "Runs" {
			.\Rename.ps1 -Path $filename
			"$filename.bak" | should exist
			"$filename" | should not exist
		}
	}
}
