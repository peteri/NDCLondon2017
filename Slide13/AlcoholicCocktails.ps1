Import-Module ..\CocktailFinder\CocktailModule\bin\debug\CocktailModule -Force
$ingredients=Get-Ingredient
$alcoholic = $ingredients.Values |  Where-Object {$_.AlcoholByVolume -gt 30}
,($alcoholic) | get-recipe
