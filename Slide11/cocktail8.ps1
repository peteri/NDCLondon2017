param(
[string]$serverName = 'localhost',
[int]$portNumber = '30000'
)

function Get-ByIngredients([String[]] $ingredients)
{
    if ($script:service -eq $null)
    {
        $script:service=New-WebServiceProxy -uri "http://${serverName}:${portNumber}/cocktail.svc" -class cocktail
    }
    $script:service.GetByAvailableIngredients($ingredients)
}

function Write-Recipes
{
param([Parameter(ValueFromPipeline=$true)]$recipe)
begin{}
process
   {

    "Name: $($recipe.Name)"
    $fmtIngredients=@{Expression={$_.Amount};Label='Amount'},
    @{Expression={$_.Unit};Label='Unit'},
    @{Expression={$_.Ingredient.Name};Label='Name'}
    $recipe.Ingredients | Format-Table $fmtIngredients
    "Garnish: $($recipe.Garnish)"
    "Preparation: $($recipe.Preparation)"
    }
}

function Get-Recipes
{
    param(
    [Parameter(ValueFromPipeline=$true)]
    [string] $cocktailName
    )
    begin 
    {
        if ($script:service -eq $null)
        {
            $script:service=New-WebServiceProxy -uri "http://${serverName}:${portNumber}/cocktail.svc" -class cocktail
        }
    }
    process 
    {
        $script:service.GetRecipe($cocktailName)
    }
    end {}
}

$ingredients=@("Gin","Vermouth - Sweet Red","Campari")
Get-ByIngredients $ingredients | Get-Recipes | Write-Recipes

