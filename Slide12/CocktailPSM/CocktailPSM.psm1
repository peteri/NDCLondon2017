[string]$cocktailServerName = 'localhost'
[int]$cocktailportNumber = '30000'

function Get-ByIngredient
{
	param(
		# ingredients array of ingredients to search for
		[String[]] $ingredients
	)
    if ($private:service -eq $null)
    {
        $private:service=New-WebServiceProxy -uri "http://${cocktailServerName}:${cocktailportNumber}/cocktail.svc" -class cocktail
    }
    $private:service.GetByAvailableIngredients($ingredients)
}

function Write-Recipe
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

function Get-Recipe
{
    param(
    [Parameter(ValueFromPipeline=$true)]
    [string] $cocktailName
    )
    begin 
    {
        if ($private:service -eq $null)
        {
            $private:service=New-WebServiceProxy -uri "http://${cocktailServerName}:${cocktailportNumber}/cocktail.svc" -class cocktail
        }
    }
    process 
    {
        $private:service.GetRecipe($cocktailName)
    }
    end {}
}

