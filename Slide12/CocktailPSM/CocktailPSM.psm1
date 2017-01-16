[string]$cocktailServerName = 'localhost'
[int]$cocktailportNumber = '30000'

<#
.Synopsis
   Retrieves a list of IBA cocktails that can be made from a list of ingredients
.DESCRIPTION
   Uses a web service
.EXAMPLE
   Get-ByIngredient @('Gin','Vermout - Sweet Red','Campari')
.INPUTS
   Does not support the pipeline
.OUTPUTS
   Names of cocktails that can be made
.NOTES
   Uses module level variables cocktailServerName and cocktailportNumber to specify the server to use.
.COMPONENT
   CocktailFinder
#>
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

Export-ModuleMember -Function Get-ByIngredient						
Export-ModuleMember -Function Get-Recipe
Export-ModuleMember -Function Write-Recipe
Export-ModuleMember -Variable cocktailportNumber
Export-ModuleMember -Variable cocktailServerName
