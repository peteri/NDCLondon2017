function f($p1,$p2) 
{
    Write-Output "P1 is"
    $p1.GetType()
    if ($p2 -ne $null)
        {
        Write-Output "P2 is"
        $p2.GetType()
        }
}

f(1,2)
