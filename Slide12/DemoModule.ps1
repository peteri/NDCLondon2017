import-module .\CocktailPSM\CocktailPSM
Get-ByIngredient('Gin','Vermouth - Sweet Red','Campari') | Get-Recipe | Write-Recipe
