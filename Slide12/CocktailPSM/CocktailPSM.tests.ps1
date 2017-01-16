$here = Split-Path -Parent $MyInvocation.MyCommand.Path
Import-Module  $here\CocktailPSM -Force

Describe "Get-ByIngredients" {
	Context "Function Exists" {
		It "Should Return" {
			$ingredients=@("Gin","Vermouth - Sweet Red","Campari")
			Get-ByIngredient $ingredients | Should Be ('Negroni','Americano','Hello')
		}
	}
}
