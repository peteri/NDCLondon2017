$here = Split-Path -Parent $MyInvocation.MyCommand.Path
Set-Location $Here

Write-Host "Current Directory is $(Get-Location)"
Describe "Rename" {
	Context "Rename Item is called" {
		$filename= 'c:\temp\test.txt'
		Mock Rename-Item {}
		It "Runs" {
			.\Rename.ps1 -Path $filename
			Assert-MockCalled Rename-Item -ParameterFilter {$path -eq $filename -and $newName -eq 'test.txt.bak'}
		}
	}
	Context "Rename Integration" {
		$filename= 'TestDrive:\test.txt'
		New-item -Path $filename -Type File
		It "Runs" {
			.\Rename.ps1 -Path $filename -Verbose
			"$filename.bak" | should exist
			"$filename" | should not exist
		}
	}
	Context "Rename Item has error" {
		$filename= 'c:\temp\test.txt'
		Mock Rename-Item { throw "Bad thing"}
		It "Runs" {
			.\Rename.ps1 -Path $filename | Should belike 'Failed *'
			Assert-MockCalled Rename-Item -ParameterFilter {$path -eq $filename -and $newName -eq 'test.txt.bak'}
		}
	}
}
