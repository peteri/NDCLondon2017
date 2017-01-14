[CmdLetBinding()]
Param()

function TestOutput
{
    Write-Host "Hello"
    Write-Output "There"
    Write-Host "World"
    Write-Verbose "Verbose"
    Write-Debug "debug"
}

$a=TestOutput
Write-Host $a