﻿function MultiplyBy4($p1) { $p1*4 }
function MultiplyBy5($p1) { $p1*5 }

function ThreeThings($a, $b, $c)
{
MultiplyBy4 $a 
MultiplyBy5 $b 
return $c*6
}

ThreeThings 4 5 6
