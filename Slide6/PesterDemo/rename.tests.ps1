Describe "Rename" {
	Context "Rename Item is called" {
		$filename= 'c:\temp\test.txt'
		Mock Rename-Item  {}
		It "Runs" {
			.\Rename.ps1 -Path $filename
			Assert-MockCalled Rename-Item -ParameterFilter {$path -eq $filename -and $newName -eq "c:\temp\test.txt.bak"}
		}
	}
}