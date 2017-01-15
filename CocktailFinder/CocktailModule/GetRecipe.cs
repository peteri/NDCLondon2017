using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

using System.Management.Automation;
using Cocktail;

namespace CocktailModule
{
    [Cmdlet(VerbsCommon.Get, "Recipe")]
    public class GetRecipe : PSCmdlet
    {
        [Parameter(Position = 0, Mandatory = true, ParameterSetName = "Ingredients",
            ValueFromPipeline = true)]
        public Ingredient[] Ingredients { get; set; }

        [Parameter(Position = 0, Mandatory = true, ParameterSetName = "Recipes",
            ValueFromPipeline = true)]
        public string[] Names { get; set; }

        protected override void ProcessRecord()
        {
            var ingredients = IngredientsReader.Read();
            var recipes = RecipesReader.Read(ingredients);
            if (Names != null)
            {
                foreach (var name in Names)
                {
                    WriteObject(recipes[name]);
                }
            }
            else
            {
                var inStock = Ingredients.ToList();
                var finder = new RecipeFinder(recipes);
                var canMake = finder.GetByAvailableIngredients(inStock);
                foreach (var name in canMake)
                {
                    WriteObject(recipes[name]);
                }
            }
        }
    }
}
