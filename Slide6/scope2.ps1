$magicNumber =10
function Test
{
    $a=$magicNumber *3
    Write-Host "3 times $magicNumber is $a"

    $script:magicNumber= 11

    $a=$magicNumber *3
    Write-Host "3 times $magicNumber is $a"
}

Test
$a=$magicNumber *3
Write-Host "3 times $magicNumber is $a"
