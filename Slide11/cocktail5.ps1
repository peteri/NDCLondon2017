param(
[string]$serverName = $(throw "The Server name must be provided. eg. 'localhost'"),
[string]$portNumber = $(throw "The port number must be provided eg 30000")
)

function Write-Recipe($recipe)
{
    "Name: $($recipe.Name)"
    $fmtIngredients=@{Expression={$_.Amount};Label='Amount'},
    @{Expression={$_.Unit};Label='Unit'},
    @{Expression={$_.Ingredient.Name};Label='Name'}
    $recipe.Ingredients | Format-Table $fmtIngredients
    "Garnish: $($recipe.Garnish)"
    "Preparation: $($recipe.Preparation)"
}

$service=New-WebServiceProxy -uri "http://$serverName:$portNumber/cocktail.svc" -class cocktail
$results=$service.GetByAvailableIngredients(("Gin","Vermouth - Sweet Red","Campari"))
$results 
$recipe=$service.GetRecipe($results[0])
Write-Recipe $recipe

