$here = Split-Path -Parent $MyInvocation.MyCommand.Path
Set-Location $here
Import-Module ..\CocktailModule\bin\debug\CocktailModule -Force

$ingredients=Get-Ingredient

Describe "Cocktail Names Test" {
    $Names='Negroni','Dry Martini'
	Context "Using position 0" {
		It "Get recipe returns two recipes" {
			$recipes = Get-Recipe $Names
			$recipes.Count | Should Be 2
			,($recipes | Select -ExpandProperty Name) | Should MatchArrayUnordered ('Negroni','Dry Martini')
			$recipes[0].GetType().Name | Should Be 'Recipe'
		}
	}
	Context "Using Name parameter" {
		It "Get recipe returns two recipes" {
			$recipes = Get-Recipe -Name $Names
			$recipes.Count | Should Be 2
			,($recipes | Select -ExpandProperty Name) | Should MatchArrayUnordered ('Negroni','Dry Martini')
			$recipes[0].GetType().Name | Should Be 'Recipe'
		}
	}
	Context "Using Pipe parameter" {
		It "Get recipe returns two recipes" {
			$recipes = $Names | Get-Recipe
			$recipes.Count | Should Be 2
			,($recipes | Select -ExpandProperty Name) | Should MatchArrayUnordered ('Negroni','Dry Martini')
			$recipes[0].GetType().Name | Should Be 'Recipe'
		}
	}
}
Describe "Cocktail Names Using PSObject" {
    $Names=@()
	$Names += New-Object PSObject -Property @{
		Name='Negroni';
		Price=12.5
	}
	$Names += New-Object PSObject -Property @{
		Name='Dry Martini';
		Price=10.0
	}
	Context "Using PsObject Name" {
		It "Get recipe returns two recipes" {
			$recipes = $Names | Get-Recipe 
			$recipes.Count | Should Be 2
			,($recipes | Select -ExpandProperty Name) | Should MatchArrayUnordered ('Negroni','Dry Martini')
			$recipes[0].GetType().Name | Should Be 'Recipe'
		}
	}
}

Describe "Cocktail Ingredients Test" {
    $inStock=@($ingredients['Gin'],$ingredients['Vermouth - Sweet Red'],$ingredients['Campari'])
	Context "Using parameter" {
		It "Runs Get-Recipe returning two recipes" {
			$recipes = Get-Recipe -InputObject $inStock
			$recipes.Count | Should Be 2
			,($recipes | Select -ExpandProperty Name) | Should MatchArrayUnordered ('Negroni','Americano')
		}
	}
	#Context "Using pipeline" {
	#	It "Runs Get-Recipe returning two recipes" {
	#		$recipes = $inStock | Get-Recipe 
	#		$recipes.Count | Should Be 2
	#		,($recipes | Select -ExpandProperty Name) | Should MatchArrayUnordered ('Negroni','Americano')
	#	}
	#}
}