$service=New-WebServiceProxy -uri http://localhost:30000/cocktail.svc -class cocktail
$results=$service.GetByAvailableIngredients(@("Gin","Vermouth - Sweet Red","Campari"))
Write-Output "You can make: $results "
$recipe=$service.GetRecipe($results[0])
$recipe
    
    $fmtIngredients=@{Expression={$_.Amount};Label='Amount'},
    @{Expression={$_.Unit};Label='Unit'},
    @{Expression={$_.Ingredient.Name};Label='Name'}

$recipe.Ingredients | Format-Table $fmtIngredients
