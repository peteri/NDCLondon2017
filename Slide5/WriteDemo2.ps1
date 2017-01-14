function TestOutput
{
    Write-Host "Hello"
    Write-Output "There"
    Write-Host "World"
}

$a=TestOutput
Write-Host $a