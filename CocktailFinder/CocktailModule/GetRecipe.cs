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
        private Dictionary<string, Ingredient> ingredients = null;
        private Dictionary<string, Recipe> recipes = null;

        [Parameter(Position = 0, Mandatory = true, ParameterSetName = "Ingredients",
            ValueFromPipeline = true)]
        [ValidateNotNullOrEmpty]
        public Ingredient[] Ingredients { get; set; }

        [Parameter(Position = 0, Mandatory = true, ParameterSetName = "Default",
            ValueFromPipeline = true, ValueFromPipelineByPropertyName = true)]
        public string[] Name { get; set; }

        protected override void BeginProcessing()
        {
            base.BeginProcessing();
            ingredients = IngredientsReader.Read();
            recipes = RecipesReader.Read(ingredients);
        }

        protected override void ProcessRecord()
        {
            if (Name != null)
            {
                foreach (var name in Name)
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
