using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Cocktail
{
    public class RecipeFinder
    {
        private Dictionary<string, Recipe> recipes = null;
        public RecipeFinder(Dictionary<string, Recipe> recipes)
        {
            this.recipes = recipes;
        }
        public List<string> GetByAvailableIngredients(List<Ingredient> ingredients)
        {
            var results = new List<string>();
            var ingredientsHash = new HashSet<string>(ingredients.Select(i => i.Name));

            foreach (var recipe in recipes.Values)
            {
                if (ingredientsHash.IsSupersetOf(recipe.Ingredients.Select(i => i.Ingredient.Name)))
                {
                    results.Add(recipe.Name);
                }
            }
            return results;
        }
    }
}
