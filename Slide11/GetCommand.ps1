Get-Command Stop-Service -Syntax
$a = Get-Command Stop-Service | Select -ExpandProperty ParameterSets 
$a | ForEach-Object {$_.Parameters | Where-Object -Property ValueFromPipeline -eq $true}
