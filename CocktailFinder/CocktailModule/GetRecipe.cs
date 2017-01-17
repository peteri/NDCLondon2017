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
        private List<Ingredient> inStock = null;

        // Ingredient parameter
        [Parameter(Position = 0, Mandatory = true, ParameterSetName = "InputObject", ValueFromPipeline = true)]
        [ValidateNotNullOrEmpty]
        public Ingredient[] InputObject { get; set; }

        // Name parameter
        [Parameter(Position = 0, Mandatory = true, ParameterSetName = "Default", ValueFromPipeline = true, ValueFromPipelineByPropertyName = true)]
        public string[] Name { get; set; }

        /// <summary>
        /// Begin the process
        /// </summary>
        protected override void BeginProcessing()
        {
            ingredients = IngredientsReader.Read();
            recipes = RecipesReader.Read(ingredients);
            inStock = new List<Ingredient>();
        }

        /// <summary>
        /// Process a record
        /// </summary>
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
                foreach(var ingredient in InputObject)
                {
                    inStock.Add(ingredient);
                }
            }
        }

        /// <summary>
        /// End the process
        /// </summary>
        protected override void EndProcessing()
        {
            if ((inStock != null) && (inStock.Count !=0))
            {
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
