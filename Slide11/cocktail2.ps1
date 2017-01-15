$service=New-WebServiceProxy -uri http://localhost:30000/cocktail.svc -class cocktail
$results=$service.GetByAvailableIngredients(@("Gin","Vermouth - Sweet Red","Campari"))
Write-Output "You can make $results"
 
