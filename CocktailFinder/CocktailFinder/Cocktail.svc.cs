using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.Serialization;
using System.ServiceModel;
using System.ServiceModel.Web;
using System.Text;
using Cocktail;

namespace CocktailFinder
{
    // NOTE: You can use the "Rename" command on the "Refactor" menu to change the class name "Service1" in code, svc and config file together.
    // NOTE: In order to launch WCF Test Client for testing this service, please select Service1.svc or Service1.svc.cs at the Solution Explorer and start debugging.
    public class CocktailService : ICocktail
    {
        public List<Ingredient> GetIngredients()
        {
            return IngredientsReader.Read().Values.ToList();
        }

        public Recipe GetRecipe(string name)
        {
            var recipes = RecipesReader.Read(IngredientsReader.Read());
            if (!recipes.ContainsKey(name))
                throw new FaultException(string.Format("Unknown cocktail name {0}",name));
            return recipes[name];
        }

        public List<string> GetRecipeNames()
        {
            var recipes = RecipesReader.Read(IngredientsReader.Read());
            return recipes.Select(r => r.Value.Name).ToList();
        }

        public List<string> GetByAvailableIngredients(List<string> names)
        {
            var ingredients = IngredientsReader.Read();
            var inCupboard = new List<Ingredient>();
            foreach (var name in names)
            {
                if (ingredients.ContainsKey(name))
                {
                    inCupboard.Add(ingredients[name]);
                }
                else
                {
                    throw new FaultException(string.Format("Unknown ingredient {0}", name));
                }
            }
            var recipes=RecipesReader.Read(ingredients);
            var finder = new RecipeFinder(recipes);
            return finder.GetByAvailableIngredients(inCupboard);
        }
    }
}
